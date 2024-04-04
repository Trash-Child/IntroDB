USE newspaper_db;
/* Insert statemnts */

/* Add journalists */
INSERT INTO Journalist (SSN, FirstName, LastName)
VALUES 
('1234567890', 'Jane', 'Doe'),
('0987654321', 'John', 'Smith'),
('1122334455', 'Emily', 'Johnson');
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
AND PubDate = '2004-08-01 06:00:00';
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

