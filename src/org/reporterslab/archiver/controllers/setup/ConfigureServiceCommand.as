package org.reporterslab.archiver.controllers.setup
{
	
	import org.reporterslab.archiver.events.ArchiverConfigurationEvent;
	import org.reporterslab.archiver.services.TimedUpdaterService;
	import org.reporterslab.archiver.services.remote.TwitterService;
	import org.robotlegs.mvcs.Command;
	
	public class ConfigureServiceCommand extends Command
	{
		
		[Inject]
		public var event:ArchiverConfigurationEvent;
		
		
		
		override public function execute():void
		{
			trace("Configuring the Services");
			//map an instance of the Timed Updater Service to notify other services when they should fetch new data.
			//created here so it starts immediately. Not sure if necessary?
			var updater:TimedUpdaterService = injector.instantiate(TimedUpdaterService);
			injector.mapValue(TimedUpdaterService, updater);
			
			//And the Twitter Service.
			var twitterService:TwitterService = injector.instantiate(TwitterService);
			injector.mapValue(TwitterService, twitterService);
			twitterService.loadLatestTimeline();
			
			dispatch(new ArchiverConfigurationEvent(ArchiverConfigurationEvent.CONFIGURE_VIEW));
		}
		
		
		
	}
}