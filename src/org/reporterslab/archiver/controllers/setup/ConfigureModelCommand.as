package org.reporterslab.archiver.controllers.setup
{
	import org.reporterslab.archiver.events.ArchiverConfigurationEvent;
	import org.reporterslab.archiver.models.ArchiverModel;
	import org.reporterslab.archiver.services.database.ArchiverDBStatusService;
	import org.robotlegs.mvcs.Command;
	
	public class ConfigureModelCommand extends Command
	{
		[Inject]
		public var event:ArchiverConfigurationEvent;
		
		[Inject]
		public var db:ArchiverDBStatusService;
		
		override public function execute():void
		{
			trace("Configuring Model");
			//set up the model.
			injector.mapSingleton(ArchiverModel);
			db.loadRecentStatuses();
			dispatch(new ArchiverConfigurationEvent(ArchiverConfigurationEvent.CONFIGURE_SERVICE));
		}
		
	}
}