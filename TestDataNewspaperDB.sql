USE newspaper_db;

INSERT INTO Journalist (SSN, FirstName, LastName) VALUES
('2412001234','Smith','Jackson'),
('0101984321','Anders','Andersen'),
('0202651122','Eddy','Thorsen');


INSERT Address VALUES
('2412001234','Hovedgade','1','København','1000','','Denmark'),
('0101984321','Algade','2','Kgs. Lyngby','2800','','Denmark'),
('0202651122','Lærkevej','100','Kgs. Lyngby','2800','','Denmark');


INSERT Phone VALUES 
('12345678','2412001234'),
('11223344','0101984321'),
('87654321','0202651122');


INSERT INTO Email (Email, SSN) VALUES
('SmithJackson@gmail.com','2412001234'),
('AndersAndersen@mail.dk','0101984321'),
('EddyTheEditor@hotmail.com','0202651122');


INSERT Photo VALUES
('Dronning Margrethe den anden der spiser en pandekage.','2008-05-31 01:43:12','2412001234','image_data_example'),
('And i sø.','2000-01-01 01:01:01','0101984321','image_data_example'),
('Tank i Ukraine','2024-01-02 17:21:00','2412001234','image_data_example'),
('Michael Van Prag','2023-01-02 13:21:00','0202651122','image_data_example');


INSERT Newspaper VALUES
('The Daily News','2004-07-16 08:53:17','00000001'),
('The Weekly News','1990-12-01 12:00:00','00000100');


INSERT Edition VALUES
('The Daily News','2004-08-01 06:00:00','0101984321'),
('The Daily News','2019-06-01 18:00:00','2412001234'),
('The Weekly News','1991-01-01 07:00:00','0202851122'),
('The Weekly News','1998-07-12 07:00:00','0202851122');

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
('Dronningen ses på åben gade og ligner enhver borger.','2019-05-31 17:23:42','Culture','I dag er dronningen blevet set på åben gade, hvor han ligner en typisk dansk bedstemor. Mange danskere er glade for at se dronningen være ydmyg.','1874','The Daily News','2019-06-01 18:00:00'),
('Dyrelivet blomstrer igen i indre København efter ny lov.','1998-07-10 13:01:57','Environment','Efter ny lovgivning om at det er blevet forbudt at smide skrald i parken, er parkens vand blevet renere. Dette har ført til at flere og flere dyr flokkes omkring parkernes søer.','3856','The Weekly News','1998-07-12 07:00:00');


INSERT Author VALUES
('0202651122','Writer','Topboss suspenderet efter mistanke om insiderhandel', '2005-02-13 11:37:00'),
('2412001234','Writer','Rusland melder om droneangreb over 1.000 kilometer fra Ukraine', '2024-04-02 10:43:00'),
('0101984321','Leader','Rusland melder om droneangreb over 1.000 kilometer fra Ukraine', '2024-04-02 10:43:00'),
('2412001234','Writer','Dronningen ses på åben gade og ligner enhver borger.','2019-05-31 17:23:42'),
('0101984321','Leader','Dronningen ses på åben gade og ligner enhver borger.','2019-05-31 17:23:42'),
('0202651122','Writer','Dyrelivet blomstrer igen i indre København efter ny lov.','1998-07-10 13:01:57'),
('0202651122','Leader','Dyrelivet blomstrer igen i indre København efter ny lov.','1998-07-10 13:01:57');

INSERT ArticlePhoto VALUES
('Tank i Ukraine','2024-01-02 17:21:00', '2412001234', 'Rusland melder om droneangreb over 1.000 kilometer fra Ukraine','2024-04-02 10:43:00', 'The Daily News','2004-08-01 06:00:00'),
('Michael Van Prag','2023-01-02 13:21:00', '0202651122', 'Topboss suspenderet efter mistanke om insiderhandel','2005-02-13 11:37:00', 'The Weekly News','1991-01-01 07:00:00'),
('Dronning Margrethe den anden der spiser en pandekage.','2008-05-31 13:43:12','2412001234','Dronningen ses på åben gade og ligner enhver borger.','2019-05-31 17:23:42','The Daily News','2019-06-01 18:00:00'),
('And i sø.','2000-01-01 01:01:01','0101984321','Dyrelivet blomstrer igen i indre København efter ny lov.','1998-07-10 13:01:57','The Weekly News','1998-07-12 07:00:00');

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
