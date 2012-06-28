package org.reporterslab.archiver.views.mediators
{
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
			
		}
		
		
	}
}