CREATE TABLE "Place" (
	"id" INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE ,
	"twitterId" VARCHAR UNIQUE,  
	"name" VARCHAR, 
	"countryCode" VARCHAR,
	"country" VARCHAR, 
	"attributes" TEXT, 
	"url" VARCHAR, 
	"boundingBox" TEXT, 
	"fullName" VARCHAR, 
	"type" VARCHAR
);