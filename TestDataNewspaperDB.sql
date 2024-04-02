USE newspaper_db;

INSERT Journalist VALUES
('2412001234','Smith','Jackson'),
('0101984321','Anders','Andersen'),
('0202651122','Eddy','Thorsen'),
('0101015500', 'Maria', 'Hansen'),
('1111113333','Christian','Hansen'),
('1312001312','Anita','Modstrøm'),
('0102030405','Niels','Numerano'),
('1312111009','Katrine','Contrano');


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
('Michael Van Prag','2023-01-02 13:21:00','0202651122','image_data_example');


INSERT Newspaper VALUES
('The Daily News','2004-07-16 08:53:17','00000001'),
('The Weekly News','1990-12-01 12:00:00','00000100');


INSERT Edition VALUES
('The Daily News','2004-08-01 06:00:00','0101984321'),
('The Daily News','2019-06-01 18:00:00','2412001234'),
('The Weekly News','1991-01-01 07:00:00','0202651122'),
('The Weekly News','1998-07-12 07:00:00','0202651122');

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
('1312111009','Reporter','Flashback: 5 år siden - Da elektronikken overlevede årtusindeskiftet','1999-12-31 23:23:23');

INSERT ArticlePhoto VALUES
('Tank i Ukraine','2024-01-02 17:21:00','2412001234', 'Rusland melder om droneangreb over 1.000 kilometer fra Ukraine','2024-04-02 10:43:00', 'The Daily News','2004-08-01 06:00:00'),
('Michael Van Prag','2023-01-02 13:21:00','0202651122', 'Topboss suspenderet efter mistanke om insiderhandel','2023-02-13 11:37:00', 'The Weekly News','1991-01-01 07:00:00'),
('Dronning Margrethe den anden der spiser en pandekage.','2008-05-31 01:43:12','2412001234','Dronningen ses på åben gade og ligner enhver borger.','2019-05-31 17:23:42','The Daily News','2019-06-01 18:00:00'),
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
