package org.reporterslab.archiver.controllers.system
{
	import org.reporterslab.archiver.services.remote.TwitterService;
	import org.robotlegs.mvcs.Command;
	
	public class ApplicationExitingCommand extends Command
	{
		
		[Inject]
		public var twitterService:TwitterService;
		
		
		override public function execute():void
		{
			trace("System Exiting.");
			//ensure the urlstream gets closed -- Twitter seems to be picky about the thing being actually closed.
			twitterService.destroy();
		}
		
	}
}