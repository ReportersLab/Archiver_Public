CREATE TABLE "Place" (
	"id" INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE , 
	"name" VARCHAR, 
	"countryCode" VARCHAR, 
	"attributes" TEXT, 
	"url" VARCHAR, 
	"twitterId" VARCHAR UNIQUE, 
	"boundingBox" TEXT, 
	"fullName" VARCHAR, 
	"type" VARCHAR
);