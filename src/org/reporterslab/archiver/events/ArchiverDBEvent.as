package org.reporterslab.archiver.events
{
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	import org.reporterslab.archiver.models.vo.Status;
	
	public class ArchiverDBEvent extends Event
	{
		
		public static const STATUSES_CREATED:String = "statusesCreated";
		public static const STATUSES_DELETED:String = "statusesDeleted";
		public static const STATUSES_SELCTED:String = "statusesSelected";
		
		public static const STATUS_CREATED:String = "statusCreated";
		public static const STATUS_DELETED:String = "statusDeleted";
		public static const STATUS_UPDATED:String = "statusUpdated";
		public static const STATUS_SELECTED:String = "statusSelected";
		
		
		public var status:Status;
		public var statuses:ArrayCollection;
		
		public function ArchiverDBEvent(type:String, status:Status = null, statuses:ArrayCollection = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.status = status;
			this.statuses = statuses;
			
		}
		
		override public function clone():Event
		{
			return new ArchiverDBEvent(type, status, statuses, bubbles, cancelable);
		}
		
		override public function toString():String{
			return formatToString("ArchiverDBEvent", "type", "bubbles", "cancelable", "eventPhase", "status", "statuses");
		}
	}
}