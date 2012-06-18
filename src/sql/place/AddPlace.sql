INSERT INTO Place
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
