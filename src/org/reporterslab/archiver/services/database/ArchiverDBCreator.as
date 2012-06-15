package org.reporterslab.archiver.services.database
{
	import com.probertson.data.QueuedStatement;
	import com.probertson.data.SQLRunner;
	
	import flash.data.SQLResult;
	import flash.errors.SQLError;
	import flash.events.SQLErrorEvent;
	
	import org.reporterslab.archiver.events.ArchiverConfigurationEvent;
	import org.robotlegs.mvcs.Actor;

	public class ArchiverDBCreator extends Actor
	{
		
		[Inject]
		public var sqlRunner:SQLRunner;
		
		public function ArchiverDBCreator()
		{
			
		}
		
		public function createDatabaseStructure():void
		{
			trace("Creating database structure");
			var statements:Vector.<QueuedStatement> = new Vector.<QueuedStatement>();
			var createEntity:QueuedStatement = new QueuedStatement(CREATE_ENTITY_TABLE_SQL);
			var createPlace:QueuedStatement = new QueuedStatement(CREATE_PLACE_TABLE_SQL);
			var createStatus:QueuedStatement = new QueuedStatement(CREATE_STATUS_TABLE_SQL);
			var createUser:QueuedStatement = new QueuedStatement(CREATE_USER_TABLE_SQL);
			statements.push(createEntity);
			statements.push(createPlace);
			statements.push(createStatus);
			statements.push(createUser);			
			sqlRunner.executeModify(statements, onCreateDB, onCreateError, null);
		}
		
		private function onCreateDB(result:Vector.<SQLResult>):void
		{
			trace("Created the database...");
			//we can continue launching the application.
			dispatch(new ArchiverConfigurationEvent(ArchiverConfigurationEvent.CONFIGURE_MODEL));
		}
		
		private function onCreateError(e:SQLError):void
		{
			trace(e);
		}
		
		
		
		[Embed(source="sql/create/CreateEntityTable.sql", mimeType="application/octet-stream")]
		private static const CreateEntityTableStatement:Class;
		private static const CREATE_ENTITY_TABLE_SQL:String = new CreateEntityTableStatement();
		
		[Embed(source="sql/create/CreatePlaceTable.sql", mimeType="application/octet-stream")]
		private static const CreatePlaceTableStatement:Class;
		private static const CREATE_PLACE_TABLE_SQL:String = new CreatePlaceTableStatement();
		
		[Embed(source="sql/create/CreateStatusTable.sql", mimeType="application/octet-stream")]
		private static const CreateStatusTableStatement:Class;
		private static const CREATE_STATUS_TABLE_SQL:String = new CreateStatusTableStatement();
		
		[Embed(source="sql/create/CreateUserTable.sql", mimeType="application/octet-stream")]
		private static const CreateUserTableStatement:Class;
		private static const CREATE_USER_TABLE_SQL:String = new CreateUserTableStatement();
		
	}
}