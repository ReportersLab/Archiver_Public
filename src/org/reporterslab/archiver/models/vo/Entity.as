package org.reporterslab.archiver.models.vo
{
	import com.dborisenko.api.twitter.data.TwitterEntity;

	
	/**
	 * 
	 * An Entity should basically be a part of the content as a string with metadata attached. Twitter does this for things like
	 * URLs, Hashtags, and User Mentions. I imagine there are other posibilities. They provide a start index and end index of the
	 * substring representing the entity, as well as a few pieces of metadata depending on the entity type.
	 * 
	 **/
	public class Entity
	{
		
		//as far as I can tell these are the only three types of entities so far.
		public static const ENTITY_TYPE_URL:String = "url";
		public static const ENTITY_TYPE_HASHTAG:String = "hashtag";
		public static const ENTITY_TYPE_MENTION:String = "usermention";
		
		
		public var id:int;
		public var ownerId:int;
		
		public var type:String;
		//url specific
		public var expandedURL:String;
		public var url:String;
		public var displayURL:String;
		//hashtag
		public var hashText:String;
		//user
		public var name:String;
		public var mentionId:String; // int also available.
		public var screenName:String;
		// general
		public var indices:Array;
		//derived
		public var startIndex:int;
		public var endIndex:int;
		
		
		public function Entity()
		{
			
		}
		
		public function parseTwitterEntity(entity:TwitterEntity, owner:Status):Entity
		{
			//twitter entity type strings are the same as our entity type strings.
			this.ownerId = owner.id;
			this.type = entity.type;
			this.expandedURL = entity.expandedURL;
			this.url = entity.url;
			this.displayURL = entity.displayURL;
			this.hashText = entity.hashText;
			this.name = entity.name;
			this.mentionId = entity.mentionId;
			this.screenName = entity.screenName;
			this.indices = entity.indices;
			this.startIndex = entity.startIndex;
			this.endIndex = entity.endIndex;
			
			return this;
		}
	}
}