package org.reporterslab.archiver.views.mediators.lists
{
	import org.reporterslab.archiver.events.ArchiverUserEvent;
	import org.reporterslab.archiver.models.ArchiverModel;
	import org.reporterslab.archiver.views.components.lists.UserList;
	import org.robotlegs.mvcs.Mediator;
	
	public class UserListMediator extends Mediator
	{
		
		[Inject]
		public var view:UserList;
		
		[Inject]
		public var model:ArchiverModel;
		
		override public function onRegister():void
		{
			eventMap.mapListener(view, ArchiverUserEvent.USER_SELECTED, dispatch);
		}
	}
}