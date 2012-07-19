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
	mediaId = :mediaId,
	mediaURL = :mediaURL,
	mediaURLHttps = :mediaURLHttps,
	mediaSizes = :mediaSizes,
	mediaType = :mediaType,
	startIndex = :startIndex,
	endIndex = :endIndex,
	ownerId = :ownerId,
	twitterStatusId = :twitterStatusId
WHERE id = :id;
