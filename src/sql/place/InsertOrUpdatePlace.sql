INSERT OR IGNORE INTO Place
(
	id,
	name,
	countryCode,
	attributes,
	url,
	twitterId,
	boundingBox,
	fullName,
	type
)
VALUES
(
	:id,
	:name,
	:countryCode,
	:attributes,
	:url,
	:twitterId,
	:boundingBox,
	:fullName,
	:type
);


UPDATE OR IGNORE Place
SET
	id = :id,
	name = :name,
	countryCode = :countryCode,
	attributes = :attributes,
	url = :url,
	twitterId = :twitterId,
	boundingBox = :boundingBox,
	fullName = :fullName,
	type = :type
WHERE id = :id 
OR twitterId = :twitterId;