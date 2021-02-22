/*-----------------FUNCIONES PARA FECHAS Y HORAS---------------------------------*/
select add_months('10/06/2020',5) as fechas from dual; --agrega los mese singresados
select months_between('20/07/2021','19/05/2020') as fecha from dual; -- retorna el nro de meses entre las fechas ingresadas
select last_day('10/06/2020') as fechas from dual; --muestra el ultimo día del mes ingresado
select next_day('10/02/2021','LUNES') as fechas from dual; --retorna la fecha del siguiente día ingresado
select current_date from dual; --retorna fecha actual
select current_timestamp from dual; --retorna fecha y hora actual
select sysdate from dual; --retorna fecha del servidor oracle
select systimestamp from dual; --retorna fecha y hora del servidor oracle
select to_date('05-SEP-2019 10:00 AM','DD-MON-YYYY HH:MI AM') FROM DUAL;
select extract(year from sysdate) from dual; -- extrae la parte especificada de la fecha ingresada

/*CONVERTIR FORMATO DE FECHA A palabras en ESPAÑOL*/
select to_char(sysdate,'day dd "de" month "de" yyyy','nls_date_language=spanish') from dual;

/*CONVERTIR FORMATO DE FECHA A  palabras en INGLÉS*/
select to_char(sysdate,'day dd "de" month "de" yyyy','nls_date_language=english') from dual;