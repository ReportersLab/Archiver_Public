package org.reporterslab.archiver.events
{
	import flash.events.Event;
	
	import org.reporterslab.archiver.models.vo.Place;
	
	public class ArchiverDBPlaceEvent extends Event
	{
		public static const PLACES_CREATED:String = "DBplacesCreated";
		public static const PLACES_DELETED:String = "DBplacesDeleted";
		public static const PLACES_LOADED:String = "DBplacesLoaded";
		public static const PLACES_SEARCHED:String = "DBplacesSearched";
		
		public static const PLACE_CREATED:String = "DBplacesCreated";
		public static const PLACE_DELETED:String = "DBplacesDeleted";
		public static const PLACE_UPDATED:String = "DBplacesUpdated";
		public static const PLACE_LOADED:String = "DBplacesLoaded";
		
		
		public var place:Place
		public var places:Vector.<Place>;
		
		public function ArchiverDBPlaceEvent(type:String, place:Place = null, places:Vector.<Place> = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.place = place;
			this.places = places;			
		}
		
		override public function clone():Event
		{
			return new ArchiverDBPlaceEvent(type, place, places, bubbles, cancelable);
		}
		
		override public function toString():String{
			return formatToString("ArchiverDBPlaceEvent", "type", "bubbles", "cancelable", "eventPhase", "place", "places");
		}
	}
}