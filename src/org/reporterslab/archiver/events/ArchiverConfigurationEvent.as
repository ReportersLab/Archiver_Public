package org.reporterslab.archiver.events
{
	import flash.events.Event;
	
	public class ArchiverConfigurationEvent extends Event
	{
		
		public static const CONFIGURE_SERVICE:String = "configureServices"; // fire up the Twitter service
		public static const CONFIGURE_DATABASE:String = "configureDatabase"; // create the database if it doesn't exist.
		public static const CONFIGURE_VIEW:String = "configureView"; // fire up the views
		public static const CONFIGURE_MODEL:String = "configureModel"; // fire up the data model
		public static const CONFIGURE_CONTROLLER:String = "configureController"; // link the commands
		public static const CONFIGURE_LOGIN:String = "configureLogin"; // if nothing is logged in,we probably need to do something?
		
		
		public function ArchiverConfigurationEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new ArchiverConfigurationEvent(type, bubbles, cancelable);
		}
		
		override public function toString():String{
			return formatToString("ArchiverConfigurationEvent", "type", "bubbles", "cancelable", "eventPhase");
		}
		
	}
}