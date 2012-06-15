package org.reporterslab.archiver.services.database
{
	import com.probertson.data.SQLRunner;
	
	import org.reporterslab.archiver.models.vo.Entity;
	import org.reporterslab.archiver.models.vo.Status;
	import org.robotlegs.mvcs.Actor;
	
	public class ArchiverDBEntityService extends Actor
	{
		
		[Inject]
		public var sqlRunner:SQLRunner;
		
		
		
		public function ArchiverDBEntityService()
		{
			super();
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