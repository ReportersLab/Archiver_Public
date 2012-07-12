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
		
		
		[Bindable] public var id:String = null;
		[Bindable] public var ownerId:int = -1;
		
		[Bindable] public var twitterStatusId:String;
		[Bindable] public var type:String;
		//url specific
		[Bindable] public var expandedURL:String;
		[Bindable] public var url:String;
		[Bindable] public var displayURL:String;
		//hashtag
		[Bindable] public var hashText:String;
		//user
		[Bindable] public var name:String;
		[Bindable] public var mentionId:String; // int also available.
		[Bindable] public var screenName:String;
		// general
		[Bindable] public var indices:Array;
		//derived
		[Bindable] public var startIndex:int;
		[Bindable] public var endIndex:int;
		
		
		public function Entity()
		{
			
		}
		
		public function parseTwitterEntity(entity:TwitterEntity, owner:Status):Entity
		{
			//twitter entity type strings are the same as our entity type strings.
			this.ownerId = owner.id;
			this.twitterStatusId = owner.twitterId;
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
		
		public function toParams():Object
		{
			var params:Object = {};
			params['ownerId'] = this.ownerId;
			params['twitterStatusId'] = this.twitterStatusId;
			params['type'] = this.type;
			params['expandedURL'] = this.expandedURL;
			params['url'] = this.url;
			params['displayURL'] = this.displayURL;
			params['hashText'] = this.hashText;
			params['name'] = this.name;
			params['mentionId'] = this.mentionId;
			params['screenName'] = this.screenName;
			params['startIndex'] = this.startIndex;
			params['endIndex'] = this.endIndex;
			params['id'] = this.id;
			
			//we need to make sure the ID is unique for this entity. Twitter doesn't send an ID withi it.
			if(this.id == null){
				if(this.twitterStatusId != null){
					//a Twitter Entity should probably be unique by the statusId and the start and end indexes.
					params['id'] = this.twitterStatusId + "_" + this.type + "_" + this.startIndex.toString() + "_" + this.endIndex.toString();
				}else if (this.ownerId != -1){
					//we can probably do the same for a non twitter entity
					params['id'] = this.ownerId + "_" + this.type + "_" + this.startIndex.toString() + "_" + this.endIndex.toString();
				}else{
					//and if we have no id at all -- probably on an import from a non-Twitter service, make something up.
					params['id'] = this.type + "_" + this.startIndex.toString() + "_" + this.endIndex.toString();
				}
			}
						
			return params;	
		}
		
		
		
	}
}