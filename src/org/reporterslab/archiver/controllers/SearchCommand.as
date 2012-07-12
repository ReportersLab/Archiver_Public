package org.reporterslab.archiver.controllers
{
	
	import org.reporterslab.archiver.events.ArchiverSearchEvent;
	import org.reporterslab.archiver.services.database.ArchiverDBPlaceService;
	import org.reporterslab.archiver.services.database.ArchiverDBStatusService;
	import org.reporterslab.archiver.services.database.ArchiverDBUserService;
	import org.reporterslab.archiver.services.remote.TwitterService;
	import org.robotlegs.mvcs.Command;
	
	public class SearchCommand extends Command
	{
		[Inject]
		public var statusService:ArchiverDBStatusService;
		
		[Inject]
		public var userService:ArchiverDBUserService;
		
		[Inject]
		public var placeService:ArchiverDBPlaceService;
		
		[Inject]
		public var twitterService:TwitterService;
		
		[Inject]
		public var event:ArchiverSearchEvent;
		
		override public function execute():void
		{
			var query:String = event.query;
			if(!query)
				return;
			
			statusService.search(query);
			userService.search(query);
			placeService.search(query);
			
			//search remote services too?
		}
		
	}
}