package org.reporterslab.archiver.controllers.setup
{
	import com.probertson.data.SQLRunner;
	
	import flash.filesystem.File;
	
	import org.reporterslab.archiver.events.ArchiverConfigurationEvent;
	import org.reporterslab.archiver.services.ArchiverDBService;
	import org.reporterslab.archiver.services.TimedUpdaterService;
	import org.reporterslab.archiver.services.remote.TwitterService;
	import org.robotlegs.mvcs.Command;
	
	public class ConfigureServiceCommand extends Command
	{
		
		[Inject]
		public var event:ArchiverConfigurationEvent;
		
		
		private static const DB_FILE_NAME:String = "data/Archive.db";
		
		override public function execute():void
		{
			trace("Configuring the Services");
			//configure the service.
			configureSQLService();
		}
		
		
		protected function configureSQLService():void
		{
			var dbFile:File = File.applicationDirectory.resolvePath(DB_FILE_NAME);
			var sqlRunner:SQLRunner = new SQLRunner(dbFile);
			//create an instance of the SQLRunner to run SQL Commands, and an instance of the Database Service. 
			injector.mapValue(SQLRunner, sqlRunner);
			injector.mapSingleton(ArchiverDBService); // the database service
			
			//map an instance of the Timed Updater Service to notify other services when they should fetch new data.
			//created here so it starts immediately. Not sure if necessary?
			var updater:TimedUpdaterService = injector.instantiate(TimedUpdaterService);
			injector.mapValue(TimedUpdaterService, updater);
			
			//And the Twitter Service.
			injector.mapSingleton(TwitterService);
			
			
			
			if(dbFile.exists){
				//if we have a database, go ahead to the model.
				trace("Service Configuration: Have Database File");
				dispatch(new ArchiverConfigurationEvent(ArchiverConfigurationEvent.CONFIGURE_MODEL));
			}else{
				//if no database exists yet, create it.
				trace("Service Configuration: No Database File");
				dispatch(new ArchiverConfigurationEvent(ArchiverConfigurationEvent.CONFIGURE_DATABASE));
			}
			
			
		}
		
		
	}
}