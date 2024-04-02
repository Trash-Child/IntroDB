/*
										!!! WARNING !!!
				This script resets the database, including tables with their stored data.
*/


/*
	Drop, create and use database.
*/
DROP DATABASE IF EXISTS newspaper_db;
CREATE DATABASE newspaper_db;
USE newspaper_db;


/*
	Drop tables.
    Not necessary when dropping database above.

DROP TABLE IF EXISTS Journalist;
DROP TABLE IF EXISTS Address;
DROP TABLE IF EXISTS Phone;
DROP TABLE IF EXISTS Email;
DROP TABLE IF EXISTS Photo;
DROP TABLE IF EXISTS Article;
DROP TABLE IF EXISTS ArticlePhoto;
DROP TABLE IF EXISTS Author;
DROP TABLE IF EXISTS Edition;
DROP TABLE IF EXISTS Newspaper;
*/


/*
	Create tables.
*/
CREATE TABLE Journalist	# Any journalist with any role.
	(SSN			VARCHAR(16) 	NOT NULL,	# Has to be VARCHAR, as social security numbers also contain letters in some countries. Size of 16 to be safe. Countries that has the longest social security number contains 10 digits, as well as a checksum character.
	 FirstName		VARCHAR(64) 	NOT NULL,
	 LastName		VARCHAR(64) 	NOT NULL,
	 PRIMARY KEY(SSN)
	); # NOTE: Addresses, phone numbers and e-mail addresses for a journalist are stored in their respective tables.
	   # WARNING: Some countries don't have social security numbers. E.g. United Kingdom. I.e. there is no support for handling journalists from said countries.

CREATE TABLE Address # Address of a journalist.
	(SSN			VARCHAR(16) 	NOT NULL,	# SSN of the journalist.
     StreetName		VARCHAR(64) 	NOT NULL,
     CivicNumber	VARCHAR(16) 	NOT NULL,	# Needs to be varchar, since it has to include "123", "123 1. tv", etc...
     City			VARCHAR(64) 	NOT NULL,
     PostalCode		VARCHAR(16) 	NOT NULL,	# Some countries have long postal codes, with some containing letters. Size of 16 to be safe. (E.g. Russias postal codes has 13 characters including a hyphon (-), while the United Kingdoms postal codes contains letters.)
     State			VARCHAR(64)		NOT NULL,
     Country		VARCHAR(64) 	NOT NULL,
     PRIMARY KEY(SSN, StreetName, CivicNumber, City, PostalCode, State, Country),
     FOREIGN KEY		  (SSN)
     REFERENCES Journalist(SSN) ON DELETE CASCADE # "ON DELETE CASCADE": Address gets deleted if the journalist gets deleted.
	); # WARNING: Can the primary key fail if we include state with null values?

CREATE TABLE Phone # Phone number of a journalist.
	(Number			DECIMAL(32,0) 	NOT NULL,	# NOTE: May need to include national code some way or another.
     SSN			VARCHAR(16)   	NOT NULL,
	 PRIMARY KEY(Number),
	 FOREIGN KEY		  (SSN)
     REFERENCES Journalist(SSN) ON DELETE CASCADE
	);

CREATE TABLE Email # E-mail of a journalist.
	(Email			VARCHAR(64) 	NOT NULL,
     SSN			VARCHAR(16) 	NOT NULL,
	 PRIMARY KEY(Email),
	 FOREIGN KEY		  (SSN)
     REFERENCES Journalist(SSN) ON DELETE CASCADE
	);

CREATE TABLE Photo # A photo that was taken during a report.
	(PhotoTitle		VARCHAR(64) 	NOT NULL,
	 PhotoDate		DATETIME 		NOT NULL,	# Date and time for when the photo was shot.
	 SSN			VARCHAR(16) 	NOT NULL,	# Social security number of the journalist who was the reporter.
     ImageData		LONGBLOB 		NOT NULL,	# Stores up to 4GB of data.
	 PRIMARY KEY(PhotoTitle, PhotoDate, SSN),
     FOREIGN KEY		  (SSN)
     REFERENCES Journalist(SSN)
	);
    # Alternative primary key: 		UploadDateTime	DATETIME,		# The date and time the photo was uploaded to the databse.
    # Alternative primary key: 		PhotoID			BINARY(16),		# Binary(16) for storing a UUID v7. (UUID has a size of 128bit. Therefore: (16bytes = 16 * 8bit = 128bit).)

