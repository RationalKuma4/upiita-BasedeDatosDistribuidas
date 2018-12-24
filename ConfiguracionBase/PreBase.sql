ALTER TABLE Citas
ADD Tecnico_TecnicoId INT NULL
GO

INSERT INTO [dbo].[AspNetRoles]([Name])
VALUES ('Administrador'),('Recepcionista')
GO
--Zonas
--Sucursales
--Usuarios
--Estudios
--Analisis
--Analisis Sucursal
--Clientes

INSERT INTO Clientes([Nombre],[ApellidoPaterno],[ApellidoMaterno],[Telefono],[Celular],[Calle],[NumeroInterior],[NumeroExterior],[Colonia],[DelegacionMunicipio],[CodigoPostal],[Sexo],[Peso],[Edad],[Estatus]) 
VALUES('Bryar','Glenna','Lysandra','0169715578','14071451296','9594838 Ac Road','0','1','L','Dublin','47337','S',117,23,'Act'),
('Cyrus','Katelyn','Teegan','0531617584','18127253285','3637166 Fringilla, Av.','0','1','Bremen','Bremen','451611','S',97,20,'Act'),
('Amena','Lara','Hollee','0109865074','17677809762','P.O. Box 905, 936 Enim. Avenue','0','1','BD','Dunstable','99553','S',115,42,'Act'),
('Dieter','Ruth','Neville','0453607094','13306052437','4632 Dictum Street','0','1','C','Galway','588942','S',81,44,'Act'),
('Amal','Olympia','Austin','0112821091','12111005303','Ap #9751182 Vulputate, Rd.','0','1','MP','Ujjain','97800','S',107,52,'Act'),
('Declan','Addison','Oleg','0221039605','17207261848','6619 Magna. Av.','0','1','NI','Wellington','94191','S',89,76,'Act'),
('Bruno','Ria','Kirby','0594642537','16107264430','7926107 Lorem, Ave','0','1','Metropolitana de Santiago','Lo Barnechea','4427','S',45,14,'Act'),
('Gail','Kiara','Mark','0056235228','16107798027','P.O. Box 347, 5316 Non, Rd.','0','1','Bahia','Camaçari','502835','S',81,64,'Act'),
('Leroy','Pascale','Noah','0343649264','16109942545','Ap #6069448 Mollis Ave','0','1','Ontario','Hearst','21111','S',114,25,'Act'),
('Kennedy','Francis','Alfonso','0426388811','16685355501','P.O. Box 617, 5086 Ut Rd.','0','1','Leicestershire','Melton Mowbray','3146','S',76,61,'Act');
GO
INSERT INTO Clientes([Nombre],[ApellidoPaterno],[ApellidoMaterno],[Telefono],[Celular],[Calle],[NumeroInterior],[NumeroExterior],[Colonia],[DelegacionMunicipio],[CodigoPostal],[Sexo],[Peso],[Edad],[Estatus]) 
VALUES('Myra','Rogan','Katell','0470167074','18615543648','4450 Sodales Rd.','0','1','Leinster','Dublin','6884','S',97,71,'Act'),
('Sylvia','Barbara','Shaeleigh','0259995584','17098640174','1685194 Eu Avenue','0','1','Georgia','Georgia','4241','S',42,38,'Act'),
('Moses','Heather','Rhoda','0302986380','12904813208','P.O. Box 564, 4406 Orci Road','0','1','Ulster','Belfast','33943','S',101,38,'Act'),
('Oliver','Vance','Leigh','0183329217','13379843775','1945 Tristique Street','0','1','Metropolitana de Santiago','Pedro Aguirre Cerda','50402','S',47,70,'Act'),
('Keely','Brendan','Brendan','0258453663','17721647770','P.O. Box 928, 4429 Nascetur Ave','0','1','Z.','Spijkenisse','51509','S',73,58,'Act'),
('Naomi','Ashton','Abbot','0956440333','18965504810','Ap #780621 Cras Rd.','0','1','Mississippi','Southaven','9540','S',94,38,'Act'),
('Basil','Zachary','Raymond','0662146309','16023167565','9985970 Torquent Ave','0','1','Lagos','Lagos','11863','S',87,53,'Act'),
('Hasad','Deanna','Britanni','0559281307','16584853467','P.O. Box 546, 1555 Nullam Rd.','0','1','Lagos','Lagos','966300','S',83,78,'Act'),
('Calista','Jonah','Murphy','0235062045','17935069412','Ap #9732033 Integer St.','0','1','Antwerpen','Vorst','71060','S',117,17,'Act'),
('Keaton','Oliver','Nathan','0709367181','15379995666','P.O. Box 524, 732 Faucibus St.','0','1','AB','Södertälje','88654','S',114,51,'Act');
GO
INSERT INTO Clientes([Nombre],[ApellidoPaterno],[ApellidoMaterno],[Telefono],[Celular],[Calle],[NumeroInterior],[NumeroExterior],[Colonia],[DelegacionMunicipio],[CodigoPostal],[Sexo],[Peso],[Edad],[Estatus]) 
VALUES('Christopher','Kennan','Martin','0065702797','19962300917','7839 Arcu St.','0','1','XIV','O''Higgins','7598','S',96,16,'Act'),
('Zane','Grace','Richard','0317894462','14415257124','9757011 A, Street','0','1','Zeeland','Sluis','9621','S',72,10,'Act'),
('Edan','Cherokee','Henry','0556212899','17385661363','3862 Orci Rd.','0','1','HB','Bremen','948805','S',103,65,'Act'),
('Raymond','Mona','Buckminster','0139999347','16358535360','P.O. Box 157, 9879 Sed Rd.','0','1','Madrid','Parla','66161434','S',51,41,'Act'),
('Rachel','Keane','Harper','0105672139','16124390013','1684489 Ut Av.','0','1','Zl','Terneuzen','02640','S',72,70,'Act'),
('Barry','Victor','Solomon','0349676196','15949344026','Ap #8923812 Cursus. St.','0','1','NW','Remscheid','521603','S',119,50,'Act'),
('Vernon','Cassady','Geraldine','0003467418','15662497287','P.O. Box 952, 6949 Feugiat Rd.','0','1','WestVlaanderen','Hertsberge','890159','S',70,80,'Act'),
('Kyle','Castor','Yoshi','0099824709','19969102125','9624 Neque Avenue','0','1','RM','Renca','625038','S',111,61,'Act'),
('Jesse','Carolyn','Byron','0904216110','11474650216','3138237 Eu Rd.','0','1','RP','Bad Dürkheim','68992','S',55,79,'Act'),
('Buckminster','Frances','Lunea','0706447636','17884844083','P.O. Box 562, 733 Dolor Rd.','0','1','Berlin','Berlin','81236','S',105,66,'Act');
GO
INSERT INTO Clientes([Nombre],[ApellidoPaterno],[ApellidoMaterno],[Telefono],[Celular],[Calle],[NumeroInterior],[NumeroExterior],[Colonia],[DelegacionMunicipio],[CodigoPostal],[Sexo],[Peso],[Edad],[Estatus]) 
VALUES('Harper','Zena','Kerry','0861383967','17586270338','3668835 Tempor Av.','0','1','W','Avesta','2130','S',104,62,'Act'),
('Aiko','Idola','Elaine','0494816734','19739509237','1802757 Sed Road','0','1','Catalunya','Tarragona','61101','S',76,61,'Act'),
('Seth','Colton','Josiah','0206438744','15229944961','P.O. Box 299, 4807 Quisque Avenue','0','1','San José','Curridabat','779828','S',64,61,'Act'),
('Henry','Oliver','Ferdinand','0784163269','15148091270','1896 Fusce Rd.','0','1','GA','Georgia','61819','S',94,38,'Act'),
('Kirsten','Victoria','Duncan','0237072287','15235869257','6725 Lacus. Avenue','0','1','British Columbia','Coldstream','85050','S',68,51,'Act'),
('Hermione','Victoria','Idona','0417329576','16777324054','Ap #7391019 Elit Rd.','0','1','MO','Independence','4892','S',75,24,'Act'),
('Henry','Madison','Bryar','0548011194','17589577101','P.O. Box 496, 1766 Ante Avenue','0','1','North Island','Palmerston North','91655','S',114,20,'Act'),
('Lesley','Sigourney','Xaviera','0441849931','11557468922','P.O. Box 762, 4933 Dignissim. Road','0','1','Ontario','Pickering','11864','S',118,14,'Act'),
('Kelsey','Hilda','Isaac','0672459995','16899520747','7393 Rutrum Street','0','1','E','Motala','812494','S',62,60,'Act'),
('Kai','Autumn','Whilemina','0931195552','17508460166','P.O. Box 714, 1200 Duis Avenue','0','1','Östergötlands län','Norrköping','7690','S',52,15,'Act');
GO
INSERT INTO Clientes([Nombre],[ApellidoPaterno],[ApellidoMaterno],[Telefono],[Celular],[Calle],[NumeroInterior],[NumeroExterior],[Colonia],[DelegacionMunicipio],[CodigoPostal],[Sexo],[Peso],[Edad],[Estatus]) 
VALUES('Declan','Kylie','Lucy','0930614043','14902675094','4101601 Massa Rd.','0','1','ON','LaSalle','820376','S',101,80,'Act'),
('Neve','Hillary','Signe','0717308955','17351749307','1437098 Enim. St.','0','1','VII','Coronel','43672','S',63,71,'Act'),
('Melyssa','Iliana','Garrett','0105535164','12537410165','7886722 Eu Avenue','0','1','Comunitat Valenciana','Valéncia','31012','S',62,25,'Act'),
('Armand','Desiree','Zeus','0790233472','12585230557','Ap #104301 Lacinia St.','0','1','Wie','Vienna','8635','S',108,34,'Act'),
('Amy','Bell','Laith','0450595377','14694288302','P.O. Box 574, 3395 Libero Avenue','0','1','Alabama','Tuscaloosa','8770','S',58,24,'Act'),
('Daquan','Kylee','Mariko','0710985891','18371864551','Ap #4808061 Non, Rd.','0','1','WA','Spokane','21022270','S',97,20,'Act'),
('Lynn','Howard','Galvin','0742899029','15373100673','4432 Cursus. Road','0','1','Oklahoma','Oklahoma City','3350','S',85,57,'Act'),
('Leah','Lara','Aretha','0054199787','13031828183','Ap #991518 Viverra. St.','0','1','Heredia','San Pablo','8649','S',82,35,'Act'),
('Breanna','Dalton','Lenore','0510578394','17177447082','4358890 Sapien Ave','0','1','MH','Satara','99184','S',61,55,'Act'),
('Perry','Demetria','Nora','0779101025','13497592840','7127 Elit, Av.','0','1','Rio Grande do Sul','Gravataí','20006','S',49,79,'Act');
GO

