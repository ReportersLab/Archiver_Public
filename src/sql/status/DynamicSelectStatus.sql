SELECT
	id,
	createdAt,
	text,
	source,
	twitterUserId,
	geo,
	placeId,
	twitterPlaceId,
	coordinates,
	twitterId,
	truncated,
	inReplyToStatusId,
	inReplyToUserId,
	inReplyToScreenName,
	contributors,
	retweeted,
	retweetCount,
	retweetedStatusTwitterId,
	retweetedStatusId,
	possiblySensitive,
	searchType,
	isMention,
	statusType,
	userId,
	favorited,
	annotations
FROM Status
WHERE :field IN :values;