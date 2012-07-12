package org.reporterslab.archiver.services
{
	import com.probertson.data.SQLRunner;
	
	import mx.collections.ArrayCollection;
	
	import org.reporterslab.archiver.events.ArchiverDBStatusEvent;
	import org.reporterslab.archiver.models.vo.Status;
	import org.robotlegs.mvcs.Actor;
	

	
	public class ArchiverDBService extends Actor
	{
		[Inject]
		public var sqlRunner:SQLRunner;
		
		
		public function ArchiverDBService()
		{
			super();
			
			trace("Archiver DB Service Created");
		}
		
		public function saveStatuses(statuses:Vector.<Status>):void
		{
			trace("Saving new statuses");
			//actually save the data here.
			
			//get the latest data back out?
			
			
			//and notify that stuff is saved. Stuff attached.
			dispatch(new ArchiverDBStatusEvent(ArchiverDBStatusEvent.STATUSES_CREATED, null, statuses));
		}
		
		public function saveStatus(status:Status, suppressNotification:Boolean = false):void
		{
			trace("Saving a status");
			
			//not really sure if this is going to work this way in the end.
			//if this is a batch, don't dispatch event.
			if(!suppressNotification){
				dispatch(new ArchiverDBStatusEvent(ArchiverDBStatusEvent.STATUS_CREATED, status));
			}
		}
		
	}
}