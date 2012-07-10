package org.reporterslab.archiver.views.mediators
{
	import org.reporterslab.archiver.events.ArchiverModelEvent;
	import org.reporterslab.archiver.events.ArchiverStatusEvent;
	import org.reporterslab.archiver.models.ArchiverModel;
	import org.reporterslab.archiver.views.components.StatusList;
	import org.robotlegs.mvcs.Mediator;
	
	public class StatusListMediator extends Mediator
	{
		
		[Inject]
		public var view:StatusList;
		
		[Inject]
		public var model:ArchiverModel;
		
		
		override public function onRegister():void
		{
			eventMap.mapListener(eventDispatcher, ArchiverModelEvent.STATUSES_ADDED, onStatusesAdded);
			eventMap.mapListener(eventDispatcher, ArchiverModelEvent.STATUSES_CHANGED, onStatusesChanged);
			eventMap.mapListener(eventDispatcher, ArchiverModelEvent.STATUS_SELECTED, onStatusSelected);
			eventMap.mapListener(view, ArchiverStatusEvent.STATUS_SELECTED, dispatch);
		}
		
		private function onStatusesAdded(event:ArchiverModelEvent):void
		{
			this.view.statuses.addAllAt(event.statuses, 0);
			this.view.selectedItem = this.view.selectedItem;
		}
		
		private function onStatusesChanged(event:ArchiverModelEvent):void
		{
			this.view.statuses = event.statuses;
			this.view.selectedItem = this.view.selectedItem;
		}
		
		private function onStatusSelected(event:ArchiverModelEvent):void
		{
			this.view.selectedItem = event.status;
		}
		
	}
}