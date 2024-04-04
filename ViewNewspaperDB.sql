USE newspaper_db;

/*
	Drop views.
*/
DROP VIEW IF EXISTS ArticleReadTimes;
DROP VIEW IF EXISTS EditionReadTimes;
DROP VIEW IF EXISTS NewspaperReadTimes;
DROP VIEW IF EXISTS ArticlePhotoCount;
DROP VIEW IF EXISTS AuthorRoles;
drop view if exists TopicReads;
drop view if exists TopicMostRead;
drop view if exists TopicLessThanAvg;
drop view if exists TopWriters;

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

-- FIND MOST READ ARTICLE IN EACH TOPIC
-- Find max(readtimes) for every topic

CREATE VIEW TopicReads as
select topic, sum(readtimes) totalreads, max(readtimes) maxreads, avg(readtimes) avgreads from article group by topic;
select * from topicreads;

-- Find article in each topic that corresponds to the most read -- TODO: identify articles on entire primary key

CREATE VIEW TopicMostRead as
select topicreads.topic Topic, articletitle MostReadArticle, article.readtimes ReadTimes, ArticleDate, Newspapertitle, Pubdate
from article natural left join topicreads where article.topic = topicreads.topic and article.readtimes = topicreads.maxreads;
select * from topicmostread;

-- View of topics with less reads than the average

Create view TopicLessThanAvg as
	Select topic, totalreads from topicreads where totalreads < (select avg(totalreads) from topicreads);

Create view TopWriters as
Select SSN, sum(readtimes) ReadSum from author natural left join articlereadtimes where role='Writer' group by SSN order by ReadSum desc;
-- select...

-- join articlereadtimes with author, select where role is writer, sort by readtimes
; -- Limit 3;

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

