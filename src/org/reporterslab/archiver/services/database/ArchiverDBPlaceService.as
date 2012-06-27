package org.reporterslab.archiver.services.database
{
	import com.probertson.data.QueuedStatement;
	import com.probertson.data.SQLRunner;
	
	import org.reporterslab.archiver.models.vo.Place;
	import org.reporterslab.archiver.models.vo.Status;
	import org.robotlegs.mvcs.Actor;
	
	public class ArchiverDBPlaceService extends Actor
	{
		
		[Inject]
		public var sqlRunner:SQLRunner;
		
		public function ArchiverDBPlaceService()
		{
			
			super();
		}
		
		
		/**
		 * @param place     The place to insert if it doesn't exist (based on unique identifiers like id or twitterId) 
		 *                    or update if it does.
		 **/
		public function getInsertOrUpdateStatement(place:Place):QueuedStatement
		{
			var statement:QueuedStatement = new QueuedStatement(INSERT_OR_UPDATE_PLACE_SQL, place.toParams());
			return statement;
		}
		
		/**
		 * @param place     The place to insert 
		 **/
		public function getInsertStatement(place:Place):QueuedStatement
		{
			var statement:QueuedStatement = new QueuedStatement(ADD_PLACE_SQL, place.toParams());
			return statement;
		}
		
		/**
		 * @param place     The place to update
		 **/
		public function getUpdateStatement(place:Place):QueuedStatement
		{
			var statement:QueuedStatement = new QueuedStatement(UPDATE_PLACE_SQL, place.toParams());
			return statement;
		}
		
		/**
		 * @param place     The place to delete
		 **/
		public function getDeleteStatement(place:Place):QueuedStatement
		{
			var statement:QueuedStatement = new QueuedStatement(DELETE_PLACE_SQL, place.toParams());
			return statement;
		}
		
		
		[Embed(source="sql/place/AddPlace.sql", mimeType="application/octet-stream")]
		private static const AddPlaceStatement:Class;
		private static const ADD_PLACE_SQL:String = new AddPlaceStatement();
		
		[Embed(source="sql/place/DeletePlace.sql", mimeType="application/octet-stream")]
		private static const DeletePlaceStatement:Class;
		private static const DELETE_PLACE_SQL:String = new DeletePlaceStatement();
		
		[Embed(source="sql/place/UpdatePlace.sql", mimeType="application/octet-stream")]
		private static const UpdatePlaceStatement:Class;
		private static const UPDATE_PLACE_SQL:String = new UpdatePlaceStatement();
		
		
		[Embed(source="sql/place/InsertOrUpdatePlace.sql", mimeType="application/octet-stream")]
		private static const InsertOrUpdatePlaceStatement:Class;
		private static const INSERT_OR_UPDATE_PLACE_SQL:String = new InsertOrUpdatePlaceStatement();
		
		[Embed(source="sql/place/SelectPlace.sql", mimeType="application/octet-stream")]
		private static const SelectPlaceStatement:Class;
		private static const SELECT_PLACE_SQL:String = new SelectPlaceStatement();
		
		
		
	}
}