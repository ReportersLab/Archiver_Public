package org.reporterslab.archiver.services.database
{
	import com.probertson.data.QueuedStatement;
	import com.probertson.data.SQLRunner;
	
	import flash.data.SQLResult;
	import flash.errors.SQLError;
	import flash.utils.Dictionary;
	
	import org.reporterslab.archiver.models.vo.Status;
	import org.reporterslab.archiver.models.vo.User;
	import org.robotlegs.mvcs.Actor;
	
	public class ArchiverDBUserService extends Actor
	{
		
		[Inject]
		public var sqlRunner:SQLRunner;
		
		
		private var userIdsToStatuses:Dictionary = new Dictionary(true);
		
		public function ArchiverDBUserService()
		{
			super();
		}
		
		public function loadUserForStatus(status:Status):void
		{
			//no user, we can't do anything. Shouldn't really happen.
			if(status.userId == -1)
				return;
			
			//if the user id doesn't exist in our hash yet, add a new array.
			if(userIdsToStatuses[status.userId] == null){
				userIdsToStatuses[status.userId] = new Vector.<Status>();
			}
			userIdsToStatuses[status.userId].push(status);
			var query:String = SELECT_USER_SQL;
			var params:Object = {id: status.userId};
			sqlRunner.execute(query, params, onUserLoaded, User, onUserLoadedError);
		}
		
		
		private function onUserLoaded(result:SQLResult):void
		{
			var user:User = result.data[0] as User; // should only be one.
			var statuses:Vector.<Status> = userIdsToStatuses[user.id];
			for each(var status:Status in statuses){
				status.user = user;
			}
			userIdsToStatuses[user.id] = null;
		}
		
		private function onUserLoadedError(error:SQLError):void
		{
			trace("Error loading user");
			trace(error);
		}
		
		
		/**
		 * @param user     The User to insert if it doesn't exist (based on unique identifiers like id or twitterId) 
		 *                    or update if it does.
		 **/
		public function getInsertOrUpdateStatement(user:User):QueuedStatement
		{
			var statement:QueuedStatement = new QueuedStatement(INSERT_OR_UPDATE_USER_SQL, user.toParams());
			return statement;
		}
		
		/**
		 * @param user     The User to insert.
		 **/
		public function getInsertStatement(user:User):QueuedStatement
		{
			var statement:QueuedStatement = new QueuedStatement(ADD_USER_SQL, user.toParams());
			return statement;
		}
		
		/**
		 * @param user     The User to update.
		 **/
		public function getUpdateStatement(user:User):QueuedStatement
		{
			var statement:QueuedStatement = new QueuedStatement(UPDATE_USER_SQL, user.toParams());
			return statement;
		}
		
		/**
		 * @param user     The User to delete.
		 **/
		public function getDeleteStatement(user:User):QueuedStatement
		{
			var statement:QueuedStatement = new QueuedStatement(DELETE_USER_SQL, user.toParams());
			return statement;
		}
		
		
		
		
		
		[Embed(source="sql/user/AddUser.sql", mimeType="application/octet-stream")]
		private static const AddUserStatement:Class;
		private static const ADD_USER_SQL:String = new AddUserStatement();
		
		[Embed(source="sql/user/DeleteUser.sql", mimeType="application/octet-stream")]
		private static const DeleteUserStatement:Class;
		private static const DELETE_USER_SQL:String = new DeleteUserStatement();
		
		[Embed(source="sql/user/UpdateUser.sql", mimeType="application/octet-stream")]
		private static const UpdateUserStatement:Class;
		private static const UPDATE_USER_SQL:String = new UpdateUserStatement();
		
		[Embed(source="sql/user/InsertOrUpdateUser.sql", mimeType="application/octet-stream")]
		private static const InsertOrUpdateUserStatement:Class;
		private static const INSERT_OR_UPDATE_USER_SQL:String = new InsertOrUpdateUserStatement();
		
		[Embed(source="sql/user/SelectUser.sql", mimeType="application/octet-stream")]
		private static const SelectUserStatement:Class;
		private static const SELECT_USER_SQL:String = new SelectUserStatement();
		
		[Embed(source="sql/user/SelectUserForScreenName.sql", mimeType="application/octet-stream")]
		private static const SelectUserForScreenNameStatement:Class;
		private static const SELECT_USER_FOR_SCREENNAME_SQL:String = new SelectUserForScreenNameStatement();
		
		[Embed(source="sql/user/SelectUserForTwitterId.sql", mimeType="application/octet-stream")]
		private static const SelectUserForTwitterIdStatement:Class;
		private static const SELECT_USER_FOR_TWITTER_ID_SQL:String = new SelectUserForTwitterIdStatement();
		
		
	}
}