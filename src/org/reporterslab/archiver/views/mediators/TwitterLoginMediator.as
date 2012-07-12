package org.reporterslab.archiver.views.mediators
{
	import org.reporterslab.archiver.events.ArchiverTwitterEvent;
	import org.reporterslab.archiver.services.remote.TwitterService;
	import org.reporterslab.archiver.views.components.TwitterLogin;
	import org.robotlegs.mvcs.Mediator;
	
	public class TwitterLoginMediator extends Mediator
	{
		
		[Inject]
		public var view:TwitterLogin;
		
		[Inject]
		public var twitterService:TwitterService;
		
		override public function onRegister():void
		{
			trace("Twitter login mediator initialized");
			eventMap.mapListener(eventDispatcher, ArchiverTwitterEvent.REQUIRES_LOGIN, onTwitterRequiresLogin);
			eventMap.mapListener(eventDispatcher, ArchiverTwitterEvent.CONSUMER_AUTHORIZED, onConsumerAuthorized, ArchiverTwitterEvent);
			eventMap.mapListener(eventDispatcher, ArchiverTwitterEvent.USER_AUTHORIZED, onUserAuthorized, ArchiverTwitterEvent);
			eventMap.mapListener(view, ArchiverTwitterEvent.REQUIRES_LOGIN, onTwitterRequiresLogin);
			eventMap.mapListener(view, ArchiverTwitterEvent.LOGIN, onLogin, ArchiverTwitterEvent);
			eventMap.mapListener(view, ArchiverTwitterEvent.LOGOUT, onLogout, ArchiverTwitterEvent);
			
			if(twitterService.authorized){
				view.currentState = "logout";
			}
			
		}
		
		private function onTwitterRequiresLogin(event:ArchiverTwitterEvent):void
		{
			trace("Requesting login url");
			view.currentState = "requestURL";
			twitterService.requestAuthURL();
		}
		
		private function onConsumerAuthorized(event:ArchiverTwitterEvent):void
		{
			trace("Consumer Authorized");
			view.url = twitterService.authorizationURL;
		}
		
		private function onUserAuthorized(event:ArchiverTwitterEvent):void
		{
			trace("user authorized");
			view.currentState = "authorized";
		}
		
		private function onLogin(event:ArchiverTwitterEvent):void
		{
			trace("Login clicked");
			twitterService.authorizeUser(view.code);
			view.currentState = "authorizing";
		}
		
		private function onLogout(event:ArchiverTwitterEvent):void
		{
			trace("logout clicked");
			view.currentState = "login";
			twitterService.requestAuthURL();
		}
		
	}
}