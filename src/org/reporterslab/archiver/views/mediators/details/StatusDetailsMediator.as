package org.reporterslab.archiver.views.mediators.details
{
	import org.reporterslab.archiver.events.ArchiverUserEvent;
	import org.reporterslab.archiver.views.components.details.StatusDetails;
	import org.robotlegs.mvcs.Mediator;
	
	public class StatusDetailsMediator extends Mediator
	{
		[Inject]
		public var view:StatusDetails;
		
		override public function onRegister():void
		{
			eventMap.mapListener(view, ArchiverUserEvent.USER_SELECTED, dispatch, ArchiverUserEvent);
		}
		
	}
}