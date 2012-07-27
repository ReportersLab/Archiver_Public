package org.reporterslab.archiver.views.mediators.lists
{
	import org.reporterslab.archiver.events.ArchiverPlaceEvent;
	import org.reporterslab.archiver.models.ArchiverModel;
	import org.reporterslab.archiver.views.components.lists.PlaceList;
	import org.robotlegs.mvcs.Mediator;
	
	public class PlaceListMediator extends Mediator
	{
		
		[Inject]
		public var view:PlaceList;
		
		[Inject]
		public var model:ArchiverModel;
		
		override public function onRegister():void
		{
			eventMap.mapListener(view, ArchiverPlaceEvent.PLACE_SELECTED, dispatch);
		}
		
	}
}