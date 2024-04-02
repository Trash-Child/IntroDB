
# Function for retrieving the number of articles that are in an edition.
DROP FUNCTION IF EXISTS ArticleCountInEdition;
DELIMITER //
CREATE FUNCTION ArticleCountInEdition
(vNewspaperTitle VARCHAR(64), vPubDate DATETIME) RETURNS INT
BEGIN
	DECLARE vArticleCount INT;
    SELECT COUNT(*) INTO vArticleCount FROM Article
    WHERE NewspaperTitle = vNewspaperTitle
    AND PubDate = vPubDate;
    RETURN vArticleCount;
END; //
DELIMITER ;
# Testing:
SELECT NewspaperTitle, PubDate, ArticleCountInEdition(NewspaperTitle, PubDate)
AS Article
FROM Edition
GROUP BY NewspaperTitle, PubDate;


# Function for retrieving the number of editions that have been published to a newspaper.
DROP FUNCTION IF EXISTS EditionCountInNewspaper;
DELIMITER //
CREATE FUNCTION EditionCountInNewspaper
(vNewspaperTitle VARCHAR(64)) RETURNS INT
BEGIN
	DECLARE vEditionCount INT;
    SELECT COUNT(*) INTO vEditionCount FROM Edition
    WHERE NewspaperTitle = vNewspaperTitle;
    RETURN vEditionCount;
END; //
DELIMITER ;
# Testing:
SELECT NewspaperTitle, EditionCountInNewspaper(NewspaperTitle)
AS Edition
FROM Newspaper
GROUP BY NewspaperTitle;


# Function for retrieving the number of articles that are in an edition.
DROP FUNCTION IF EXISTS ArticleCountInNewspaper;
DELIMITER //
CREATE FUNCTION ArticleCountInNewspaper
(vNewspaperTitle VARCHAR(64)) RETURNS INT
BEGIN
	DECLARE vArticleCount INT;
    SELECT COUNT(*) INTO vArticleCount FROM Article
    WHERE NewspaperTitle = vNewspaperTitle;
    RETURN vArticleCount;
END; //
DELIMITER ;
# Testing:
SELECT NewspaperTitle, ArticleCountInNewspaper(NewspaperTitle)
AS Article
FROM Newspaper
GROUP BY NewspaperTitle;


