package org.reporterslab.archiver.events
{
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	import org.reporterslab.archiver.models.vo.Status;
	
	public class ArchiverModelEvent extends Event
	{
		
		public static const STATUSES_ADDED:String = "statusesAdded";
		public static const STATUSES_SEARCHED:String = "statusesSearched";
		public static const STATUSES_CHANGED:String = "statusesChanged";
		public static const STATUS_ADDED:String = "statusAdded";
		public static const STATUS_SELECTED:String = "statusSelected";
		
		public var statuses:ArrayCollection;
		public var status:Status;
		
		public function ArchiverModelEvent(type:String, statuses:ArrayCollection = null, status:Status = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.statuses = statuses;
			this.status = status;
		}
		
		override public function clone():Event
		{
			return new ArchiverModelEvent(type, statuses, status, bubbles, cancelable);
		}
		
		override public function toString():String
		{
			return formatToString("ArchiverModelEvent", "type", "bubbles", "cancelable", "eventPhase", "statuses", "status");
		}
		
	}
}