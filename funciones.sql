/*
'''

+ Se pueden emplear funciones del sistema en cualquier lugar en el que se permita una expresión en una sentencia "select"
+ Al igual que los procedimientos almacenados, son bloques de código que permiten agrupar y organizar sentencias sql que se ejecutan al invocar la función.
+ Las funciones tienen una estructura similar a la de los procedimientos almacenados, pero la función además contiene la cláusula "return" y siempre retorna un valor 


'''
*/

select * from libros22;

/*FUNCION RECIBE 1 PARÁMETRO UN VLAOR A INCREMENTAR Y RETORNA EL VALOR INGRESADO CON INCREMENTO DEL 10%*/
create or replace function f_incremento10 (avalor number)
    return number
is
begin
    return avalor + (avalor * 0.1);
end;
/

SELECT titulo, precio, f_incremento10(precio) as precio_10porc_mas from libros22;


/* FUNCION QUE RECIBE 2 PARÁMETROS, UN VALOR A INCREMENTAR Y EL INCREMENTO Y RETORNA EL VALOR INGRESADO COMO PRIMER ARGUMENTO CON EL INCREMENTO ESPECIDIFCADO POR
EL SEGUNDO ARGUMENTO*/

CREATE OR REPLACE FUNCTION f_incremento(precio number,aumento number)
    return number
is
begin
    return precio + (precio * (aumento/100));
end;
/

select titulo, precio, f_incremento(precio, 50) as precio_aumentado from libros22;


/* La siguiente función recibe un parámetro de tipo numérico y retorna una cadena de caracteres. Se define una variable en la zona de definición de variables denominada 
"valorretornado" de tipo varchar. En el cuerpo de la función empleamos una estructura condicional (if) para averiguar si el valor enviado como argumento es menor o 
igual a 20, si lo es, almacenamos en la variable "valorretornado" la cadena "economico", en caso contrario guardamos en tal variable la cadena "costoso"; al finalizar 
la estructura condicional retornamos la variable "valorretornado": */

create or replace function f_costoso (avalor number)
    return varchar
is
    valorretornado varchar(20);
begin
    valorretornado:='';
    if avalor <= 20 then
        valorretornado:='económico';
    else valorretornado:='costoso';
    end if;
    return valorretornado;
end;
/

select titulo, precio, f_costoso(precio) as clasificacion from libros22;



/* FUNCION QUE RECIBE 2 PARÁMETROS NUMÉRICOS Y RETORNA EL PROMEDIO*/
 create or replace function f_promedio (num1 number, num2 number)
 return number
 is
 begin
    return (num1+num2)/2;
end;
/

select f_promedio(10,20) from dual;


/*--------------------------------------------------USO IF EN FUNCIONES-------------------------------------*/

 create table notas(
  nombre varchar2(30),
  nota number(4,2)
 );
  insert into notas values('Acosta Ana', 6.7);
 insert into notas values('Bustos Brenda', 9.5);
 insert into notas values('Caseros Carlos', 3.7);
 insert into notas values('Dominguez Daniel', 2);
 insert into notas values('Fuentes Federico', 8);
 insert into notas values('Gonzalez Gaston', 7);
 insert into notas values('Juarez Juana', 4);
 insert into notas values('Lopez Luisa',5.3);
 
 select * from notas;
 
/* crear o reemplazar "f_condicion" que recibe una nota y retorna una cadena de caracteres indicando si aprueba o no*/
create or replace function f_condition (nota number)
    return varchar2
is
    valorretornado varchar(20);
begin
    valorretornado:='';
    if nota > 4 then
        valorretornado:='Aprobado';
    else valorretornado:='Reprobado';
    end if;
    return valorretornado;
end;
/

drop function f_condition;
    
select nombre, nota, f_condition(nota) as condicion from notas;

/*REALIZAR LA MIMA FUNCION PERO SIN EL ELSE*/
create or replace function f_condition_sin_else (nota number)
    return varchar2
is
    valorretornado varchar(20);
begin
    valorretornado:='Aprobado';
    if nota < 4 then
        valorretornado:='Reprobado';
    end if;
    return valorretornado;
end;
/

select nombre, nota, f_condition(nota),f_condition_sin_else(nota) as condicion from notas;

