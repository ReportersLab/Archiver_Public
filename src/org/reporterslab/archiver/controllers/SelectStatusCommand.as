package org.reporterslab.archiver.controllers
{
	import org.reporterslab.archiver.events.ArchiverStatusEvent;
	import org.reporterslab.archiver.models.ArchiverModel;
	import org.robotlegs.mvcs.Command;
	
	public class SelectStatusCommand extends Command
	{
		[Inject]
		public var event:ArchiverStatusEvent;
		
		[Inject]
		public var model:ArchiverModel;
		
		override public function execute():void
		{
			this.model.selectedStatus = event.status;
		}
		
	}
}