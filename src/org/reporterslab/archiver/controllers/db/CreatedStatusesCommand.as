package org.reporterslab.archiver.controllers.db
{
	import org.reporterslab.archiver.events.ArchiverDBEvent;
	import org.robotlegs.mvcs.Command;
	
	public class CreatedStatusesCommand extends Command
	{
		
		[Inject]
		public var event:ArchiverDBEvent;
		
		override public function execute():void
		{
			trace("Statuses created in DB. Updating Model.");
			//this should update the model after the content is created.
		}
	}
}