INSERT OR IGNORE INTO Entity
(
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
)
VALUES
(
	:id,
	:type,
	:expandedURL,
	:url,
	:displayURL,
	:hashText,
	:name,
	:mentionId,
	:screenName,
	:startIndex,
	:endIndex,
	:ownerId,
	:twitterStatusId
);

UPDATE OR IGNORE Entity
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
WHERE id = :id ;
