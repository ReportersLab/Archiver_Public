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
		public var id:int = -1;
		public var text:String;
		public var source:String; // as in, what posted the status. In Twitter this may be something like "Web" or "Instagram"
		
		public var user:User; // the system user id
		public var userId:int = -1;
		
		//these may have to be converted into strings or pulled apart or put into separate tables or something.
		public var geo:Object = null; //Twitter JSON renders as: "geo": { "type":"Point", "coordinates":[37.78029, -122.39697] }
		public var coordinates:Object = null; //not defined in the API
		public var place:Place = null; //Twitter Specific for now, but may be generic. Have to look at other APIs
		public var placeId:int = -1; // system id of the place.
		public var twitterPlaceId:String = null; //place id from twitter.
		
		//twitter specific
		public var twitterId:String = null; // hmmmm. Probably want a unique DB id if we're mixing different status types (ie. Facebook + Twitter).
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
		public var twitterUserId:String; // the twitter user
		
		
		//entities -- may not be Twitter specific. Go into separate tables.
		public var urls:Vector.<Entity> = null;
		public var hashtags:Vector.<Entity> = null;
		public var userMentions:Vector.<Entity> = null;
		public var entities:Vector.<Entity> = null; // This would be a collection of the 3 above.
		
		public var annotations:Object = null; // no idea what this is.
		public var isMention:Boolean = false;
		//if this is a retweet, there's an entire other status here. Probably save it as just the ID and link two.
		public var retweetedStatus:Status;
		public var retweetedStatusTwitterId:String;
		public var retweetedStatusId:int = -1;
		
		
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
			this.twitterId = status.id;
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
				this.twitterUserId = this.user.twitterId;
			}
			
			if(status.place){
				this.place = new Place();
				this.place.parseTwitterPlace(status.place);
				this.twitterPlaceId = this.place.twitterId;
			}
			
			if(status.retweetedStatus){
				this.retweetedStatus = new Status();
				this.retweetedStatus.parseTwitterStatus(status.retweetedStatus);
				this.retweetedStatusTwitterId = this.retweetedStatus.twitterId;
			}
	
			if(status.urls){
				this.urls = new Vector.<Entity>();
				for each(te in status.urls){
					var urlEntity:Entity = new Entity();
					urlEntity.parseTwitterEntity(te, this);
					this.urls.push(urlEntity);
				}
			}
			
			if(status.hashtags){
				this.hashtags = new Vector.<Entity>();
				for each(te in status.hashtags){
					var hash:Entity = new Entity();
					hash.parseTwitterEntity(te, this);
					this.hashtags.push(hash);
				}
			}
			
			if(status.userMentions){
				this.userMentions = new Vector.<Entity>();
				for each(te in status.userMentions){
					var mention:Entity = new Entity();
					mention.parseTwitterEntity(te, this);
					this.userMentions.push(mention);
				}
			}
			
			if(status.entities){
				this.entities = new Vector.<Entity>();
				for each(te in status.entities){
					var e:Entity = new Entity();
					e.parseTwitterEntity(te, this);
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
		
		
		
		public function toParams():Object
		{
			var params:Object = {};
			
			params['statusType'] = this.statusType; 
			params['createdAt'] = this.createdAt;
			params['id'] = this.id == -1 ? null : this.id;
			params['text'] = this.text;
			params['source'] = this.source;
			params['userId'] = this.userId == -1 ? null : this.userId;
			params['geo'] = JSON.stringify(this.geo);
			params['coordinates'] =  JSON.stringify(this.coordinates);
			params['placeId'] = this.placeId == -1 ? null : this.placeId;
			params['twitterPlaceId'] = this.twitterPlaceId;
			params['twitterId'] = this.twitterId;
			params['truncated'] = this.truncated;
			params['inReplyToStatusId'] = this.inReplyToStatusId;
			params['inReplyToUserId'] = this.inReplyToUserId;
			params['favorited'] = this.favorited;
			params['inReplyToScreenName'] = this.inReplyToScreenName;
			params['contributors'] = this.contributors;
			params['retweeted'] = this.retweeted;
			params['retweetCount'] = this.retweetCount;
			params['retweetedStatusTwitterId'] = this.retweetedStatusTwitterId;
			params['retweetedStatusId'] = this.retweetedStatusId == -1 ? null : this.retweetedStatusId;
			params['possiblySensitive'] = this.possiblySensitive;
			params['searchType'] = this.searchType;
			params['twitterUserId'] = this.twitterUserId;
			params['annotations'] = this.annotations;
			params['isMention'] = this.isMention;
			
			return params;
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	}
}