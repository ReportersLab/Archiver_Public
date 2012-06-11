package org.reporterslab.archiver
{
	import flash.display.DisplayObjectContainer;
	
	import org.reporterslab.archiver.controllers.setup.StartupCommand;
	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.mvcs.Context;
	
	public class ArchiverContext extends Context
	{
		public function ArchiverContext(contextView:DisplayObjectContainer=null, autoStartup:Boolean=true)
		{
			super(contextView, autoStartup);
		}
		
		override public function startup():void
		{
			//register our startup command -- which configures EVERYTHING
			commandMap.mapEvent(ContextEvent.STARTUP, StartupCommand, ContextEvent, true);
			//lets start everything up.
			dispatchEvent(new ContextEvent(ContextEvent.STARTUP));
		}
		
	}
}