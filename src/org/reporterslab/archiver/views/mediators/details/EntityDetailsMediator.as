package org.reporterslab.archiver.views.mediators.details
{
	import org.reporterslab.archiver.views.components.details.EntityDetails;
	import org.robotlegs.mvcs.Mediator;
	
	public class EntityDetailsMediator extends Mediator
	{
		
		[Inject]
		public var view:EntityDetails;
		
		override public function onRegister():void
		{
			
		}
	}
}