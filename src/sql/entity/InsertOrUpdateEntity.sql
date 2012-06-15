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
	ownerId
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
	:ownerId
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
	ownerId = :ownerId
WHERE id = :id 
