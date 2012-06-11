package org.reporterslab.archiver.events
{
	import flash.events.Event;
	
	public class ArchiverTwitterEvent extends Event
	{
		
		public static const LOGIN:String = "login";
		public static const LOGOUT:String = "logout";
		
		public var code:String;
		
		public function ArchiverTwitterEvent(type:String, code:String = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new ArchiverTwitterEvent(type, code, bubbles, cancelable);
		}
		
		override public function toString():String{
			return formatToString("ArchiverTwitterEvent", "type", "bubbles", "cancelable", "eventPhase", "code");
		}
		
	}
}