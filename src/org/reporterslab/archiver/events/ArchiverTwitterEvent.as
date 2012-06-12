package org.reporterslab.archiver.events
{
	import flash.events.Event;
	
	public class ArchiverTwitterEvent extends Event
	{
		
		public static const LOGIN:String = "login";
		public static const LOGOUT:String = "logout";
		
		public var code:String;
		public var data:Object;
		
		public function ArchiverTwitterEvent(type:String, code:String = null, data:Object = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.code = code;
			this.data = data;
		}
		
		override public function clone():Event
		{
			return new ArchiverTwitterEvent(type, code, data, bubbles, cancelable);
		}
		
		override public function toString():String{
			return formatToString("ArchiverTwitterEvent", "type", "bubbles", "cancelable", "eventPhase", "code", "data");
		}
		
	}
}