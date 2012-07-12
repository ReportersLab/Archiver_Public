package org.reporterslab.archiver.events
{
	import flash.events.Event;
	
	public class ArchiverSearchEvent extends Event
	{
		
		public static const SEARCH:String = "viewSearch";
		
		public var query:String;
		
		public function ArchiverSearchEvent(type:String, query:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.query = query;
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new ArchiverSearchEvent(type, query, bubbles, cancelable);
		}
	}
}