SELECT
	id,
	name,
	countryCode,
	attributes,
	url,
	twitterId,
	boundingBox,
	fullName,
	type
FROM Place
WHERE id = :id;