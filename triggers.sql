/*
Un "trigger" (disparador o desencadenador) es un bloque de código que se ejecuta automáticamente cuando ocurre algún evento (como inserción, 
actualización o borrado) sobre una determinada tabla (o vista); es decir, cuando se intenta modificar los datos de una tabla (o vista) 
asociada al disparador.

Se crean para conservar la integridad referencial y la coherencia entre los datos entre distintas tablas; para registrar los cambios que 
se efectúan sobre las tablas y la identidad de quien los realizó; para realizar cualquier acción cuando una tabla es modificada; etc.

Si se intenta modificar (agregar, actualizar o eliminar) datos de una tabla asociada a un disparador, el disparador se ejecuta (se dispara) en forma automática.

La diferencia con los procedimientos almacenados del sistema es que los triggers:
- no pueden ser invocados directamente; al intentar modificar los datos de una tabla asociada a un disparador, el disparador se ejecuta automáticamente.
- no reciben y retornan parámetros.
- son apropiados para mantener la integridad de los datos, no para obtener resultados de consultas.

 create or replace trigger NOMBREDISPARADOR
 MOMENTO-- before, after o instead of
 EVENTO-- insert, update o delete
 of CAMPOS-- solo para update
 on NOMBRETABLA
 NIVEL--puede ser a nivel de sentencia (statement) o de fila (for each row)
 when CONDICION--opcional
 begin
  CUERPO DEL DISPARADOR--sentencias
 end NOMBREDISPARADOR;
 /
 
"MOMENTO" indica cuando se disparará el trigger en relación al evento, puede ser BEFORE (antes), AFTER (después) o INSTEAD OF (en lugar de). "before" 
significa que el disparador se activará antes que se ejecute la operación (insert, update o delete) sobre la tabla, que causó el disparo del mismo. 
"after" significa que el trigger se activará después que se ejecute la operación que causó el disparo. "instead of" sólo puede definirse sobre vistas, 
anula la sentencia disparadora, se ejecuta en lugar de tal sentencia (ni antes ni después).

"EVENTO" especifica la operación (acción, tipo de modificación) que causa que el trigger se dispare (se active), puede ser "insert", "update" o "delete"; 
DEBE colocarse al menos una acción, puede ser más de una, en tal caso se separan con "or". Si "update" lleva una lista de atributos, el trigger sólo se 
ejecuta si se actualiza algún atributo de la lista.

"NIVEL" puede ser a nivel de sentencia o de fila. "for each row" indica que el trigger es a nivel de fila, es decir, se activa una vez por cada registro 
afectado por la operación sobre la tabla, cuando una sola operación afecta a varios registros. Los triggers a nivel de sentencia, se activan una sola vez 
(antes o después de ejecutar la operación sobre la tabla). Si no se especifica, o se especifica "statement", es a nivel de sentencia.

Consideraciones generales:

- Las siguientes instrucciones no están permitidas en un desencadenador: create database, alter database, drop database, load database, restore database, load log, 
reconfigure, restore log, disk init, disk resize.

- Se pueden crear varios triggers para cada evento, es decir, para cada tipo de modificación (inserción, actualización o borrado) para una misma tabla. Por ejemplo, 
se puede crear un "insert trigger" para una tabla que ya tiene otro "insert trigger".
*/





/*- "user_objects": nos muestra todos los objetos de la base de datos seleccionada, incluidos los triggers. En la columna "object_type" aparece "trigger" si 
es un disparador. En el siguiente ejemplo solicitamos todos los objetos que son disparadores*/
select *from user_objects where object_type='TRIGGER';

/*"user_triggers": nos muestra todos los triggers de la base de datos actual. Muestra el nombre del desencadenador (trigger_name), si es before o after y 
si es a nivel de sentencia o por fila (trigger_type), el evento que lo desencadena (triggering_event), a qué objeto está asociado, si tabla o vista (base_object_type), 
el nombre de la tabla al que está asociado (table_name), los campos, si hay referencias, el estado, la descripción, el cuerpo (trigger_body), etc. En el siguiente 
ejemplo solicitamos información de todos los disparadores que comienzan con "TR"*/
select trigger_name, triggering_event from user_triggers where trigger_name like 'TR%';

/*"user_source": se puede visualizar el código fuente almacenado en un disparador consultando este diccionario: En el siguiente ejemplo solicitamos 
el código fuente del objeto "TR_insertar_libros" */
select * from user_source where name='TR_INSERTAR_LIBROS';






/*------------------------------------------------TRIGGER DE INSERCIÓN A NIVEL DE SENTENCIA------------------------------------------------------------------------------*/
 drop table librosxx;

 create table librosxx(
  codigo number(6),
  titulo varchar2(40),
  autor varchar2(30),
  precio number(6,2)
 );

 drop table control;
 create table control(
  usuario varchar2(30),
  fecha date
 );
 
/* Creamos un disparador que se dispare cada vez que se ingrese un registro en "libros"; el trigger debe ingresar en la tabla "control", el nombre del usuario, 
la fecha y la hora en la cual se realizó un "insert" sobre "libros" */
alter session set NLS_DATE_FORMAT = 'DD/MM/YYYY HH24:MI';
 
 create or replace trigger tr_ingresar_libros
  before insert
  on librosxx
 begin
  insert into control values(user,sysdate);
 end tr_ingresar_libros;
 /
 
 select * from user_triggers;
 
select * from librosxx;
select * from control;
insert into librosxx values(150,'Matematica estas ahi','Paenza',12);
insert into librosxx values(185,'El aleph','Borges',42);


