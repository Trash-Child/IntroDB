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
	(SSN			VARCHAR(16)		NOT NULL,
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
    
    
    
    
INSERT Journalist VALUES
('2412001234','Smith','Jackson'),
('0101984321','Anders','Andersen'),
('0202651122','Eddy','Thorsen'),
('0101015500', 'Maria', 'Hansen'),
('1111113333','Christian','Hansen'),
('1312001312','Anita','Modstrøm'),
('0102030405','Niels','Numerano'),
('1312111009','Katrine','Contrano'),
('1122334455','Soren','Sondergaard'),
('9998887776','Maren','Kristensen'),
('1716008787','Oliver','Sørensen'),
('7878787878','Hanne','Petterson'),
('1357913579','Nino','Nilsson'),
('2468101214','Karina','Kristensen'),
('1352464789','Sonny','Olsen'),
('1919890765','Henny','Heinz'),
('2392273648','Lise','Lorentzen');

INSERT Address VALUES
('2412001234','Hovedgade','1','København','1000','','Denmark'),
('0101984321','Algade','2','Kgs. Lyngby','2800','','Denmark'),
('0202651122','Lærkevej','100','Kgs. Lyngby','2800','','Denmark');

INSERT Phone VALUES 
('12345678','2412001234'),
('11223344','0101984321'),
('87654321','0202651122');

INSERT Email VALUES
('SmithJackson@gmail.com','2412001234'),
('AndersAndersen@mail.dk','0101984321'),
('EddyTheEditor@hotmail.com','0202651122');

INSERT Photo VALUES
('Dronning Margrethe den anden der spiser en pandekage.','2008-05-31 01:43:12','2412001234','image_data_example'),
('And i sø.','2000-01-01 01:01:01','0101984321','image_data_example'),
('Tank i Ukraine','2024-01-02 17:21:00','2412001234','image_data_example'),
('Michael Van Prag','2023-01-02 13:21:00','0202651122','image_data_example'),
('Screenshot fra Lo-Fi stream','2020-01-01 10:15:01','0102030405','image_data_example'),
('Dnipro efter bombardement','2020-03-03 09:12:01','1312001312','image_data_example'),
('Kaffebønner i kværn','2021-09-07 11:19:01','1716008787','image_data_example'),
('Sølvpapirshat','2021-01-020 09:12:00','1716008787','image_data_example'),
('Skovsegryde med ske','2022-02-02 13:12:01','1716008787','image_data_example'),
('Rotte i et køkken','2022-02-02 09:00:01','1716008787','image_data_example'),
('Everest er sunket','2020-03-03 09:12:01','1357913579','image_data_example'),
('Folk forlader folketinget','2020-03-03 09:12:01','1357913579','image_data_example');


INSERT Newspaper VALUES
('The Daily News','2000-02-08 08:53:17','00000001'),
('The Weekly News','1999-07-27 12:00:00','00000200'),
('The Month in Minutes','2005-07-00 12:00:00','00010000');


INSERT Edition VALUES
('The Daily News','2004-08-01 06:00:00','0101984321'),
('The Daily News','2019-06-01 18:00:00','2412001234'),
('The Daily News','2020-06-20 06:00:00','1312111009'),
('The Daily News','2024-04-03 06:00:00','1312111009'),
('The Weekly News','1991-01-01 07:00:00','0202651122'),
('The Weekly News','1998-07-12 07:00:00','0202651122'),
('The Weekly News','2022-03-15 06:00:00','0101015500'),
('The Month in Minutes','2005-07-01 12:00:00','1919890765'),
('The Month in Minutes','2006-08-02 12:00:00','7878787878'),
('The Month in Minutes','2010-09-01 12:00:00','1111113333'),
('The Month in Minutes','2020-10-02 12:00:00','1352464789'),
('The Month in Minutes','2021-10-01 12:00:00','1352464789'),
('The Month in Minutes','2022-11-01 12:00:00','2392273648');

INSERT Article VALUES
('Rusland melder om droneangreb over 1.000 kilometer fra Ukraine','2024-04-02 10:43:00','Krig','

To industrianlæg i den russiske region Tatarstan er blevet ramt af droneangreb omkring 1.100 kilometer fra grænsen til Ukraine, oplyser russiske embedsmænd tirsdag.
Viser angrebet sig at komme fra ukrainsk område, vil det være et af de angreb, der har ramt længst inde på russisk territorium siden krigens begyndelse i februar 2022. Det oplyses dog ikke, om angrebet kom fra ukrainsk område.',

'10035','The Daily News','2004-08-01 06:00:00'),

('Topboss suspenderet efter mistanke om insiderhandel','2023-02-13 11:37:00','Sport','

Ajax har suspenderet administrerende direktør i klubben Ajax, Alex Kroes, med henblik på at afskedige ham helt på et senere tidspunkt.
Det skriver den hollandske storklub på sin hjemmeside. 
Årsagen til den opsigtsvækkende beslutning skal findes i, at det er kommet frem, at Kroes op til sin ansættelse i august sidste år købte over 17.000 Ajax-aktier ugentligt. ',

'5000','The Weekly News','1991-01-01 07:00:00'),
('Mudderkast på borgen - Boje insisterer på gratis underbukser','2022-08-12 10:30:29','Politik',
'Debatten raser igen om hvorvidt staten bør finansiere gratis menstruationsprodukter på offentlige toiletter. Debatten blev personlig, efter Lars Boje (Nye Borgerlige) sammenlignede menstruation med at skide i bukserne.
- Skal der så også være gratis underbukser? Hvad nu hvis jeg går en tur på skaden, og så spontant skider jeg i bukserne? 
Udtalen har vagt stor debat i det offentlige rum, hvor folk nu diskuterer hvor vidt de to hændelser er sammenlignelige, i stedet for at tale om det egentlige emne - skal folk med livmoder have en håndsrækning til at eksistere på lige fod med folk uden, når menstruationen kommer uventet?',
13852, 'The Daily News', '2019-06-01 18:00:00'
),

('Hvem gav ordren? Forsøg på afdækning af minksagen stødt på grund igen','2020-09-09 11:00:30', 'Politik',
'Var det Mette, var det Barbara, var det en af de mange afskedte ministre? Ingen vil tage skylden',
10005, 'The Weekly News', '1998-07-12 07:00:00'
),
('Flashback: 5 år siden - Da elektronikken overlevede årtusindeskiftet','1999-12-31 23:23:23','Kultur',
'Mange stiller spørgsmål ved hvorvidt vores moderne elektroniske verden risikerer at gå i stå, når vi runder årtusindeskiftet. 
Den såkaldte Y2K er frygtet af mange, og af en eller anden grund er der ikke rigtig nogle der ved om det hele står eller falder, så vi må bare vente og se åbenbart.
',
2003,'The Daily News','2004-08-01 06:00:00'
),
('Er agurketiden endeligt forbi? Miljøkatastrofen truer Jens Hansens agurkegård','2000-11-19 20:13:00','Miljø',
'Verdens førende forskere sår tvivl om hvorvidt landbruget kan holde til tidens kommende miljøkatastrofer. For Jens Hansen kan de kommende tørketider betyde betydeligt mindre agurker, hvilket ville være en mindre katastrofe for den ellers succesfulde agurkeavler.
- Jeg må jo gå over til kun at lave skoleagurker, hvis det her fortsætter
',
902, 'The Daily News','2004-08-01 06:00:00'
),
('Cubakrisens effekt på moderne krigsførsel','2003-12-12 16:29:00','Krig',
'Cubakrisen er efterhånden længe siden, men er stadig relevant i opfattelsen af atomvåben',
1100, 'The Weekly News','1998-07-12 07:00:00'
),
('Lo-Fi løfter studieindsatsen','2020-06-10 10:10:10','Kultur',
'Hjemsendelsen gør det sværere at studere. Flere unge har fundet ud af, det hele bliver lidt lettere med Lo-Fi-musik i baggrunden.',
2654, 'The Daily News','2020-06-20 06:00:00'
),
('Putin: vi gør det for deres skyld','2022-03-03 11:11:11','Krig',
'Putin insisterer på at invasionen af Ukraine er for alles bedste',
5533, 'The Weekly News','2022-03-15 06:00:00'
),
('Kaffeafhænigheden stiger igen','2021-09-07 12:00:01','Samfund',
'Efterhånden som landet åbnes op, stiger danskernes kaffebrug. Noget tyder på afhængigheden har været faldet under nedlukningen, men vendt tilbage sammen med en tavlere hverdag.',
2468, 'The Month in Minutes','2021-10-01 12:00:00'
),
('Månedens vildeste konspirationsteori: Q-Anon','2020-10-01 16:21:00','Samfund',
'En stadigt voksende gruppe er overbevist om at USAs Elite drikker barneblod',
6172, 'The Month in Minutes','2020-10-02 12:00:00'
),
('LA med ny kampagne på borgen - krammer frygten væk','2024-04-02 12:00:00','Politik',
'LA har foræret en bamse til Ida Auken. Med bamsen følger budskabet at deres politik slet ikke er så skræmmende, som man skulle tro. Nu kan man åbenbart kramme politik.',
1827, 'The Daily News','2024-04-03 06:00:00'
),
('Whiskey- eller rødvinssovs? Køkkenrotte har svaret','2022-10-29 13:29:22','Mad',
'Køkkenrotterne indtog Noma i sidste uge, og foretrak whiskeysovsen. 8 ud ad 10 rotter gik direkte i den gyldne gryde, mens rødvinssovsen appelerede til fåtallet.',
3456, 'The Month in Minutes','2022-11-01 12:00:00'
),
('Verdens højeste bjerg er faktisk kun nr. 2','2006-07-25 13:29:33','Verden',
'Mt. Everest er sunket 400 meter siden man målte det sidst. Verdens tidligere næstehøjeste bjerg K2 ligger altså nu nummer et.',
3251, 'The Month in Minutes','2006-08-02 12:00:00'
),
('Partier kommer og går hurtigere end nogensinde før','2005-04-25 13:29:33','Politik',
'Efter årtusindeskiftet er partiudskiftningen tiltaget kraftigt.',
2251, 'The Month in Minutes','2005-07-01 12:00:00'
),
('Dronningen ses på åben gade og ligner enhver borger.','2019-05-31 17:23:42','Kultur','I dag er dronningen blevet set på åben gade, hvor han ligner en typisk dansk bedstemor. Mange danskere er glade for at se dronningen være ydmyg.','1874','The Daily News','2019-06-01 18:00:00'),
('Dyrelivet blomstrer igen i indre København efter ny lov.','1998-07-10 13:01:57','Miljø','Efter ny lovgivning om at det er blevet forbudt at smide skrald i parken, er parkens vand blevet renere. Dette har ført til at flere og flere dyr flokkes omkring parkernes søer.','3856','The Weekly News','1998-07-12 07:00:00'),
('Brøndby vinder over FCK', '2020-05-13 12:34:00', 'Sport','FCK kom foran 1-0 men tabte 2-1. Øv', '2143','The Weekly News','1998-07-12 07:00:00');


INSERT Author VALUES
('0202651122','Writer','Topboss suspenderet efter mistanke om insiderhandel', '2023-02-13 11:37:00'),
('2412001234','Reporter','Topboss suspenderet efter mistanke om insiderhandel', '2023-02-13 11:37:00'),
('2412001234','Writer','Rusland melder om droneangreb over 1.000 kilometer fra Ukraine', '2024-04-02 10:43:00'),
('0101984321','Leader','Rusland melder om droneangreb over 1.000 kilometer fra Ukraine', '2024-04-02 10:43:00'),
('2412001234','Writer','Dronningen ses på åben gade og ligner enhver borger.','2019-05-31 17:23:42'),
('0101984321','Leader','Dronningen ses på åben gade og ligner enhver borger.','2019-05-31 17:23:42'),
('0202651122','Writer','Dyrelivet blomstrer igen i indre København efter ny lov.','1998-07-10 13:01:57'),
('0202651122','Reporter','Dyrelivet blomstrer igen i indre København efter ny lov.','1998-07-10 13:01:57'),
('0202651122','Leader','Dyrelivet blomstrer igen i indre København efter ny lov.','1998-07-10 13:01:57'),
('0102030405','Leader','Flashback: 5 år siden - Da elektronikken overlevede årtusindeskiftet','1999-12-31 23:23:23'),
('1312111009','Reporter','Er agurketiden endeligt forbi? Miljøkatastrofen truer Jens Hansens agurkegård','2000-11-19 20:13:00'),
('1312001312','Leader','Mudderkast på borgen - Boje insisterer på gratis underbukser','2022-08-12 10:30:29'),
('1111113333','Writer','Cubakrisens effekt på moderne krigsførsel','2003-12-12 16:29:00'),
('1312111009','Writer','Er agurketiden endeligt forbi? Miljøkatastrofen truer Jens Hansens agurkegård','2000-11-19 20:13:00'),
('0101015500','Leader','Er agurketiden endeligt forbi? Miljøkatastrofen truer Jens Hansens agurkegård','2000-11-19 20:13:00'),
('0102030405','Reporter','Lo-Fi løfter studieindsatsen','2020-06-10 10:10:10'),
('1312111009','Leader','Lo-Fi løfter studieindsatsen','2020-06-10 10:10:10'),
('1312111009','Reporter','Flashback: 5 år siden - Da elektronikken overlevede årtusindeskiftet','1999-12-31 23:23:23'),
('1312001312','Leader','Putin: vi gør det for deres skyld','2022-03-03 11:11:11'),
('1312001312','Reporter','Putin: vi gør det for deres skyld','2022-03-03 11:11:11'),
('0101015500','Writer','Putin: vi gør det for deres skyld','2022-03-03 11:11:11'),
('1716008787','Reporter','Kaffeafhænigheden stiger igen','2021-09-07 12:00:01'),
('1357913579','Writer','Kaffeafhænigheden stiger igen','2021-09-07 12:00:01'),
('2412001234','Leader','Kaffeafhænigheden stiger igen','2021-09-07 12:00:01'),
('1716008787','Reporter','Månedens vildeste konspirationsteori: Q-Anon','2020-10-01 16:21:00'),
('2468101214','Leader','Månedens vildeste konspirationsteori: Q-Anon','2020-10-01 16:21:00'),
('1352464789','Writer','Månedens vildeste konspirationsteori: Q-Anon','2020-10-01 16:21:00'),
('1122334455','Writer','LA med ny kampagne på borgen - krammer frygten væk','2024-04-02 12:00:00'),
('1122334455','Leader','LA med ny kampagne på borgen - krammer frygten væk','2024-04-02 12:00:00'),
('2392273648','Writer','Whiskey- eller rødvinssovs? Køkkenrotte har svaret','2022-10-29 13:29:22'),
('2392273648','Leader','Whiskey- eller rødvinssovs? Køkkenrotte har svaret','2022-10-29 13:29:22'),
('1716008787','Reporter','Whiskey- eller rødvinssovs? Køkkenrotte har svaret','2022-10-29 13:29:22'),
('1357913579','Reporter','Verdens højeste bjerg er faktisk kun nr. 2','2006-07-25 13:29:33'),
('1919890765','Writer','Verdens højeste bjerg er faktisk kun nr. 2','2006-07-25 13:29:33'),
('2392273648','Leader','Verdens højeste bjerg er faktisk kun nr. 2','2006-07-25 13:29:33'),
('7878787878','Writer','Partier kommer og går hurtigere end nogensinde før','2005-04-25 13:29:33'),
('7878787878','Leader','Partier kommer og går hurtigere end nogensinde før','2005-04-25 13:29:33'),
('1357913579','Reporter','Partier kommer og går hurtigere end nogensinde før','2005-04-25 13:29:33');


INSERT ArticlePhoto VALUES
('Tank i Ukraine','2024-01-02 17:21:00','2412001234', 'Rusland melder om droneangreb over 1.000 kilometer fra Ukraine','2024-04-02 10:43:00', 'The Daily News','2004-08-01 06:00:00'),
('Michael Van Prag','2023-01-02 13:21:00','0202651122', 'Topboss suspenderet efter mistanke om insiderhandel','2023-02-13 11:37:00', 'The Weekly News','1991-01-01 07:00:00'),
('Dronning Margrethe den anden der spiser en pandekage.','2008-05-31 01:43:12','2412001234','Dronningen ses på åben gade og ligner enhver borger.','2019-05-31 17:23:42','The Daily News','2019-06-01 18:00:00'),
('And i sø.','2000-01-01 01:01:01','0101984321','Dyrelivet blomstrer igen i indre København efter ny lov.','1998-07-10 13:01:57','The Weekly News','1998-07-12 07:00:00'),
('Screenshot fra Lo-Fi stream','2020-01-01 10:15:01','0102030405','Lo-Fi løfter studieindsatsen','2020-06-10 10:10:10','The Daily News','2020-06-20 06:00:00'),
('Dnipro efter bombardement','2020-03-03 09:12:01','1312001312','Putin: vi gør det for deres skyld','2022-03-03 11:11:11','The Weekly News','2022-03-15 06:00:00'),
('Kaffebønner i kværn','2021-09-07 11:19:01','1716008787','Kaffeafhænigheden stiger igen','2021-09-07 12:00:01','The Month in Minutes','2021-10-01 12:00:00'),
('Sølvpapirshat','2021-01-020 09:12:00','1716008787','Månedens vildeste konspirationsteori: Q-Anon','2020-10-01 16:21:00','The Month in Minutes','2020-10-02 12:00:00'),
('Skovsegryde med ske','2022-02-02 13:12:01','1716008787','Whiskey- eller rødvinssovs? Køkkenrotte har svaret','2022-10-29 13:29:22','The Month in Minutes','2022-11-01 12:00:00'),
('Rotte i et køkken','2022-02-02 09:00:01','1716008787','Whiskey- eller rødvinssovs? Køkkenrotte har svaret','2022-10-29 13:29:22','The Month in Minutes','2022-11-01 12:00:00'),
('Everest er sunket','2020-03-03 09:12:01','1357913579','Verdens højeste bjerg er faktisk kun nr. 2','2006-07-25 13:29:33','The Month in Minutes','2006-08-02 12:00:00'),
('Folk forlader folketinget','2020-03-03 09:12:01','1357913579','Partier kommer og går hurtigere end nogensinde før','2005-04-25 13:29:33','The Month in Minutes','2005-07-01 12:00:00');

SELECT * FROM Journalist;
SELECT * FROM Address;
SELECT * FROM Phone;
SELECT * FROM Email;
SELECT * FROM Photo;
SELECT * FROM Newspaper;
SELECT * FROM Edition;
SELECT * FROM Article;
SELECT * FROM Author;
SELECT * FROM ArticlePhoto;