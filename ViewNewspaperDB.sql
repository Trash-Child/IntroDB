USE newspaper_db;

/*
	Drop views.
*/
DROP VIEW IF EXISTS ArticleReadTimes;
DROP VIEW IF EXISTS EditionReadTimes;
DROP VIEW IF EXISTS NewspaperReadTimes;

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
AND Article.PubDate = Edition.PubDate;

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


/*
	Test views.
*/
SELECT * FROM ArticleReadTimes;
SELECT * FROM EditionReadTimes;
SELECT * FROM NewspaperReadTimes;
SELECT * FROM ArticlePhotoCount;
SELECT * FROM AuthorRoles;
