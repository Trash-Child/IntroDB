USE newspaper_db;

INSERT INTO Journalist (SSN, FirstName, LastName) VALUES
('2412001234','Smith','Jackson'),
('0101984321','Anders','Andersen'),
('0202651122','Eddy','Thorsen');
#SELECT * FROM Journalist;

INSERT INTO Address (SSN, StreetName, CivicNumber, City, PostalCode, State, Country) VALUES
('2412001234','Hovedgade','1','København','1000','','Denmark'),
('0101984321','Algade','2','Kgs. Lyngby','2800','','Denmark'),
('0202651122','Lærkevej','100','Kgs. Lyngby','2800','','Denmark');
#SELECT * FROM Address;

INSERT INTO Phone (Number, SSN) VALUES
('12345678','2412001234'),
('11223344','0101984321'),
('87654321','0202651122');
SELECT * FROM Phone;

INSERT INTO Email (Email, SSN) VALUES
('SmithJackson@gmail.com','2412001234'),
('AndersAndersen@mail.dk','0101984321'),
('EddyTheEditor@hotmail.com','0202651122');

INSERT Photo VALUES
('Dronning Margrethe den anden der spiser en pandekage.','2008-05-31 13:43:12','2412001234','image_data_example'),
('And i sø.','2000-01-01 01:01:01','0101984321','image_data_example');

INSERT Newspaper VALUES
('The Daily News','2004-07-16 08:53:17','00000001'),
('The Weekly News','1990-12-01 12:00:00','00000100');

INSERT Edition VALUES
('The Daily News','2004-08-01 06:00:00','0101984321'),
('The Daily News','2019-06-01 18:00:00','2412001234'),
('The Weekly News','1991-01-01 07:00:00','0202851122'),
('The Weekly News','1998-07-12 07:00:00','0202851122');

INSERT Article VALUES
('Dronningen ses på åben gade og ligner enhver borger.','2019-05-31 17:23:42','Culture','I dag er dronningen blevet set på åben gade, hvor han ligner en typisk dansk bedstemor. Mange danskere er glade for at se dronningen være ydmyg.','1874','The Daily News','2019-06-01 18:00:00'),
('Dyrelivet blomstrer igen i indre København efter ny lov.','1998-07-10 13:01:57','Environment','Efter ny lovgivning om at det er blevet forbudt at smide skrald i parken, er parkens vand blevet renere. Dette har ført til at flere og flere dyr flokkes omkring parkernes søer.','3856','The Weekly News','1998-07-12 07:00:00');

INSERT Author VALUES
('2412001234','Writer','Dronningen ses på åben gade og ligner enhver borger.','2019-05-31 17:23:42'),
('0101984321','Leader','Dronningen ses på åben gade og ligner enhver borger.','2019-05-31 17:23:42'),
('0202651122','Writer','Dyrelivet blomstrer igen i indre København efter ny lov.','1998-07-10 13:01:57'),
('0202651122','Leader','Dyrelivet blomstrer igen i indre København efter ny lov.','1998-07-10 13:01:57');

INSERT ArticlePhoto VALUES
('Dronning Margrethe den anden der spiser en pandekage.','2008-05-31 13:43:12','2412001234','Dronningen ses på åben gade og ligner enhver borger.','2019-05-31 17:23:42','The Daily News','2019-06-01 18:00:00'),
('And i sø.','2000-01-01 01:01:01','0101984321','Dyrelivet blomstrer igen i indre København efter ny lov.','1998-07-10 13:01:57','The Weekly News','1998-07-12 07:00:00');