CREATE TABLE Newspaper # A repeating newspaper with the same title. E.g. A newspaper called "The Daily News" and another newspaper called "The Weekly News".
	(NewspaperTitle	VARCHAR(64) 	NOT NULL,
	 FoundDate		DATETIME		NOT NULL,
	 Periodicity	DECIMAL(8,0)	NOT NULL,	# How long between each new edition, formatted as YYMMWWDD with YY being how many years between, MM: months, WW: weeks and DD: days. E.g. "The Daily News" would have a Periodicity value of 00000001, and "The Weekly News" would have a Periodicity value of 00000100.
	 PRIMARY KEY(NewspaperTitle)
	);

CREATE TABLE Edition # Edition of a newspaper.
	(NewspaperTitle	VARCHAR(64) 	NOT NULL,
	 PubDate		DATETIME		NOT NULL,
     SSN			VARCHAR(16)		NOT NULL,	# Editor of this edition.
	 PRIMARY KEY(NewspaperTitle, PubDate),
     FOREIGN KEY		  (NewspaperTitle)
     REFERENCES  Newspaper(NewspaperTitle),
	 FOREIGN KEY		  (SSN)
     REFERENCES Journalist(SSN)
	); # NOTE: Articles in an edition are stored in 'Article' table.

CREATE TABLE Article # Article for an edition.
	(ArticleTitle	VARCHAR(100) 	NOT NULL,
     ArticleDate	DATETIME 		NOT NULL,	# Date for when the edition of the article was uploaded.
     Topic			VARCHAR(64) 	NOT NULL,
     Text			TEXT 			NOT NULL,	# Can store 65,535 characters. Should consider using MEDIUMTEXT which stores 16mil characters.
	 ReadTimes		DECIMAL(16,0) 	NOT NULL,	# Has to be instantiated as 0 for error detection.
     NewspaperTitle	VARCHAR(64) 	NOT NULL,	# Part of primary key of Edition.
     PubDate 		DATETIME 		NOT NULL,	# Part of primary key of Edition.
	 PRIMARY KEY(ArticleTitle, ArticleDate, NewspaperTitle, PubDate),
	 FOREIGN KEY	   (NewspaperTitle, PubDate)
     REFERENCES Edition(NewspaperTitle, PubDate)
	); # NOTE: A unique article edition is characterized by the ArticleDate. This way, an article can be edited before released to the newspaper 'Edition'. I.e: Article edition is not to be confused with 'Edition'.

    CREATE TABLE Author # Journalist writing role of an article.
	(SSN			VARCHAR(16) 	NOT NULL,
     Role			VARCHAR(64)		NOT NULL,
     ArticleTitle	VARCHAR(100) 	NOT NULL,
     ArticleDate	DATETIME		NOT NULL,
     PRIMARY KEY(SSN, Role, ArticleTitle, ArticleDate),
	 FOREIGN KEY		  (SSN)
     REFERENCES Journalist(SSN),
	 FOREIGN KEY	   	  (ArticleTitle, ArticleDate)
     REFERENCES    Article(ArticleTitle, ArticleDate)
    ); # NOTE: Author becomes author of every edition of the article.

    CREATE TABLE ArticlePhoto # Relation between photos used in article edition.
	(PhotoTitle		VARCHAR(64)		NOT NULL,
	 PhotoDate		DATETIME		NOT NULL,
     SSN			VARCHAR(16)		NOT NULL,	# Part of primary key of Photo.
     ArticleTitle	VARCHAR(64)		NOT NULL,
	 ArticleDate	DATETIME		NOT NULL,
     NewspaperTitle	VARCHAR(64)		NOT NULL,
     PubDate 		DATETIME		NOT NULL,
	 PRIMARY KEY(PhotoTitle, PhotoDate, SSN, ArticleTitle, ArticleDate, NewspaperTitle, PubDate),
	 FOREIGN KEY	   (PhotoTitle, PhotoDate, SSN)
     REFERENCES   Photo(PhotoTitle, PhotoDate, SSN),
	 FOREIGN KEY	   (ArticleTitle, ArticleDate, NewspaperTitle, PubDate)
     REFERENCES Article(ArticleTitle, ArticleDate, NewspaperTitle, PubDate)
	);