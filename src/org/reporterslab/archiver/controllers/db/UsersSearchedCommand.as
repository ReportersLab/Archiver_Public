package org.reporterslab.archiver.controllers.db
{
	import mx.collections.ArrayCollection;
	
	import org.reporterslab.archiver.events.ArchiverDBUserEvent;
	import org.reporterslab.archiver.models.ArchiverModel;
	import org.reporterslab.archiver.models.vo.User;
	import org.robotlegs.mvcs.Command;
	
	
	public class UsersSearchedCommand extends Command
	{
		
		[Inject]
		public var event:ArchiverDBUserEvent;
		
		[Inject]
		public var model:ArchiverModel;
		
		override public function execute():void
		{
			var out:ArrayCollection = new ArrayCollection();
			for each(var u:User in event.users){
				out.addItem(u);
			}
			model.searchedUsers = out;
		}
		
		
	}
}