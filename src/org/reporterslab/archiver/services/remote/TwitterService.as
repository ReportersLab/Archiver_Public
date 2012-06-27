package org.reporterslab.archiver.services.remote
{
	import com.dborisenko.api.twitter.TwitterAPI;
	import com.dborisenko.api.twitter.commands.streaming.UserStream;
	import com.dborisenko.api.twitter.commands.timeline.LoadHomeTimeline;
	import com.dborisenko.api.twitter.data.StreamingObject;
	import com.dborisenko.api.twitter.data.TwitterStatus;
	import com.dborisenko.api.twitter.events.TwitterEvent;
	import com.dborisenko.api.twitter.events.TwitterStreamingEvent;
	import com.dborisenko.api.twitter.net.TwitterOperation;
	import com.dborisenko.api.twitter.oauth.events.OAuthTwitterEvent;
	
	import flash.data.EncryptedLocalStore;
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;
	
	import org.reporterslab.archiver.events.ArchiverContentEvent;
	import org.reporterslab.archiver.events.ArchiverTwitterEvent;
	import org.reporterslab.archiver.models.vo.Status;
	import org.reporterslab.archiver.services.remote.configs.TwitterConfigs;
	import org.reporterslab.archiver.services.remote.twitter.StatusCatchUpLoader;
	import org.robotlegs.mvcs.Actor;
	
	public class TwitterService extends Actor
	{
		
		private var _api:TwitterAPI = new TwitterAPI();
		private var _authorizationURL:String;
		private var _latestTimelineOp:TwitterOperation;
		private var _catchUpLoader:StatusCatchUpLoader;
		private var _stream:UserStream;
		
		public var newestId:String;
		public var oldestId:String;
		
		public var latestData:ArrayCollection;
		
		public function TwitterService()
		{
			super();
			trace("Twitter Service Created");
			newestId = getLatestStoredId();
			initializeApi();
			catchUp();
		}
		
		
		
		public function loadLatestTimeline():void
		{
			if(_latestTimelineOp){
				_latestTimelineOp.removeEventListener(TwitterEvent.COMPLETE, onLatestTimeline);
			}
			//load the timeline of authenticated user. We probably want to use the sinceId and maxId somehow.
			_latestTimelineOp = new LoadHomeTimeline(this.newestId, null, 200);
			//tie handler to operation.
			_latestTimelineOp.addEventListener(TwitterEvent.COMPLETE, this.onLatestTimeline);
			//and post the op to the api.
			_api.post(_latestTimelineOp);
		}
		
		
		private function onLatestTimeline(event:TwitterEvent):void
		{
			if(event.success){
				storeLatestId(event.data);
				var output:Vector.<Status> = parseStatuses(event.data);
				if(output.length > 0){
					this.newestId = output[0].twitterId;
					this.oldestId = output[output.length - 1].twitterId;	
				}else{
					trace("No New Tweets");
				}
				dispatch(new ArchiverContentEvent(ArchiverContentEvent.NEW_CONTENT, ArchiverContentEvent.TYPE_TWITTER, output));
			}else{
				//needs better error handling, probably.
				trace("Error loading timeline: " + event.data.toString());
				//send up the original event data as an error message.
				dispatch(new ArchiverContentEvent(ArchiverContentEvent.ERROR_LOADING_CONTENT, ArchiverContentEvent.TYPE_TWITTER, event.data));
			}
		}
		
		
		/**
		 * Takes a twitter post result and converts it into a vector of status objects.
		 * 
		 * @param data       The object (should be an array collection) containing the statuses.
		 **/
		public function parseStatuses(data:Object):Vector.<Status>
		{
			//save the latest data.
			latestData = data as ArrayCollection;
			//convert to our statuses.
			var output:Vector.<Status> = new Vector.<Status>();
			for each(var ts:TwitterStatus in latestData)
			{
				var s:Status = new Status();
				s.parseTwitterStatus(ts);
				output.push(s);
			}
			
			return output;
		}
		
		
		
		/**
		 * This should catch up the Timeline from wherever it last stopped until now. Note that the Twitter API will only
		 * send the most recent 800 statuses back at maximum (in 200-status chunks). This could prove to be the downfall
		 * of the entire application. Imagine someone turning on the PC after a weekend, it couldn't catch up...
		 **/
		
		public function catchUp():void
		{
			var sinceId:String = getLatestStoredId();
			trace("Launching the catch up. Id from Local Store: " + sinceId);
			//I think maxId is always going to be null here?
			this._catchUpLoader = new StatusCatchUpLoader(this._api, sinceId, null);
			this._catchUpLoader.addEventListener(TwitterEvent.COMPLETE, onCatchUp);
		}
		
		private function onCatchUp(event:TwitterEvent):void
		{
			if(event.success){
				var output:Vector.<Status> = parseStatuses(event.data);
				dispatch(new ArchiverContentEvent(ArchiverContentEvent.NEW_CONTENT, ArchiverContentEvent.TYPE_TWITTER, output));
			}else{
				dispatch(new ArchiverContentEvent(ArchiverContentEvent.ERROR_LOADING_CONTENT, ArchiverContentEvent.TYPE_TWITTER, event.data));
			}
			//we're caught up, start the stream.
			startStream();
		}
		
		
		public function startStream():void
		{
			_stream = new UserStream(); // all defaults.
			_stream.addEventListener(TwitterStreamingEvent.PROGRESS, onStreamingData);
			_stream.addEventListener(TwitterStreamingEvent.STREAM_ERROR, onStreamingError);
			_api.post(_stream);
		}
		
		private function onStreamingData(event:TwitterStreamingEvent):void
		{
			var data:StreamingObject = event.streamObject;
			
			if(data.type == StreamingObject.TYPE_STATUS){
				storeLatestId(data.data as TwitterStatus);
				var statuses:Vector.<Status> = new Vector.<Status>();
				var newStatus:Status = new Status();
				statuses.push(newStatus.parseTwitterStatus(data.data as TwitterStatus));
				dispatch(new ArchiverContentEvent(ArchiverContentEvent.NEW_CONTENT, ArchiverContentEvent.TYPE_TWITTER, statuses));
			}
			//ideally we'd handle all the other content types. For now this should work.
			
		}
		
		private function onStreamingError(event:TwitterStreamingEvent):void
		{
			trace("Twitter Stream Error. Should handle a restart or switch to polling here.");
		}
		
		
		/**
		 * Here is where we would run the OAUTH process. First we'd have to test if we hvae a User's Token in the
		 * Encrypted Data Store. If not, then we'd dispatch an event eventually telling the View to do a login
		 * with the appropriate authorization URL.
		 * 
		 * User would do a login and input the returned number code (only example I have for that, may be a different
		 * way) and send that event up the chain. This service catches it, runs the login, gets the access tokens, 
		 * and then saves them in the encrypted store.
		 * 
		 * Process:
		 * 
		 * 1) Register events
		 * 2) Call _api.connection.authorize(TWITTER_CONSUMER_KEY, TWITTER_CONSUMER_SECRET)
		 *    --> Authorization URL returned, dispatch that as an event. View handles.
		 * 3) URL user views contains a numerical code for the user to input into a text box. On 'submit' dispatch event.
		 * 4) This service listens for that event and handles it.
		 * 5) Call to _api.connection.grantAccess(CODE), where CODE is the numerical value the user input.
		 * 6) OAuth service says there was an error or AUTHORIZED event fired.
		 * 7) Assuming authorized
		 *    --> _api.connection.accessToken.key and _api.connection.accessToken.secret get saved in EDS.
		 * 8) Otherwise dispatch failure event and view handles.
		 * 
		 **/ 
		private function initializeApi():void
		{
			
			//
			//;
			//_api.connection.addEventListener(OAuthTwitterEvent.REQUEST_TOKEN_RECEIVED, onRequestTokenReceived);
			//_api.connection.addEventListener(OAuthTwitterEvent.REQUEST_TOKEN_ERROR, onRequestTokenError);
			//_api.connection.addEventListener(OAuthTwitterEvent.ACCESS_TOKEN_ERROR, onAccessTokenError);
			//_api.connection.addEventListener(OAuthTwitterEvent.AUTHORIZED, onAuthorized);
			
			
			//_api.connection.authorize(TWITTER_CONSUMER_KEY, TWITTER_CONSUMER_SECRET);
			
			
			//for now, let's just hardcode these. We can worry about the OAuth stuff later.
			_api.connection.setConsumer(TwitterConfigs.TWITTER_CONSUMER_KEY, TwitterConfigs.TWITTER_CONSUMER_SECRET);
			_api.connection.setAccessToken(TwitterConfigs.TWITTER_ACCESS_TOKEN, TwitterConfigs.TWITTER_TOKEN_SECRET);
			
		}
		
		
		private function onRequestTokenReceived(event:OAuthTwitterEvent):void
		{
			//returns after an 'authorize' call.
			trace("Twitter Service: Can request a user token");	
			_authorizationURL = _api.connection.authorizeURL;
			
		}
		
		private function onRequestTokenError(event:OAuthTwitterEvent):void
		{
			//happens if the application keys are wrong or there's a connectino error.
			trace("Twitter Service: Connection error");
		}
		
		private function onAccessTokenError(event:OAuthTwitterEvent):void
		{
			//somehow getting the access token failed. Probably because the user put the code in wrong.
			trace("Twitter Service: Error receiving access token");
		}
		
		private function onAuthorized(event:OAuthTwitterEvent):void
		{
			//we have the user tokens and they're in the API.
			trace("Twitter Service: Good to Go");
		}
		
		public function authorizeUser(code:String):void
		{
			_api.connection.grantAccess(code);
		}
		
		
		
		/**
		 * Takes a Twitter API result and saves the latest Id to the local store for later use.
		 * 
		 * @param data             A result from the Twitter API. This will almost certainly be an ArrayCollection. If it isn't,
		 * 							no data is saved.
		 **/
		protected function storeLatestId(data:Object):void
		{
			if (data is ArrayCollection && ArrayCollection(data).length > 0)
			{
				var item:TwitterStatus = ArrayCollection(data).getItemAt(0) as TwitterStatus;
				if (item){
					trace("Saving id to the local store: " + item.id);
					var bytes:ByteArray = new ByteArray();
					bytes.writeObject(item.id);
					EncryptedLocalStore.setItem("latestTwitterId", bytes);
				}
			}
		}
		
		public function getLatestStoredId():String
		{
			var idBytes:ByteArray = EncryptedLocalStore.getItem("latestTwitterId");
			var id:String = null;
			if(idBytes){
				//bytes are a string.
				id = idBytes.readObject() as String;
			}
			return id;
		}
		
	}
}