USE newspaper_db;
/* Insert statemnts */

/* Add journalists */
INSERT INTO Journalist (SSN, FirstName, LastName)
VALUES 
('1234567898', 'Jane', 'Doe'),
('0987654321', 'John', 'Smith'),
('1122334490', 'Emily', 'Johnson');
SELECT * FROM Journalist ;

/* Update statemnts */

/* Update journalist name. Suppose Smith Jackson has legally changed his name to Smith Johnson */
UPDATE Journalist
SET LastName = 'Johnson'
WHERE SSN = '2412001234';
SELECT * FROM Journalist ;

/* Update an address. If Anders Andersen moves from 'Algade 2' to 'Brogade 3' in the same city and postal code area */
UPDATE Address
SET StreetName = 'Brogade', CivicNumber = '3'
WHERE SSN = '0101984321' AND StreetName = 'Algade' AND CivicNumber = '2';
SELECT * FROM Address ;

/* update the Text and ReadTimes fields of an existing article in the Article table.*/
UPDATE Article
SET Text = 'Det var fake news', 
    ReadTimes = 6000
WHERE ArticleTitle = 'Rusland melder om droneangreb over 1.000 kilometer fra Ukraine'
AND ArticleDate = '2024-04-02 10:43:00'
AND NewspaperTitle = 'The Daily News'
AND PubDate = '2024-08-01 06:00:00';
SELECT * FROM Article ;

/* Delete statemnts */

/* Delete a journalists email .*/ 
DELETE FROM Email
WHERE SSN = '0202651122';
SELECT * FROM Email ;

/* Delete a journalists full address. */  
DELETE FROM Address
WHERE SSN = '2412001234';
SELECT * FROM Address ;



/*
	Drop views.
*/
DROP VIEW IF EXISTS ArticleReadTimes;
DROP VIEW IF EXISTS EditionReadTimes;
DROP VIEW IF EXISTS NewspaperReadTimes;
DROP VIEW IF EXISTS ArticlePhotoCount;
DROP VIEW IF EXISTS AuthorRoles;
DROP VIEW IF EXISTS TopicReads;
DROP VIEW IF EXISTS TopicMostRead;
DROP VIEW IF EXISTS TopicLessThanAvg;
DROP VIEW IF EXISTS TopWriters;
DROP VIEW IF EXISTS Top10Writers;
DROP VIEW IF EXISTS writerreporter;

/*
	Create views.
*/
# Article readers
CREATE VIEW ArticleReadTimes AS
SELECT ArticleTitle, ReadTimes
FROM Article;

# Issue/edition readers
CREATE VIEW EditionReadTimes AS
SELECT Edition.NewspaperTitle, Edition.PubDate, SUM(ReadTimes)
FROM Edition, Article
WHERE Article.NewspaperTitle = Edition.NewspaperTitle
AND Article.PubDate = Edition.PubDate
GROUP BY Edition.NewspaperTitle, Edition.PubDate;
# Test
SELECT * FROM EditionReadTimes;

# Newspaper readers
CREATE VIEW NewspaperReadTimes AS
SELECT Newspaper.NewspaperTitle, SUM(ReadTimes)
FROM Newspaper, Edition, Article
WHERE Article.NewspaperTitle = Edition.NewspaperTitle
AND Article.PubDate = Edition.PubDate
GROUP BY Newspaper.NewspaperTitle;
# Test
SELECT * FROM NewspaperReadTimes;

# Number of photos in an article
CREATE VIEW ArticlePhotoCount AS
SELECT
    ap.ArticleTitle,
    ap.ArticleDate,
    ap.NewspaperTitle,
    ap.PubDate,
    COUNT(*) AS PhotoCount
FROM ArticlePhoto ap
GROUP BY ap.ArticleTitle, ap.ArticleDate, ap.NewspaperTitle, ap.PubDate;

# find the number of photos for a specific article:
SELECT * FROM ArticlePhotoCount
WHERE ArticleTitle = 'Your Article Title Here'
AND ArticleDate = 'YYYY-MM-DD HH:MM:SS';

# Author role
CREATE VIEW AuthorRoles AS
SELECT
    a.SSN,
    j.FirstName,
    j.LastName,
    a.ArticleTitle,
    a.ArticleDate,
    a.Role
FROM Author a
JOIN Journalist j ON a.SSN = j.SSN;

# find information for a specific author by their SSN:
SELECT *
FROM AuthorRoles
WHERE SSN = 'YourSSNHere';

-- Q6: FIND MOST READ ARTICLE IN EACH TOPIC
-- Find max(readtimes) for every topic
CREATE VIEW TopicReads as
select topic, sum(readtimes) totalreads, max(readtimes) maxreads, avg(readtimes) avgreads from article group by topic;
select * from topicreads;
-- Find article in each topic that corresponds to the most read 
CREATE VIEW TopicMostRead as
select topicreads.topic Topic, articletitle MostReadArticle, article.readtimes ReadTimes, ArticleDate, Newspapertitle, Pubdate
from article natural left join topicreads where article.topic = topicreads.topic and article.readtimes = topicreads.maxreads;


