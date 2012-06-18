UPDATE Entity
SET
	ownerId = (SELECT id FROM Status WHERE twitterId = :twitterStatusId)
WHERE twitterStatusId = :twitterStatusId;
