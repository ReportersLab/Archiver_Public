package org.reporterslab.archiver.controllers.setup
{
	import org.reporterslab.archiver.events.ArchiverConfigurationEvent;
	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.mvcs.Command;
	
	public class StartupCommand extends Command
	{
		
		[Inject]
		public var event:ContextEvent;
		
		override public function execute():void
		{
			//Link commands to events
			commandMap.mapEvent(ArchiverConfigurationEvent.CONFIGURE_CONTROLLER, ConfigureControllerCommand, ArchiverConfigurationEvent);
			//Ties Database creation event. NOTE: This should only be fired if DB doesn't exist.
			commandMap.mapEvent(ArchiverConfigurationEvent.CONFIGURE_DATABASE, ConfigureDatabaseCommand, ArchiverConfigurationEvent);
			//Fired after controller is configured. Creates instances of Twitter / DB services for Injector.
			//Creates DB if needed.
			commandMap.mapEvent(ArchiverConfigurationEvent.CONFIGURE_SERVICE, ConfigureServiceCommand, ArchiverConfigurationEvent);
			//Launches data model. Called after Services and Database initialized.
			//Data flows from services into Model and then into views. One model for now?
			commandMap.mapEvent(ArchiverConfigurationEvent.CONFIGURE_MODEL, ConfigureModelCommand, ArchiverConfigurationEvent);
			//And finally let people see what all this work did.
			commandMap.mapEvent(ArchiverConfigurationEvent.CONFIGURE_VIEW, ConfigureViewCommand, ArchiverConfigurationEvent);
			
			//Let the games begin.
			dispatch(new ArchiverConfigurationEvent(ArchiverConfigurationEvent.CONFIGURE_CONTROLLER));
			
		}
		
		
	}
}