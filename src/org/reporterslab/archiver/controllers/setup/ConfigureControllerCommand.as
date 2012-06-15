package org.reporterslab.archiver.controllers.setup
{
	import org.reporterslab.archiver.controllers.SaveContentCommand;
	import org.reporterslab.archiver.controllers.TwitterLoginCommand;
	import org.reporterslab.archiver.controllers.UpdateServicesCommand;
	import org.reporterslab.archiver.controllers.db.CreatedStatusesCommand;
	import org.reporterslab.archiver.events.ArchiverConfigurationEvent;
	import org.reporterslab.archiver.events.ArchiverContentEvent;
	import org.reporterslab.archiver.events.ArchiverDBEvent;
	import org.reporterslab.archiver.events.ArchiverTwitterEvent;
	import org.reporterslab.archiver.events.ArchiverUpdaterEvent;
	import org.robotlegs.mvcs.Command;
	
	public class ConfigureControllerCommand extends Command
	{
		
		[Inject]
		public var event:ArchiverConfigurationEvent;
		
		override public function execute():void
		{
			//configure the controllers.
			trace("Configuring the Controller.");
		
			commandMap.mapEvent(ArchiverTwitterEvent.LOGIN, TwitterLoginCommand, ArchiverTwitterEvent);
			commandMap.mapEvent(ArchiverContentEvent.NEW_CONTENT, SaveContentCommand, ArchiverContentEvent);
			commandMap.mapEvent(ArchiverUpdaterEvent.UPDATE, UpdateServicesCommand, ArchiverUpdaterEvent);
			
			//database events
			commandMap.mapEvent(ArchiverDBEvent.STATUSES_CREATED, CreatedStatusesCommand, ArchiverDBEvent); 
			
			
			
			//Configure the Service
			dispatch(new ArchiverConfigurationEvent(ArchiverConfigurationEvent.CONFIGURE_DATABASE));
		}
		
		
	}
}