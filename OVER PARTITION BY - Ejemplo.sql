DROP TABLE ordenes;

CREATE TABLE ordenes (
  id number(4),
  order_date varchar2(255),
  customer_name varchar2(255) default NULL,
  customercity varchar2(255),
  orderamount varchar2(50) default NULL,
  PRIMARY KEY (id)
);

INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (1,'08/21/2021','Driscoll Gibson','Kanpur Cantonment',1879);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (2,'01/19/2021','Bruno Spence','Silifke',1969);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (3,'02/13/2021','Travis Kirk','Traiguén',1690);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (4,'10/03/2021','Oscar Madden','Lacombe County',1618);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (5,'10/12/2021','Wyatt Holder','Carunchio',1407);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (6,'09/07/2021','Declan Robles','Vanderhoof',450);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (7,'05/16/2020','Aristotle Richmond','Monte Santa Maria Tiberina',1355);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (8,'08/19/2020','Bernard Navarro','Ogbomosho',1756);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (9,'02/04/2021','Keane Fletcher','Shawinigan',669);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (10,'05/03/2021','Wade Copeland','Mechelen-aan-de-Maas',708);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (11,'03/29/2020','Kamal Mercer','Châlons-en-Champagne',134);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (12,'07/05/2020','Aquila Morrison','Invergordon',705);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (13,'11/01/2020','Zachery Nguyen','Dalcahue',30);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (14,'05/08/2021','Francis Morin','Chicago',1908);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (15,'11/25/2020','Eaton Henson','Langenburg',115);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (16,'07/08/2021','Tyler Durham','Limbach-Oberfrohna',673);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (17,'09/09/2021','Damian Hampton','Hastings',1495);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (18,'09/04/2021','Cairo Merrill','Warminster',634);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (19,'12/20/2021','Ryder Stout','Grand Island',1660);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (20,'07/08/2020','Rudyard Pitts','Orroli',236);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (21,'12/31/2020','Jared Young','Calice al Cornoviglio',1528);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (22,'06/25/2020','Henry Morris','Melilla',1441);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (23,'10/04/2021','Jack Daniels','Rimbey',23);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (24,'02/08/2022','Josiah Burks','Chicoutimi',1891);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (25,'06/24/2021','Arsenio Nielsen','Metro',1184);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (26,'05/21/2020','Theodore Valdez','Zandhoven',435);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (27,'04/13/2021','Basil Salinas','Noisy-le-Grand',1462);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (28,'12/01/2021','Kelly Rodgers','Terragnolo',1369);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (29,'08/11/2020','Elijah Holland','Wetaskiwin',107);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (30,'03/31/2021','Russell Clements','Nagpur',1923);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (31,'12/11/2020','Ulric Griffin','Banff',1391);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (32,'05/15/2020','Abdul Burgess','Wayaux',1044);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (33,'09/29/2021','Quinlan Wolf','Breton',1999);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (34,'10/22/2020','Mason Chambers','Chile Chico',1502);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (35,'08/29/2020','Plato Howell','Iowa City',430);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (36,'02/19/2021','Valentine Key','Braunschweig',877);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (37,'11/13/2020','Bruno Garner','Jemeppe-sur-Sambre',436);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (38,'09/22/2020','Lucius Morin','Roxboro',140);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (39,'03/06/2020','Brody Frazier','Inveraray',899);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (40,'05/03/2020','Barry Jefferson','Raurkela Civil Township',762);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (41,'01/18/2022','Hakeem Acevedo','Montpellier',1531);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (42,'03/19/2021','Howard Hill','Zandhoven',1151);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (43,'09/28/2020','Scott Atkinson','Winterswijk',743);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (44,'03/21/2021','Brandon Lowe','Chaudfontaine',192);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (45,'09/09/2021','Levi Ferrell','Juseret',423);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (46,'08/12/2021','Elvis Simmons','Rivi?re-du-Loup',1857);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (47,'03/25/2020','Oleg Sharpe','Hamme-Mille',331);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (48,'03/04/2020','Brandon Jensen','Milwaukee',277);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (49,'04/16/2020','Vaughan Bird','Saint-Dizier',941);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (50,'03/07/2020','Jack Saunders','Erie',1608);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (51,'09/22/2021','Amery Weiss','Torrejón de Ardoz',1109);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (52,'02/21/2022','Linus May','L''Hospitalet de Llobregat',262);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (53,'09/01/2020','Austin Torres','Merrickville-Wolford',758);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (54,'04/08/2020','Peter Horne','Leuze',875);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (55,'01/24/2021','Xavier Nash','Strathcona County',1901);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (56,'04/01/2021','Palmer Nixon','Tofield',1976);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (57,'11/14/2020','Allistair Vance','Bras',243);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (58,'03/20/2021','Peter Morrow','Avin',1132);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (59,'09/11/2021','Basil Howard','Fresno',165);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (60,'10/02/2020','Lane Salinas','Rivi?re-du-Loup',791);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (61,'02/09/2021','Rogan Mcfadden','Korkino',1370);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (62,'09/06/2021','Hyatt Baxter','Armenia',1670);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (63,'05/07/2020','Samuel Burch','Bronnitsy',212);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (64,'05/15/2021','Edan Valdez','Beaconsfield',1827);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (65,'09/28/2020','Callum Rosa','Rotterdam',472);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (66,'02/03/2021','Mason Mcfadden','Jennersdorf',227);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (67,'03/10/2022','Gavin George','Ipatinga',363);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (68,'10/26/2020','Castor Neal','Penticton',609);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (69,'08/24/2021','Leo Lindsay','Nieuwegein',1070);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (70,'06/24/2020','Herrod Robles','Grimbergen',1886);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (71,'03/21/2021','Nigel Sparks','Torchiarolo',1474);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (72,'09/17/2021','Griffin Pace','Gignod',884);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (73,'02/05/2021','Knox Brady','Itagüí',413);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (74,'07/23/2020','Abbot Blackwell','Bhatinda',214);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (75,'11/17/2021','Carlos Ryan','Hallein',1251);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (76,'04/01/2020','Jelani Sears','Meldert',1848);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (77,'03/15/2022','Dennis Mcgowan','Calco',1233);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (78,'06/25/2021','Valentine Brennan','Buken',1233);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (79,'10/18/2020','Lamar Bolton','Mogliano',1517);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (80,'04/04/2020','Kieran Rojas','Soye',622);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (81,'10/25/2021','Wallace Wilkins','Balikpapan',1735);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (82,'02/20/2021','Lucas Sexton','Blackwood',750);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (83,'05/29/2021','Benjamin Potts','Davenport',664);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (84,'01/22/2022','Randall Benson','Groß-Gerau',1189);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (85,'06/28/2021','Tyrone Ball','Khanewal',94);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (86,'09/04/2021','Fitzgerald Dotson','Erchie',1791);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (87,'09/20/2021','Samson Johnston','Sullana',620);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (88,'07/11/2021','Ronan Diaz','Tarrasa',548);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (89,'11/21/2021','Cyrus Dalton','Saintes',223);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (90,'02/15/2021','Otto Ortega','Siena',646);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (91,'06/14/2020','Griffith Boone','Sierning',1464);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (92,'12/29/2020','Kasper Parker','San Giovanni Lipioni',556);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (93,'08/08/2021','Trevor Day','Bad Dürkheim',548);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (94,'08/05/2021','Ivor Hanson','Rekem',1908);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (95,'02/19/2021','Dieter Cooke','Faridabad',1010);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (96,'03/30/2022','Alec Ferguson','Itapipoca',811);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (97,'11/21/2020','Tyler Ayers','Marentino',854);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (98,'02/07/2021','Bevis Owens','Daly',1723);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (99,'08/07/2021','Joseph Fulton','Finspång',1763);
INSERT INTO ordenes (ID,order_date,customer_name,customercity,orderamount) VALUES (100,'04/06/2021','Aristotle Berg','Khanpur',1806);