/* En el siguiente ejemplo colocamos un "if" dentro de otro "if". En el cuerpo de la función controlamos si la nota es menor a 4 (retorna "desaprobado"),
luego, dentro del "else", controlamos si la nota es menor a 8 (retorna "regular") y si no lo es ("else"), retorna "promocionado" */

create or replace function f_if_anidado (nota number)
    return varchar2
is
    val_retorno varchar2(20);
begin
    val_retorno:='';
    if nota < 4 then
        val_retorno:='Desaprobado';
    else
        if nota < 8 and nota >=4 then
            val_retorno:='Regular';
        else val_retorno:='Promocionado';
        end if;
    end if;
    return val_retorno;
end;
/

select nombre, nota, f_condition(nota),f_condition_sin_else(nota) as condicion, f_if_anidado(nota) as condicion_detalle from notas;

create or replace function f_elif_notas (nota number)
    return varchar2
is
    val_retorno varchar2(20);
begin
    val_retorno:='';
    if nota < 4 then
        val_retorno:='Desaprobado';
    elsif nota < 8 and nota >=4 then
            val_retorno:='Regular';
    else val_retorno:='Promocionado';
    end if;
    return val_retorno;
end;
/

select nombre, nota, f_condition(nota),f_condition_sin_else(nota) as condicion, f_if_anidado(nota) as condicion_detalle, f_elif_notas(nota) as condicion_detalle_elif from notas;

/* Un negocio almacena los datos de sus productos en una tabla denominada "productos". Dicha tabla contiene el código de producto, el precio, el stock mínimo que se necesita 
(cantidad mínima requerida antes de comprar más) y el stock actual (cantidad disponible en depósito). Si el stock actual es cero, es urgente reponer tal producto; 
menor al stock mínimo requerido, es necesario reponer tal producto; si el stock actual es igual o supera el stock minimo, está en estado normal. */

 create table productos(
  codigo number(5),
  precio number(6,2),
  stockminimo number(4),
  stockactual number(4)
 );
 insert into productos values(100,10,100,200);
 insert into productos values(102,15,200,500);
 insert into productos values(130,8,100,0);
 insert into productos values(240,23,100,20);
 insert into productos values(356,12,100,250);
 insert into productos values(360,7,100,100);
 insert into productos values(400,18,150,100);
 
 select * from productos;
 
 /* Cree una función que reciba dos valores numéricos correspondientes a ambos stosks. Debe comparar ambos stocks y retornar una cadena de caracteres indicando 
 el estado de cada producto, si stock actual es:
- cero: "faltante",
 - menor al stock mínimo: "reponer",
 - igual o superior al stock mínimo: "normal".
 
 Realice una función similar a las anteriores, pero esta vez, si el estado es "reponer" o "faltante", debe especificar la cantidad necesaria 
 (valor necesario para llegar al stock mínimo)
 */
create or replace function prod_estado (stockmin number, stockactual number)
    return varchar2
is
    val varchar(20);
begin
    val:='';
    if stockactual = 0 then
        val:= 'Faltante ' || to_char(stockmin);
    elsif stockactual < stockmin then
        val:= 'Reponer ' || to_char(stockmin - stockactual);
    elsif stockactual >= stockmin then
        val:= 'Normal';
    end if;
    return val;
end;
/

select codigo, stockminimo, stockactual, prod_estado(stockminimo,stockactual) as estado_stock from productos;




/*------------------------------------------------------------USO DE CASE--------------------------------------------------------*/

/*
La estructura "case" es similar a "if", sólo que se pueden establecer varias condiciones a cumplir. Con el "if" solamente podemos obtener dos salidas, 
cuando la condición resulta verdadera y cuando es falsa, si queremos más opciones podemos usar "case". 

La cláusula "else" puede omitirse, en caso que no se encuentre coincidencia con ninguno de los "when", se sale del "case" sin modificar el valor de la variable 
"trimestre", con lo cual, retorna el valor 4, que es que que almacenaba antes de entrar a la estructura "case".

Otra diferencia con "if" es que el "case" toma valores puntuales, no expresiones. No es posible realizar comparaciones en cada "when". La siguiente sintaxis provocaría un error:
*/

 create or replace function f_mes(afecha date)
   return varchar2
 is
  mes varchar2(20);
 begin
   mes:='enero';
   case extract(month from afecha)
     when 1 then mes:='enero';
     when 2 then mes:='febrero';
     when 3 then mes:='marzo';
     when 4 then mes:='abril';
     when 5 then mes:='mayo';
     when 6 then mes:='junio';
     when 7 then mes:='julio';
     when 8 then mes:='agosto';
     when 9 then mes:='setiembre';
     when 10 then mes:='octubre';
     when 11 then mes:='noviembre';
     else mes:='diciembre';
   end case;
   return mes;
 end;
 /

