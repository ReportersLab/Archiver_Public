package org.reporterslab.archiver.services.database
{
	import com.probertson.data.SQLRunner;
	
	import org.reporterslab.archiver.events.ArchiverDBEvent;
	import org.reporterslab.archiver.models.vo.Status;
	import org.robotlegs.mvcs.Actor;
	
	public class ArchiverDBStatusService extends Actor
	{
		
		[Inject]
		public var sqlRunner:SQLRunner;
		
		public function ArchiverDBStatusService()
		{
			super();
		}
		
		public function saveStatuses(statuses:Vector.<Status>):void
		{
			trace("Saving new statuses");
			//actually save the data here.
			
			//get the latest data back out?
			
			
			//and notify that stuff is saved. Stuff attached.
			dispatch(new ArchiverDBEvent(ArchiverDBEvent.STATUSES_CREATED, null, statuses));
		}
		
		public function saveStatus(status:Status, suppressNotification:Boolean = false):void
		{
			trace("Saving a status");
			
			//not really sure if this is going to work this way in the end.
			//if this is a batch, don't dispatch event.
			if(!suppressNotification){
				dispatch(new ArchiverDBEvent(ArchiverDBEvent.STATUS_CREATED, status));
			}
		}
		
		
		
		
		
		
		
		
		
		[Embed(source="sql/status/AddStatus.sql", mimeType="application/octet-stream")]
		private static const AddStatusStatement:Class;
		private static const ADD_STATUS_SQL:String = new AddStatusStatement();
		
		[Embed(source="sql/status/DeleteStatus.sql", mimeType="application/octet-stream")]
		private static const DeleteStatusStatement:Class;
		private static const DELETE_STATUS_SQL:String = new DeleteStatusStatement();
		
		[Embed(source="sql/status/UpdateStatus.sql", mimeType="application/octet-stream")]
		private static const UpdateStatusStatement:Class;
		private static const UPDATE_STATUS_SQL:String = new UpdateStatusStatement();
		
		[Embed(source="sql/status/InsertOrUpdateStatus.sql", mimeType="application/octet-stream")]
		private static const InsertOrUpdateStatusStatement:Class;
		private static const INSERT_OR_UPDATE_STATUS_SQL:String = new InsertOrUpdateStatusStatement();
		
		[Embed(source="sql/status/SelectStatus.sql", mimeType="application/octet-stream")]
		private static const SelectStatusStatement:Class;
		private static const SELECT_STATUS_SQL:String = new SelectStatusStatement();
		
		[Embed(source="sql/status/SelectAllStatuses.sql", mimeType="application/octet-stream")]
		private static const SelectAllStatusesStatement:Class;
		private static const SELECT_ALL_STATUSES_SQL:String = new SelectAllStatusesStatement();
		
		[Embed(source="sql/status/SelectStatusesForPlace.sql", mimeType="application/octet-stream")]
		private static const SelectStatusesForPlaceStatement:Class;
		private static const SELECT_STATUSES_FOR_PLACE_SQL:String = new SelectStatusesForPlaceStatement();
		
		[Embed(source="sql/status/SelectStatusesForUser.sql", mimeType="application/octet-stream")]
		private static const SelectStatusesForUserStatement:Class;
		private static const SELECT_STATUSES_FOR_USER_SQL:String = new SelectStatusesForUserStatement();
		
		
	}
}