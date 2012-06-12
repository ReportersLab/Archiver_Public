package org.reporterslab.archiver.controllers
{
	import mx.collections.ArrayCollection;
	
	import org.reporterslab.archiver.events.ArchiverContentEvent;
	import org.reporterslab.archiver.models.vo.Status;
	import org.reporterslab.archiver.services.ArchiverDBService;
	import org.robotlegs.mvcs.Command;
	
	public class SaveContentCommand extends Command
	{
		
		[Inject]
		public var event:ArchiverContentEvent;
		
		[Inject]
		public var dataService:ArchiverDBService;
		
		override public function execute():void
		{
			/**
			* first we should save the data with the data service.
			* data service should probably send up an event when saved, which another command would
			* handle and tell the model.
			**/
			
			trace("Have some new statuses");
			//save the data.
			if(event.data is ArrayCollection){
				dataService.saveStatuses(event.data as ArrayCollection);
			}else if (event.data is Status){
				dataService.saveStatus(event.data as Status);
			}
			
		}
		
		
	}
}