select * from ordenes;
select * from ordenes where customercity = 'Traiguén';

update ordenes set customercity = 'Phoenix' where id < 25;
update ordenes set customercity = 'New york' where id >= 25 and id<50;
update ordenes set customercity = 'Chicago' where id >= 50 and id<75;
update ordenes set customercity = 'Columbus' where id >= 75 and id<=100;


/*Supongamos que queremos encontrar los siguientes valores en la tabla Órdenes:

Valor mínimo de pedido en una ciudad
Valor máximo de pedido en una ciudad
Valor medio de pedido en una ciudad
*/

select 
  customercity
, avg(orderamount) avgorderamount
, min(orderamount) minorderamount
, sum(orderamount) totalorderamount
from ordenes
group by customercity;

/* En este momento, queremos agregar también la columna CustomerName y OrderAmount en la salida. 
Agreguemos estas columnas en la instrucción select y ejecutemos el siguiente código.

SELECT Customercity, CustomerName ,OrderAmount,
       AVG(Orderamount) AS AvgOrderAmount, 
       MIN(OrderAmount) AS MinOrderAmount, 
       SUM(Orderamount) TotalOrderAmount
FROM [dbo].[Orders]
GROUP BY Customercity;

Una vez que ya ejecutemos esta consulta, recibiremos un mensaje de error. En la cláusula SQL GROUP BY, 
podemos utilizar una columna en la instrucción select, si a su vez se utiliza en la cláusula Group by. 
No permite ninguna columna en la cláusula select que no sea parte de la cláusula GROUP BY.

Podemos utilizar la cláusula PARTITION BY de SQL para poder resolver este problema. 
*/

