package org.reporterslab.archiver.models.vo
{
	import com.dborisenko.api.twitter.data.TwitterEntity;
	import com.dborisenko.api.twitter.data.TwitterStatus;

	public class Status
	{
		
		public static const TYPE_TWITTER:String = "twitter";
		public static const TYPE_TWITTER_SEARCH:String = "twitterSearch";
		
		
		public var statusType:String; // Twitter, Twitter Search, Facebook(?), RSS(?), etc. 
		
		//generic
		public var createdAt:Date;
		public var id:String;
		public var text:String;
		public var source:String; // as in, what posted the status. In Twitter this may be something like "Web" or "Instagram"
		public var user:User; // the user that posted this status. May be null?
		
		//these may have to be converted into strings or pulled apart or put into separate tables or something.
		public var geo:Object = null; //Twitter JSON renders as: "geo": { "type":"Point", "coordinates":[37.78029, -122.39697] }
		public var coordinates:Object = null; //not defined in the API
		public var place:Place = null; //Twitter Specific for now, but may be generic. Have to look at other APIs
		
		
		//twitter specific
		public var truncated:Boolean;
		public var inReplyToStatusId:String;
		public var inReplyToUserId:String;
		public var favorited:Boolean;
		public var inReplyToScreenName:String;
		public var contributors:Array = null;
		public var retweeted:Boolean = false;
		public var retweetCount:int = 0;
		public var possiblySensitive:Boolean = false;
		public var searchType:String;
		
		//entities -- may not be Twitter specific. Go into separate tables.
		public var urls:Vector.<Entity> = null;
		public var hashtags:Vector.<Entity> = null;
		public var userMentions:Vector.<Entity> = null;
		public var entities:Vector.<Entity> = null; // This would be a collection of the 3 above.
		
		public var annotations:Object = null; // no idea what this is.
		public var isMention:Boolean = false;
		//if this is a retweet, there's an entire other status here. Probably save it as just the ID and link two.
		public var retweetedStatus:Status;
		
		
		public function Status()
		{
			
		}
		
		public function parseTwitterStatus(status:TwitterStatus):Status
		{
			var te:TwitterEntity;
			
			this.coordinates = status.coordinates;
			this.favorited = status.favorited;
			this.createdAt = status.createdAt;//CreatedAtDate.parse(status.created_at);
			this.truncated = status.truncated;
			this.text = status.text;
			this.annotations = status.annotations;
			this.contributors = status.contributors;
			this.id = status.id;
			this.geo = status.geo; // better parsing needed.
			this.inReplyToUserId = status.inReplyToUserId;
			this.inReplyToScreenName = status.inReplyToScreenName;
			
			this.source = status.source;
			this.inReplyToStatusId = status.inReplyToStatusId;
			this.retweeted = status.retweeted;
			this.retweetCount = status.retweetCount;
			this.possiblySensitive = status.possiblySensitive;
			
			if(status.user){
				this.user = new User();	
				this.user.parseTwitterUser(status.user);
			}
			
			if(status.place){
				this.place = new Place();
				this.place.parseTwitterPlace(status.place);
			}
			
			if(status.retweetedStatus){
				this.retweetedStatus = new Status();
				this.retweetedStatus.parseTwitterStatus(status.retweetedStatus);
			}
	
			if(status.urls){
				this.urls = new Vector.<Entity>();
				for each(te in status.urls){
					var urlEntity:Entity = new Entity();
					urlEntity.parseTwitterEntity(te);
					this.urls.push(urlEntity);
				}
			}
			
			if(status.hashtags){
				this.hashtags = new Vector.<Entity>();
				for each(te in status.hashtags){
					var hash:Entity = new Entity();
					hash.parseTwitterEntity(te);
					this.hashtags.push(hash);
				}
			}
			
			if(status.userMentions){
				this.userMentions = new Vector.<Entity>();
				for each(te in status.userMentions){
					var mention:Entity = new Entity();
					mention.parseTwitterEntity(te);
					this.userMentions.push(mention);
				}
			}
			
			if(status.entities){
				this.entities = new Vector.<Entity>();
				for each(te in status.entities){
					var e:Entity = new Entity();
					e.parseTwitterEntity(te);
					this.entities.push(e);
				}
			}
			
			if(status.resultType){
				this.statusType = TYPE_TWITTER_SEARCH;
				this.searchType = status.resultType;
			}else{
				this.statusType = TYPE_TWITTER;
			}		
			return this;
		}
		
		
	}
}