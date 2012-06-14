SELECT
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
FROM Status
WHERE id = :id