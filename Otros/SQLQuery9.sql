INSERT INTO Clientes([Nombre],[ApellidoPaterno],[ApellidoMaterno],[Calle],[NumeroInterior],[NumeroExterior],[Colonia],[DelegacionMunicipio],[CodigoPostal],[Sexo],[Peso],[Edad],[Estatus]) 
VALUES('Kevin','Solomon','Jarvis','P.O. Box 797, 1989 Ipsum Rd.','16177','86883','Rivers','Bahrain',3,'S',74,14,'Act'),
('Myles','Gillespie','Gray','706-6377 Ipsum Ave','10846','693776','PR','Pitcairn Islands',6,'S',99,34,'Act'),
('Daryl','Sexton','Dejesus','8717 Dictum Ave','538135','R5S 5X6','Sl?skie','United Arab Emirates',2,'S',73,25,'Act'),
('Samantha','Paul','Dudley','940-3836 Ridiculus Rd.','288674','9869','Hawaii','Turks and Caicos Islands',7,'S',80,44,'Act'),
('Theodore','Knapp','Hooper','976-1468 Nullam Road','G4M 7J4','53708-095','Quebec','Estonia',1,'S',59,41,'Act'),
('Mona','Oconnor','Barnett','941-8579 Convallis Street','612983','9727','Prince Edward Island','Benin',1,'S',65,45,'Act'),
('Chloe','Castaneda','Fitzpatrick','306-673 Nec Avenue','8654','04384','Ontario','Algeria',5,'S',61,35,'Act'),
('Tara','Gentry','Ramos','486 Sit Road','V7X 8S4','69538','KP','Peru',10,'S',79,48,'Act'),
('Kirby','Casey','Bennett','149-8044 Mauris Rd.','5326','47316','Berlin','Cuba',10,'S',70,10,'Act'),
('Jaden','Walls','Roth','P.O. Box 443, 7642 Eu, Road','7357','L02 1BZ','PK','Brazil',2,'S',88,11,'Act'),
('Maxine','Stephens','Bell','418-6272 Placerat. Rd.','99769','277750','Quebec','Nicaragua',9,'S',60,30,'Act'),
('Slade','Santiago','Carey','2683 Venenatis Rd.','199774','379613','Illes Balears','Cocos (Keeling) Islands',7,'S',72,49,'Act'),
('Todd','Charles','Christian','P.O. Box 744, 4015 Massa. Avenue','41010','573651','Ohio','Barbados',10,'S',81,50,'Act'),
('Curran','Logan','Mathews','4504 Tristique Avenue','29641','50430','Ov','Gabon',1,'S',74,41,'Act'),
('Madaline','Graham','Bell','1974 Mollis. Avenue','02-191','05076','CM','Thailand',5,'S',70,42,'Act'),
('Kenyon','Hendricks','Gonzales','P.O. Box 936, 5879 Nisi St.','13152-467','681586','São Paulo','Canada',8,'S',77,42,'Act'),
('Whitney','Pena','Estes','2153 Mauris Av.','11277','10213','NO','Kyrgyzstan',7,'S',67,47,'Act'),
('Darrel','Maynard','Le','345 Neque Avenue','C7X 1E7','321328','CV','Fiji',10,'S',54,26,'Act'),
('Calista','Parrish','Buchanan','P.O. Box 357, 4459 Cras St.','67522','OY3Z 9BO','ST','Saudi Arabia',5,'S',87,42,'Act'),
('Beau','Cohen','Cervantes','P.O. Box 387, 4272 Metus. Ave','32469','68-158','Vienna','Morocco',3,'S',61,23,'Act');
GO

