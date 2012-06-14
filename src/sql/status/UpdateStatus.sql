UPDATE Status
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