create or replace function f_trimestre(afecha date)
   return varchar2
 is
  mes varchar2(20);
  trimestre number;
 begin
   mes:=extract(month from afecha);
   trimestre:=4;
   case mes
     when 1 then trimestre:=1;
     when 2 then trimestre:=1;
     when 3 then trimestre:=1;
     when 4 then trimestre:=2;
     when 5 then trimestre:=2;
     when 6 then trimestre:=2;
     when 7 then trimestre:=3;
     when 8 then trimestre:=3;
     when 9 then trimestre:=3;
     else trimestre:=4;
   end case;
   return trimestre;
 end;
 /
 
select f_mes('10/12/2009') from dual;
select f_trimestre('10/12/2009') from dual;

 create table empleados22 (
  documento char(8),
  nombre varchar(30),
  fechanacimiento date  
 );

 insert into empleados22 values('20111111','Acosta Ana','10/05/1968');
 insert into empleados22 values('22222222','Bustos Bernardo','09/07/1970');
 insert into empleados22 values('22333333','Caseros Carlos','15/10/1971');
 insert into empleados22 values('23444444','Fuentes Fabiana','25/01/1972');
 insert into empleados22 values('23555555','Gomez Gaston','28/03/1979');
 insert into empleados22 values('24666666','Juarez Julieta','18/02/1981');
 insert into empleados22 values('25777777','Lopez Luis','17/09/1978');
 insert into empleados22 values('26888888','Morales Marta','22/12/1975');

select * from empleados22;

select nombre,fechanacimiento,
    case extract(month from fechanacimiento)
        when 1 then 1
        when 2 then 1
        when 3 then 1
        when 4 then 2
        when 5 then 2
        when 6 then 3
        when 7 then 3
        when 8 then 3
        when 9 then 3
    else 4
    end as trimestre
    from empleados22 
    order by trimestre;
    
/*
La empresa tiene por política festejar los cumpleaños de sus empleados cada mes, si es de sexo femenino se le regala un ramo de flores, sino, 
una lapicera. Realice un "select" mostrando el nombre del empleado, el día del cumpleaños y una columna extra que muestre "FLORES" o "LAPICERA" 
según el sexo del empleado (case), de todos los empleados que cumplen años en el mes de agosto (where) y ordene por día.
*/

 drop table empleados33;

 create table empleados33 (
  documento char(20),
  nombre varchar(30),
  fechanacimiento date,
  hijos number(2),
  sueldo number(6,2),
  sexo char(2)  
 );
 
  insert into empleados33 values('20000000','Acosta Ana','10/05/1968',0,800,'f');
 insert into empleados33 values('21111111','Bustos Bernardo','09/07/1970',2,550,'m');
 insert into empleados33 values('22222222','Caseros Carlos','15/10/1971',3,500,'m');
 insert into empleados33 values('23333333','Fuentes Fabiana','25/08/1972',0,500,'f');
 insert into empleados33 values('24444444','Gomez Gaston','28/03/1979',1,850,'m');
 insert into empleados33 values('25555555','Juarez Javier','18/08/1981',2,600,'m');
 insert into empleados33 values('26666666','Lopez Luis','17/09/1978',4,690,'m');
 insert into empleados33 values('27777777','Morales Marta','22/08/1975',2,480,'f');
 insert into empleados33 values('28888888','Norberto Nores','11/08/1973',3,460,'m');
 insert into empleados33 values('29999999','Oscar Oviedo','19/07/1976',0,700,'m');
 
 select * from empleados33;
 
select nombre, fechanacimiento, extract(day from fechanacimiento) as día,
    case sexo
        when 'm' then 'Lapicera'
        when 'f' then 'Flores'
    end as regalo
    from empleados33
    order by nombre;
    
select nombre, fechanacimiento, extract(day from fechanacimiento) as día,
    case sexo
        when 'm' then 'Lapicera'
        else 'Flores'
    end as regalo
    from empleados33
    where extract(month from fechanacimiento) = '08'
    order by 2;
    