INSERT INTO Estudios([Nombre],[Descripcion],[Estatus]) VALUES('Quamar','Lorem ipsum dolor sit amet,','Act'),
('Gil','Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed','Act'),
('Aimee','Lorem ipsum dolor sit amet, consectetuer','Act'),('Lenore','Lorem ipsum dolor sit','Act'),
('Stephen','Lorem ipsum dolor sit amet, consectetuer adipiscing elit.','Act'),('Norman','Lorem','Act'),
('Jemima','Lorem ipsum dolor sit amet,','Act'),('Germaine','Lorem ipsum dolor sit amet, consectetuer','Act'),
('Lesley','Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur','Act'),
('Yetta','Lorem ipsum dolor sit amet, consectetuer','Act'),('Nell','Lorem ipsum dolor sit amet, consectetuer adipiscing','Act'),
('Chase','Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur','Act'),
('Olympia','Lorem ipsum dolor sit amet, consectetuer adipiscing elit.','Act');
GO

INSERT INTO Analisis([Nombre],[Descripcion],[Requisitos],[CategoriaId],[Estatus]) 
VALUES('Allistair','Lorem ipsum dolor sit','vel nisl. Quisque fringilla euismod', 1, 'Act'),
('Lionel','Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur','tempor lorem, eget mollis lectus', 1,'Act'),
('Declan','Lorem ipsum dolor sit','interdum feugiat. Sed nec',2,'Act'),
('Pascale','Lorem ipsum dolor sit amet,','pharetra nibh. Aliquam ornare, libero at auctor ullamcorper,',2,'Act'),
('Clark','Lorem ipsum dolor sit amet,','amet massa. Quisque porttitor eros nec tellus. Nunc',2,'Act'),
('Harriet','Lorem ipsum dolor sit','egestas a, scelerisque sed,',3,'Act'),
('Thane','Lorem ipsum','velit. Cras lorem lorem, luctus ut, pellentesque eget, dictum',4,'Act'),
('Nolan','Lorem ipsum dolor sit','Fusce fermentum fermentum arcu. Vestibulum ante ipsum primis in faucibus',5,'Act'),
('Regan','Lorem ipsum','elit. Etiam laoreet, libero et',5,'Act')
,('Tyrone','Lorem','ipsum leo',6,'Act');
GO

INSERT INTO Sucursales([Nombre],[Calle],[NumeroInterior],[NumeroExterior],[Colonia],[DelegacionMunicipio],[CodigoPostal],[Telefono],[Horario],[Estatus],[ZonaId]) 
VALUES('Eu Associates','Ap #506-780 Euismod St.','54595255899','613838-9603','Bedfordshire','Oman','66-608','16030426-8485','PDT','Act',1),
('Adipiscing Incorporated','705-412 Nec Rd.','77755308599','945602-3929','MI','Albania','10708','16730923-5773','PDT','Act',1),
('Sem Consequat Nec Associates','P.O. Box 417, 9321 Ipsum. Rd.','92609027799','054869-3563','CAL','French Southern Territories','7149','16121004-7773','PDT','Act',1),
('Vel Vulputate Incorporated','553-6793 Et, Avenue','42995624599','418528-7895','Corse','Cyprus','34397-975','16160817-7901','PDT','Act',2),
('Nec Leo Morbi LLC','337-5056 Sem, St.','10452230299','297710-1845','RM','Mayotte','7678','16340804-2434','PDT','Act',2),
('Id Enim Curabitur Limited','P.O. Box 879, 4449 Dapibus Ave','70589417999','297985-0332','Pays de la Loire','Madagascar','R3S 5Z4','16170325-9307','PDT','Act',2),
('Proin Mi Aliquam LLC','2776 Ipsum Av.','97469762299','186628-7756','Wie','Georgia','B7F 5TB','16440505-1030','PDT','Act',2),
('Fusce Fermentum Fermentum Ltd','165-7604 Non, Street','14448720599','686626-6262','Ulster','Israel','08-353','16781021-8342','PST','Act',3),
('Nullam Ut Consulting','370-2223 Eros. St.','67407475399','365684-4598','Odisha','Cook Islands','394633','16950708-2783','PDT','Act',3),
('Commodo Industries','P.O. Box 842, 4525 Erat. St.','83888213499','025717-1934','Rajasthan','Tajikistan','04581-813','16071204-6531','PDT','Act',3);
go

