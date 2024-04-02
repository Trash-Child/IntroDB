
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
CALL AddArticle('ArticleTitle_test','ArticleDate_test','Topic_test','Text_test','ReadTimes_test','NewspaperTitle_test','PubDate_test');
SELECT * FROM Article;

