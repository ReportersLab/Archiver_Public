UPDATE Place
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
WHERE id = :id;
