SELECT
	type,
	expandedURL,
	url,
	displayURL,
	hashText,
	name,
	mentionId,
	screenName,
	startIndex,
	endIndex,
	ownerId,
	twitterStatusId
FROM Entity
WHERE id = :id;