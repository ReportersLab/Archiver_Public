package org.reporterslab.archiver.controllers.setup
{
	import org.reporterslab.archiver.events.ArchiverConfigurationEvent;
	import org.reporterslab.archiver.views.mediators.ApplicationMediator;
	import org.robotlegs.mvcs.Command;
	
	public class ConfigureViewCommand extends Command
	{
		
		[Inject]
		public var event:ArchiverConfigurationEvent;
		
		override public function execute():void
		{
			trace("Configuring Views");
			//configure the views. Basically linking Mediators to Views.
			mediatorMap.mapView(Archiver, ApplicationMediator);
		}
		
	}
}