/* 
Una librería almacena los datos de sus libros en una tabla denominada "libros" y en una tabla "ofertas", algunos datos de los libros 
cuyo precio no supera los $30. Además, controla las inserciones que los empleados realizan sobre "ofertas", almacenando en la tabla "control" 
el nombre del usuario, la fecha y hora, cada vez que se ingresa un nuevo registro en la tabla "ofertas"

*/

 drop table librosyy;
 drop table ofertasyy;
 drop table controlyy;
 
  create table librosyy(
  codigo number(6),
  titulo varchar2(40),
  autor varchar2(30),
  editorial varchar2(20),
  precio number(6,2)
 );

 create table ofertasyy(
  titulo varchar2(40),
  autor varchar2(30),
  precio number(6,2)
 );

 create table controlyy(
  usuario varchar2(30),
  fecha date
 );
 
 alter session set NLS_DATE_FORMAT = 'DD/MM/YYYY HH24:MI';

 /*
 Cree un disparador que se dispare cuando se ingrese un nuevo registro en "ofertas"; el trigger debe ingresar en la tabla "control", 
 el nombre del usuario, la fecha y la hora en la cual se realizó un "insert" sobre "ofertas"
 */
 
 create or replace trigger tr_ingresar_oferta
 before insert
 on ofertasyy
 begin
    insert into controlyy values(user, systimestamp);
 end tr_ingresar_oferta;
 /
 
  select * from user_triggers;

 insert into librosyy values(100,'Uno','Richard Bach','Planeta',25); 
 insert into librosyy values(102,'Matematica estas ahi','Paenza','Nuevo siglo',12); 
 insert into librosyy values(105,'El aleph','Borges','Emece',32); 
 insert into librosyy values(120,'Aprenda PHP','Molina Mario','Nuevo siglo',55);
 insert into librosyy values(100,'Uno','Richard Bach','Planeta',25); 
 insert into librosyy values(102,'Matematica estas ahi','Paenza','Nuevo siglo',12); 
 insert into librosyy values(105,'El aleph','Borges','Emece',32); 
 insert into librosyy values(120,'Aprenda PHP','Molina Mario','Nuevo siglo',55);

  
select * from librosyy;
select * from controlyy;
select * from ofertasyy; 
select * from librosyy where precio < 30;

insert into ofertasyy select titulo,autor,precio from librosyy where precio<30;





/*-----------------------------DISPARADOR DE INSERCION A NIVEL DE FILA (INSERT TRIGGER FOR EACH ROW)--------------------------------------------*/

/*Vimos la creación de un disparador para el evento de inserción a nivel de sentencia, es decir, se dispara una vez por cada sentencia "insert" sobre la tabla asociada.

/*
En caso que una sola sentencia "insert" ingrese varios registros en la tabla asociada, el trigger se disparará una sola vez; si queremos que se active una vez por cada registro afectado, 
debemos indicarlo con "for each row".
*/

 drop table libros_ter;
 drop table ofertas_ter;
 drop table control_ter;
 
  create table libros_ter(
  codigo number(6),
  titulo varchar2(40),
  autor varchar2(30),
  editorial varchar2(20),
  precio number(6,2)
 );

 create table ofertas_ter(
  titulo varchar2(40),
  autor varchar2(30),
  precio number(6,2)
 );

 create table control_ter(
  usuario varchar2(30),
  fecha date
 );
 
  alter session set NLS_DATE_FORMAT = 'DD/MM/YYYY HH24:MI';


/*
Creamos un disparador que se dispare una vez por cada registro ingresado en "ofertas"; el trigger debe ingresar en la tabla "control", 
el nombre del usuario, la fecha y la hora en la cual se realizó un "insert" sobre "ofertas"
*/
create or replace trigger tr_ingresar_ofertas
  before insert
  on ofertas_ter
  for each row
 begin
  insert into control_ter values(user,sysdate);
 end tr_ingresar_ofertas;
 /
 
insert into libros_ter values(100,'Uno','Richard Bach','Planeta',25);
 insert into libros_ter values(102,'Matematica estas ahi','Paenza','Nuevo siglo',12);
 insert into libros_ter values(105,'El aleph','Borges','Emece',32);
 insert into libros_ter values(120,'Aprenda PHP','Molina Mario','Nuevo siglo',55);

select * from libros_ter;
select * from control_ter;
select * from ofertas_ter; 
select * from libros_ter where precio < 30;


 insert into ofertas_ter select titulo,autor,precio from libros_ter where precio<30;
 
 
 
/*-------------------------------------------------------------TRIGGER DE BORRADO---------------------------------------------------*/


 drop table libros_tr_del;
 drop table control_tr_del;
 
  create table libros_tr_del(
  codigo number(6),
  titulo varchar2(40),
  autor varchar2(30),
  editorial varchar2(20),
  precio number(6,2)
 );

 create table control_tr_del(
  usuario varchar2(30),
  fecha date
 );
 
insert into libros_tr_del values(97,'Uno','Richard Bach','Planeta',25);
 insert into libros_tr_del values(98,'El aleph','Borges','Emece',28);
 insert into libros_tr_del values(99,'Matematica estas ahi','Paenza','Nuevo siglo',12);
 insert into libros_tr_del values(100,'Aprenda PHP','Molina Mario','Nuevo siglo',55);
 insert into libros_tr_del values(101,'Alicia en el pais de las maravillas','Carroll','Planeta',35);
 insert into libros_tr_del values(102,'El experto en laberintos','Gaskin','Planeta',20);

/*
Creamos un disparador a nivel de fila, que se dispare cada vez que se borre un registro de "libros"; el trigger debe ingresar en la 
tabla "control", el nombre del usuario, la fecha y la hora en la cual se realizó un "delete" sobre "libros"
*/

-- a nivel de filas
 create or replace trigger tr_borrar_libros
  before delete
  on libros_tr_del
  for each row
 begin
  insert into control_tr_del values(user,sysdate);
 end tr_borrar_libros;
 /
 
 -- a nivel de sentencia
  create or replace trigger tr_borrar_libros
  before delete
  on libros_tr_del
 begin
  insert into control_tr_del values(user,sysdate);
 end tr_borrar_libros;
 /
  select *from user_triggers where trigger_name ='TR_BORRAR_LIBROS';

select * from libros_tr_del;
select * from control_tr_del;
select * from libros_tr_del where codigo < 100;

delete from libros_tr_del where codigo < 100;

