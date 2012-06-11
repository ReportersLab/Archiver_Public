package org.reporterslab.archiver.controllers.setup
{
	import org.reporterslab.archiver.events.ArchiverConfigurationEvent;
	import org.robotlegs.mvcs.Command;
	
	public class ConfigureDatabaseCommand extends Command
	{
		
		[Inject]
		public var event:ArchiverConfigurationEvent;
		
		override public function execute():void
		{
			trace("Creating Database");
			
			// configure the database if it doesn't exist.
			//var creator:DatabaseCreator = injector.instantiate(DatabaseCreator);
			//creator.createDatabaseStructure();
			
			//normally we would detain this command and listen for a completed event on the database constructor.
			//then we could fire the model configuration event. OR we could just have the creator fire that event...
			dispatch(new ArchiverConfigurationEvent(ArchiverConfigurationEvent.CONFIGURE_MODEL));
			
		}
		
	}
}