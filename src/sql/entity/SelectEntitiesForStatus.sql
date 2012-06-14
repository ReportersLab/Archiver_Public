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
	ownerId
FROM Entity
WHERE ownerId = :statusId