/* */

 drop table empleados_tr_delete;
 drop table control_tr_delete;
 
  create table empleados_tr_delete(
  documento char(8),
  apellido varchar2(20),
  nombre varchar2(20),
  seccion varchar2(30),
  sueldo number(8,2)
 );

 create table control_tr_delete(
  usuario varchar2(30),
  fecha date
 );
 
  insert into empleados_tr_delete values('22333444','ACOSTA','Ana','Secretaria',500);
 insert into empleados_tr_delete values('22777888','DOMINGUEZ','Daniel','Secretaria',560);
 insert into empleados_tr_delete values('22999000','FUENTES','Federico','Sistemas',680);
 insert into empleados_tr_delete values('22555666','CASEROS','Carlos','Contaduria',900);
 insert into empleados_tr_delete values('23444555','GOMEZ','Gabriela','Sistemas',1200);
 insert into empleados_tr_delete values('23666777','JUAREZ','Juan','Contaduria',1000);
 
 select *  from empleados_tr_delete;
 select * from control_tr_delete;
 
 /*
  Cree un disparador a nivel de fila, que se dispare cada vez que se borre un registro de "empleados"; el trigger debe ingresar en 
  la tabla "control", el nombre del usuario y la fecha en la cual se realizó un "delete" sobre "empleados"*/
  
  create or replace trigger del_row_em_to_reg
  before delete
  on empleados_tr_delete
  for each row
  begin
    insert into control_tr_delete values (user,sysdate);
  end del_row_em_to_reg;
  /
  
  select * from empleados_tr_delete where sueldo > 800;
  
  delete from empleados_tr_delete where sueldo > 800;
  
   
 select *  from empleados_tr_delete;
 select * from control_tr_delete;
 
 
 
 
 /*------------------------------------------TRIGGER DE UPDATE a nivel de sentencia y filas----------------------------------------*/
 
create or replace trigger actu_row_em_to_reg
  before update
  on empleados_tr_delete
  for each row
  begin
    insert into control_tr_delete values (user,sysdate);
  end del_row_em_to_reg;
  /
  
  update empleados_tr_delete set nombre = 'ALberta' where nombre = 'AMANDA';
  
  
  
  
  
  
 /*--------------------------------------------------TRIGGER DE UPDATE A NIVEL DE FIAS Y SENTENCIAS - LISTA DE CAMPOS------------------------------------------------------*/
 
 /* 
 El trigger de actualización (a nivel de sentencia o de fila) permite incluir una lista de campos. Si se incluye el nombre de un campo (o varios) 
 luego de "update", el trigger se disparará únicamente cuando alguno de esos campos (incluidos en la lista) es actualizado. Si se omite la lista de campos, 
 el trigger se dispara cuando cualquier campo de la tabla asociada es modificado, es decir, por defecto toma todos los campos de la tabla.
 */
 
drop table control_act_campos;
 drop table libros_act_campos;
 
  create table libros_act_campos(
  codigo number(6),
  titulo varchar2(40),
  autor varchar2(30),
  editorial varchar2(20),
  precio number(6,2)
 );

 create table control_act_campos(
  usuario varchar2(30),
  fecha date
 );
 
  insert into libros_act_campos values(100,'Uno','Richard Bach','Planeta',25);
 insert into libros_act_campos values(103,'El aleph','Borges','Emece',28);
 insert into libros_act_campos values(105,'Matematica estas ahi','Paenza','Nuevo siglo',12);
 insert into libros_act_campos values(120,'Aprenda PHP','Molina Mario','Nuevo siglo',55);
 insert into libros_act_campos values(145,'Alicia en el pais de las maravillas','Carroll','Planeta',35);
 
 
 /* 
 Una librería almacena los datos de sus libros en una tabla denominada "libros" y controla las acciones que los empleados 
 realizan sobre dicha tabla almacenando en la tabla "control" el nombre del usuario y la fecha, cada vez que se modifica el "precio" de un libro.
 */
 
  create or replace trigger tr_actualizar_precio_libros
  before update of precio, codigo
  on libros_act_campos
  for each row
 begin
  insert into control_act_campos values(user,sysdate);
 end tr_actualizar_precio_libros;
 /
 
 select * from libros_act_campos;
 select * from control_act_campos;
 
 update libros_act_campos set autor = 'Vega' where autor = 'Borges'; --NO SE AGREGA NADA A LA TABLA CONTROL PORQUE EN EL TRIGGER NO LO ESPECIFICA
 update libros_act_campos set codigo = 200 where codigo = 145;
update libros_act_campos set precio = 100 where precio = 35;




/*---------------------------------------------------------------TRIGGER PARA MULTIPLES EVENTOS---------------------------------------------*/

 drop table libros_tr_mult;
 drop table control_tr_mult;
 
  create table libros_tr_mult(
  codigo number(6),
  titulo varchar2(40),
  autor varchar2(30),
  editorial varchar2(20),
  precio number(6,2)
 );
 
 create table control_tr_mult(
  usuario varchar2(30),
  fecha date,
  operacion varchar2(20)
 );
 
insert into libros_tr_mult values(100,'Uno','Richard Bach','Planeta',25);
 insert into libros_tr_mult values(103,'El aleph','Borges','Emece',28);
 insert into libros_tr_mult values(105,'Matematica estas ahi','Paenza','Nuevo siglo',12);
 insert into libros_tr_mult values(120,'Aprenda PHP','Molina Mario','Nuevo siglo',55);
 insert into libros_tr_mult values(145,'Alicia en el pais de las maravillas','Carroll','Planeta',35);
 
 /* Creamos un disparador a nivel de sentencia, que se dispare cada vez que se ingrese, actualice o elimine un registro de la tabla "libros". 
 El trigger ingresa en la tabla "control", el nombre del usuario, la fecha y la hora en la cual se realizó la modificación y 
 el tipo de operación que se realizó*/
 
create or replace trigger tr_cambios_libros
before insert or update or delete
on libros_tr_mult
for each row
begin
 if inserting then
   insert into control_tr_mult values (user, sysdate,'inserción');
 end if;
 if updating then
  insert into control_tr_mult values (user, sysdate,'actualización');
 end if;
 if deleting then
   insert into control_tr_mult values (user, sysdate,'borrado');
 end if;
