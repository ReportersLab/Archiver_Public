package org.reporterslab.archiver.events
{
	import flash.events.Event;
	
	import org.reporterslab.archiver.models.vo.Status;
	
	public class ArchiverDBStatusEvent extends Event
	{
		
		public static const STATUSES_CREATED:String = "DBstatusesCreated";
		public static const STATUSES_DELETED:String = "DBstatusesDeleted";
		public static const STATUSES_LOADED:String = "DBstatusesLoaded";
		public static const STATUSES_SEARCHED:String = "DBstatusesSearched";
		
		public static const STATUS_CREATED:String = "DBstatusCreated";
		public static const STATUS_DELETED:String = "DBstatusDeleted";
		public static const STATUS_UPDATED:String = "DBstatusUpdated";
		public static const STATUS_LOADED:String = "DBstatusLoaded";
		
		
		public var status:Status;
		public var statuses:Vector.<Status>;
		
		public function ArchiverDBStatusEvent(type:String, status:Status = null, statuses:Vector.<Status> = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.status = status;
			this.statuses = statuses;
			
		}
		
		override public function clone():Event
		{
			return new ArchiverDBStatusEvent(type, status, statuses, bubbles, cancelable);
		}
		
		override public function toString():String{
			return formatToString("ArchiverDBStatusEvent", "type", "bubbles", "cancelable", "eventPhase", "status", "statuses");
		}
	}
}