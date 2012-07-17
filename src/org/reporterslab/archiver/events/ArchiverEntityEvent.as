package org.reporterslab.archiver.events
{
	import flash.events.Event;
	
	import org.reporterslab.archiver.models.vo.Entity;
	
	public class ArchiverEntityEvent extends Event
	{
		
		public static const ENTITY_SELECTED:String = "entitySelected";
		
		public var entity:Entity;
		
		public function ArchiverEntityEvent(type:String, entity:Entity, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.entity = entity;
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new ArchiverEntityEvent(type, entity, bubbles, cancelable);
		}
	}
}