end tr_cambios_libros;
/

select * from libros_tr_mult;
select  * from control_tr_mult;

 update libros_tr_mult set precio=precio+precio*0.1 where editorial='Planeta';
 
delete from libros_tr_mult where codigo=145;




 drop table libros_tr_mult_restric;
 drop table control_tr_mult_restric;
 
  create table libros_tr_mult_restric(
  codigo number(6),
  titulo varchar2(40),
  autor varchar2(30),
  editorial varchar2(20),
  precio number(6,2)
 );
 
 create table control_tr_mult_restric(
  usuario varchar2(30),
  fecha date,
  operacion varchar2(20)
 );
 
insert into libros_tr_mult_restric values(100,'Uno','Richard Bach','Planeta',25);
 insert into libros_tr_mult_restric values(103,'El aleph','Borges','Emece',28);
 insert into libros_tr_mult_restric values(105,'Matematica estas ahi','Paenza','Nuevo siglo',12);
 insert into libros_tr_mult_restric values(120,'Aprenda PHP','Molina Mario','Nuevo siglo',55);
 insert into libros_tr_mult_restric values(145,'Alicia en el pais de las maravillas','Carroll','Planeta',35);
select * from libros_tr_mult_restric;
select * from control_tr_mult_restric;


/* El gerente permite:
- ingresar o borrar libros de la tabla "libros" unicamente los sábados de 8 a 12 hs.
- actualizar los precios de los libros de lunes a viernes de 8 a 18 hs. y sábados entre la 8 y 12 hs.
Cree un disparador para los tres eventos que controle la hora en que se realizan las operaciones sobre "libros". Si se intenta eliminar, ingresar o 
actualizar registros de "libros" fuera de los días y horarios permitidos, debe aparecer un mensaje de error. Si la operación de ingreso, borrado 
o actualización de registros se realiza, se debe almacenar en "control", el nombre del usuario, la fecha y el tipo de operación ejecutada
*/

create or replace trigger tr_restric_cambios_libros
before insert or update or delete
on libros_tr_mult_restric
for each row
begin
    if inserting then
        if((to_char(sysdate,'dy','nls_date_language=SPANISH') in ('vie')) and (to_number(to_char(sysdate,'HH24')) between 1 and 20)) then
            insert into control_tr_mult_restric values(user,sysdate,'Ingreso');
        else
            raise_application_error(-20000,'Los ingresos sólo los Sábados de 8 a 12 hrs.');
        end if;
    end if;
    if updating then
        if(((to_char(sysdate,'dy','nls_date_language=SPANISH') in ('lun','mar','mié','jue','vie')) and (to_number(to_char(sysdate,'HH24')) between 8 and 19)) or ((to_char(sysdate,'dy','nls_date_language=SPANISH') in('sáb')) and(to_number(to_char(sysdate,'HH24')) between 8 and 11))) then    
            insert into control_tr_mult_restric values(user,sysdate,'Actualizado');
        else 
            raise_application_error(-20001,'Las actualizaciones solo de Lunes a Viernes de 8 a 20 o Sábado de 8 a 12 hr s.');
        end if;
    end if;
    if deleting then
        if((to_char(sysdate,'dy','nls_date_language=SPANISH') in ('sáb')) and (to_number(to_char(sysdate,'HH24')) between 8 and 11)) then
            insert into control_tr_mult_restric values(user,sysdate,'Borrado');
        else 
            raise_application_error(-20002,'Las eliminaciones sólo los Sábados de 8 a 12 hs.');
        end if;
    end if;
end tr_restric_cambios_libros;
/

insert into libros_tr_mult_restric values(150,'El experto en laberintos 2','Gaskin','Planeta',40);
update libros_tr_mult_restric set precio=45 where codigo=150;
delete from libros_tr_mult_restric where codigo=150;


/*---------------------------------------------TRIGGER OLD y NEW-----------------------------------------------------------------------------------------------------*/

/*
Cuando trabajamos con trigger a nivel de fila, Oracle provee de dos tablas temporales a las cuales se puede acceder, que contienen los antiguos y nuevos valores 
de los campos del registro afectado por la sentencia que disparó el trigger. El nuevo valor es ":new" y el viejo valor es ":old". Para referirnos a ellos debemos especificar 
su campo separado por un punto ":new.CAMPO" y ":old.CAMPO".
El acceso a estos campos depende del evento del disparador.
En un trigger disparado por un "insert", se puede acceder al campo ":new" unicamente, el campo ":old" contiene "null".
En una inserción se puede emplear ":new" para escribir nuevos valores en las columnas de la tabla.
En un trigger que se dispara con "update", se puede acceder a ambos campos. En una actualizacion, se pueden comparar los valores de ":new" y ":old".
En un trigger de borrado, unicamente se puede acceder al campo "old", ya que el campo ":new" no existe luego que el registro es eliminado, el campo ":new" contiene "null" y no puede ser modificado.
Los valores de "old" y "new" están disponibles en triggers after y before.
El valor de ":new" puede modificarse en un trigger before, es decir, se puede acceder a los nuevos valores antes que se ingresen en la tabla y cambiar los valores asignando a ":new.CAMPO" otro valor.
El valor de ":new" NO puede modificarse en un trigger after, esto es porque el trigger se activa luego que los valores de "new" se almacenaron en la tabla.
El campo ":old" nunca se modifica, sólo puede leerse.
Pueden usarse en una clásula "when" (que veremos posteriormente).
En el cuerpo el trigger, los campos "old" y "new" deben estar precedidos por ":" (dos puntos), pero si está en "when" no.

Entonces, se puede acceder a los valores de ":new" y ":old" en disparadores a nivel de fila (no en disparadores a nivel de sentencia). Están disponibles en triggers 
after y before. Los valores de ":old" solamente pueden leerse, nunca modificarse. Los valores de ":new" pueden modificarse únicamente en triggers before 
(nunca en triggers after).

*/
 drop table control_new_old;
 drop table libros_new_old;

 create table libros_new_old(
  codigo number(6),
  titulo varchar2(40),
  autor varchar2(30),
  editorial varchar2(20),
  precio number(6,2)
 );

 create table control_new_old(
  usuario varchar2(30),
  fecha date,
  codigo number(6),
  precioanterior number(6,2),
  precionuevo number(6,2)
 );
 
