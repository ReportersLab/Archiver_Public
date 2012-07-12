package org.reporterslab.archiver.events
{
	import flash.events.Event;
	
	import org.reporterslab.archiver.models.vo.Place;
	
	public class ArchiverPlaceEvent extends Event
	{
		
		public static const PLACE_SELECTED:String = "viewPlaceSelected";
		
		public var place:Place;
		
		public function ArchiverPlaceEvent(type:String, place:Place, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.place = place;
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new ArchiverPlaceEvent(type, place, bubbles, cancelable);
		}
	}
}