package org.reporterslab.archiver.services.remote
{
	import com.dborisenko.api.twitter.TwitterAPI;
	import com.dborisenko.api.twitter.oauth.events.OAuthTwitterEvent;
	
	import flash.events.Event;
	
	import org.reporterslab.archiver.events.ArchiverTwitterEvent;
	import org.reporterslab.archiver.services.remote.configs.TwitterConfigs;
	import org.robotlegs.mvcs.Actor;
	
	public class TwitterService extends Actor
	{
		
		private var _api:TwitterAPI = new TwitterAPI();
		
		private var _authorizationURL:String;
		
		public function TwitterService()
		{
			super();
			trace("Twitter Service Created");
			
			initializeApi();
			
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
		
		
	}
}