/* Podemos utilizar la cláusula SQL PARTITION BY con la cláusula OVER para poder especificar la 
columna en la que necesitamos efectuar la agregación. En el ejemplo anterior, utilizamos Agrupar por, 
con la columna CustomerCity y calculamos los valores promedio, mínimo y máximo.
Ahora vuelva a ejecutar este escenario con la cláusula SQL PARTITION BY utilizando la siguiente consulta.
*/


/*Por cada registro de la tabla muestra los datos indicados, muestra el promedio, el min y la suma, en 
base al total de los registros de la tabla
*/
SELECT customercity, 
       AVG(orderamount) OVER(PARTITION BY Customercity) AS AvgOrderAmount, 
       MIN(orderAmount) OVER(PARTITION BY Customercity) AS MinOrderAmount, 
       SUM(orderamount) OVER(PARTITION BY Customercity) TotalOrderAmount
FROM system.ordenes;



/*Por cada registro de la tabla, muestra la información propia de cada registro y también la información
basada en el total de registros de la tabla que se indicó, como promedio, max y suma de los registrose
existentes en la tabla
*/
SELECT customercity
, customer_name
, orderamount
, COUNT(ID) over(partition by customercity) as Countoforders
, AVG(orderamount) OVER(PARTITION BY Customercity) AS AvgOrderAmount
, MIN(orderAmount) OVER(PARTITION BY Customercity) AS MinOrderAmount
, SUM(orderamount) OVER(PARTITION BY Customercity) TotalOrderAmount
FROM system.ordenes;


select customercity, avg(orderamount), min(orderamount), sum(orderamount) from
system.ordenes where customercity ='Chicago' group by customercity;



/*-------------------PARTITION BY con ROW_NUMBER()------------------------------------*/

/* Podemos utilizar la cláusula SQL PARTITION BY con la función ROW_ NUMBER( ) para así 
poder obtener un número de fila de cada fila dentro de la partición. Ahora definimos los siguientes 
parámetros para usar ROW_NUMBER con la cláusula SQL PARTITION BY.

- PARTITION BY columna: En este ejemplo, queremos particionar datos en la columna CustomerCity
- ORDER BY columna: En la columna ORDER BY, establecemos una columna o condición que define el 
número de fila. En este ejemplo, nosotros queremos ordenar los datos en la columna OrderAmount
*/

SELECT 
  customercity
, customer_name
/*muestra el numero de la fila dentro de su partición, ordenadas según se indica*/
, row_number() over(partition by customercity order by orderamount desc) as "Row_number"
, orderamount
, COUNT(ID) over(partition by customercity) as Countoforders
, AVG(orderamount) OVER(PARTITION BY Customercity) AS AvgOrderAmount
, MIN(orderAmount) OVER(PARTITION BY Customercity) AS MinOrderAmount
, SUM(orderamount) OVER(PARTITION BY Customercity) TotalOrderAmount
from system.ordenes;



/*--------------------- PARTITION BY - TOTAL ACUMULADO-------------------------------------*/

/*En la siguiente consulta, emplearemos la cláusula ROWS especificada para poder seleccionar la 
fila actual (utilizando CURRENT ROW) y la siguiente fila (utilizando 1 FOLLOWING). Además, 
calcula la suma en esas filas utilizando sum (Orderamount) con una partición en CustomerCity 
(utilizando OVER (PARTITION BY Customercity ORDER BY OrderAmount DESC).
*/

select 
  customercity
, customer_name
, orderamount
, COUNT(ID) over(partition by customercity) as Countoforders
, AVG(orderamount) OVER(PARTITION BY Customercity) AS AvgOrderAmount
, MIN(orderAmount) OVER(PARTITION BY Customercity) AS MinOrderAmount
, SUM(orderamount) OVER(PARTITION BY Customercity) TotalOrderAmount
/*muestra el numero de la fila dentro de su partición, ordenadas según se indica*/
, row_number() over(partition by customercity order by orderamount desc) as "ROW_NUMBER"

/*Muestra el total acumulativo por particion*/
, sum(orderamount) over (partition by customercity
  order by orderamount desc rows unbounded preceding) as "suma_acumulativa_total"
, avg(orderamount) over(partition by customercity order by orderamount desc rows unbounded preceding)
  as "prom_acumulativo"
from system.ordenes;