package org.reporterslab.archiver.controllers.db
{
	import mx.collections.ArrayCollection;
	
	import org.reporterslab.archiver.events.ArchiverDBPlaceEvent;
	import org.reporterslab.archiver.models.ArchiverModel;
	import org.reporterslab.archiver.models.vo.Place;
	import org.robotlegs.mvcs.Command;
	
	public class PlacesSearchedCommand extends Command
	{
		
		[Inject]
		public var event:ArchiverDBPlaceEvent;
		
		[Inject]
		public var model:ArchiverModel;
		
		override public function execute():void
		{
			var out:ArrayCollection = new ArrayCollection();
			for each(var p:Place in event.places){
				out.addItem(p);
			}
			model.searchedPlaces = out;
		}
		
	}
}