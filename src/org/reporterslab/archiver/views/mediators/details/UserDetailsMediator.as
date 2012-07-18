package org.reporterslab.archiver.views.mediators.details
{
	import org.reporterslab.archiver.views.components.details.UserDetails;
	import org.robotlegs.mvcs.Mediator;
	
	public class UserDetailsMediator extends Mediator
	{
		
		[Inject]
		public var view:UserDetails;
		
		override public function onRegister():void
		{
			
		}
	}
}