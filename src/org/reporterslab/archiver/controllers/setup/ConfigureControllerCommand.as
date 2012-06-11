package org.reporterslab.archiver.controllers.setup
{
	import org.reporterslab.archiver.TwitterLoginCommand;
	import org.reporterslab.archiver.events.ArchiverConfigurationEvent;
	import org.reporterslab.archiver.events.ArchiverTwitterEvent;
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
			//Configure the Service
			dispatch(new ArchiverConfigurationEvent(ArchiverConfigurationEvent.CONFIGURE_SERVICE));
		}
		
		
	}
}