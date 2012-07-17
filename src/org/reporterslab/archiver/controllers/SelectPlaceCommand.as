package org.reporterslab.archiver.controllers
{
	import org.reporterslab.archiver.events.ArchiverPlaceEvent;
	import org.reporterslab.archiver.models.ArchiverModel;
	import org.robotlegs.mvcs.Command;
	
	public class SelectPlaceCommand extends Command
	{
		[Inject]
		public var event:ArchiverPlaceEvent;
		
		[Inject]
		public var model:ArchiverModel;
		
		override public function execute():void
		{
			this.model.selectedPlace = event.place;
		}
		
	}
}