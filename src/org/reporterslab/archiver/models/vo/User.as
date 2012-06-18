package org.reporterslab.archiver.models.vo
{
	import com.dborisenko.api.twitter.data.TwitterUser;

	public class User
	{
		
		//generic
		public var id:int = -1;
		public var name:String;
		public var screenName:String;
		public var location:String;
		public var description:String;
		public var profileImageUrl:String;
		public var url:String;
		public var firstName:String; // may never need.
		public var lastName:String; // may never need.
		
		//twitter specific
		public var twitterId:String;
		public var isProtected:Boolean;
		public var friendCount:Number;
		public var followersCount:Number;
		public var createdAt:Date;
		public var favouritesCount:Number;
		public var utcOffset:int;
		public var timeZone:String;
		public var notifications:Boolean;
		public var statusesCount:Number;
		public var profileBackgroundColor:String;
		public var profileTextColor:String;
		public var profileLinkColor:String;
		public var profileSidebarFillColor:String;
		public var profileSidebarBorderColor:String;
		public var profileBackgroundImageUrl:String;
		public var profileBackgroundTile:String;
		public var status:Status;
		public var profileUseBackgroundImage:Boolean = false;
		public var defaultProfileImage:Boolean = false;
		public var isTranslator:Boolean = false;
		public var followRequestSent:Boolean = false;
		public var contributorsEnabled:Boolean = false;
		public var defaultProfile:Boolean = false;
		public var listedCount:int = 0;
		public var language:String = "en";
		public var geoEnabled:Boolean = false;
		public var verified:Boolean = false;
		public var showAllInlineMedia:Boolean = false;
		
		public var following:Boolean;
		public var follower:Boolean;
		public var blocked:Boolean;
		
		
		
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
		
		
	}
}