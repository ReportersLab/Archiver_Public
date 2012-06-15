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
);