CREATE TABLE "Entity" (
	"id" INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL UNIQUE ,
	"ownerId" INTEGER, 
	"twitterStatusId" VARCHAR,
	"type" VARCHAR, 
	"expandedURL" VARCHAR, 
	"url" VARCHAR, 
	"displayURL" VARCHAR, 
	"hashText" VARCHAR, 
	"name" VARCHAR, 
	"mentionId" VARCHAR, 
	"screenName" VARCHAR, 
	"startIndex" INTEGER, 
	"endIndex" INTEGER
);