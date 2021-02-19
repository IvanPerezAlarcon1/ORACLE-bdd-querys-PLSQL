/* 

Las estructuras repetitivas permiten ejecutar una secuencia de sentencias varias veces. Hay tres estructuras repetitivas, o bucles: loop, for y while.

Comenzamos por "loop", que es la más simple. Veremos la sintaxis del bucle "loop" que combina una condición y la palabra "exit".

*/

set serveroutput on; 
execute dbms_output.enable(20000);
/* salida de servidor activada 
En primer lugar activamos el paquete que contiene los procedimientos necesarios para la salida de datos por pantalla (set serveroutput on) y 
habilitamos las llamadas a tales procedimientos.
el execute permite 20000 salidas
*/

declare 
    resultado number;
    multiplicador number:=0;
begin
    loop
        resultado:=3*multiplicador;
        dbms_output.put_line('3x' || to_char(multiplicador) || '=' || to_char(resultado));
        multiplicador:= multiplicador + 1;
        exit when multiplicador > 5;
    end loop;
end;
/


/* 
En el siguiente ejemplo se muestra la tabla del 4. Se va incrementando la variable "multiplicador" y se almacena en una variable "resultado"; el ciclo se repite hasta
que la variable resultado llega o supera el valor 50. 
*/

declare
  resultado number;
  multiplicador number:=0;
begin
  loop
    resultado:=4*multiplicador;
    exit when resultado>=50;
    dbms_output.put_line('4x'||to_char(multiplicador)||'='||to_char(resultado));
    multiplicador:=multiplicador+1;
  end loop;
end;
/


drop table empleados55;
create table empleados55(
  nombre varchar2(40),
  sueldo number(6,2)
 );
 
  insert into empleados55 values('Acosta Ana',550); 
 insert into empleados55 values('Bustos Bernardo',850); 
 insert into empleados55 values('Caseros Carolina',900); 
 insert into empleados55 values('Dominguez Daniel',490); 
 insert into empleados55 values('Fuentes Fabiola',820); 
 insert into empleados55 values('Gomez Gaston',740); 
 insert into empleados55 values('Huerta Hernan',1050);
 
select * from empleados55;
 
 /* 
 Se necesita incrementar los sueldos en forma proporcional, en un 10% cada vez y controlar que la suma total de sueldos no sea menor a $7000, 
 si lo es, el bucle debe continuar y volver a incrementar los sueldos, en caso de superarlo, se saldrá del ciclo repetitivo; es decir, este bucle 
 continuará el incremento de sueldos hasta que la suma de los mismos llegue o supere los 7000.
 */
 
declare
    total number;
begin
    loop
        update empleados55 set sueldo = sueldo + (sueldo * 0.1);
        select sum(sueldo) into total from empleados55;
        exit when total > 8000;
    end loop;
end;
/

select sum(sueldo) from empleados55;
select * from empleados55;


/*
- Se necesita incrementar los sueldos en forma proporcional, en un 5% cada vez y controlar que el sueldo máximo alcance o supere los $1600, al llegar o superarlo, 
el bucle debe finalizar. Incluya una variable contador que cuente cuántas veces se repite el bucle
- Verifique que los sueldos han sido incrementados y el sueldo máximo es igual o superior a 1600

- Muestre el sueldo mínimo realizando un "select"

- Se necesita incrementar los sueldos en forma proporcional, en un 10% cada vez y controlar que el sueldo mínimo no supere los $900. Emplee la sintaxis "if CONDICION then exit"

- Muestre el sueldo mínimo realizando un "select"
*/

declare 
    cont number:= 0;
    maxim number;
begin
    loop
        update empleados55 set sueldo = sueldo + (sueldo * 0.05);
        cont:= cont + 1;
        select max(sueldo) into maxim from empleados55;
        exit when maxim > 1600;
    end loop;
    dbms_output.put_line(cont);
end;
/
        
/* Se necesita incrementar los sueldos en forma proporcional, en un 10% cada vez y controlar que el sueldo mínimo no supere los $900. 
Emplee la sintaxis "if CONDICION then exit"
*/

declare 
    cont number:= 0;
    mini number;
begin
    loop
        select min(sueldo) into mini from empleados55;
        if(mini + mini * 0.1 > 900) then exit;
        else
            update empleados55 set sueldo = sueldo + (sueldo * 0.1);
        end if;
    end loop;
    dbms_output.put_line(cont);
end;
/


/*-------------------------------------------------------------------------USO DE FOR----------------------------------------------------------------------*/

