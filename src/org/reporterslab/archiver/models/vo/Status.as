package org.reporterslab.archiver.models.vo
{
	import com.dborisenko.api.twitter.data.TwitterEntity;
	import com.dborisenko.api.twitter.data.TwitterStatus;
	
	import mx.collections.ArrayCollection;

	public class Status
	{
		
		public static const TYPE_TWITTER:String = "twitter";
		public static const TYPE_TWITTER_SEARCH:String = "twitterSearch";
		
		
		[Bindable] public var statusType:String; // Twitter, Twitter Search, Facebook(?), RSS(?), etc. 
		
		//generic
		[Bindable] public var createdAt:Date;
		[Bindable] public var id:int = -1;
		[Bindable] public var text:String;
		[Bindable] public var source:String; // as in, what posted the status. In Twitter this may be something like "Web" or "Instagram"
		
		[Bindable] public var user:User; // the system user id
		[Bindable] public var userId:int = -1;
		
		//these may have to be converted into strings or pulled apart or put into separate tables or something.
		[Bindable] public var geo:Object = null; //Twitter JSON renders as: "geo": { "type":"Point", "coordinates":[37.78029, -122.39697] }
		[Bindable] public var coordinates:Object = null; //not defined in the API
		[Bindable] public var place:Place = null; //Twitter Specific for now, but may be generic. Have to look at other APIs
		[Bindable] public var placeId:int = -1; // system id of the place.
		[Bindable] public var twitterPlaceId:String = null; //place id from twitter.
		
		//twitter specific
		[Bindable] public var twitterId:String = null; // hmmmm. Probably want a unique DB id if we're mixing different status types (ie. Facebook + Twitter).
		[Bindable] public var truncated:Boolean;
		[Bindable] public var inReplyToStatusId:String;
		[Bindable] public var inReplyToUserId:String;
		[Bindable] public var favorited:Boolean;
		[Bindable] public var inReplyToScreenName:String;
		[Bindable] public var contributors:Array = null;
		[Bindable] public var retweeted:Boolean = false;
		[Bindable] public var retweetCount:int = 0;
		[Bindable] public var possiblySensitive:Boolean = false;
		[Bindable] public var searchType:String;
		[Bindable] public var twitterUserId:String; // the twitter user
		
		
		//entities -- may not be Twitter specific. Go into separate tables.
		[Bindable] public var urls:Vector.<Entity> = null;
		[Bindable] public var hashtags:Vector.<Entity> = null;
		[Bindable] public var userMentions:Vector.<Entity> = null;
		[Bindable] public var media:Vector.<Entity> = null;
		[Bindable] public var entities:Vector.<Entity> = null; // This would be a collection of the 3 above.
		[Bindable] public var entitiesAC:ArrayCollection = null;
		
		[Bindable] public var annotations:Object = null; // no idea what this is.
		[Bindable] public var isMention:Boolean = false;
		//if this is a retweet, there's an entire other status here. Probably save it as just the ID and link two.
		[Bindable] public var retweetedStatus:Status;
		[Bindable] public var retweetedStatusTwitterId:String;
		[Bindable] public var retweetedStatusId:int = -1;
		
		
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
			
			if(status.media){
				this.media = new Vector.<Entity>();
				for each(te in status.media){
					var m:Entity = new Entity();
					m.parseTwitterEntity(te, this);
					this.media.push(m);
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
		
		
		public function addEntities(entities:Array):void
		{
			urls = new Vector.<Entity>();
			hashtags = new Vector.<Entity>();
			userMentions = new Vector.<Entity>();
			media = new Vector.<Entity>();
			this.entities = new Vector.<Entity>();
			entitiesAC = new ArrayCollection();
			
			for each(var e:Entity in entities){
				if(e.type == Entity.ENTITY_TYPE_HASHTAG){
					hashtags.push(e);	
				}else if(e.type == Entity.ENTITY_TYPE_MENTION){
					userMentions.push(e);
				}else if(e.type == Entity.ENTITY_TYPE_MEDIA){
					media.push(e);
				}else{
					urls.push(e);
				}
				this.entities.push(e);
				entitiesAC.addItem(e);
			}
		}
		
		
		
		
		
		
		
		
		
		
		
	}
}