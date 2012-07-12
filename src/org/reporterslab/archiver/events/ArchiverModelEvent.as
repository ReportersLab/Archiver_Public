package org.reporterslab.archiver.events
{
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	import org.reporterslab.archiver.models.vo.Status;
	
	public class ArchiverModelEvent extends Event
	{
		
		public static const STATUSES_ADDED:String = "ModelstatusesAdded";
		public static const STATUSES_SEARCHED:String = "ModelstatusesSearched";
		public static const STATUSES_CHANGED:String = "ModelstatusesChanged";
		public static const STATUS_ADDED:String = "ModelstatusAdded";
		
		
		public static const STATUS_SELECTED:String = "ModelstatusSelected";
		public static const USER_SELECTED:String = "ModeluserSelected";
		public static const PLACE_SELECTED:String = "ModelplaceSelected";
		
		public static const USERS_SEARCHED:String = "ModelusersSearched";
		public static const PLACES_SEARCHED:String = "ModelplacesSearched";
		
		public var objects:ArrayCollection;
		public var object:Object;
		
		public function ArchiverModelEvent(type:String, objects:ArrayCollection = null, object:Object = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.objects = objects;
			this.object = object;
		}
		
		override public function clone():Event
		{
			return new ArchiverModelEvent(type, objects, object, bubbles, cancelable);
		}
		
		override public function toString():String
		{
			return formatToString("ArchiverModelEvent", "type", "bubbles", "cancelable", "eventPhase", "objects", "object");
		}
		
	}
}