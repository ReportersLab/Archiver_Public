package org.reporterslab.archiver.services.database.loaders
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import org.reporterslab.archiver.services.database.ArchiverDBUserService;
	
	public class UserLoader extends EventDispatcher
	{
		protected var service:ArchiverDBUserService;
		
		public function UserLoader(service:ArchiverDBUserService, userId:int = null)
		{
			if(userId)
				loadUserById(userId);
		}
		
		public function loadUserById(id:int):void
		{
			
		}
		
		
		
	}
}