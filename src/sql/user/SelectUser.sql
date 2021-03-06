SELECT
	id,
	name, 
	screenName, 
	location, 
	description, 
	profileImageUrl, 
	url, 
	firstName, 
	lastName, 
	twitterId, 
	isProtected, 
	friendCount, 
	followersCount, 
	createdAt, 
	favouritesCount, 
	utcOffset, 
	timeZone, 
	notifications, 
	statusesCount, 
	profileBackgroundColor, 
	profileTextColor, 
	profileLinkColor, 
	profileSidebarFillColor, 
	profileSidebarBorderColor, 
	profileBackgroundImageUrl, 
	profileBackgroundTile, 
	statusId, 
	profileUseBackgroundImage, 
	defaultProfileImage, 
	isTranslator, 
	followRequestSent, 
	contributorsEnabled, 
	defaultProfile, 
	listedCount, 
	language, 
	geoEnabled, 
	verified, 
	showAllInlineMedia, 
	following, 
	follower, 
	blocked
FROM User
WHERE id = :id;