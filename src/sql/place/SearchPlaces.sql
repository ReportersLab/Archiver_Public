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
WHERE fullName LIKE :query
LIMIT 200;