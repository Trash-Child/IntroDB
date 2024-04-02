DELIMITER //
CREATE TRIGGER ArticleBeforeEdition
BEFORE INSERT ON Article FOR EACH ROW
BEGIN
IF NEW.ArticleDate < Edition.PubDate THEN SET NEW.ArticleDate = '0000-00-00 00:00:00';
END IF;
END//
DELIMITER ;