INSERT INTO [dbo].[AnalisisSucursal] ([SucursalId],[AnalisisId],[Costo],[Estatus])
VALUES(1,1,10,'Act'),(1,2,10,'Act'),(1,3,10,'Act'),(1,4,10,'Act'),(2,1,10,'Act'),(2,2,10,'Act'),(2,3,10,'Act'),
(2,4,10,'Act'),(3,1,10,'Act'),(3,2,10,'Act'),(3,3,10,'Act'),(3,4,10,'Act'),(4,5,10,'Act'),(4,6,10,'Act'),
(4,1,10,'Act'),(4,2,10,'Act'),(5,1,10,'Act'),(5,2,10,'Act'),(5,3,10,'Act');
GO

INSERT INTO Usuarios([Usuario],[Nombre],[ApellidoPaterno],[ApellidoMaterno],[Calle],[NumeroInterior],[NumeroExterior],[Colonia],[DelegacionMunicipio],[CodigoPostal],[Estado],[Edad],[Sexo],[Notas],[SucursalId],[Estatus]) 
VALUES('Ignacia','Maryam','Gray','Mooney','559-7090 Arcu. Avenue','29491','51411','ON','Gabon',1,'FC',25,'S','convallis est, vitae sodales nisi magna sed dui. Fusce aliquam,',1,'Act'),
('Walter','Kathleen','Rose','Contreras','575-8016 Arcu Av.','69975','114344','Vienna','Kuwait',9,'LO',31,'S','feugiat placerat velit. Quisque varius. Nam porttitor scelerisque neque. Nullam',1,'Act'),
('Sasha','Jasmine','Banks','Roach','Ap #774-8312 Et Ave','468304','29381','Västra Götalands län','Western Sahara',9,'MO',13,'S','odio tristique pharetra. Quisque ac libero nec ligula consectetuer rhoncus.',1,'Act'),
('Yen','Edan','Blankenship','Boone','956-4650 Sapien, Street','12688','10265-429','VII','United States',5,'NI',19,'S','Nulla aliquet. Proin velit. Sed malesuada augue ut lacus. Nulla',1,'Act'),
('Drew','Hunter','Mcfarland','Graham','P.O. Box 648, 1729 Etiam Road','7702MM','63720','Uttar Pradesh','Spain',1,'ON',39,'S','amet metus. Aliquam erat volutpat. Nulla facilisis. Suspendisse commodo tincidunt',1,'Act'),
('Latifah','Xyla','Ortiz','Gilbert','Ap #688-1496 Nunc St.','8118','819125','Waals-Brabant','Norway',7,'Stm',15,'S','ullamcorper magna. Sed eu eros. Nam consequat dolor vitae dolor.',2,'Act'),
('Barry','Linus','Shields','Bryan','9368 Aliquam Avenue','47299','6139QI','New South Wales','Vanuatu',8,'Bihar',31,'S','eget laoreet posuere, enim nisl elementum purus, accumsan interdum libero',2,'Act'),
('Camille','Rahim','Duran','Horn','Ap #262-9979 Quis, Ave','07282','20016','Brandenburg','Georgia',8,'Bretagne',11,'S','nec ante blandit viverra. Donec tempus, lorem fringilla ornare placerat,',2,'Act'),
('Kato','Kylynn','Hebert','Yates','Ap #870-7431 Sagittis. Street','4050','70-322','MN','Peru',8,'Provence-Alpes-Côte d''Azur',22,'S','in consectetuer ipsum nunc id enim. Curabitur massa. Vestibulum accumsan',2,'Act'),
('Adam','Linda','Morris','Miranda','2112 Varius. Ave','53714-015','1710','A','Ireland',4,'Western Australia',12,'S','magna sed dui. Fusce aliquam, enim nec tempus scelerisque, lorem',2,'Act'),
('Portia','Joel','Lindsey','Wolf','677-3814 Ullamcorper Rd.','29286','31674','Ulster','Iceland',6,'AQ',30,'S','dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus.',3,'Act'),
('Rebekah','Christen','Burton','Knight','6540 Gravida Street','81630','81155','IX','Guam',4,'SP',29,'S','enim. Sed nulla ante, iaculis nec, eleifend non, dapibus rutrum,',3,'Act'),
('Eve','Justine','Hardin','Maddox','206-3632 Mi Av.','20326','746889','Ist','Greenland',9,'IV',50,'S','Integer vulputate, risus a ultricies adipiscing, enim mi tempor lorem,',3,'Act'),
('Ifeoma','Blossom','Acosta','Wiggins','5222 Sit St.','14025','5585CW','RM','Estonia',5,'QC',13,'S','venenatis vel, faucibus id, libero. Donec consectetuer mauris id sapien.',3,'Act'),
('Uriah','Nicholas','Hall','Richardson','P.O. Box 570, 4157 Nascetur St.','91659','30-137','Noord Holland','Saint Pierre and Miquelon',10,'Idaho',24,'S','purus mauris a nunc. In at pede. Cras vulputate velit',3,'Act'),
('Yardley','Bruno','Nash','Luna','6655 Integer Rd.','4084NS','H5X 0X5','SJ','Serbia',3,'Abruzzo',35,'S','orci luctus et ultrices posuere cubilia Curae; Donec tincidunt. Donec',4,'Act'),
('Hasad','Dana','Odom','Bailey','7308 Aliquet St.','51298','26513','San José','Andorra',2,'Metropolitana de Santiago',33,'S','eget metus eu erat semper rutrum. Fusce dolor quam, elementum',4,'Act');
GO

