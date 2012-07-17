package org.reporterslab.archiver.controllers.setup
{
	
	import com.probertson.data.SQLRunner;
	
	import flash.data.SQLConnection;
	import flash.data.SQLMode;
	import flash.filesystem.File;
	
	import org.reporterslab.archiver.events.ArchiverConfigurationEvent;
	import org.reporterslab.archiver.services.ArchiverDBService;
	import org.reporterslab.archiver.services.database.*;
	import org.robotlegs.mvcs.Command;
	
	
	public class ConfigureDatabaseCommand extends Command
	{
		
		[Inject]
		public var event:ArchiverConfigurationEvent;
		
		
		private static const DB_DIRECTORY:String = "Archiver/data";
		private static const DB_FILE_NAME:String = "Archive.sqlite";
		private static const DB_FULL_PATH:String = "Archiver/data/Archive.sqlite";
		
		override public function execute():void
		{
			trace("Creating Database");
			
			
			//this didn't seem to work...
			//var dbFile:File = File.applicationStorageDirectory.resolvePath(DB_FILE_NAME);
			var dbFile:File = File.documentsDirectory.resolvePath(DB_FULL_PATH);
			
			
			var sqlRunner:SQLRunner = new SQLRunner(dbFile, 10);
			//create an instance of the SQLRunner to run SQL Commands, and an instance of the Database Service. 
			injector.mapValue(SQLRunner, sqlRunner);
			injector.mapSingleton(ArchiverDBService); // the database service -- may remove
			//services for individual data types. I'm not really sure if this is smarter or less smart than putting
			//all of the commands in one monolithic service. Or splitting it appart but not making these Actors. AAaaaahhhh.
			injector.mapSingleton(ArchiverDBStatusService);
			injector.mapSingleton(ArchiverDBPlaceService);
			injector.mapSingleton(ArchiverDBEntityService);
			injector.mapSingleton(ArchiverDBUserService);
			
			
			
			if(dbFile.exists){
				//if we have a database, go ahead to the model.
				trace("Database Configuration: Have Database File. Configuring Model");
				dispatch(new ArchiverConfigurationEvent(ArchiverConfigurationEvent.CONFIGURE_MODEL));
			}else{
				
				//So the file doesn't exist, let's see first if the directory exists and create it if needed.
				var dbDirectory:File = File.documentsDirectory.resolvePath(DB_DIRECTORY);
				
				if(!dbDirectory.exists)
				{
					dbDirectory.createDirectory();
				}
				//next, we have to create the actual database.
				var sqlConnection:SQLConnection = new SQLConnection();
				try
				{
					//database should be created here.
					sqlConnection.open(dbDirectory.resolvePath(DB_FILE_NAME), SQLMode.CREATE);
					//and we're done.
					sqlConnection.close();
				}
				catch (e:Error)
				{
					trace(e.getStackTrace());
				}
				
				
				var creator:ArchiverDBCreator = injector.instantiate(ArchiverDBCreator);
				creator.createDatabaseStructure();
				
				
			}
			
			
		}
		
	}
}