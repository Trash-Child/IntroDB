
DROP TRIGGER IF EXISTS ArticleBeforeEdition;
DELIMITER //
CREATE TRIGGER ArticleBeforeEdition
BEFORE INSERT ON Article FOR EACH ROW
BEGIN
IF NEW.ArticleDate <= NEW.PubDate 
THEN SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'ArticleDate-ERROR: Article must be published before the Edition';
END IF;
END//
DELIMITER ;