/* En el siguiente ejemplo se muestra la tabla del 3. La variable "f" comienza en cero (límite inferior del for) y se va incrementando de a uno; el ciclo se 
repite hasta que "f" llega a 5 (límite superior del for), cuando llega a 6, el bucle finaliza.*/
  set serveroutput on;
 begin
  for f in 0..10 loop
   dbms_output.put_line('3x'||to_char(f)||'='||to_char(f*3));
  end loop;
 end;
 /
 
 /*Si queremos que el contador se decremente en cada repetición, en lugar de incrementarse, debemos colocar "reverse" luego de "in" y antes del límite inferior; 
 el contador comenzará por el valor del límite superior y finalizará al llegar al límite inferior decrementando de a uno. En este ejemplo mostramos la tabla del 
 3 desde el 5 hasta el cero*/
  begin
  for f in reverse 0..10 loop
   dbms_output.put_line('3x'||to_char(f)||'='||to_char(f*3));
  end loop;
 end;
 /
 
 /*Se pueden colocar "for" dentro de otro "for". Por ejemplo, con las siguientes líneas imprimimos las tablas del 2 y del 3 del 1 al 9*/
 
set serveroutput on;
 begin
  for f in 2..3 loop
   dbms_output.put_line('tabla del '||to_char(f));
   for g in 1..9 loop
     dbms_output.put_line(to_char(f)||'x'||to_char(g)||'='||to_char(f*g));
   end loop;--fin del for g
  end loop;--fin del for f
end;
/

/*Con la estructura repetitiva "for... loop" que vaya del 1 al 20, muestre los números pares.
Dentro del ciclo debe haber una estructura condicional que controle que el número sea par y si lo es, lo imprima por pantalla.*/

set serveroutput on;
begin
    for f in 1..20 loop
        if mod(f,2) = 0 then
            dbms_output.put_line('Número par: ' || to_char(f));
        end if;
    end loop;
end;
/
 
 
/* 
Con la estructura repetitiva "for... loop" muestre la sumatoria del número 5; la suma de todos los números del 1 al 5. Al finalizar el ciclo 
debe mostrarse por pantalla la sumatoria de 5 (15)
*/
declare
    suma number:= 0;
begin
    for f in 1..5 loop
        suma := suma + f;
    end loop;
    dbms_output.put_line('La sumatoria de ' || to_char(5) || ' es: '|| to_char(suma));
end;
/

/*
Cree una función que reciba un valor entero y retorne el factorial de tal número; el factorial se obtiene multiplicando el 
valor que recibe por el anterior hasta llegar a multiplicarlo por uno) Llame a la función creada anteriormente y obtenga el factorial de 5 y de 4 (120 y 24)
*/

create or replace function f_factorial_num (valor number)
    return number
is
    factorial number(5);
begin
    factorial:=1;
    for f in 1..valor loop
        factorial := factorial * f;
    end loop;
    return factorial;
end;
/

create or replace function f_factorial_num_rev (valor number)
    return number
is
    factorial number:=1;
begin
    for f in reverse 1..valor loop
        factorial := factorial * f;
    end loop;
    return factorial;
end;
/

select f_factorial_num(5) from dual; --120
select f_factorial_num(4) from dual; --24

select f_factorial_num_rev(5) from dual; --120
select f_factorial_num_rev(4) from dual; --24


/*
Cree un procedimiento que reciba dos parámetros numéricos; el procedimiento debe mostrar la tabla de multiplicar del número enviado como primer argumento, 
desde el 1 hasta el númeo enviado como segundo argumento. Emplee "for"
Ejecute el procedimiento creado anteriormente enviándole los valores necesarios para que muestre la tabla del 6 hasta el 20
Ejecute el procedimiento creado anteriormente enviándole los valores necesarios para que muestre la tabla del 9 hasta el 10
*/

create or replace procedure proc_for_ (val1 number,val2 number)
as
    multi number:=1;
begin
    dbms_output.put_line('Tabla del ' || to_char(val1));
    for f in 1..val2 loop
    dbms_output.put_line(to_char(val1) || ' x '|| to_char(f) || '= ' || to_char(val1*f));
    end loop;
end;
/

exec proc_for_(6,20);
exec proc_for_(9,10);




/*-------------------------------------------------------WHILE LOOP--------------------------------------------------------------------*/
/*
La diferencia entre "while...loop" y "for...loop" es que en la segunda se puede establecer la cantidad de repeticiones del bucle con el 
valor inicial y final. Además, el segundo siempre se ejecuta, al menos una vez, en cambio el primero puede no ejecutarse nunca, caso en 
el cual al evaluar la condicion por primera vez resulte falsa.
*/

/*tabla del 3 hasta el 5*/
 set serveroutput on;
 execute dbms_output.enable (20000);
declare
 numero number:=0;
 resultado number;
begin
  while numero<=5 loop
   resultado:=3*numero;
   dbms_output.put_line('3*'||to_char(numero)||'='||to_char(resultado));
   numero:=numero+1;
  end loop;
end;
/
