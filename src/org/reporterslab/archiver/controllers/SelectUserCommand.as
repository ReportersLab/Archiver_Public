package org.reporterslab.archiver.controllers
{
	import org.reporterslab.archiver.events.ArchiverUserEvent;
	import org.reporterslab.archiver.models.ArchiverModel;
	import org.robotlegs.mvcs.Command;
	
	public class SelectUserCommand extends Command
	{
		
		[Inject]
		public var event:ArchiverUserEvent;
		
		[Inject]
		public var model:ArchiverModel;
		
		override public function execute():void
		{
			this.model.selectedUser = event.user;
		}
		
	}
}