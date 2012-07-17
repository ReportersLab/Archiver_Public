package org.reporterslab.archiver.views.mediators
{
	import org.reporterslab.archiver.events.ArchiverEntityEvent;
	import org.reporterslab.archiver.models.ArchiverModel;
	import org.reporterslab.archiver.views.components.EntityList;
	import org.robotlegs.mvcs.Mediator;
	
	public class EntityListMediator extends Mediator
	{
		[Inject]
		public var view:EntityList;
		
		[Inject]
		public var model:ArchiverModel;
		
		override public function onRegister():void
		{
			eventMap.mapListener(view, ArchiverEntityEvent.ENTITY_SELECTED, dispatch);
		}
	}
}