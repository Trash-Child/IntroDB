USE newspaper_db;
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

/* update the Text and ReadTimes fields of an existing article in the Article table.*/
UPDATE Article
SET Text = 'Updated article text with more comprehensive information on global warming...', 
    ReadTimes = 600
WHERE ArticleTitle = 'The Impact of Global Warming'
AND ArticleDate = '2024-04-01 00:00:00'
AND NewspaperTitle = 'The Daily News'
AND PubDate = '2024-04-01 00:00:00';


/*  update the ArticleTitle and ArticleDate for a specific photo related to an article.
This might be necessary if the photo was mistakenly associated with the wrong article edition or if the article's details have changed. */
UPDATE ArticlePhoto
SET ArticleTitle = 'Dronning Margrethe den anden der ryger', ArticleDate = '2024-04-01 00:00:00'
WHERE PhotoTitle = 'Dronning Margrethe den anden der spiser en pandekage.'
AND PhotoDate = '2008-05-31 01:43:12'
AND SSN = '2412001234'
AND ArticleTitle = 'OldArticleTitle'
AND ArticleDate = '2008-05-31 00:00:00'
AND NewspaperTitle = 'The Daily News'
AND PubDate = '2008-08-01 06:00:00 AM';


/* Delete statemnts */

/* Delete a journalist and all related records. 
If journalist Eddy Thorsen is no longer part of the database, and you want to remove all records related to him due to the CASCADE constraint on foreign keys */ 
DELETE FROM Journalist
WHERE SSN = '0202651122';

/* Delete an edition of a newspaper. If a particular edition of 'The Daily News' needs to be removed */ 
DELETE FROM Edition
WHERE NewspaperTitle = 'The Daily News' AND PubDate = '20040801 06:00:00 AM';

/* Delete an article from the Article table. 
The article we want to remove is titled "Outdated Tech Trends" published in "The Weekly News" on a specific publication date. */ 
DELETE FROM Article
WHERE ArticleTitle = 'Outdated Tech Trends'
AND ArticleDate = '2024-03-29 00:00:00' 
AND NewspaperTitle = 'The Weekly News'
AND PubDate = '2024-03-29 00:00:00';