--tecnicos
INSERT INTO Tecnicos
([Nombre],[ApellidoPaterno],[ApellidoMaterno],[Calle],[NumeroInterior],[NumeroExterior],[Colonia],[DelegacionMunicipio],[CodigoPostal],[Estado],[Edad],[Sexo],[Notas],[Estatus],[SucursalId],[EstudioId]) 
VALUES('Rowan','Colton','Myra','Ap #9029503 Velit. Road','0','1','Minnesota','Saint Paul','45135106','Wallis and Futuna',48,'S','bibendum ullamcorper. Duis cursus, diam at pretium aliquet, metus urna','Act',9,7),
('Hedley','Baker','Dorian','6556 Vitae, Rd.','0','1','NSW','Liverpool','62007','Seychelles',20,'S','ridiculus mus. Donec dignissim magna a tortor. Nunc commodo auctor','Act',4,3),
('Prescott','Nash','Jayme','9761 Neque St.','0','1','CE','Dreux','1547','Iraq',35,'S','et, lacinia vitae, sodales at, velit. Pellentesque ultricies dignissim lacus.','Act',7,9),
('Nadine','Leroy','Channing','P.O. Box 918, 7377 Libero Road','0','1','NT','Northampton','976400','Belgium',34,'S','nulla. Donec non justo. Proin non massa non ante bibendum','Act',2,2),
('Samson','Marsden','Rosalyn','6594 Rutrum Avenue','0','1','Munster','Cork','52557','Vanuatu',62,'S','et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien,','Act',4,3),
('Ali','Vance','Blake','8146 Sed St.','0','1','O','Alingsås','729510','Australia',16,'S','eget massa. Suspendisse eleifend. Cras sed leo. Cras vehicula aliquet','Act',4,5),
('Amir','Maile','Aaron','5442993 Nulla Rd.','0','1','Madhya Pradesh','Jabalpur','388556','French Southern Territories',19,'S','faucibus leo, in lobortis tellus justo sit amet nulla. Donec','Act',3,4),
('Bethany','Tiger','Camilla','P.O. Box 725, 2777 Nec Road','0','1','Cartago','Paraíso','844372','French Guiana',58,'S','Mauris vel turpis. Aliquam adipiscing lobortis risus. In mi pede,','Act',8,7),
('Brady','Vera','Shelly','3788 Parturient Av.','0','1','AK','Fairbanks','05629','Zimbabwe',10,'S','Quisque varius. Nam porttitor scelerisque neque. Nullam nisl. Maecenas malesuada','Act',3,8),
('Nichole','Tiger','Rajah','Ap #2243049 Ad St.','0','1','Ayd?n','Nazilli','59451','Belgium',46,'S','nunc nulla vulputate dui, nec tempus mauris erat eget ipsum.','Act',7,9);
GO
INSERT INTO Tecnicos([Nombre],[ApellidoPaterno],[ApellidoMaterno],[Calle],[NumeroInterior],[NumeroExterior],[Colonia],[DelegacionMunicipio],[CodigoPostal],[Estado],[Edad],[Sexo],[Notas],[Estatus],[SucursalId],[EstudioId]) 
VALUES('Tanner','Rana','Cooper','7063045 Duis Street','0','1','Katsina','Funtua','0437','Japan',57,'S','eget, dictum placerat, augue. Sed molestie. Sed id risus quis','Act',1,3),
('Hanna','Devin','Roanna','5219 Nulla Rd.','0','1','Maranhão','Santa Inês','4262','Nauru',53,'S','elit. Aliquam auctor, velit eget laoreet posuere, enim nisl elementum','Act',8,2),
('Joseph','Brandon','Vanna','Ap #6672823 Sed Rd.','0','1','MA','Móstoles','371052','Mongolia',78,'S','Cras dictum ultricies ligula. Nullam enim. Sed nulla ante, iaculis','Act',5,1),
('Desirae','Daria','Aubrey','P.O. Box 510, 5633 Dictum. Street','0','1','Arkansas','Little Rock','72005','Western Sahara',77,'S','blandit viverra. Donec tempus, lorem fringilla ornare placerat, orci lacus','Act',6,10),
('Buffy','Nevada','Brady','8860 Dictum St.','0','1','BE','Berlin','2233','Gambia',12,'S','elit. Aliquam auctor, velit eget laoreet posuere, enim nisl elementum','Act',3,1),
('Alexandra','Teagan','Ivory','P.O. Box 169, 2028 Nibh. Rd.','0','1','Massachusetts','Worcester','8300','Isle of Man',22,'S','natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.','Act',1,1),
('Jerome','Halee','Aretha','7949 Eget, Avenue','0','1','NSW','Orange','41903','Qatar',12,'S','adipiscing, enim mi tempor lorem, eget mollis lectus pede et','Act',3,9),
('Reese','Rahim','Laith','P.O. Box 859, 1232 Ut Rd.','0','1','AB','Upplands Väsby','7722','Falkland Islands',80,'S','Donec dignissim magna a tortor. Nunc commodo auctor velit. Aliquam','Act',9,7),
('Michelle','Graiden','Lars','Ap #1561871 Integer Rd.','0','1','SI','Queenstown','159562','Azerbaijan',27,'S','rutrum. Fusce dolor quam, elementum at, egestas a, scelerisque sed,','Act',2,4),
('Quon','Riley','Quentin','7603 Cursus St.','0','1','Idaho','Boise','6151','Holy See (Vatican City State)',80,'S','Integer tincidunt aliquam arcu. Aliquam ultrices iaculis odio. Nam interdum','Act',8,7);
GO
INSERT INTO Tecnicos([Nombre],[ApellidoPaterno],[ApellidoMaterno],[Calle],[NumeroInterior],[NumeroExterior],[Colonia],[DelegacionMunicipio],[CodigoPostal],[Estado],[Edad],[Sexo],[Notas],[Estatus],[SucursalId],[EstudioId]) 
VALUES('Hilel','Shad','Isabelle','3484621 Sapien. Street','0','1','San José','Concepción','43187','India',71,'S','habitant morbi tristique senectus et netus et malesuada fames ac','Act',6,7),
('Cole','Marvin','Neil','Ap #4314098 Pharetra St.','0','1','New South Wales','Dubbo','37323','Cambodia',22,'S','molestie orci tincidunt adipiscing. Mauris molestie pharetra nibh. Aliquam ornare,','Act',9,1),
('Athena','Prescott','Amethyst','P.O. Box 820, 2019 Suspendisse St.','0','1','WestVlaanderen','Assebroek','00503','Saint Kitts and Nevis',54,'S','adipiscing, enim mi tempor lorem, eget mollis lectus pede et','Act',5,8),
('Cooper','Giselle','Zane','3411 Gravida. Avenue','0','1','New South Wales','Penrith','7737','Nigeria',46,'S','enim commodo hendrerit. Donec porttitor tellus non magna. Nam ligula','Act',1,7),
('Miranda','Scarlet','Hillary','9505 Eu Av.','0','1','Samsun','Vezirköprü','50000','Azerbaijan',56,'S','scelerisque neque sed sem egestas blandit. Nam nulla magna, malesuada','Act',6,1),
('Reed','Joy','Bo','5385 Amet, Street','0','1','Luxemburg','Montleban','9017','United Kingdom (Great Britain)',68,'S','orci. Ut sagittis lobortis mauris. Suspendisse aliquet molestie tellus. Aenean','Act',1,5),
('MacKensie','Lev','Amela','2985 Libero Av.','0','1','AP','Guntur','073522','Nepal',80,'S','ridiculus mus. Aenean eget magna. Suspendisse tristique neque venenatis lacus.','Act',2,3),
('Stacey','Vernon','Chiquita','3238859 Consectetuer Rd.','0','1','AK','Uyo','7733','Cook Islands',28,'S','ligula. Nullam feugiat placerat velit. Quisque varius. Nam porttitor scelerisque','Act',9,5),
('Geraldine','Alfonso','Brenda','Ap #2644101 Nec St.','0','1','C','Turrialba','09568','Korea, South',73,'S','pede, ultrices a, auctor non, feugiat nec, diam. Duis mi','Act',4,1),
('Montana','Damian','Isabelle','P.O. Box 253, 9213 Elementum Road','0','1','Comunitat Valenciana','Valéncia','32509','Sao Tome and Principe',59,'S','dolor sit amet, consectetuer adipiscing elit. Etiam laoreet, libero et','Act',7,1);
GO
INSERT INTO Tecnicos([Nombre],[ApellidoPaterno],[ApellidoMaterno],[Calle],[NumeroInterior],[NumeroExterior],[Colonia],[DelegacionMunicipio],[CodigoPostal],[Estado],[Edad],[Sexo],[Notas],[Estatus],[SucursalId],[EstudioId]) 
VALUES('Benjamin','Clio','Hyatt','3035231 Sit Ave','0','1','Vienna','Vienna','98997','Korea, North',62,'S','in, dolor. Fusce feugiat. Lorem ipsum dolor sit amet, consectetuer','Act',4,9),
('Destiny','Francis','TaShya','Ap #4041671 Penatibus Rd.','0','1','Bremen','Bremen','5227','Senegal',35,'S','interdum. Curabitur dictum. Phasellus in felis. Nulla tempor augue ac','Act',9,5),
('Drake','Kadeem','Aileen','Ap #2943504 Malesuada St.','0','1','UP','Maunath Bhanjan','55555','Sint Maarten',75,'S','lacus. Quisque imperdiet, erat nonummy ultricies ornare, elit elit fermentum','Act',4,5),
('Leroy','Benjamin','Raja','P.O. Box 131, 797 Dignissim Avenue','0','1','Pembrokeshire','Fishguard','65930','Bahamas',54,'S','lorem, vehicula et, rutrum eu, ultrices sit amet, risus. Donec','Act',1,5),
('Tallulah','Knox','Chase','Ap #8024214 Sodales Street','0','1','Kansas','Overland Park','8100','Iraq',80,'S','mus. Proin vel nisl. Quisque fringilla euismod enim. Etiam gravida','Act',8,1),
('Guy','Neville','Jaden','Ap #919482 Augue Road','0','1','TX','Fort Worth','38415','Oman',47,'S','id, blandit at, nisi. Cum sociis natoque penatibus et magnis','Act',2,1),
('Brooke','Logan','Karyn','7112 Lorem St.','0','1','Metropolitana de Santiago','Isla de Maipo','1965','Turkey',17,'S','sed pede nec ante blandit viverra. Donec tempus, lorem fringilla','Act',8,8),
('Sydney','Luke','Cheryl','2732 Non, Av.','0','1','RJ','São João de Meriti','44444','Cayman Islands',72,'S','nulla ante, iaculis nec, eleifend non, dapibus rutrum, justo. Praesent','Act',9,5),
('Cole','Barclay','Cameron','P.O. Box 287, 8067 Enim. Avenue','0','1','Los Ríos','Río Bueno','7441','Andorra',64,'S','sed dictum eleifend, nunc risus varius orci, in consequat enim','Act',5,8),
('Alec','Ruth','Moana','2532 Nulla St.','0','1','Stockholms län','Boo','56490','Libya',29,'S','gravida mauris ut mi. Duis risus odio, auctor vitae, aliquet','Act',5,4);
GO
INSERT INTO Tecnicos([Nombre],[ApellidoPaterno],[ApellidoMaterno],[Calle],[NumeroInterior],[NumeroExterior],[Colonia],[DelegacionMunicipio],[CodigoPostal],[Estado],[Edad],[Sexo],[Notas],[Estatus],[SucursalId],[EstudioId]) 
VALUES('Ruby','Fritz','Price','6383 Ipsum St.','0','1','Vienna','Vienna','84918952','Peru',49,'S','ornare egestas ligula. Nullam feugiat placerat velit. Quisque varius. Nam','Act',6,9),
('Scarlett','Lev','Courtney','9540 Risus. Ave','0','1','Ontario','St. Catharines','1993','Guatemala',52,'S','Quisque imperdiet, erat nonummy ultricies ornare, elit elit fermentum risus,','Act',7,10),
('Oprah','Althea','Latifah','Ap #3853603 Vitae Rd.','0','1','MA','Santa Inês','65198727','Tonga',53,'S','nascetur ridiculus mus. Proin vel arcu eu odio tristique pharetra.','Act',2,7),
('Aretha','Haviva','Carol','5162 Non Av.','0','1','NI','Porirua','2691','Cayman Islands',73,'S','mi enim, condimentum eget, volutpat ornare, facilisis eget, ipsum. Donec','Act',2,5),
('Denise','Maile','Lionel','Ap #543476 Aliquet Street','0','1','AB','Stockholm','41207','Saint Helena, Ascension and Tristan da Cunha',79,'S','aliquet lobortis, nisi nibh lacinia orci, consectetuer euismod est arcu','Act',8,5),
('Lois','Flavia','Shaeleigh','Ap #114252 Pede, St.','0','1','CAM','Frigento','7152','Wallis and Futuna',76,'S','eu arcu. Morbi sit amet massa. Quisque porttitor eros nec','Act',5,9),
('Mallory','Isaiah','Mikayla','349237 Leo, Street','0','1','North Island','North Shore','0315EO','Luxembourg',57,'S','a nunc. In at pede. Cras vulputate velit eu sem.','Act',1,6),
('Jocelyn','Kristen','Stewart','673845 Non, Ave','0','1','Quebec','SaintPierre','57736','Tanzania',53,'S','dictum. Phasellus in felis. Nulla tempor augue ac ipsum. Phasellus','Act',2,7),
('Emerald','Armando','Kai','7057 Eros. Ave','0','1','KT','Katsina','20010','French Southern Territories',51,'S','augue ac ipsum. Phasellus vitae mauris sit amet lorem semper','Act',8,5),
('Jonah','Kieran','Colleen','631316 Libero Rd.','0','1','New South Wales','Cessnock','60628','Malta',58,'S','Sed auctor odio a purus. Duis elementum, dui quis accumsan','Act',8,7);
GO