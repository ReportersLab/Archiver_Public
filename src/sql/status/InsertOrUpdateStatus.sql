INSERT OR IGNORE INTO Status
(
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
)
VALUES
(
	:id,
	:createdAt,
	:text,
	:source,
	:twitterUserId,
	:geo,
	:placeId,
	:twitterPlaceId,
	:coordinates,
	:twitterId,
	:truncated,
	:inReplyToStatusId,
	:inReplyToUserId,
	:inReplyToScreenName,
	:contributors,
	:retweeted,
	:retweetCount,
	:retweetedStatusTwitterId,
	:retweetedStatusId,
	:possiblySensitive,
	:searchType,
	:isMention,
	:statusType,
	:userId,
	:favorited,
	:annotations
);


UPDATE OR IGNORE Status
SET
	createdAt = :createdAt,
	text = :text,
	source = :source,
	twitterUserId = :twitterUserId,
	geo = :geo,
	placeId = :placeId,
	twitterPlaceId = :twitterPlaceId,
	coordinates = :coordinates,
	twitterId = :twitterId,
	truncated = :truncated,
	inReplyToStatusId = :inReplyToStatusId,
	inReplyToUserId = :inReplyToUserId,
	inReplyToScreenName = :inReplyToScreenName,
	contributors = :contributors,
	retweeted = :retweeted,
	retweetCount = :retweetCount,
	retweetedStatusTwitterId = :retweetedStatusTwitterId,
	retweetedStatusId = :retweetedStatusId,
	possiblySensitive = :possiblySensitive,
	searchType = :searchType,
	isMention = :isMention,
	statusType = :statusType,
	userId = :userId,
	favorited = :favorited,
	annotations = :annotations
WHERE id = :id 
OR twitterId = :twitterId;



