package org.reporterslab.archiver.views.mediators
{
	import org.reporterslab.archiver.events.ArchiverModelEvent;
	import org.reporterslab.archiver.events.ArchiverSearchEvent;
	import org.reporterslab.archiver.models.ArchiverModel;
	import org.reporterslab.archiver.views.components.SearchPanel;
	import org.robotlegs.mvcs.Mediator;
	
	public class SearchPanelMediator extends Mediator
	{
		
		
		[Inject]
		public var view:SearchPanel;
		
		[Inject]
		public var model:ArchiverModel;
		
		override public function onRegister():void
		{
			eventMap.mapListener(eventDispatcher, ArchiverModelEvent.STATUSES_SEARCHED, onStatusesSearched);
			eventMap.mapListener(eventDispatcher, ArchiverModelEvent.PLACES_SEARCHED, onPlacesSearched);
			eventMap.mapListener(eventDispatcher, ArchiverModelEvent.USERS_SEARCHED, onUsersSearched);
			eventMap.mapListener(view, ArchiverSearchEvent.SEARCH, dispatch);
		}
		
		private function onStatusesSearched(event:ArchiverModelEvent):void
		{
			this.view.statuses = model.searchedStatuses;
		}
		
		private function onUsersSearched(event:ArchiverModelEvent):void
		{
			this.view.users = model.searchedUsers;	
		}
		
		private function onPlacesSearched(event:ArchiverModelEvent):void
		{
			this.view.places = model.searchedPlaces;
		}
		
	}
}