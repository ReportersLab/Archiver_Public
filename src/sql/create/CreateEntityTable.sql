CREATE TABLE "Entity" (
	"id" PRIMARY KEY NOT NULL UNIQUE,
	"ownerId" INTEGER, 
	"twitterStatusId" VARCHAR,
	"type" VARCHAR, 
	"expandedURL" VARCHAR, 
	"url" VARCHAR, 
	"displayURL" VARCHAR, 
	"hashText" VARCHAR, 
	"name" VARCHAR, 
	"mentionId" VARCHAR,
	"mediaId" VARCHAR,
	"mediaURL" VARCHAR,
	"mediaURLHttps" VARCHAR,
	"mediaType" VARCHAR,
	"mediaSizes" VARCHAR,  
	"screenName" VARCHAR, 
	"startIndex" INTEGER, 
	"endIndex" INTEGER
);