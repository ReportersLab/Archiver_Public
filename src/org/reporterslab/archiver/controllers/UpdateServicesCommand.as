package org.reporterslab.archiver.controllers
{
	import org.reporterslab.archiver.events.ArchiverUpdaterEvent;
	import org.reporterslab.archiver.services.remote.TwitterService;
	import org.robotlegs.mvcs.Command;
	
	public class UpdateServicesCommand extends Command
	{
		
		[Inject]
		public var event:ArchiverUpdaterEvent;
		
		[Inject]
		public var twitterService:TwitterService;
		
		override public function execute():void
		{
			trace("Loading new data for our services.");
			//normally we'd do something more intelligent here.
			twitterService.fetchLatestData();
		}
		
	}
}