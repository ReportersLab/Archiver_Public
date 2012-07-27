package org.reporterslab.archiver.views.mediators
{
	import org.reporterslab.archiver.events.ArchiverModelEvent;
	import org.reporterslab.archiver.events.ArchiverSearchEvent;
	import org.reporterslab.archiver.events.ArchiverTwitterEvent;
	import org.reporterslab.archiver.models.ArchiverModel;
	import org.reporterslab.archiver.services.remote.TwitterService;
	import org.reporterslab.archiver.views.components.SearchPanel;
	import org.robotlegs.mvcs.Mediator;
	
	public class SearchPanelMediator extends Mediator
	{
		
		
		[Inject]
		public var view:SearchPanel;
		
		[Inject]
		public var model:ArchiverModel;
		
		[Inject]
		public var twitterService:TwitterService;
		
		override public function onRegister():void
		{
			eventMap.mapListener(eventDispatcher, ArchiverModelEvent.STATUSES_SEARCHED, onStatusesSearched);
			eventMap.mapListener(eventDispatcher, ArchiverModelEvent.PLACES_SEARCHED, onPlacesSearched);
			eventMap.mapListener(eventDispatcher, ArchiverModelEvent.USERS_SEARCHED, onUsersSearched);
			eventMap.mapListener(view, ArchiverSearchEvent.SEARCH, dispatch);
			eventMap.mapListener(view, ArchiverTwitterEvent.ADD_SEARCH_TERM, onAddSearchTerm);
			eventMap.mapListener(view, ArchiverTwitterEvent.DELETE_SEARCH_TERM, onDeleteSearchTerm);
			this.view.twitterTerms = twitterService.getSearchTerms();
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
		
		private function onAddSearchTerm(event:ArchiverTwitterEvent):void{
			var term:String = event.data as String;
			twitterService.addSearchTermToStream(term);
			this.view.twitterTerms = twitterService.getSearchTerms();
		}
		
		private function onDeleteSearchTerm(event:ArchiverTwitterEvent):void
		{
			var term:String = event.data as String;
			twitterService.removeSearchTermFromStream(term);
			this.view.twitterTerms = twitterService.getSearchTerms();
		}
		
	}
}