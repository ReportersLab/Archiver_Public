

CREATE TABLE "Entity" (
	"id" INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL UNIQUE , 
	"type" VARCHAR, 
	"expandedURL" VARCHAR, 
	"url" VARCHAR, 
	"displayURL" VARCHAR, 
	"hashText" VARCHAR, 
	"name" VARCHAR, 
	"mentionId" VARCHAR, 
	"screenName" VARCHAR, 
	"startIndex" INTEGER, 
	"endIndex" INTEGER, 
	"ownerId" INTEGER
)

CREATE TABLE "Place" (
	"id" INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE , 
	"name" VARCHAR, 
	"countryCode" VARCHAR, 
	"attributes" TEXT, 
	"url" VARCHAR, 
	"twitterId" VARCHAR, 
	"boundingBox" TEXT, 
	"fullName" VARCHAR, 
	"type" VARCHAR
)

CREATE TABLE "Status" (
	"id" INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE , 
	"createdAt" DATETIME DEFAULT CURRENT_TIMESTAMP, 
	"text" TEXT, 
	"source" VARCHAR, 
	"twitterUser" VARCHAR, 
	"geo" VARCHAR, 
	"latitude" FLOAT, 
	"longitude" FLOAT, 
	"coordinates" VARCHAR, 
	"twitterId" VARCHAR, 
	"truncated" BOOL, 
	"inReplyToStatusId" VARCHAR, 
	"inReplyToUserId" VARCHAR, 
	"contributors" VARCHAR, 
	"retweetCount" INTEGER, 
	"possiblySensitive" BOOL, 
	"searchType" VARCHAR, 
	"isMention" BOOL, 
	"retweetedStatus" VARCHAR, 
	"statusType" VARCHAR, 
	"placeId" INTEGER, 
	"userId" INTEGER
)

CREATE TABLE "User" (
	"id" INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE , 
	"name" VARCHAR, 
	"screenName" VARCHAR, 
	"location" TEXT, 
	"description" TEXT, 
	"profileImageUrl" VARCHAR, 
	"url" VARCHAR, 
	"firstName" VARCHAR, 
	"lastName" VARCHAR, 
	"twitterId" VARCHAR, 
	"isProtected" BOOL NOT NULL  DEFAULT -1, 
	"friendCount" INTEGER NOT NULL  DEFAULT 0, 
	"followersCount" INTEGER NOT NULL  DEFAULT 0, 
	"createdAt" DATETIME NOT NULL  DEFAULT CURRENT_DATE, 
	"favouritesCount" INTEGER NOT NULL  DEFAULT 0, 
	"utcOffset" INTEGER, 
	"timeZone" VARCHAR, 
	"notifications" BOOL NOT NULL  DEFAULT -1, 
	"statusesCount" INTEGER NOT NULL  DEFAULT 0, 
	"profileBackgroundColor" VARCHAR, 
	"profileTextColor" VARCHAR, 
	"profileLinkColor" VARCHAR, 
	"profileSidebarFillColor" VARCHAR, 
	"profileSidebarBorderColor" VARCHAR, 
	"profileBackgroundImageUrl" VARCHAR, 
	"profileBackgroundTile" VARCHAR, 
	"statusId" INTEGER, 
	"profileUserBackgroundImage" VARCHAR, 
	"defaultProfileImage" VARCHAR, 
	"isTranslator" BOOL NOT NULL  DEFAULT -1, 
	"followRequestSent" BOOL NOT NULL  DEFAULT -1, 
	"contributorsEnabled" BOOL NOT NULL  DEFAULT -1, 
	"defaultProfile" BOOL NOT NULL  DEFAULT -1, 
	"listedCount" INTEGER NOT NULL  DEFAULT 0, 
	"language" VARCHAR, 
	"geoEnabled" BOOL NOT NULL  DEFAULT -1, 
	"verified" BOOL NOT NULL  DEFAULT -1, 
	"showAllInlineMedia" BOOL NOT NULL  DEFAULT -1, 
	"following" BOOL NOT NULL  DEFAULT -1, 
	"follower" BOOL NOT NULL  DEFAULT -1, 
	"blocked" BOOL NOT NULL  DEFAULT -1
)






















