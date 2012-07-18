package org.reporterslab.archiver.services.database
{
	import com.probertson.data.QueuedStatement;
	import com.probertson.data.SQLRunner;
	
	import flash.data.SQLResult;
	import flash.errors.SQLError;
	
	import org.reporterslab.archiver.events.ArchiverDBStatusEvent;
	import org.reporterslab.archiver.models.vo.Entity;
	import org.reporterslab.archiver.models.vo.Place;
	import org.reporterslab.archiver.models.vo.Status;
	import org.reporterslab.archiver.models.vo.User;
	import org.robotlegs.mvcs.Actor;
	
	
	
	
	[Event(name="statusesCreated",type="org.reporterslab.archiver.events.ArchiverDBStatusEvent")]
	[Event(name="statusesDeleted",type="org.reporterslab.archiver.events.ArchiverDBStatusEvent")]
	[Event(name="statusesLoaded",type="org.reporterslab.archiver.events.ArchiverDBStatusEvent")]
	
	[Event(name="statusCreated",type="org.reporterslab.archiver.events.ArchiverDBStatusEvent")]
	[Event(name="statusDeleted",type="org.reporterslab.archiver.events.ArchiverDBStatusEvent")]
	[Event(name="statusUpdated",type="org.reporterslab.archiver.events.ArchiverDBStatusEvent")]
	[Event(name="statusLoaded",type="org.reporterslab.archiver.events.ArchiverDBStatusEvent")]
	
	
	public class ArchiverDBStatusService extends Actor
	{
		
		[Inject]
		public var sqlRunner:SQLRunner;
		
		[Inject]
		public var userService:ArchiverDBUserService;
		
		[Inject]
		public var placeService:ArchiverDBPlaceService;
		
		[Inject]
		public var entityService:ArchiverDBEntityService;
		
		private var _savingStatuses:Vector.<Status>
		
		
		//for loading statuses for a user or a place
		protected var userIdsToUser:Object = {};
		protected var placeIdsToPlace:Object = {};
		protected var currentEntity:Entity;
		
		public function ArchiverDBStatusService()
		{
			super();
		}
		

//=========================================== STATUS SAVING =======================================================
		
		/**
		 * Not sure of the best way to link up twitterIds and system ids. If we start mixing content types (ie Twitter & Facebook)
		 * this will start to become a problem. So, this function will attempt to link items properly using system ids... 
		 * 
		 * @param statuses     The Status objects to save. These will be assumed to have come from Twitter.
		 **/
		public function saveTwitterStatuses(statuses:Vector.<Status>):void
		{
			//we're going to be adding a whole lot of stuff here.
			var statements:Vector.<QueuedStatement> = new Vector.<QueuedStatement>();
			
			for each(var status:Status in statuses){
				//first add / update the status.
				statements.push(this.getInsertOrUpdateStatement(status));
				//then add / update the user -- this should always exist, but let's be sure.
				if(status.user){
					statements.push(userService.getInsertOrUpdateStatement(status.user));
				}
				//and the place. Much more likely to be null
				if(status.place){
					statements.push(placeService.getInsertOrUpdateStatement(status.place));
				}
				
				//and all of the entities
				for each (var entity:Entity in status.entities){
					//adds the entities.
					statements.push(entityService.getInsertOrUpdateStatement(entity));
					//at this point the status, place, and user are all there. So we can get the real status ID to add to that entity.
					statements.push(entityService.getUpdateTwitterStatement(entity));
				}
				//and finally, update the status itself with the proper place and user id
				statements.push(this.getUpdateTwitterStatement(status));
			}
			trace("Number of Statuses: " + statuses.length);
			trace("Statements to Execute: " + statements.length);
			//for access later... So this method shouldn't be called twice per frame.
			//I can't find a hook anywhere to tie the statuses with the operation. executeModify returns void or I'd use a Dictionary.
			_savingStatuses = statuses;
			//and execute the statements.
			if(statements.length > 0){
				sqlRunner.executeModify(statements, onSaveStatuses, onSaveStatusesError, onSaveStatusesProgress);
			}
		}
		
		/**
		 * Saves all of the statuses in the vector. No related content like the saveTwitterStatuses method.
		 * 
		 * @param statuses      The statuses to save.
		 **/
		public function saveStatuses(statuses:Vector.<Status>):void
		{
			var statements:Vector.<QueuedStatement> = new Vector.<QueuedStatement>();
			
			for each(var status:Status in statuses){
				statements.push(this.getInsertOrUpdateStatement(status));
			}
			
			sqlRunner.executeModify(statements, onSaveStatuses, onSaveStatusesError);
		}
		
		/**
		 * Saves a status. No related content like the saveTwitterStatuses method.
		 * 
		 * @param status      The status to save.
		 **/
		public function saveStatus(status:Status):void
		{
			trace("Saving a status");
			
			var statements:Vector.<QueuedStatement> = new Vector.<QueuedStatement>();
			statements.push(this.getInsertOrUpdateStatement(status));
			sqlRunner.executeModify(statements, onSaveStatuses, onSaveStatusesError);
			
		}
		
		
		//handles statuses saved result. Could be one or more statuses here. If more, metadata results could also be included.
		public function onSaveStatuses(result:Vector.<SQLResult>):void
		{
			trace("Statuses saved");
			dispatch(new ArchiverDBStatusEvent(ArchiverDBStatusEvent.STATUSES_CREATED, null, null));
			//this.loadAllStatuses();
			if(_savingStatuses.length > 0){
				if((_savingStatuses[0].statusType == Status.TYPE_TWITTER) || (_savingStatuses[0].statusType == Status.TYPE_TWITTER_SEARCH)){
					this.loadTwitterStatuses(_savingStatuses);
				}else{
					this.loadAllStatuses();
				}
			}
		}
		
		public function onSaveStatusesError(e:SQLError):void
		{
			trace("There was an error saving the statuses. Hmmm.");
			trace(e);
		}
		
		public function onSaveStatusesProgress(numStepsComplete:uint, totalSteps:uint):void
		{
			//trace("Complete: " + numStepsComplete + " of " + totalSteps);
		}
		
		
//============================================= STATUS LOADING ===========================================
		
		
		/**
		 * This should take a vector of Status objects generated from a Twitter service (as in, they have Twitter IDs, but not
		 * System IDs and query their appropriate objects from the database. Most likely called immediately after adding
		 * Twitter objects into the DB.
		 * 
		 * @param statuses         A Vector of Status objects to fill out data for.
		 **/
		public function loadTwitterStatuses(statuses:Vector.<Status>):void
		{
			var inClause:String = "(";
			var query:String = DYNAMIC_SELECT_STATUS_SQL;
			for each(var s:Status in statuses){
				inClause += "'" + s.twitterId + "',";
			}
			inClause = inClause.substr(0, inClause.length - 1) + ")"; // remove last comma.
			query = query.replace(":values", inClause);
			query = query.replace(":field", "twitterId");
			sqlRunner.execute(query, null, onLoadStatuses, Status, onLoadStatusesError);
		}
		
		public function loadAllStatuses():void
		{
			sqlRunner.execute(SELECT_ALL_STATUSES_SQL, null, onLoadStatuses, Status, onLoadStatusesError);
		}
		
		public function loadRecentStatuses():void
		{
			sqlRunner.execute(SELECT_RECENT_STATUSES_SQL, null, onLoadStatuses, Status, onLoadStatusesError);
		}
		
		protected function onLoadStatuses(result:SQLResult):void
		{
			var statuses:Vector.<Status> = genResultVector(result.data);
			dispatch(new ArchiverDBStatusEvent(ArchiverDBStatusEvent.STATUSES_LOADED, null, statuses));
		}
		
		protected function onLoadStatusesError(e:SQLError):void
		{
			trace("Error loading statuses");
			trace(e);
		}
		

		
//=========================================== LOADING STATUSES FOR A USER ==================================================

		public function loadStatusesForUser(user:User):void
		{
			userIdsToUser[user.id] = user;
			var params:Object = {userId:user.id};
			var query:String = SELECT_STATUSES_FOR_USER_SQL;
			sqlRunner.execute(query, params, onLoadStatusesForUser, Status, onLoadStatusesForUserError);
		}
		
		protected function onLoadStatusesForUser(result:SQLResult):void
		{
			var user:User;
			var statuses:Vector.<Status> = genResultVector(result.data, false);
			if(statuses.length > 0){
				user = userIdsToUser[statuses[0].userId];	
				
				for each(var s:Status in statuses){
					s.user = user;
				}
				
				user.statuses = statuses;
			}
		}
		
		protected function onLoadStatusesForUserError(error:SQLError):void
		{
			trace("Loading Statuses For User Error");
			trace(error);
		}
		
//=========================================== LOADING STATUSES FOR A PLACE =================================================
		
		public function loadStatusesForPlace(place:Place):void
		{
			placeIdsToPlace[place.id] = place;
			var params:Object = {placeId:place.id};
			var query:String = SELECT_STATUSES_FOR_PLACE_SQL;
			sqlRunner.execute(query, params, onLoadStatusesForPlace, Status, onLoadStatusesForPlaceError);
		}
		
		protected function onLoadStatusesForPlace(result:SQLResult):void
		{
			var place:Place;
			var statuses:Vector.<Status> = genResultVector(result.data);
			if(statuses.length > 0){
				place = placeIdsToPlace[statuses[0].placeId];
			
				for each(var s:Status in statuses){
					s.place = place;
				}
				place.statuses = statuses;
			}
		}
		
		protected function onLoadStatusesForPlaceError(error:SQLError):void
		{
			trace("Loading Statuses For Place Error.");
			trace(error);
		}

		
//=======================================  LOADING STATUSES FOR AN ENTITY ===================================================
		public function loadStatusesForEntity(entity:Entity):void
		{
			currentEntity = entity;
			var sql:String = SEARCH_STATUSES_SQL;
			var query:String = "";
			var params:Object = {};
			if(entity.type == Entity.ENTITY_TYPE_HASHTAG){
				query = entity.hashText;
			}else if(entity.type == Entity.ENTITY_TYPE_MENTION){
				query = entity.screenName;
			}else if(entity.type == Entity.ENTITY_TYPE_URL){
				query = entity.url; // should be the T.Co url.
			}
			params['query'] = "%" + query + "%";
			sqlRunner.execute(sql, params, onLoadStatusesForEntity, Status, onLoadStatusesForEntityError);
		}
		
		protected function onLoadStatusesForEntity(result:SQLResult):void
		{
			var entity:Entity = currentEntity;
			var statuses:Vector.<Status> = genResultVector(result.data);
			if(statuses.length > 0){
				entity.statuses = statuses;
			}
		}
		
		protected function onLoadStatusesForEntityError(error:SQLError):void
		{
			trace("Error loading statuses for entity.");
			trace(error);
		}
		
		
//================================================= SEARCHING  ==============================================================		
	
		public function search(query:String):void
		{
			query = "%" + query + "%"; // add wildcards.
			var params:Object = {'query': query};
			sqlRunner.execute(SEARCH_STATUSES_SQL, params, onSearch, Status, onSearchError);
		}

		protected function onSearch(result:SQLResult):void
		{
			var statuses:Vector.<Status> = genResultVector(result.data);
			dispatch(new ArchiverDBStatusEvent(ArchiverDBStatusEvent.STATUSES_SEARCHED, null, statuses));
		}
		
		protected function onSearchError(e:SQLError):void
		{
			trace("Error Searching Statuses");
			trace(e);
		}
		
		
		
		
		
//================================================= UTILS ==================================================================
		
		private function genResultVector(data:Object, addUser:Boolean = true):Vector.<Status>
		{
			var statuses:Vector.<Status> = new Vector.<Status>();
			
			if(data is Array)
				statuses = Vector.<Status>(data as Array);
			
			if(data is Status)
				statuses.push(data as Status);
			
			//flesh out statuses with related data.... ????? Can't decide if this is sane or not.
			//alternative is to load only small pieces of whate we need and then flesh out on demand. That's a little harder.
			if(addUser){
				for each(var s:Status in statuses){
					this.userService.loadUserForStatus(s);
				}
			}
			return statuses;
		}

		
		public function fleshOutStatus(status:Status):Status
		{
			if((status.userId != -1) && (status.user == null)){
				userService.loadUserForStatus(status);
			}
			
			if((status.placeId != -1) && (status.place == null)){
				placeService.loadPlaceForStatus(status);
			}
			
			if((status.entities == null )){
				entityService.loadEntitiesForStatus(status);
			}
			
			return status;
		}
		
		
		
//================================================== STATEMENT RETRIEVAL ====================================================		
		
		
		/**
		 * @param status     The status to insert if it doesn't exist (based on unique identifiers like id or twitterId) 
		 *                    or update if it does.
		 **/
		public function getInsertOrUpdateStatement(status:Status):QueuedStatement
		{
			var statement:QueuedStatement = new QueuedStatement(INSERT_OR_UPDATE_STATUS_SQL, status.toParams());
			return statement;
		}
		
		
		/**
		 * @param status     The status to add
		 **/
		public function getInsertStatement(status:Status):QueuedStatement
		{
			var statement:QueuedStatement = new QueuedStatement(ADD_STATUS_SQL, status.toParams());
			return statement;
		}
		
		/**
		 * @param status     The status to update
		 **/
		public function getUpdateStatement(status:Status):QueuedStatement
		{
			var statement:QueuedStatement = new QueuedStatement(UPDATE_STATUS_SQL, status.toParams());
			return statement;
		}
		
		/**
		 * @param status     The status to delete
		 **/
		public function getDeleteStatement(status:Status):QueuedStatement
		{
			var statement:QueuedStatement = new QueuedStatement(DELETE_STATUS_SQL, status.toParams());
			return statement;
		}
		
		/**
		 * @param status     The status insert if it doesn't exist (based on unique identifiers like id or twitterId) 
		 *                    or update if it does.
		 **/
		public function getUpdateTwitterStatement(status:Status):QueuedStatement
		{
			var params:Object = {"twitterId": status.twitterId, "twitterUserId": status.twitterUserId, "twitterPlaceId": status.twitterPlaceId};
			var statement:QueuedStatement = new QueuedStatement(UPDATE_TWITTER_STATUS_SQL, params);
			return statement;
		}
		
		
		
		
		[Embed(source="sql/status/AddStatus.sql", mimeType="application/octet-stream")]
		private static const AddStatusStatement:Class;
		private static const ADD_STATUS_SQL:String = new AddStatusStatement();
		
		[Embed(source="sql/status/DeleteStatus.sql", mimeType="application/octet-stream")]
		private static const DeleteStatusStatement:Class;
		private static const DELETE_STATUS_SQL:String = new DeleteStatusStatement();
		
		[Embed(source="sql/status/UpdateStatus.sql", mimeType="application/octet-stream")]
		private static const UpdateStatusStatement:Class;
		private static const UPDATE_STATUS_SQL:String = new UpdateStatusStatement();
		
		[Embed(source="sql/status/UpdateTwitterStatus.sql", mimeType="application/octet-stream")]
		private static const UpdateTwitterStatusStatement:Class;
		private static const UPDATE_TWITTER_STATUS_SQL:String = new UpdateTwitterStatusStatement();
		
		[Embed(source="sql/status/InsertOrUpdateStatus.sql", mimeType="application/octet-stream")]
		private static const InsertOrUpdateStatusStatement:Class;
		private static const INSERT_OR_UPDATE_STATUS_SQL:String = new InsertOrUpdateStatusStatement();
		
		[Embed(source="sql/status/SelectStatus.sql", mimeType="application/octet-stream")]
		private static const SelectStatusStatement:Class;
		private static const SELECT_STATUS_SQL:String = new SelectStatusStatement();
		
		[Embed(source="sql/status/DynamicSelectStatus.sql", mimeType="application/octet-stream")]
		private static const DynamicSelectStatusStatement:Class;
		private static const DYNAMIC_SELECT_STATUS_SQL:String = new DynamicSelectStatusStatement();
		
		[Embed(source="sql/status/SelectAllStatuses.sql", mimeType="application/octet-stream")]
		private static const SelectAllStatusesStatement:Class;
		private static const SELECT_ALL_STATUSES_SQL:String = new SelectAllStatusesStatement();
		
		[Embed(source="sql/status/SelectRecentStatuses.sql", mimeType="application/octet-stream")]
		private static const SelectRecentStatusesStatement:Class;
		private static const SELECT_RECENT_STATUSES_SQL:String = new SelectRecentStatusesStatement();
		
		[Embed(source="sql/status/SelectStatusesForPlace.sql", mimeType="application/octet-stream")]
		private static const SelectStatusesForPlaceStatement:Class;
		private static const SELECT_STATUSES_FOR_PLACE_SQL:String = new SelectStatusesForPlaceStatement();
		
		[Embed(source="sql/status/SelectStatusesForUser.sql", mimeType="application/octet-stream")]
		private static const SelectStatusesForUserStatement:Class;
		private static const SELECT_STATUSES_FOR_USER_SQL:String = new SelectStatusesForUserStatement();
		
		[Embed(source="sql/status/SelectStatusesForEntity.sql", mimeType="application/octet-stream")]
		private static const SelectStatusesForEntityStatement:Class;
		private static const SELECT_STATUSES_FOR_ENTITY_SQL:String = new SelectStatusesForEntityStatement();
		
		[Embed(source="sql/status/SearchStatuses.sql", mimeType="application/octet-stream")]
		private static const SearchStatusesStatement:Class;
		private static const SEARCH_STATUSES_SQL:String = new SearchStatusesStatement();
		
	}
}