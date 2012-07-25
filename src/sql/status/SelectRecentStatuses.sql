SELECT
		Status.id AS Status_id,
	Status.createdAt AS Status_createdAt,
	Status.text AS Status_text,
	Status.source AS Status_source,
	Status.twitterUserId AS Status_twitterUserId,
	Status.geo AS Status_geo,
	Status.placeId AS Status_placeId,
	Status.twitterPlaceId AS Status_twitterPlaceId,
	Status.coordinates AS Status_coordinates,
	Status.twitterId AS Status_twitterId,
	Status.truncated AS Status_truncated,
	Status.inReplyToStatusId AS Status_inReplyToStatusId,
	Status.inReplyToUserId AS Status_inReplyToUserId,
	Status.inReplyToScreenName AS Status_inReplyToScreenName,
	Status.contributors AS Status_contributors,
	Status.retweeted AS Status_retweeted,
	Status.retweetCount AS Status_retweetCount,
	Status.retweetedStatusTwitterId AS Status_retweetedStatusTwitterId,
	Status.retweetedStatusId AS Status_retweetedStatusId,
	Status.possiblySensitive AS Status_possiblySensitive,
	Status.searchType AS Status_searchType,
	Status.isMention AS Status_isMention,
	Status.statusType AS Status_statusType,
	Status.userId AS Status_userId,
	Status.favorited AS Status_favorited,
	Status.annotations AS Status_annotations,
	User.id AS User_id,
	User.name AS User_name, 
	User.screenName AS User_screenName, 
	User.location AS User_location, 
	User.description AS User_description, 
	User.profileImageUrl AS User_profileImageUrl, 
	User.url AS User_url, 
	User.firstName AS User_firstName, 
	User.lastName AS User_lastName, 
	User.twitterId AS User_twitterId, 
	User.isProtected AS User_isProtected, 
	User.friendCount AS User_friendCount, 
	User.followersCount AS User_followersCount, 
	User.createdAt AS User_createdAt, 
	User.favouritesCount AS User_favouritesCount, 
	User.utcOffset AS User_utcOffset, 
	User.timeZone AS User_timeZone, 
	User.notifications AS User_notifications, 
	User.statusesCount AS User_statusesCount, 
	User.profileBackgroundColor AS User_profileBackgroundColor, 
	User.profileTextColor AS User_profileTextColor, 
	User.profileLinkColor AS User_profileLinkColor, 
	User.profileSidebarFillColor AS User_profileSidebarFillColor, 
	User.profileSidebarBorderColor AS User_profileSidebarBorderColor, 
	User.profileBackgroundImageUrl AS User_profileBackgroundImageUrl, 
	User.profileBackgroundTile AS User_profileBackgroundTile, 
	User.statusId AS User_statusId, 
	User.profileUseBackgroundImage AS User_profileUseBackgroundImage, 
	User.defaultProfileImage AS User_defaultProfileImage, 
	User.isTranslator AS User_isTranslator, 
	User.followRequestSent AS User_followRequestSent, 
	User.contributorsEnabled AS User_contributorsEnabled, 
	User.defaultProfile AS User_defaultProfile, 
	User.listedCount AS User_listedCount, 
	User.language AS User_language, 
	User.geoEnabled AS User_geoEnabled, 
	User.verified AS User_verified, 
	User.showAllInlineMedia AS User_showAllInlineMedia, 
	User.following AS User_following, 
	User.follower AS User_follower, 
	User.blocked AS User_blocked
FROM Status, User
WHERE Status.userId = User.id
ORDER BY Status.createdAt DESC
LIMIT 500;