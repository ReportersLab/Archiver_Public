package org.reporterslab.archiver.events
{
	import flash.events.Event;
	
	public class ArchiverContentEvent extends Event
	{
		
		public static const NEW_CONTENT:String = "newContent";
		public static const ERROR_LOADING_CONTENT:String = "errorLoadingContent";
		
		
		public static const TYPE_TWITTER:String = "twitter";
		//future types?
		//public static const TYPE_FACEBOOK:String = "facebook";
		//public static const TYPE_RSS:String = "rss";
		
		public var contentType:String;
		public var data:Object;
		
		public function ArchiverContentEvent(type:String, contentType:String, data:Object, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.contentType = contentType;
			this.data = data;
		}
		
		override public function clone():Event
		{
			return new ArchiverContentEvent(type, contentType, data, bubbles, cancelable);
		}
		
		override public function toString():String{
			return formatToString("ArchiverContentEvent", "type", "bubbles", "cancelable", "eventPhase", "contentType", "data");
		}
	}
}