insert into libros_new_old values(100,'Uno','Richard Bach','Planeta',25);
 insert into libros_new_old values(103,'El aleph','Borges','Emece',28);
 insert into libros_new_old values(105,'Matematica estas ahi','Paenza','Nuevo siglo',12);
 insert into libros_new_old values(120,'Aprenda PHP','Molina Mario','Nuevo siglo',55);
 insert into libros_new_old values(145,'Alicia en el pais de las maravillas','Carroll','Planeta',35);
 
 /*
 Creamos un trigger a nivel de fila que se dispara "antes" que se ejecute un "update" sobre el campo "precio" de la tabla "libros". En el 
 cuerpo del disparador se debe ingresar en la tabla "control", el nombre del usuario que realizó la actualización, la fecha, el código del 
 libro que ha sido modificado, el precio anterior y el nuevo
 */
 
create or replace trigger tr_actualizar_precio_libros_new_old
 before update of precio
 on libros_new_old
 for each row
 begin
  insert into control_new_old values(user,sysdate,:new.codigo,:old.precio,:new.precio);
 end tr_actualizar_precio_libros_new_old;
 /
 
/*
Cuando el trigger se dispare, antes de ingresar los valores a la tabla, almacenará en "control", además del nombre del usuario y la fecha, el precio anterior del libro y el nuevo valor.
El siguiente trigger debe controlar el precio que se está actualizando, si supera los 50 pesos, se debe redondear tal valor a entero, hacia abajo (empleando "floor"), 
es decir, se modifica el valor ingresado accediendo a ":new.precio" asignándole otro valor.
*/

 create or replace trigger tr_actualizar_precio_libros_new_old_control_precio
 before update of precio
 on libros_new_old
 for each row
 begin
  if (:new.precio>50) then
   :new.precio:=floor(:new.precio);
  end if;
  insert into control_new_old values(user,sysdate,:new.codigo,:old.precio,:new.precio);
 end tr_actualizar_precio_libros_new_old_control_precio;
 /
 
 /*
 Podemos crear un disparador para múltiples eventos, que se dispare al ejecutar "insert", "update" y "delete" sobre "libros". En el cuerpo del trigger 
 se realiza la siguiente acción: se almacena el nombre del usuario, la fecha y los antiguos y viejos valores del campo "precio"
 */
 create or replace trigger tr_ins_upd_del__libros_new_old_control
 before insert or update or delete
 on libros_new_old
 for each row
 begin
  insert into control_new_old values(user,sysdate,:old.codigo,:old.precio,:new.precio);
 end tr_ins_upd_del__libros_new_old_control;
 /
 
 select * from libros_new_old;
 select * from control_new_old;
 
 update libros_new_old set precio = 30 where codigo = 100;
 
 
 /* 
 
 */
  drop table control_new_old_comercio_11;
 drop table articulos_new_old_comercio_11;
 
  create table articulos_new_old_comercio_11(
  codigo number(6),
  descripcion varchar2(40),
  precio number (6,2),
  stock number(4)
 );

 create table control_new_old_comercio_11(
  usuario varchar2(30),
  fecha date,
  codigo number(6)
 );
 
 /*
 Cree un trigger a nivel de fila que se dispara "antes" que se ejecute un "insert" sobre la tabla "articulos". En el cuerpo del disparador se 
 debe ingresar en la tabla "control", el nombre del usuario que realizó la inserción, la fecha y el código del articulo que se ha ingresado
 */
 create or replace trigger tr_control_comercio
 before insert
 on articulos_new_old_comercio_11
 for each row
 begin
    insert into control_new_old_comercio_11 values (user, sysdate,:new.codigo);
end tr_control_comercio;
/

/*
Cree un disparador que calcule el código cada vez que se inserte un nuevo registro
Este trigger ingresa el código siguiente al máximo actual, omitiendo el código ingresado
*/
 create or replace trigger tr_control_comecerio_codigo
 before insert
 on articulos_new_old_comercio_11
 for each row
 begin
   select max(codigo)+1 into :new.codigo from articulos_new_old_comercio_11;
   if :new.codigo is null then
    :new.codigo:=1;
   end if;
 end tr_control_comecerio_codigo;
 /

 select * from articulos_new_old_comercio_11;
 select * from control_new_old_comercio_11;
 
  insert into articulos_new_old_comercio_11 values(100,'regla 20 cm.',5.4,100);
  
 insert into articulos_new_old_comercio_11 values(102,'regla 40 cm.',15,80);
 insert into articulos_new_old_comercio_11 values(109,'lapices color x12',6,150);
 insert into articulos_new_old_comercio_11 values(130,'lapices color x6',4.5,100);
 insert into articulos_new_old_comercio_11 values(200,'compas metal',21.8,50);
 
 
 
 
 /*--------------------------------------------------------------TRIGGER CONDICIONADO CON WHEN-----------------------------------------------*/
 
 /* 
En los triggers a nivel de fila, se puede incluir una restricción adicional, agregando la clausula "when" con una condición que se evalúa para 
cada fila que afecte el disparador; si resulta cierta, se ejecutan las sentencias del trigger para ese registro; si resulta falsa, el trigger no se dispara para ese registro.
Limitaciones de "when":
- no puede contener subconsultas, funciones agregadas ni funciones definidas por el usuario;
- sólo se puede hacer referencia a los parámetros del evento;
- no se puede especificar en los trigers "instead of" ni en trigger a nivel de sentencia.
 */
 
  drop table libros_tr_when;
  
  create table libros_tr_when(
  codigo number(6),
  titulo varchar2(40),
  autor varchar2(30),
  editorial varchar2(20),
  precio number(6,2)
 );
 
 insert into libros_tr_when values(100,'Uno','Richard Bach','Planeta',25);
 insert into libros_tr_when values(103,'El aleph','Borges','Planeta',40);
 insert into libros_tr_when values(105,'Matematica estas ahi','Paenza','Nuevo siglo',12);
 insert into libros_tr_when values(120,'Aprenda PHP','Molina Mario','Nuevo siglo',55);
  insert into libros_tr_when values(250,'El experto en laberintos','Gaskin','Emece',30.80);
 insert into libros_tr_when values(300,'Alicia en el pais de las maravillas','Carroll','Emece',55.6); -- se activa trigger tr_precio_libros_tr_when
