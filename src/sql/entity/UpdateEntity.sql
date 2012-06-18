UPDATE Entity
SET
	type = :type,
	expandedURL = :expandedURL,
	url = :url,
	displayURL = :displayURL,
	hashText = :hashText,
	name = :name,
	mentionId = :mentionId,
	screenName = :screenName,
	startIndex = :startIndex,
	endIndex = :endIndex,
	ownerId = :ownerId,
	twitterStatusId = :twitterStatusId
WHERE id = :id;
