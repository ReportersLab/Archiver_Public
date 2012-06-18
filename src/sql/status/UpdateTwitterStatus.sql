UPDATE Status
SET
	placeId = (SELECT id FROM Place WHERE twitterId = :twitterPlaceId),
	userId =  (SELECT id FROM User WHERE twitterId = :twitterUserId)
WHERE twitterId = :twitterId;
