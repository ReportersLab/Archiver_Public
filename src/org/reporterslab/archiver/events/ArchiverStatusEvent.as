package org.reporterslab.archiver.events
{
	import flash.events.Event;
	
	import org.reporterslab.archiver.models.vo.Status;
	
	public class ArchiverStatusEvent extends Event
	{
		public static const STATUS_SELECTED:String = "statusEventStatusSelected";
		
		public var status:Status;
		
		public function ArchiverStatusEvent(type:String, status:Status = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.status = status;
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new ArchiverStatusEvent(type, status, bubbles, cancelable);	
		}
	}
}