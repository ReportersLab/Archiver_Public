SELECT
	id,
	type,
	expandedURL,
	url,
	displayURL,
	hashText,
	name,
	mentionId,
	screenName,
	mediaId,
	mediaURL,
	mediaURLHttps,
	mediaSizes,
	mediaType,
	startIndex,
	endIndex,
	ownerId,
	twitterStatusId
FROM Entity
WHERE id = :id;