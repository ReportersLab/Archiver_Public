package org.reporterslab.archiver.controllers.setup
{
	import org.reporterslab.archiver.events.ArchiverConfigurationEvent;
	import org.reporterslab.archiver.models.ArchiverModel;
	import org.robotlegs.mvcs.Command;
	
	public class ConfigureModelCommand extends Command
	{
		[Inject]
		public var event:ArchiverConfigurationEvent;
		
		override public function execute():void
		{
			trace("Configuring Model");
			//set up the model.
			injector.mapSingleton(ArchiverModel);
			dispatch(new ArchiverConfigurationEvent(ArchiverConfigurationEvent.CONFIGURE_SERVICE));
		}
		
	}
}