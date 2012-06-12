package org.reporterslab.archiver.controllers
{
	import org.reporterslab.archiver.events.ArchiverTwitterEvent;
	import org.reporterslab.archiver.services.remote.TwitterService;
	import org.robotlegs.mvcs.Command;
	
	public class TwitterLoginCommand extends Command
	{
		
		[Inject]
		public var event:ArchiverTwitterEvent
		
		[Inject]
		public var service:TwitterService;
		
		override public function execute():void
		{
			service.authorizeUser(event.code);	
		}
	}
}