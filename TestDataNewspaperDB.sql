USE newspaper_db;

INSERT Journalist VALUES
('2412001234','Smith','Jackson'),
('0101984321','Anders','Andersen'),
('0202651122','Eddy','Thorsen');
SELECT * FROM Journalist;

INSERT Address VALUES
('2412001234','Hovedgade','1','København','1000',NULL,'Denmark'),
('0101984321','Algade','2','Kgs. Lyngby','2800',NULL,'Denmark'),
('0202851122','Lærkevej','100','Kgs. Lyngby','2800',NULL,'Denmark');

INSERT Phone VALUES
('12345678','2412001234'),
('11223344','0101984321'),
('87654321','0202851122');

INSERT Email VALUES
('SmithJackson@gmail.com','2412001234'),
('AndersAndersen@mail.dk','0101984321'),
('EddyTheEditor@hotmail.com','0202851122');

INSERT Photo VALUES
('Dronning Margrethe den anden der spiser en pandekage.','20080531 01:43:12 PM','2412001234','image_data_example'),
('And i sø.','20000101 01:01:01 AM','0101984321','image_data_example');

INSERT Newspaper VALUES
('The Daily News','20040716 08:53:17 AM','00000001'),
('The Weekly News','19901201 12:00:00 PM','00000100');

INSERT Edition VALUES
('The Daily News','20040801 06:00:00 AM','0101984321'),
('The Weekly News','19910101 07:00:00 AM','0202851122');

INSERT Article VALUES
('HArt1','2023-11-26 12:00:00','Health','Drink water','10','DailyNews','2023-11-26 12:00:05'),
('HArt2','2023-11-27 12:02:00','Health','Eat legumes','12','DailyNews','2023-11-27 12:02:05'),
('FArt1','2023-11-27 12:06:00','Finance','Invest Early','26','DailyNews','2023-11-27 12:06:05'),
('FArt2','2023-11-27 12:06:00','Finance','Invest Earlier!','28','DailyNews','2023-11-27 12:06:05');

INSERT Author VALUES
('Biology','Watson','90000'),
('Comp. Sci.','Taylor','100000');

INSERT ArticlePhoto VALUES
('Biology','Watson','90000'),
('Comp. Sci.','Taylor','100000');