-- Q6: Identify top journalists
Create view TopWriters as
Select SSN, sum(readtimes) ReadSum from author natural left join articlereadtimes where role='Writer' group by SSN order by ReadSum desc;
Create view Top10Writers as select * from TopWriters limit 10;

/* Q(3) - Which are the reporters whose photos were never used more than once. */ 
SELECT DISTINCT j.FirstName, j.LastName
FROM Journalist j
JOIN Photo p ON j.SSN = p.SSN
WHERE p.PhotoTitle IN (
    SELECT ap.PhotoTitle
    FROM ArticlePhoto ap
    GROUP BY ap.PhotoTitle, ap.PhotoDate, ap.SSN
    HAVING COUNT(*) = 1
) AND p.PhotoDate IN (
    SELECT ap.PhotoDate
    FROM ArticlePhoto ap
    GROUP BY ap.PhotoTitle, ap.PhotoDate, ap.SSN
    HAVING COUNT(*) = 1
) AND p.SSN IN (
    SELECT ap.SSN
    FROM ArticlePhoto ap
    GROUP BY ap.PhotoTitle, ap.PhotoDate, ap.SSN
    HAVING COUNT(*) = 1
);

-- Q6: View of topics with less reads than the average
Create view TopicLessThanAvg as
	Select topic, totalreads from topicreads where totalreads < (select avg(totalreads) from topicreads);
    
-- Q6: Identify journalists who were both writers and reporters for the same article
Create view WriterReporter as
Select a.SSN, -- a.role arole, b.role brole, 
a.articletitle, a.articledate from author a left join author b on a.SSN = b.SSN 
where a.role = 'Writer' and b.role = 'Reporter' and
a.articletitle = b.articletitle and
a.articledate = b.articledate;

/*
	Test views.
*/
SELECT * FROM ArticleReadTimes;
SELECT * FROM EditionReadTimes;
SELECT * FROM NewspaperReadTimes;
SELECT * FROM ArticlePhotoCount;
SELECT * FROM AuthorRoles;
select * from topicmostread;
select * from TopicLessThanAvg;
select * from TopWriters;
select * from Top10Writers;
select * from writerreporter;


/* TRIGGER */
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

/* PROCEDURE */

# Procedure to add a new journalist.
DROP PROCEDURE IF EXISTS AddJournalist;
DELIMITER //
CREATE PROCEDURE AddJournalist
	(IN vSSN VARCHAR(16), IN vFirstName VARCHAR(64), IN vLastName VARCHAR(64),
	IN vStreetName VARCHAR(64), IN vCivicNumber VARCHAR(16), IN vCity VARCHAR(64), IN vPostalCode VARCHAR(16), IN vState VARCHAR(64), IN vCountry VARCHAR(64),
	IN vNumber DECIMAL(32,0),
	IN vEmail VARCHAR(64))
    
    # Error handling
	BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;
    
	INSERT Journalist
	VALUES (vSSN, vFirstName, vLastName);
    
	INSERT Address
	VALUES (vSSN, vStreetName, vCivicNumber, vCity, vPostalCode, vState, vCountry);
    
    INSERT Phone
	VALUES (vNumber, vSSN);
    
    INSERT Email
	VALUES (vEmail, vSSN);
END //
DELIMITER ;
# 	Test
# Adding journalist Lars Larsen: CALL AddJournalist('0101011234','Lars','Larsen','Gadevej','2 1.th','Lazy Town','1337','','Utopia','88888888','LarsDenStore@hotmail.com');
# Viewing the journalists: SELECT * FROM Journalist;
# Trying to add journalist with same phone number. Should fail: CALL AddJournalist('8932832573','erthwh','wrhawr','beathb','2 1.th','aethb','1337','','Utopia','88888888','wrgbwr@hotmail.com');
# Viewing the journalists again, to see that nothing is changed: SELECT * FROM Journalist;


# Procedure to add a new article.
DROP PROCEDURE IF EXISTS AddArticle;
DELIMITER //
CREATE PROCEDURE AddArticle
	(IN vArticleTitle VARCHAR(64),
     IN vArticleDate DATETIME,
     IN vTopic VARCHAR(64),
     IN vText TEXT,
	 IN vReadTimes DECIMAL(16,0),
     
     IN vNewspaperTitle VARCHAR(64),
     IN vPubDate DATETIME)
    
	BEGIN
    
	INSERT Article
	VALUES (vArticleTitle, vArticleDate, vTopic, vText, vReadTimes, vNewspaperTitle, vPubDate);
END //
DELIMITER ;
CALL AddArticle('ArticleTitle_test','1800-01-01 04:00:00','Topic_test','Text_test','0','The Daily News','2004-08-01 06:00:00');
SELECT * FROM Article;

/* FUCNTIONS */

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



