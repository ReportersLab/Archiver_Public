package org.reporterslab.archiver.controllers
{
	import org.reporterslab.archiver.events.ArchiverEntityEvent;
	import org.reporterslab.archiver.models.ArchiverModel;
	import org.robotlegs.mvcs.Command;
	
	public class SelectEntityCommand extends Command
	{
		
		[Inject]
		public var event:ArchiverEntityEvent;
		
		[Inject]
		public var model:ArchiverModel;
		
		override public function execute():void
		{
			this.model.selectedEntity = event.entity;
		}
		
	}
}