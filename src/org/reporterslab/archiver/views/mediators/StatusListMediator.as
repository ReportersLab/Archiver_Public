package org.reporterslab.archiver.views.mediators
{
	import org.reporterslab.archiver.events.ArchiverModelEvent;
	import org.reporterslab.archiver.events.ArchiverStatusEvent;
	import org.reporterslab.archiver.events.ArchiverUserEvent;
	import org.reporterslab.archiver.models.ArchiverModel;
	import org.reporterslab.archiver.models.vo.Status;
	import org.reporterslab.archiver.views.components.lists.StatusList;
	import org.robotlegs.mvcs.Mediator;
	
	public class StatusListMediator extends Mediator
	{
		
		[Inject]
		public var view:StatusList;
		
		[Inject]
		public var model:ArchiverModel;
		
		
		override public function onRegister():void
		{
			eventMap.mapListener(eventDispatcher, ArchiverModelEvent.STATUSES_ADDED, onStatusesAdded, ArchiverModelEvent);
			eventMap.mapListener(eventDispatcher, ArchiverModelEvent.STATUSES_CHANGED, onStatusesChanged, ArchiverModelEvent);
			eventMap.mapListener(eventDispatcher, ArchiverModelEvent.STATUS_SELECTED, onStatusSelected, ArchiverModelEvent);
			eventMap.mapListener(view, ArchiverStatusEvent.STATUS_SELECTED, dispatch, ArchiverStatusEvent);
			eventMap.mapListener(view, ArchiverUserEvent.USER_SELECTED, dispatch, ArchiverUserEvent);
		}
		
		private function onStatusesAdded(event:ArchiverModelEvent):void
		{
			if(view.live)
				this.view.statuses.addAllAt(event.objects, 0);
			this.view.selectedItem = model.selectedStatus;
		}
		
		private function onStatusesChanged(event:ArchiverModelEvent):void
		{
			if(view.live)
				this.view.statuses = event.objects;
			this.view.selectedItem = model.selectedStatus;
		}
		
		private function onStatusSelected(event:ArchiverModelEvent):void
		{
			this.view.selectedItem = event.object as Status;
		}
		
	}
}