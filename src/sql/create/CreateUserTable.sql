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
	"twitterId" VARCHAR UNIQUE, 
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
);

