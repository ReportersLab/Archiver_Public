package org.reporterslab.archiver.views.mediators
{
	import flash.events.Event;
	
	import org.reporterslab.archiver.events.ArchiverModelEvent;
	import org.reporterslab.archiver.events.ArchiverTwitterEvent;
	import org.reporterslab.archiver.models.ArchiverModel;
	import org.robotlegs.mvcs.Mediator;
	
	public class ApplicationMediator extends Mediator
	{
		
		[Inject]
		public var view:Archiver;
		
		[Inject]
		public var model:ArchiverModel;
		
		
		override public function onRegister():void
		{
			eventMap.mapListener(view, Event.EXITING, dispatch);
			eventMap.mapListener(eventDispatcher, ArchiverModelEvent.ENTITY_SELECTED, onItemSelected, Event);
			eventMap.mapListener(eventDispatcher, ArchiverModelEvent.PLACE_SELECTED, onItemSelected, Event);
			eventMap.mapListener(eventDispatcher, ArchiverModelEvent.USER_SELECTED, onItemSelected, Event);
			eventMap.mapListener(eventDispatcher, ArchiverModelEvent.STATUS_SELECTED, onItemSelected, Event);
			eventMap.mapListener(eventDispatcher, ArchiverTwitterEvent.USER_AUTHORIZED, onUserAuthorized, ArchiverTwitterEvent);
		}
		
		public function onItemSelected(event:Event):void
		{
			view.currentState = "details";
			view.navButtons.selectedIndex = 2;
		}
		
		public function onUserAuthorized(event:ArchiverTwitterEvent):void
		{
			this.view.currentState = "live";
			view.navButtons.selectedIndex = 0;
		}
	}
}