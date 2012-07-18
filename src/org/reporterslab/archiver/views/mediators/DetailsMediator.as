package org.reporterslab.archiver.views.mediators
{
	import org.reporterslab.archiver.events.ArchiverModelEvent;
	import org.reporterslab.archiver.models.ArchiverModel;
	import org.reporterslab.archiver.services.database.ArchiverDBStatusService;
	import org.reporterslab.archiver.views.components.Details;
	import org.robotlegs.mvcs.Mediator;
	
	public class DetailsMediator extends Mediator
	{
		
		[Inject]
		public var view:Details;
		
		[Inject]
		public var model:ArchiverModel;
		
		[Inject]
		public var db:ArchiverDBStatusService;
		
		override public function onRegister():void
		{
			eventMap.mapListener(eventDispatcher, ArchiverModelEvent.STATUS_SELECTED, onStatusSelected);
			eventMap.mapListener(eventDispatcher, ArchiverModelEvent.PLACE_SELECTED, onPlaceSelected);
			eventMap.mapListener(eventDispatcher, ArchiverModelEvent.USER_SELECTED, onUserSelected);
			eventMap.mapListener(eventDispatcher, ArchiverModelEvent.ENTITY_SELECTED, onEntitySelected);
		}
		
		private function onStatusSelected(event:ArchiverModelEvent):void
		{
			view.status = model.selectedStatus;
			db.fleshOutStatus(view.status);
			db.loadStatusesForUser(view.status.user);
		}
		
		private function onPlaceSelected(event:ArchiverModelEvent):void
		{
			view.place = model.selectedPlace;
			db.loadStatusesForPlace(view.place);
		}
		
		private function onUserSelected(event:ArchiverModelEvent):void
		{
			view.user = model.selectedUser;
			db.loadStatusesForUser(view.user);
		}
		
		private function onEntitySelected(event:ArchiverModelEvent):void
		{
			view.entity = model.selectedEntity;
			db.loadStatusesForEntity(view.entity);
		}
		
	}
}