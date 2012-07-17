package org.reporterslab.archiver.services.database
{
	import com.probertson.data.QueuedStatement;
	import com.probertson.data.SQLRunner;
	
	import flash.data.SQLResult;
	import flash.errors.SQLError;
	import flash.utils.Dictionary;
	
	import org.reporterslab.archiver.events.ArchiverDBPlaceEvent;
	import org.reporterslab.archiver.models.vo.Place;
	import org.reporterslab.archiver.models.vo.Status;
	import org.robotlegs.mvcs.Actor;
	
	public class ArchiverDBPlaceService extends Actor
	{
		
		[Inject]
		public var sqlRunner:SQLRunner;
		
		private var placeIdsToStatuses:Dictionary = new Dictionary(true);
		
		
		public function ArchiverDBPlaceService()
		{
			super();
		}

		
		
//========================== FOR FLESHING OUT STATUSES WITH PLACE DETAILS =================================
		
		public function loadPlaceForStatus(status:Status):void
		{
			//no user, we can't do anything. Shouldn't really happen.
			if(status.placeId == -1)
				return;
			
			//if the user id doesn't exist in our hash yet, add a new array.
			if(placeIdsToStatuses[status.placeId] == null){
				placeIdsToStatuses[status.placeId] = new Vector.<Status>();
			}
			placeIdsToStatuses[status.placeId].push(status);
			var query:String = SELECT_PLACE_SQL;
			var params:Object = {id: status.placeId};
			sqlRunner.execute(query, params, onPlaceForStatusLoaded, Place, onPlaceForStatusLoadedError);
		}
		
		
		private function onPlaceForStatusLoaded(result:SQLResult):void
		{
			if(!result.data)
				return;
			
			var place:Place = result.data[0] as Place; // should only be one.
			var statuses:Vector.<Status> = placeIdsToStatuses[place.id];
			for each(var status:Status in statuses){
				status.place = place;
			}
			placeIdsToStatuses[place.id] = null;
		}
		
		private function onPlaceForStatusLoadedError(error:SQLError):void
		{
			trace("Error loading Place");
			trace(error);
		}
		
		
		
//========================================= SEARCHING =============================================
		
		public function search(query:String):void
		{
			query = "%" + query + "%";
			var params:Object = {'query':query};
			
			sqlRunner.execute(SEARCH_PLACES_SQL, params, onSearchPlaces, Place, onSearchPlacesError);
		}
		
		
		protected function onSearchPlaces(result:SQLResult):void
		{
			var places:Vector.<Place> = genPlaceVector(result.data);
			dispatch(new ArchiverDBPlaceEvent(ArchiverDBPlaceEvent.PLACES_SEARCHED, null, places));
		}
		
		protected function onSearchPlacesError(e:SQLError):void
		{
			trace("Error Searching Users");
			trace(e);
		}
		
		
//======================================== UTILS ===================================================		

		protected function genPlaceVector(data:Object):Vector.<Place>
		{
			var places:Vector.<Place> = new Vector.<Place>();
			if(data == null)
				return places;
			
			if(data is Array)
				places = Vector.<Place>(data as Array);
			
			if(data is Place)
				places.push(data as Place);
			
			return places;
		}
		
		
//================================================ STATEMENT FETCHING ==============================
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
		
		[Embed(source="sql/place/SearchPlaces.sql", mimeType="application/octet-stream")]
		private static const SearchPlacesStatement:Class;
		private static const SEARCH_PLACES_SQL:String = new SearchPlacesStatement();
		
	}
}