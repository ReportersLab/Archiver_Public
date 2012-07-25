package org.reporterslab.archiver.models.vo
{
	import com.dborisenko.api.twitter.data.TwitterUser;
	
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	import mx.collections.SortField;

	public class User
	{
		
		//generic
		[Bindable] public var id:int = -1;
		[Bindable] public var name:String;
		[Bindable] public var screenName:String;
		[Bindable] public var location:String;
		[Bindable] public var description:String;
		[Bindable] public var profileImageUrl:String;
		[Bindable] public var url:String;
		[Bindable] public var firstName:String; // may never need.
		[Bindable] public var lastName:String; // may never need.
		
		//twitter specific
		[Bindable] public var twitterId:String;
		[Bindable] public var isProtected:Boolean;
		[Bindable] public var friendCount:Number;
		[Bindable] public var followersCount:Number;
		[Bindable] public var createdAt:Date;
		[Bindable] public var favouritesCount:Number;
		[Bindable] public var utcOffset:int;
		[Bindable] public var timeZone:String;
		[Bindable] public var notifications:Boolean;
		[Bindable] public var statusesCount:Number;
		[Bindable] public var profileBackgroundColor:String;
		[Bindable] public var profileTextColor:String;
		[Bindable] public var profileLinkColor:String;
		[Bindable] public var profileSidebarFillColor:String;
		[Bindable] public var profileSidebarBorderColor:String;
		[Bindable] public var profileBackgroundImageUrl:String;
		[Bindable] public var profileBackgroundTile:String;
		[Bindable] public var profileUseBackgroundImage:Boolean = false;
		[Bindable] public var defaultProfileImage:Boolean = false;
		[Bindable] public var isTranslator:Boolean = false;
		[Bindable] public var followRequestSent:Boolean = false;
		[Bindable] public var contributorsEnabled:Boolean = false;
		[Bindable] public var defaultProfile:Boolean = false;
		[Bindable] public var listedCount:int = 0;
		[Bindable] public var language:String = "en";
		[Bindable] public var geoEnabled:Boolean = false;
		[Bindable] public var verified:Boolean = false;
		[Bindable] public var showAllInlineMedia:Boolean = false;
		
		[Bindable] public var following:Boolean;
		[Bindable] public var follower:Boolean;
		[Bindable] public var blocked:Boolean;
		
		[Bindable] public var statusId:String;
		[Bindable] public var status:Status;
		//so if we want to laod the statuses for this user...
		private var _statuses:Vector.<Status>;
		[Bindable] public var statusesAC:ArrayCollection;
		[Bindable] public var chartDataAC:ArrayCollection = new ArrayCollection();
		
		
		public function set statuses(value:Vector.<Status>):void
		{
			this._statuses = value;
			this.statusesAC = new ArrayCollection();
			for each(var s:Status in statuses){
				statusesAC.addItem(s);
			}
			genChartData();
		}
		public function get statuses():Vector.<Status>
		{
			return _statuses;
		}
		
		
		public function User()
		{
			
		}
		
		public function parseTwitterUser(user:TwitterUser):User
		{
			
			this.twitterId = user.id;
			this.name = user.name;
			this.screenName = user.screenName;
			this.location = user.location;
			this.description = user.description;
			this.profileImageUrl = user.profileImageUrl;
			this.url = user.url;
			this.isProtected = user.isProtected;
			this.friendCount = user.friendsCount;
			this.followersCount = user.followersCount;
			this.createdAt = user.createdAt;
			this.favouritesCount = user.favouritesCount;
			this.utcOffset = user.utcOffset;
			this.timeZone = user.timeZone;
			this.notifications = user.notifications;
			this.statusesCount = user.statusesCount;
			this.profileBackgroundColor = user.profileBackgroundColor;
			this.profileTextColor = user.profileTextColor;
			this.profileLinkColor = user.profileLinkColor;
			this.profileSidebarFillColor = user.profileSidebarFillColor;
			this.profileSidebarBorderColor = user.profileSidebarBorderColor;
			this.profileBackgroundImageUrl = user.profileBackgroundImageUrl;
			this.profileBackgroundTile = user.profileBackgroundTile;
			this.profileUseBackgroundImage = user.profileUseBackgroundImage;
			this.defaultProfileImage = user.defaultProfileImage;
			this.isTranslator = user.isTranslator;
			this.followRequestSent = user.followRequestSent;
			this.contributorsEnabled = user.contributorsEnabled;
			this.defaultProfile = user.defaultProfile;
			this.listedCount = user.listedCount;
			this.language = user.language;
			this.geoEnabled = user.geoEnabled;
			this.verified = user.verified;
			this.showAllInlineMedia = user.showAllInlineMedia;
			this.following = user.following;
			this.follower = user.isFollower;
			this.blocked = user.isBlocked;
			
			if(user.status){
				this.status = new Status();
				this.status.parseTwitterStatus(user.status);
				this.status.user = this;
			}
			
			return this;
		}
		
		
		public function toParams():Object
		{
			var params:Object = {};
			
			params['id'] = this.id == -1 ? null : this.id;
			params['name'] = this.name;
			params['screenName'] = this.screenName;
			params['location'] = this.location;
			params['description'] = this.description;
			params['profileImageUrl'] = this.profileImageUrl;
			params['url'] = this.url;
			params['firstName'] = this.firstName;
			params['lastName'] = this.lastName;
			params['twitterId'] = this.twitterId;
			params['isProtected'] = this.isProtected;
			params['friendCount'] = this.friendCount;
			params['followersCount'] = this.followersCount;
			params['createdAt'] = this.createdAt;
			params['favouritesCount'] = this.favouritesCount;
			params['utcOffset'] = this.utcOffset;
			params['timeZone'] = this.timeZone;
			params['notifications'] = this.notifications;
			params['statusesCount'] = this.statusesCount;
			params['profileBackgroundColor'] = this.profileBackgroundColor;
			params['profileTextColor'] = this.profileTextColor;
			params['profileLinkColor'] = this.profileLinkColor;
			params['profileSidebarFillColor'] = this.profileSidebarFillColor;
			params['profileSidebarBorderColor'] = this.profileSidebarBorderColor;
			params['profileBackgroundImageUrl'] = this.profileBackgroundImageUrl;
			params['profileBackgroundTile'] = this.profileBackgroundTile;
			params['profileUseBackgroundImage'] = this.profileUseBackgroundImage;
			params['defaultProfileImage'] = this.defaultProfileImage;
			params['isTranslator'] = this.isTranslator;
			params['followRequestSent'] = this.followRequestSent;
			params['contributorsEnabled'] = this.contributorsEnabled;
			params['defaultProfile'] = this.defaultProfile;
			params['listedCount'] = this.listedCount;
			params['language'] = this.language;
			params['geoEnabled'] = this.geoEnabled;
			params['verified'] = this.verified;
			params['showAllInlineMedia'] = this.showAllInlineMedia;
			params['following'] = this.following;
			params['follower'] = this.follower;
			params['blocked'] = this.blocked;
			params['statusId'] = this.status != null ? this.status.id : null;
			return params;
			
		}
		
		
		
		public function genChartData():void
		{
			var dateHash:Object = {};
			chartDataAC = new ArrayCollection();
			for each (var s:Status in statusesAC){
				var key:String = s.createdAt.month + "-" + s.createdAt.date + "-" + s.createdAt.fullYear;
				var dateData:Object = dateHash[key];
				if(!dateData){
					dateData = {date:key, fullDate:new Date(s.createdAt.fullYear, s.createdAt.month, s.createdAt.date), statuses:0};
					dateHash[key] = dateData;
				}
				dateData['statuses']++;
			}
			
			for each(var item:Object in dateHash){
				chartDataAC.addItem(item);
			}
			
			var sortField:SortField = new SortField("fullDate", false, true);
			var sort:Sort = new Sort();
			sort.fields = [sortField];
			chartDataAC.sort = sort;
			chartDataAC.refresh();
		}
		
		
		
		public function fromSQL(data:Object):void
		{
			this.id = data.User_id;
			this.twitterId = data.User_twitterId;
			this.name = data.User_name;
			this.screenName = data.User_screenName;
			this.location = data.User_location;
			this.description = data.User_description;
			this.profileImageUrl = data.User_profileImageUrl;
			this.url = data.User_url;
			this.isProtected = data.User_isProtected;
			this.friendCount = data.User_friendsCount;
			this.followersCount = data.User_followersCount;
			this.createdAt = data.User_createdAt;
			this.favouritesCount = data.User_favouritesCount;
			this.utcOffset = data.User_utcOffset;
			this.timeZone = data.User_timeZone;
			this.notifications = data.User_notifications;
			this.statusesCount = data.User_statusesCount;
			this.profileBackgroundColor = data.User_profileBackgroundColor;
			this.profileTextColor = data.User_profileTextColor;
			this.profileLinkColor = data.User_profileLinkColor;
			this.profileSidebarFillColor = data.User_profileSidebarFillColor;
			this.profileSidebarBorderColor = data.User_profileSidebarBorderColor;
			this.profileBackgroundImageUrl = data.User_profileBackgroundImageUrl;
			this.profileBackgroundTile = data.User_profileBackgroundTile;
			this.profileUseBackgroundImage = data.User_profileUseBackgroundImage;
			this.defaultProfileImage = data.User_defaultProfileImage;
			this.isTranslator = data.User_isTranslator;
			this.followRequestSent = data.User_followRequestSent;
			this.contributorsEnabled = data.User_contributorsEnabled;
			this.defaultProfile = data.User_defaultProfile;
			this.listedCount = data.User_listedCount;
			this.language = data.User_language;
			this.geoEnabled = data.User_geoEnabled;
			this.verified = data.User_verified;
			this.showAllInlineMedia = data.User_showAllInlineMedia;
			this.following = data.User_following;
			this.follower = data.User_isFollower;
			this.blocked = data.User_isBlocked;
		}
		
		
	}
}