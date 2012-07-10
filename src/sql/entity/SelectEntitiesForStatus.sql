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
	startIndex,
	endIndex,
	ownerId,
	twitterStatusId
FROM Entity
WHERE ownerId = :statusId;