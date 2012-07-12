package org.reporterslab.archiver.events
{
	import flash.events.Event;
	
	import org.reporterslab.archiver.models.vo.User;
	
	public class ArchiverUserEvent extends Event
	{
		
		public static const USER_SELECTED:String = "viewUserSelected";
		public var user:User;
		
		
		public function ArchiverUserEvent(type:String, user:User, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.user = user;
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new ArchiverUserEvent(type, user, bubbles, cancelable);
		}
			
	}
}