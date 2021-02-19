/* 
-
-
-

Un procedimiento almacenado puede incluir cualquier cantidad y tipo de instrucciones DML (de manipulación de datos, como insert, update, delete), 
no instrucciones DDL (de definición de datos, como create..., drop... alter...).

-
-
-
*/


select * from libros22;

/*--------------PROCEDIMIENTO AUMENTA EN UN 10% EL VALOR DE LOS LIBROS---------------*/
CREATE OR REPLACE PROCEDURE incre_10porc_val_libros
AS
BEGIN 
UPDATE libros22 set precio = precio+(precio*0.1);
end;
/

/*PARA ELIMINAR UN PROCEDIMIENTO*/
drop procedure incre_10porc_val_libros;

execute incre_10porc_val_libros; /* tambien se puede usar la abreviación de exec*/



/*------------PROCEDIMIENTO ALMACENADO QUE AUMENTE LOS SUELDOS INFERIORES AL PROMEDIO EN UN 20% DE LA TABLA EMPLEADOS----------------*/
select * from empleados order by sueldo asc;
select avg(sueldo) from empleados;
select * from empleados where sueldo < (select avg(sueldo) from empleados);


create or replace procedure pa_aumentarsueldo
as
begin
update empleados set sueldo = sueldo + (sueldo*0.2) where sueldo < (select avg(sueldo) from empleados);
end;
/
exec pa_aumentarsueldo;


/*Cree (o reemplace) un procedimiento almacenado que ingrese en la tabla "empleados_antiguos" el documento, nombre y apellido (concatenados) 
de todos los empleados de la tabla "empleados" que ingresaron a la empresa hace más de 10 años*/

 DROP TABLE empleados_antiguos;
 create table empleados_antiguos(
  documento11 char(8),
  nombre varchar2(40)
);

select * from empleados;
select * from empleados_antiguos;
select nombre || ' ' || apellido from empleados where (extract(year from current_date) - extract(year from fechaingreso)) > 10;

create or replace procedure llenar_empl_antiguos
as
begin
insert into empleados_antiguos select documento, nombre || ' ' || apellido from empleados where (extract(year from current_date) - extract(year from fechaingreso)) > 10;
end;
/

exec llenar_empl_antiguos;



/*-------------------PROCEDIMIENTOS ALMACENADOS CON PARÁMETROS DE ENTRADA Y/O VALOR POR DEFECTO------------------------------------*/
SELECT * FROM LIBROS22

CREATE OR REPLACE procedure pa_libros_aumentar10(a_editorial in varchar2)
as
begin
update libros22 set precio =precio+(precio*0.1) where editorial = a_editorial;
end;
/
exec pa_libros_aumentar10('Emece')
SELECT * FROM LIBROS22

----------------con valores por defecto-----------------------------
drop procedure pa_libros_aumentar
 create or replace procedure pa_libros_aumentar(aeditorial in varchar2,aporcentaje in number default 10)
 as
 begin
  update libros22 set precio=precio+(precio*aporcentaje/100)
  where editorial=aeditorial;
 end;
 /
 
exec pa_libros_aumentar('Planeta');
SELECT * FROM LIBROS22
exec pa_libros_aumentar('Emece', 50);


/* En caso que un procedimiento tenga definidos varios parámetros con valores por defecto y al invocarlo colocamos uno solo, Oracle asume que es el primero de ellos. 
si son de tipos de datos diferentes, Oracle los convierte. En caso de meter solo 2 valores, estos se ingresan en titulo y autor independiente de si son consistentes o no*/

drop pa_libros_insertar

 create or replace procedure pa_libros_insertar
  (atitulo in varchar2 default null, aautor in varchar2 default 'desconocido',
   aeditorial in varchar2 default 'sin especificar', aprecio in number default 0, acantidad in number default 0)
 as
 begin
  insert into libros22 values (atitulo,aautor,aeditorial,aprecio,acantidad);
 end;
 /
 
 exec pa_libros_insertar
 
 
 /* procedimiento con variable que recibe un  libro y rescato el autor de ese libro */
 SELECT * FROM LIBROS22

drop table tabla1;
create table tabla1(
    titulo1 varchar2(40),
    precio number(6,2)
);
 
 drop procedure pa_autorlibro;
create or replace procedure pa_autorlibro(atitulo in varchar2)
as 
    vautor varchar(20);
begin
    select autor into vautor from libros22 where titulo = atitulo; --se guarda en vautor el autor del libro ingresado por parametro
    insert into tabla1
        select titulo, precio from libros22 where autor = vautor;
end;
/

exec pa_autorlibro('Uno');
exec pa_autorlibro('El aleph');

 SELECT * FROM tabla1;