update libros_tr_when set precio = 80.4 where precio = 25; --se activa trigger tr_precio_libros_tr_when
 
 select * from libros_tr_when;
 
 
 /*
 Creamos un trigger a nivel de fila que se dispara "antes" que se ejecute un "insert" o un "update" sobre el campo "precio" de la 
 tabla "libros". Se activa solamente si el nuevo precio que se ingresa o se modifica es superior a 50, en caso de serlo, se modifica el 
 valor ingresado redondeándolo a entero
 */
 create or replace trigger tr_precio_libros_tr_when
 before insert or update of precio
 on libros_tr_when
 for each row when(:new.precio>50)
 begin
  :new.precio := round(:new.precio);
 end tr_precio_libros_tr_when;
 /
 
 /*
 Reemplazamos el trigger anterior por uno sin condición "when". La condición se controla en un "if" en el interior del trigger. En 
 este caso, el trigger se dispara SIEMPRE que se actualice un precio en "libros", dentro del trigger se controla el precio, si cumple 
 la condición, se modifica, sino no
 */
 
 create or replace trigger tr_precio_libros_tr_sin_when
 before insert or update of precio
 on libros_tr_when
 for each row
 begin
  dbms_output.put_line('Trigger disparado');
  if :new.precio>50 then
   dbms_output.put_line('Precio redondeado');
   :new.precio:= round(:new.precio);
  end if;
 end tr_precio_libros_tr_sin_when;
 /
 
 
 
  drop table libros_tr_when_ejercicio;
 drop table ofertas_tr_when_ejercicio;
 
  create table libros_tr_when_ejercicio(
  codigo number(6),
  titulo varchar2(40),
  autor varchar2(30),
  editorial varchar(20),
  precio number(6,2)
 );

 create table ofertas_tr_when_ejercicio(
  codigo number(6),
  titulo varchar2(40)
 );
 
 insert into libros_tr_when_ejercicio values(100,'Uno','Richard Bach','Planeta',25);
 insert into libros_tr_when_ejercicio values(103,'El aleph','Borges','Emece',28);
 insert into libros_tr_when_ejercicio values(105,'Matematica estas ahi','Paenza','Nuevo siglo',12);
 insert into libros_tr_when_ejercicio values(20,'Aprenda PHP','Molina Mario','Nuevo siglo',55);
 insert into libros_tr_when_ejercicio values(145,'Alicia en el pais de las maravillas','Carroll','Planeta',35);
 
 /*
 Cree un trigger a nivel de fila que se dispara "antes" que se ejecute un "insert" sobre "libros". Se activa solamente si el precio 
 que se ingresa es inferior a $30, en caso de serlo, se ingresa en "ofertas" el código y precio del libro
 */
 create or replace trigger libros_precio_ingre_
 before insert 
 on libros_tr_when_ejercicio
 for each row when(new.precio < 30)
 begin
    insert into ofertas_tr_when_ejercicio values (:new.codigo,:new.precio);
 end libros_precio_ingre_;
 /

 select * from libros_tr_when_ejercicio;
 select * from ofertas_tr_when_ejercicio;
 
  insert into libros_tr_when_ejercicio values(150,'El experto en laberintos','Gaskin','Planeta',28);
 insert into libros_tr_when_ejercicio values(155,'El gato con botas',null,'Planeta',38);


/* 
Cree un trigger a nivel de fila que se dispare al borrar un libro de "libros", únicamente si el precio del libro que se elimina es inferior a 
$30, es decir, si existe en "ofertas" 
*/

create or replace trigger tr_libros_precio_borrar
before delete
on libros_tr_when_ejercicio
for each row when(old.precio < 30)
begin
    delete from ofertas_tr_when_ejercicio where codigo = :old.codigo;
end tr_libros_precio_borrar;
/

delete from libros_tr_when_ejercicio where codigo=150;

