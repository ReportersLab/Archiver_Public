package org.reporterslab.archiver.services
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.reporterslab.archiver.events.ArchiverUpdaterEvent;
	import org.robotlegs.mvcs.Actor;
	
	public class TimedUpdaterService extends Actor
	{
		protected static const TIMER_DURATION:int = 1000 * 60 * 1; // one minute. 
		
		private var _timer:Timer;
		
		public function TimedUpdaterService()
		{
			super();
			_timer = new Timer(TIMER_DURATION);
			startTimer();
		}
		
		/**
		 * Called when the timer updates. Simply notifies listeners that it's time to update
		 */
		private function onTimer(event:TimerEvent):void
		{
			trace("Timer Fired");
			dispatch(new ArchiverUpdaterEvent(ArchiverUpdaterEvent.UPDATE));
		}
		
		
		public function startTimer():void
		{
			trace("Starting Timer");
			if(_timer.running)
				return;
			
			
			_timer.addEventListener(TimerEvent.TIMER, onTimer, false, 0, true);
			_timer.start();		
		}
		
		public function stopTimer():void
		{
			trace("Stopping Timer");
			if(!_timer.running)
				return;
			
			_timer.removeEventListener(TimerEvent.TIMER, onTimer);
			_timer.stop();
		}
	}
}