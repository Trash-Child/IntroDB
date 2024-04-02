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
SELECT Edition.NewspaperTitle, SUM(ReadTimes)
FROM Edition, Article
WHERE Article.NewspaperTitle = Edition.NewspaperTitle
AND Article.PubDate = Edition.PubDate;

# Newspaper readers
CREATE VIEW NewspaperReadTimes AS
SELECT Newspaper.NewspaperTitle, SUM(ReadTimes)
FROM Newspaper, Edition, Article
WHERE Article.NewspaperTitle = Edition.NewspaperTitle
AND Article.PubDate = Edition.PubDate;

/*
	Test views.
*/
SELECT * FROM ArticleReadTimes;
SELECT * FROM EditionReadTimes;
SELECT * FROM NewspaperReadTimes;
