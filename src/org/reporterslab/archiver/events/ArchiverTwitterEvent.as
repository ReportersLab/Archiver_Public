package org.reporterslab.archiver.events
{
	import flash.events.Event;
	
	public class ArchiverTwitterEvent extends Event
	{
		//fired if the service needs to be logged in.
		public static const REQUIRES_LOGIN:String = "twitterRequiresLogin";
		//fired when application is authorized, user can login with url stored in 'data' object
		public static const CONSUMER_AUTHORIZED:String = "twitterConsumerAuthorized";
		//fired when user is authorized and API is read.
		public static const USER_AUTHORIZED:String = "twitterUserAuthorized";
		//fired when there's an error. Urgh.
		public static const KEY_ERROR:String = "twitterLoginError";
		
		//From the View
		public static const LOGIN:String = "twitterLogin";
		public static const LOGOUT:String = "twitterLogout";
		
		public var data:Object;
		
		public function ArchiverTwitterEvent(type:String, data:Object = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.data = data;
		}
		
		override public function clone():Event
		{
			return new ArchiverTwitterEvent(type, data, bubbles, cancelable);
		}
		
		override public function toString():String{
			return formatToString("ArchiverTwitterEvent", "type", "bubbles", "cancelable", "eventPhase", "code", "data");
		}
		
	}
}