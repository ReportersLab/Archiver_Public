package org.reporterslab.archiver.events
{
	import flash.events.Event;
	
	import org.reporterslab.archiver.models.vo.User;
	
	public class ArchiverDBUserEvent extends Event
	{
		
		public static const USERS_CREATED:String = "DBusersCreated";
		public static const USERS_DELETED:String = "DBusersDeleted";
		public static const USERS_LOADED:String = "DBusersLoaded";
		public static const USERS_SEARCHED:String = "DBusersSearched";
		
		public static const USER_CREATED:String = "DBuserCreated";
		public static const USER_DELETED:String = "DBuserDeleted";
		public static const USER_UPDATED:String = "DBuserUpdated";
		public static const USER_LOADED:String = "DBuserLoaded";
		
		
		public var user:User;
		public var users:Vector.<User>
		
		public function ArchiverDBUserEvent(type:String, user:User, users:Vector.<User>, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.user = user;
			this.users = users;
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new ArchiverDBUserEvent(type, user, users, bubbles, cancelable);
		}
		
		override public function toString():String{
			return formatToString("ArchiverDBUserEvent", "type", "bubbles", "cancelable", "eventPhase", "user", "users");
		}
	}
}