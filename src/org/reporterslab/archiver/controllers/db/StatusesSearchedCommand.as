package org.reporterslab.archiver.controllers.db
{
	import mx.collections.ArrayCollection;
	
	import org.reporterslab.archiver.events.ArchiverDBStatusEvent;
	import org.reporterslab.archiver.models.ArchiverModel;
	import org.reporterslab.archiver.models.vo.Status;
	import org.robotlegs.mvcs.Command;
	
	public class StatusesSearchedCommand extends Command
	{
		
		[Inject]
		public var event:ArchiverDBStatusEvent;
		
		[Inject]
		public var model:ArchiverModel;

		override public function execute():void
		{
			var out:ArrayCollection = new ArrayCollection();
			for each(var s:Status in event.statuses){
				out.addItem(s);
			}
			model.searchedStatuses = out;
		}
	}
}