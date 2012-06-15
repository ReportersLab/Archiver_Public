INSERT OR IGNORE INTO Status
(
	id,
	createdAt,
	text,
	source,
	twitterUser,
	geo,
	placeId,
	latitude,
	longitude,
	coordinates,
	twitterId,
	truncated,
	inReplyToStatusId,
	inReplyToUserId,
	contributors,
	retweetCount,
	possiblySensitive,
	searchType,
	isMention,
	retweetedStatus,
	statusType,
	userId
)
VALUES
(
	:id,
	:createdAt,
	:text,
	:source,
	:twitterUser,
	:geo,
	:placeId,
	:latitude,
	:longitude,
	:coordinates,
	:twitterId,
	:truncated,
	:inReplyToStatusId,
	:inReplyToUserId,
	:contributors,
	:retweetCount,
	:possiblySensitive,
	:searchType,
	:isMention,
	:retweetedStatus,
	:statusType,
	:userId
);


UPDATE OR IGNORE Status
SET
	createdAt = :createdAt,
	text = :text,
	source = :source,
	twitterUser = :twitterUser,
	geo = :geo,
	placeId = :placeId,
	latitude = :latitude,
	longitude = :longitude,
	coordinates = :coordinates,
	twitterId = :twitterId,
	truncated = :truncated,
	inReplyToStatusId = :inReplyToStatusId,
	inReplyToUserId = :inReplyToUserId,
	contributors = :contributors,
	retweetCount = :retweetCount,
	possiblySensitive = :possiblySensitive,
	searchType = :searchType,
	isMention = :isMention,
	retweetedStatus = :retweetedStatus,
	statusType = :statusType,
	userId = :userId
WHERE id = :id 
OR twitterId = :twitterId;



