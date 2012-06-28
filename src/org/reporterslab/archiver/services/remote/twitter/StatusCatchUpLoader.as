package org.reporterslab.archiver.services.remote.twitter
{
	import com.dborisenko.api.twitter.TwitterAPI;
	import com.dborisenko.api.twitter.commands.timeline.LoadHomeTimeline;
	import com.dborisenko.api.twitter.data.TwitterStatus;
	import com.dborisenko.api.twitter.events.TwitterEvent;
	import com.dborisenko.api.twitter.net.TwitterOperation;
	
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	
	//fires when either all tweets are loaded or the API stops returning results.
	[Event(name="complete", type="com.dborisenko.api.twitter.events.TwitterEvent")]
	
	
	
	
	/**
	 * The general idea here is that the Service saves the last ID that was stored in the database and we want to catch up to that
	 * ID as the application is relaunched. There are, unfortunately, a number of things on Twitter's end that make this difficult.
	 * 
	 * 1) You can only ever get the 800 latest Tweets for any given timeline from Twitter. This means if the computer is off for
	 *    the weekend or something, you're going to miss tweets. I know of no way around this.
	 * 
	 * 2) The "since_id" parameter doesn't work in the best way possible. When you pass in an ID that is older than the number of
	 *    tweets you are requesting (up to 200, which we use here) back, it automatically changes it to the the oldest tweet available
	 *    in that count range. NOT the oldest available (the 800th tweet). This means you can't catch up that way.
	 * 
	 * 3) The best way seems to be to use the max_id property. First set it to null and request the most recent 200 tweets. When
	 *    the results return loop over them to see if any match the Id of the most recent tweet you have saved (called sinceId in this
	 *    Class). If they do, you're done and can return. If not, you have to grab another 200 and check again. Keep doing this
	 *    until you have either found the id or the API refuses to return any more results.
	 *  
	 * 
	 **/ 
	public class StatusCatchUpLoader extends EventDispatcher
	{
		private var _operation:LoadHomeTimeline;
		private var _sinceId:String;
		private var _maxId:String;
		private var _statuses:ArrayCollection;
		private var _api:TwitterAPI;
		
		/**
		 * 
		 * The Status catcher-upper. Launches a series of requests to attempt to "catch up" the database to the current position
		 * on the timeline.
		 * 
		 * @param api          Required. The Twitter API you want to use to execute these calls. Must be logged in and authenticated.
		 * 
		 * @param sinceId      The most recent tweet you have stored and want to catch up from.
		 * 
		 * @param maxId        The top end you want to limit the catch up process to.
		 * 
		 **/
		public function StatusCatchUpLoader(api:TwitterAPI, sinceId:String = null, maxId:String = null)
		{
			trace("Catch Up Loader initialized, Since: " + sinceId + " , Max: " + maxId);
			_api = api;
			_sinceId = sinceId;
			_maxId = maxId;
			_statuses = new ArrayCollection();
			_operation = getOperation();
			_operation.addEventListener(TwitterEvent.COMPLETE, onLoadHomeTimeline);
			_api.post(_operation);
		}
		
		
		protected function getOperation():LoadHomeTimeline
		{
			return new LoadHomeTimeline(null, _maxId, 200);
		}
		
		protected function onLoadHomeTimeline(event:TwitterEvent):void
		{
			_operation.removeEventListener(TwitterEvent.COMPLETE, onLoadHomeTimeline);
			trace("Catch Up Progress.");
			if(event.success){
				var newMaxId:String = readMaxId(event.data);
				trace("New Max Id: " + newMaxId + " Old: " + _maxId);
				//some stuff was returned. Lets add it to the collection and then try to load more.
				if(event.data is ArrayCollection){
					var ac:ArrayCollection = event.data as ArrayCollection;
					_statuses.addAll(ac);
					
					
					//if we've found our last id, we're done and can return.
					for each(var tweet:TwitterStatus in ac){
						if(parseFloat(tweet.id) >= parseFloat(_sinceId)){
							notifyListeners();
							return;
						}
					}
					
					//if this is the last bit of data Twitter will give us, we're done and can return.
					if(
						((_maxId == newMaxId) && (_maxId != null)) 
						|| (ac.length == 0)
					){
						notifyListeners();
					//otherwise we're not done and need to get more.
					}else{
						var prevId:Number = (Number(newMaxId) -1);
						_maxId = prevId == -1 ? null : prevId.toString();
						_operation = getOperation();
						_operation.addEventListener(TwitterEvent.COMPLETE, onLoadHomeTimeline);
						_api.post(_operation);
					}
					
				}else{
					//nothing was returned, we're done.
					notifyListeners();
				}
			}else{
				//something bad happened.
				notifyListeners(event);
			}
		}
		
		protected function notifyListeners(event:TwitterEvent = null):void
		{
			//trace("Catch Up Loading Complete.");
			_operation.removeEventListener(TwitterEvent.COMPLETE, onLoadHomeTimeline);
			if(!event){
				dispatchEvent(new TwitterEvent(TwitterEvent.COMPLETE, _statuses, true));
			}else{
				//trace("There was an error catching up. " + event.data);
				dispatchEvent(new TwitterEvent(TwitterEvent.COMPLETE, event.data, false));
			}
		}

		
		protected function readSinceId(data:Object):String
		{
			//if we never sent one in to begin with, return null.
			if(_sinceId == null) 
				return null;
			
			//if the data is a collection that contains a twitter status, the one at [0] is the newest
			//and we want that Id to be the starting point for our next API call.
			if (data is ArrayCollection && ArrayCollection(data).length > 0)
			{
				var item:TwitterStatus = ArrayCollection(data).getItemAt(0) as TwitterStatus;
				if (item)
				{
					return item.id;
				}
			}
			//if no data at all, return null.
			return null;
		}
		
		protected function readMaxId(data:Object):String
		{
			//we alawys start from the beginning and move backwards until we hit the _sinceId
			//if(_sinceId == null){
				if (data is ArrayCollection && ArrayCollection(data).length > 0)
				{
					var ac:ArrayCollection = data as ArrayCollection;
					var item:TwitterStatus = ac.getItemAt(ac.length - 1) as TwitterStatus;
					if (item)
					{
						return item.id;
					}
				}
			//}
			
			//otherwise we'll just use the existing maxId, null or otherwise.
			return _maxId;
			
		}
		
	}
}