package org.reporterslab.archiver.services.database
{
	import com.probertson.data.QueuedStatement;
	import com.probertson.data.SQLRunner;
	
	import flash.data.SQLResult;
	import flash.errors.SQLError;
	
	import org.reporterslab.archiver.models.vo.Entity;
	import org.reporterslab.archiver.models.vo.Status;
	import org.robotlegs.mvcs.Actor;
	
	public class ArchiverDBEntityService extends Actor
	{
		
		[Inject]
		public var sqlRunner:SQLRunner;
		
		private var statusIdsToStatus:Object = {};
		
		
		public function ArchiverDBEntityService()
		{
			super();
		}
		
		

//===================================== FOR FLESHING OUT STATUSES WITH THEIR ENTITIES =========================
		
		public function loadEntitiesForStatus(status:Status):void
		{
			statusIdsToStatus[status.id] = status;
			var query:String = SELECT_ENTITIES_FOR_STATUS_SQL;
			var params:Object = {statusId:status.id};
			sqlRunner.execute(query, params, onLoadEntitiesForStatus, Entity, onLoadEntitiesForStatusError);
			
		}
		
		private function onLoadEntitiesForStatus(result:SQLResult):void
		{
			var entities:Array = result.data as Array;
			if((entities == null) || (entities.length == 0)){
				return
			}
			var status:Status = statusIdsToStatus[entities[0].ownerId];
			status.addEntities(entities);
			statusIdsToStatus[entities[0].ownerId] = null;			
		}
		
		private function onLoadEntitiesForStatusError(error:SQLError):void
		{
			trace("Error loading entities for status");
			trace(error);
		}
		
		
		/**
		 * @param entity    The entity to insert if it doesn't exist (based on unique identifiers like id or twitterId) 
		 *                    or update if it does.
		 **/
		public function getInsertOrUpdateStatement(entity:Entity):QueuedStatement
		{
			var statement:QueuedStatement = new QueuedStatement(INSERT_OR_UPDATE_ENTITY_SQL, entity.toParams());
			return statement;
		}
		
		/**
		 * @param entity    The entity to Insert
		 **/
		public function getInsertStatement(entity:Entity):QueuedStatement
		{
			var statement:QueuedStatement = new QueuedStatement(ADD_ENTITY_SQL, entity.toParams());
			return statement;
		}
		
		/**
		 * @param entity    The entity to update
		 **/
		public function getUpdateStatement(entity:Entity):QueuedStatement
		{
			var statement:QueuedStatement = new QueuedStatement(UPDATE_ENTITY_SQL, entity.toParams());
			return statement;
		}
		
		/**
		 * @param entity    The entity to delete
		 **/
		public function getDeleteStatement(entity:Entity):QueuedStatement
		{
			var statement:QueuedStatement = new QueuedStatement(DELETE_ENTITY_SQL, entity.toParams());
			return statement;
		}
		
		/**
		 * @param entity    The entity from Twitter that needs to be updated with system IDs.
		 **/
		public function getUpdateTwitterStatement(entity:Entity):QueuedStatement
		{
			var params:Object = {"twitterStatusId": entity.twitterStatusId};
			var statement:QueuedStatement = new QueuedStatement(UPDATE_TWITTER_ENTITY_SQL, params);
			return statement;
		}
		
		
		
		
		
		
		[Embed(source="sql/entity/AddEntity.sql", mimeType="application/octet-stream")]
		private static const AddEntityStatement:Class;
		private static const ADD_ENTITY_SQL:String = new AddEntityStatement();
		
		[Embed(source="sql/entity/DeleteEntity.sql", mimeType="application/octet-stream")]
		private static const DeleteEntityStatement:Class;
		private static const DELETE_ENTITY_SQL:String = new DeleteEntityStatement();
		
		[Embed(source="sql/entity/UpdateEntity.sql", mimeType="application/octet-stream")]
		private static const UpdateEntityStatement:Class;
		private static const UPDATE_ENTITY_SQL:String = new UpdateEntityStatement();
		
		[Embed(source="sql/entity/UpdateTwitterEntity.sql", mimeType="application/octet-stream")]
		private static const UpdateTwitterEntityStatement:Class;
		private static const UPDATE_TWITTER_ENTITY_SQL:String = new UpdateTwitterEntityStatement();
		
		[Embed(source="sql/entity/InsertOrUpdateEntity.sql", mimeType="application/octet-stream")]
		private static const InsertOrUpdateEntityStatement:Class;
		private static const INSERT_OR_UPDATE_ENTITY_SQL:String = new InsertOrUpdateEntityStatement();
		
		[Embed(source="sql/entity/SelectEntity.sql", mimeType="application/octet-stream")]
		private static const SelectEntityStatement:Class;
		private static const SELECT_ENTITY_SQL:String = new SelectEntityStatement();
		
		[Embed(source="sql/entity/SelectEntitiesForStatus.sql", mimeType="application/octet-stream")]
		private static const SelectEntitiesForStatusStatement:Class;
		private static const SELECT_ENTITIES_FOR_STATUS_SQL:String = new SelectEntitiesForStatusStatement();
		
		
	}
}