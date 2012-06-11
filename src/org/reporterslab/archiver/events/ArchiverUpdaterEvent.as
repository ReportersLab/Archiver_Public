package org.reporterslab.archiver.events
{
	import flash.events.Event;
	
	public class ArchiverUpdaterEvent extends Event
	{
		
		public static const UPDATE:String = "update"; //fired when the timer goes off. Servies should listen.
		
		public function ArchiverUpdaterEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new ArchiverUpdaterEvent(type, bubbles, cancelable);
		}
		
		override public function toString():String{
			return formatToString("ArchiverUpdaterEvent", "type", "bubbles", "cancelable", "eventPhase");
		}
		
	}
}