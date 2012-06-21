SELECT
	id,
	name,
	countryCode,
	country,
	attributes,
	url,
	twitterId,
	boundingBox,
	fullName,
	type
FROM Place
WHERE id = :id;