/*
La empresa necesita controlar cuando se le aumenta el sueldo a los empleados, guardando en una tabla denominada "control", el nombre 
del usuario, la fecha, el documento de quien se ha modificado el sueldo, el antiguo sueldo y el nuevo sueldo. Para ello cree la tabla 
control (antes elimínela por si existe)
*/

 drop table empleados_when_sueldos;

 create table empleados_when_sueldos(
  documento char(8),
  apellido varchar2(20),
  nombre varchar2(20),
  seccion varchar2(30),
  sueldo number(8,2)
 );

 insert into empleados_when_sueldos values('22333444','ACOSTA','Ana','Secretaria',500);
 insert into empleados_when_sueldos values('22555666','CASEROS','Carlos','Contaduria',900);
 insert into empleados_when_sueldos values('22777888','DOMINGUEZ','Daniel','Secretaria',560);
 insert into empleados_when_sueldos values('22999000','FUENTES','Federico','Sistemas',680);
 insert into empleados_when_sueldos values('23444555','GOMEZ','Gabriela','Sistemas',1200);
 insert into empleados_when_sueldos values('23666777','JUAREZ','Juan','Contaduria',1000);
 
 drop table controls_when_sueldos;
 create table controls_when_sueldos(
    usuario varchar2(20),
    fecha date,
    documento char(8),
    sueldo_ant number(8,2),
    sueldo_act number(8,2)
 );
 
 /* 
Cree un disparador que almacene el nombre del usuario, la fecha, documento, el antiguo y el nuevo sueldo en "control" cada vez que se actualice 
un sueldo de la tabla "empleados" a un valor mayor. Si el sueldo se disminuye, el trigger no debe activarse. Si se modifica otro campo 
diferente de "sueldo", no debe activarse.
 */
 select * from empleados_when_sueldos;
 select * from controls_when_sueldos;
 
 create or replace trigger tr_empl_suel_control
 before update of sueldo
 on empleados_when_sueldos
 for each row when (old.sueldo < new.sueldo)
 begin
    insert into controls_when_sueldos values (user, sysdate,:old.documento,:old.sueldo,:new.sueldo);
 end tr_empl_suel_control;
 /
 
 update empleados_when_sueldos set sueldo = 1000 where seccion = 'Sistemas';
 
 /*
 Cree un disparador a nivel de fila que se dispare cada vez que se ingrese un nuevo empleado y coloque en mayúsculas el apellido ingresado. 
 Además, si no se ingresa sueldo, debe ingresar '0'
 */
 
 create or replace trigger tr_emple_mayus_ape
 before insert 
 on empleados_when_sueldos
 for each row
 begin
    :new.apellido := upper(:new.apellido);
    if(:new.sueldo is null) then
        :new.sueldo := 0;
    end if;
 end tr_emple_mayus_ape;
 /
 
  select * from empleados_when_sueldos;

  insert into empleados_when_sueldos values('25666777','Lopez','Luisa','Secretaria',650);
 insert into empleados_when_sueldos (documento,apellido,nombre, seccion) values('26777888','Morales','Marta','Secretaria');
 insert into empleados_when_sueldos values('26999000','Perez','Patricia','Contaduria',null);
 
 
 /*-----------------------------------------------------------------------TRIGGER DE UPDATE CAMPOS----------------------------------------------------------------------*/
 
drop table controlprecios_1;
 drop table libros_1;
 drop table control_1;
 
 create table libros_1(
  codigo number(6),
  titulo varchar2(40),
  autor varchar2(30),
  editorial varchar2(20),
  precio number(6,2),
  stock number(4)
 );

 create table control_1(
  usuario varchar2(30),
  fecha date,
  codigo number(6)
 );

 create table controlprecios_1(
  fecha date,
  codigo number(6),
  precioanterior number(6,2),
  precionuevo number(6,2)
 );
 
  insert into libros_1 values(100,'Uno','Richard Bach','Planeta',25,100);
 insert into libros_1 values(103,'El aleph','Borges','Emece',28,0);
 insert into libros_1 values(105,'Matematica estas ahi','Paenza','Nuevo siglo',12,50);
 insert into libros_1 values(120,'Aprenda PHP','Molina Mario','Nuevo siglo',55,200);
 insert into libros_1 values(145,'Alicia en el pais de las maravillas','Carroll','Planeta',35,10);
 
 /*
Cree un trigger a nivel de fila que se dispare "antes" que se ejecute un "update" sobre la tabla "libros".
En el cuerpo del trigger se debe averiguar el campo que ha sido modificado; en caso de modificarse el "precio", se ingresa en la tabla 
"controlPrecios" la fecha, el código del libro y el antiguo y nuevo precio; en caso de actualizarse cualquier otro campo, se almacena en la 
tabla "control" el nombre del usuario que realizó la modificación, la fecha y el código del libro modificado.
 */
 
 create or replace trigger tr_actualizar_libros_antes_1
 before update
 on libros_1
 for each row
 begin
    if updating ('precio') then
        insert into controlprecios_1 values(sysdate, :old.codigo, :old.precio, :new.precio);
    else 
        insert into control_1 values (user, sysdate, :old.codigo);
    end if;
 end tr_actualizar_libros_antes_1;
 /
 
  update libros_1 set precio=35 where codigo=100;
   update libros_1 set stock=0 where codigo=145;

 
 select * from libros_1;
  select * from control_1;
   select * from controlprecios_1;
  
  
   
/*Una librería almacena los datos de sus libros en una tabla denominada "libros".*/

 drop table libros_2;

 create table libros_2(
  codigo number(6),
  titulo varchar2(40),
  autor varchar2(30),
  editorial varchar2(20),
  precio number(6,2),
  stock number(4)
 );
 
  insert into libros_2 values(100,'Uno','Richard Bach','Planeta',25,100);
 insert into libros_2 values(103,'El aleph','Borges','Emece',28,0);
 insert into libros_2 values(105,'Matematica estas ahi','Paenza','Nuevo siglo',12,50);
 insert into libros_2 values(120,'Aprenda PHP','Molina Mario','Nuevo siglo',55,200);
 insert into libros_2 values(145,'Alicia en el pais de las maravillas','Carroll','Planeta',35,10);
 
 /*
 Cree un trigger a nivel de fila que se dispare "antes" que se ejecute un "update" sobre la tabla "libros". En el cuerpo del trigger se debe averiguar el campo que ha sido modificado. 
 En caso de modificarse:
- el código, debe rechazarse la modificación con un mensaje de error.
- el "precio", se controla si es mayor o igual a cero, si lo es, debe dejarse el precio anterior y mostrar un mensaje de error.
- el stock, debe controlarse que no se ingrese un número negativo ni superior a 1000, en tal caso, debe rechazarse con un mensaje de error.*/

create or replace trigger tr_libreria_almacen_2
before update
on libros_2
for each row
begin
    if updating ('codigo') then
        raise_application_error(-20000,'No puede llevarse a cabo la actualización del campo código');
    elsif updating ('stock') then
        if (:new.stock < 0) or (:new.stock > 1000) then
            raise_application_error(-20001,'El valor de stock debe estar entre 0 y 1000');
        end if;
    elsif updating ('precio') then
        if (:new.precio < 0) then
            raise_application_error(-20002,'No pueden colocar precios negativos');
        end if;   
    end if;
end tr_libreria_almacen_2;
/