/*INSERT INTO UsuariosSucursal([UsuarioId], [SucursalId], [Estatus])
VALUES(2,1,'Act'),(3,1,'Act'),(4,1,'Act'),(5,2,'Act'),(6,2,'Act'),(7,2,'Act'),(8,2,'Act'),
(9,3,'Act'),(10,3,'Act'),(11,3,'Act'),(12,3,'Act'),(13,4,'Act');*/

INSERT INTO Tecnicos([Nombre],[ApellidoPaterno],[ApellidoMaterno],[Calle],[NumeroInterior],[NumeroExterior],[Colonia],[DelegacionMunicipio],[CodigoPostal],[Estado],[Edad],[Sexo],[Notas],[Estatus],[SucursalId],[EstudioId]) 
VALUES('Justine','Davis','Duffy','P.O. Box 378, 2795 Interdum Ave','L2H 4B1','BD0 3CW','?an','Malawi',5,'Kano',50,'S','ut erat. Sed nunc est, mollis non, cursus non, egestas','Act',1,1),
('Nicole','Contreras','Workman','9250 Pellentesque. Av.','3693','8517','Odisha','Saint Helena, Ascension and Tristan da Cunha',5,'Catalunya',10,'S','elit, a feugiat tellus lorem eu metus. In lorem. Donec','Act',1,2),
('Valentine','Landry','Garrison','248-9940 Et Ave','59-453','7661','WB','Comoros',1,'Vienna',17,'S','faucibus orci luctus et ultrices posuere cubilia Curae; Donec tincidunt.','Act',1,3),
('Otto','Mccullough','Ferrell','5782 Amet, Street','U1 0GS','78062','Ulster','Egypt',8,'Istanbul',40,'S','enim diam vel arcu. Curabitur ut odio vel est tempor','Act',1,4),
('Clayton','Rios','Armstrong','Ap #991-8777 Posuere Street','25724','80184-124','Östergötlands län','United Kingdom (Great Britain)',8,'Andalucía',10,'S','Phasellus dolor elit, pellentesque a, facilisis non, bibendum sed, est.','Act',1,5),
('Vera','Gonzalez','Sykes','Ap #578-3655 Eu Street','11976','76161','PM','Guernsey',8,'Brussels Hoofdstedelijk Gewest',34,'S','risus a ultricies adipiscing, enim mi tempor lorem, eget mollis','Act',2,1),
('Venus','Underwood','Murphy','Ap #179-8598 Metus. St.','K2S 2V6','T56 8ON','Gelderland','Saudi Arabia',5,'Oyo',43,'S','malesuada vel, convallis in, cursus et, eros. Proin ultrices. Duis','Act',2,2),
('Keaton','Chaney','Rich','550-3061 Urna, St.','32364','763604','WA','Equatorial Guinea',9,'Sardegna',14,'S','augue id ante dictum cursus. Nunc mauris elit, dictum eu,','Act',2,3),
('Shafira','Mcdonald','Rivas','1742 Interdum. Road','36686-643','60100','North Island','Swaziland',9,'Quebec',33,'S','ut erat. Sed nunc est, mollis non, cursus non, egestas','Act',2,4),
('Mercedes','Rush','Munoz','Ap #245-7421 Enim, Rd.','995102','600195','Berlin','India',5,'HA',24,'S','Ut semper pretium neque. Morbi quis urna. Nunc quis arcu','Act',2,5),
('Dexter','Becker','Olson','242-340 Laoreet St.','8373','21214','Ontario','Qatar',5,'SAR',36,'S','arcu. Vestibulum ante ipsum primis in faucibus orci luctus et','Act',3,1),
('Kai','Day','Strickland','6782 Orci Ave','708773','2933','Vienna','Macao',9,'Gl',10,'S','magna. Nam ligula elit, pretium et, rutrum non, hendrerit id,','Act',3,2),
('Guy','Bartlett','Herrera','875-1940 Diam St.','4325','77583','Western Australia','Turkey',9,'NÖ.',13,'S','interdum ligula eu enim. Etiam imperdiet dictum magna. Ut tincidunt','Act',3,3),
('Destiny','Mcmahon','Page','2291 Massa Av.','G9M 2CV','3809','MB','Cocos (Keeling) Islands',8,'ON',48,'S','tellus justo sit amet nulla. Donec non justo. Proin non','Act',3,4),
('Buckminster','Coffey','Mcknight','Ap #491-9435 Ac Street','M7X 2X1','258146','North Island','Heard Island and Mcdonald Islands',4,'Hat',40,'S','enim. Etiam gravida molestie arcu. Sed eu nibh vulputate mauris','Act',3,5),
('Hilary','Mathews','Chavez','Ap #952-7759 Ridiculus Av.','05330','493287','Adana','Gibraltar',4,'Van',21,'S','est arcu ac orci. Ut semper pretium neque. Morbi quis','Act',4,1),
('Darrel','Casey','Cameron','P.O. Box 235, 4436 Interdum. Rd.','76-381','573958','H','Indonesia',9,'Jönköpings län',14,'S','aliquet. Phasellus fermentum convallis ligula. Donec luctus aliquet odio. Etiam','Act',4,1),
('Chiquita','Glenn','Fowler','Ap #104-7350 Metus St.','44-287','21470','Dalarnas län','Puerto Rico',2,'E',42,'S','lectus rutrum urna, nec luctus felis purus ac tellus. Suspendisse','Act',4,2),
('Burke','Chase','Mills','Ap #762-3011 A, Street','62333-691','Y6X 3A9','West Bengal','Tajikistan',3,'QC',49,'S','magna sed dui. Fusce aliquam, enim nec tempus scelerisque, lorem','Act',4,2),
('Dominique','Watson','Wood','557-9132 Fusce Ave','29038','511683','LU','Uganda',4,'CH',39,'S','Sed malesuada augue ut lacus. Nulla tincidunt, neque vitae semper','Act',4,3);
GO

/*INSERT INTO TecnicoAnalisis(TecnicoId, AnalisisSucursalId, Estatus)
VALUES(1,1,'Act'),(1,2,'Act'),(2,2,'Act'),(2,3,'Act'),(3,3,'Act'),(3,4,'Act'),(4,5,'Act'),
(4,6,'Act'),(5,6,'Act'),(5,7,'Act'),(6,7,'Act'),(6,8,'Act'),(7,8,'Act'),(7,9,'Act'),(8,9,'Act'),
(8,10,'Act'),(9,10,'Act'),(9,11,'Act'),(10,11,'Act'),(10,12,'Act');*/




SELECT * FROM Estudios
SELECT * FROM Analisis
SELECT * FROM AnalisisSucursal
SELECT * FROM Sucursales
SELECT * FROM Usuarios
SELECT * FROM Tecnicos
SELECT * FROM Clientes
SELECT * FROM Citas
SELECT * FROM Historicos



