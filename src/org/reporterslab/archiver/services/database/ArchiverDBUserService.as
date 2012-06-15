package org.reporterslab.archiver.services.database
{
	import com.probertson.data.SQLRunner;
	
	import org.reporterslab.archiver.models.vo.Status;
	import org.reporterslab.archiver.models.vo.User;
	import org.robotlegs.mvcs.Actor;
	
	public class ArchiverDBUserService extends Actor
	{
		
		[Inject]
		public var sqlRunner:SQLRunner;
		
		public function ArchiverDBUserService()
		{
			super();
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