select * from libros_2;
 update libros_2 set precio=-50 where codigo=100;
 update libros_2 set precio=1 where codigo=100;
  update libros_2 set stock=-1 where codigo=100;
 update libros_2 set stock=2000 where codigo=100;
 update libros_2 set stock=200 where codigo=100;
 
 
 /* 
 Un comercio almacena los datos de los artículos que tiene para la venta en una tabla denominada "articulos". En otra tabla denominada "pedidos" 
 almacena el código de cada artículo y la cantidad que necesita solicitar a los mayoristas. En una tabla llamada "controlPrecios" almacena la fecha, 
 el código del artículo y ambos precios (antiguo y nuevo).
 */
 
  drop table articulos_3;
 drop table pedidos_3;
 drop table controlPrecios_3;
 
  create table articulos_3(
  codigo number(4),
  descripcion varchar2(40),
  precio number (6,2),
  stock number(4)
 );

 create table pedidos_3(
  codigo number(4),
  cantidad number(4)
 );

 create table controlPrecios_3(
  fecha date,
  codigo number(4),
  anterior number(6,2),
  nuevo number(6,2)
 );
 
  insert into articulos_3 values(100,'cuaderno rayado 24h',4.5,100);
 insert into articulos_3 values(102,'cuaderno liso 12h',3.5,150);
 insert into articulos_3 values(104,'lapices color x6',8.4,60);
 insert into articulos_3 values(160,'regla 20cm.',6.5,40);
 insert into articulos_3 values(173,'compas xxx',14,35);
 insert into articulos_3 values(234,'goma lapiz',0.95,200);
 
   insert into articulos_3 values(100,'cuaderno rayado 24h',4.5,0);
 insert into articulos_3 values(102,'cuaderno liso 12h',3.5,0);
 insert into articulos_3 values(104,'lapices color x6',8.4,0);
 insert into articulos_3 values(160,'regla 20cm.',6.5,0);
 insert into articulos_3 values(173,'compas xxx',14,0);
 insert into articulos_3 values(234,'goma lapiz',0.95,0);
 
 /*para activar salida por consola*/
 set serveroutput on;
 execute dbms_output.enable(20000);
 
 /* 
 Cada vez que se disminuye el stock de un artículo de la tabla "articulos", se debe incrementar la misma cantidad de ese artículo en "pedidos" y 
 cuando se incrementa en "articulos", se debe disminuir la misma cantidad en "pedidos". 
 Si se ingresa un nuevo artículo en "articulos", debe agregarse 
 un registro en "pedidos" con "cantidad" cero. Si se elimina un registro en "articulos", debe eliminarse tal artículo de "pedidos". 
 Cree un trigger 
 para los tres eventos (inserción, borrado y actualización), a nivel de fila, sobre "articulos", para los campos "stock" y "precio", que realice las 
 tareas descritas anteriormente, si el campo modificado es "stock". Si el campo modificado es "precio", almacene en la tabla "controlPrecios", la fecha, 
 el código del artículo, el precio anterior y el nuevo.
 
 
 El trigger muestra el mensaje "Trigger activado" cada vez que se dispara; en cada "if" muestra un segundo mensaje que indica cuál condición se ha cumplido.
 */
 
 select * from articulos_3;
 select * from pedidos_3;
 select * from controlPrecios_3;
 
 create or replace trigger tr_art_ped_cntrl_precios_upda_dele_inser_3
 before insert or delete or update of stock, precio
 on articulos_3
 for each row
 begin
    dbms_output.put_line('Trigger activado');
    if inserting then
        dbms_output.put_line('Inserción');
        insert into pedidos_3 values(:new.codigo, 0);
    end if;
    if updating ('stock') then
        dbms_output.put_line('Actualización de stock');
        update pedidos_3 set cantidad = cantidad + (:old.stock - :new.stock) where codigo = :old.codigo;
    end if;
    if updating ('precio') then
        dbms_output.put_line('Actualización de precio');
        insert into controlPrecios_3 values (sysdate, :old.codigo, :old.precio, :new.precio);
    end if;
    if deleting then
        dbms_output.put_line('Borrado');
        delete from pedidos_3 where codigo = :old.codigo; 
    end if;
 end tr_art_ped_cntrl_precios_upda_dele_inser_3;
 /
 
 
  update articulos_3 set stock=30 where codigo=100;
 insert into articulos_3 values(280,'carpeta oficio',15,50);
 delete articulos_3 where codigo=100;
  update articulos_3 set precio=4.8 where codigo=102;
  update articulos_3 set descripcion='compas metal xxx' where codigo=173;
 update articulos_3 set precio=10, stock=55, descripcion='lapices colorx6 Faber' where codigo=104;
 
 update articulos_3 set stock=10 where codigo>=104;
 update articulos_3 set precio=precio+precio*0.1 where codigo>=104;
 delete from articulos_3 where codigo>=104;
 
 
 
 /*------------------------------------------TRIGGERS ENABLE/DISABLE----------------------------------------------*/
 
 /*
 Un disparador puede estar en dos estados: habilitado (enabled) o deshabilitado (disabled).
Cuando se crea un trigger, por defecto está habilitado.
Se puede deshabilitar un trigger para que no se ejecute. Un trigger deshabilitado sigue existiendo, 
pero al ejecutar una instrucción que lo dispara, no se activa.
 */
 
 alter trigger tr_art_ped_cntrl_precios_upda_dele_inser_3 disable;
 alter trigger tr_art_ped_cntrl_precios_upda_dele_inser_3 enable;

/*
Se pueden habilitar o deshabilitar todos los trigger establecidos sobre una tabla especifica, se 
emplea la siguiente sentencia;
*/

alter table EMPLEADOS_TR_DELETE disable all triggers;
alter table EMPLEADOS_TR_DELETE enable all triggers;


/*Comando para saber el estado de los triggers */
select * from user_triggers;
select * from user_triggers where table_name = 'EMPLEADOS_TR_DELETE';


/*----------------------ELIMINAR TRIGGERS----------------------------------*/

/*
Si eliminamos una tabla, se eliminan todos los triggers establecidos sobre ella.
*/

DROP TRIGGER tr_art_ped_cntrl_precios_upda_dele_inser_3;

select * from user_indexes;