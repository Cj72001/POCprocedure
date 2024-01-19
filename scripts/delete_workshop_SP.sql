
create or replace procedure delete_workshop(workshop_id_to_delete int)
as $$
declare 
wcontador INT;
wp_ids_to_delete INT[];

begin 
--Primero verificamos si exite el propietario
select count(*) into wcontador from public."WORKSHOPS" where workshop_id = workshop_id_to_delete;

if wcontador = 0 
then raise exception 'La workshop con ID: %, no existe', workshop_id_to_delete;

else
-------------------------------------------------------------------------------------
--Eliminando los registros de las tablas que no le hacen referencia, 
--y ellas hacen referencia a una tabla

delete from  public."MEASURE_UNITS" where workshop_id = workshop_id_to_delete;
delete from  public."SERVICE_TYPES" where workshop_id = workshop_id_to_delete;
delete from  public."LOGOS" where workshop_id = workshop_id_to_delete;

delete from  public."WORK_ORDER_DETAILS" where work_order_id in
(select work_order_id from public."WORK_ORDERS" where workshop_id = workshop_id_to_delete);

delete from  public."PROVIDER_CONTACTS" where provider_id in
(select provider_id from "PROVIDERS" where workshop_id = workshop_id_to_delete);

delete from  public."BUDGET_DETAILS" where budget_id in
(select budget_id from public."BUDGETS" where budget_id in 
(select budget_id from public."WORK_ORDERS" where work_order_id = workshop_id_to_delete));

delete from public."RECEPTION_PHOTOS" where reception_id in
(select reception_id from public."RECEPTIONS" where workshop_id = workshop_id_to_delete);

delete from public."ACTIVITIES" where process_id in
(select process_id from public."PROCESS" where workshop_id = workshop_id_to_delete);

--Eliminando los registros de las tablas que no le hacen referencia, 
--y ellas hacen referencia a dos tabla

--esta tabla hace referencia a RECEPTIONS y al ITEMS que recibio
--se elimina en base a las recepciones (puede ser en base a los items?)

delete from public."ITEM_VALUES" where reception_id in
(select reception_id from public."RECEPTIONS" where workshop_id = workshop_id_to_delete);

delete from public."OPERATIONS" where workshop_id = workshop_id_to_delete;

delete from public."USERS_APP_VEHICLES" where user_app_id in
(select user_app_id from public."USERS_APP" where person_id in 
(select person_id from public."PERSON_WORKSHOPS" where workshop_id = workshop_id_to_delete));

--esta tabla hace referencia a las WORK_ORDER_NOTIFICATION para
--el EMPLOYEE, por lo que se eliminara en base a las WORK_ORDER_NOTIFICATION
delete from public."WORK_ORDER_VIEW_NOTIFICATION" where work_order_notification_id in
(select work_order_notification_id from public."WORK_ORDER_NOTIFICATION" where work_order_id in 
(select work_order_id from public."WORK_ORDERS" where workshop_id = workshop_id_to_delete));

--esta tabla hace referencia a los PROCESS de los PACKAGES,
--se eliminara en base a los PACKAGES
delete from public."PACKAGE_PROCESS" where package_id in
(select package_id from public."PACKAGES" where workshop_id = workshop_id_to_delete);


--Eliminamos los registros de la tabla que hace referencia a VEHICLES y PERSONS
delete from public."PERSON_VEHICLES" where person_id in 
(select person_id from public."PERSON_WORKSHOPS" where workshop_id = workshop_id_to_delete);



--Agregamos los ids de las PERSONS a eliminar despues,
--en funcion de la tabla PERSON_WORKSHOPS:
select array_agg(person_id) into wp_ids_to_delete from public."PERSON_WORKSHOPS" where workshop_id = workshop_id_to_delete;

--Eliminamos los registros de la tabla que hace referencia a PERSONS:
delete from public."PERSON_WORKSHOPS" where workshop_id = workshop_id_to_delete;


--(Al eliminar las tablas anteriores resulta que:) no son referenciados y hacen una sola referencia:
--Como eliminamos los registros de la tabla PERSONS_WORKSHOPS, no tenemos referencia indirecta
--lo haremos por medio del array "wp_ids_to_delete"
delete from public."USERS_APP" where person_id = any(wp_ids_to_delete);

delete from public."ITEMS" where workshop_id = workshop_id_to_delete;

--eliminacion inderecto por medio de WORK_ORDERS
delete from public."WORK_ORDER_NOTIFICATION" where work_order_id in
(select work_order_id from public."WORK_ORDERS" where workshop_id = workshop_id_to_delete);


--Eliminando los registros de las tablas que no le hacen referencia, 
--y ellas hacen referencia a tres tablas
delete from public."COMMENTS" where work_order_id in
(select work_order_id from public."WORK_ORDERS" where workshop_id = workshop_id_to_delete);

delete from public."SCREEN_ROLES" where workshop_id = workshop_id_to_delete;
--tiene relacion con PROCESS y INVOICES, se hare en funcion de los INVOICES
delete from public."INVOICE_DETAILS" where invoice_id in
(select invoice_id from public."INVOICES" where workshop_id = workshop_id_to_delete);

--tiene relacion con PROCESS y WORK_ORDERS, se hare en funcion de WORK_ORDERS
delete from public."TIME_TRACKER" where work_order_id in
(select work_order_id from public."WORK_ORDERS" where workshop_id = workshop_id_to_delete);
delete from public."PROCESS" where workshop_id = workshop_id_to_delete;
delete from public."PRODUCTS" where workshop_id = workshop_id_to_delete;
delete from public."CATEGORIES" where workshop_id = workshop_id_to_delete; --ADDED
delete from public."PROVIDERS" where workshop_id = workshop_id_to_delete;
delete from public."INVOICES" where workshop_id = workshop_id_to_delete;
delete from public."SERIES" where workshop_id = workshop_id_to_delete;
delete from public."INVOICE_TYPES" where workshop_id = workshop_id_to_delete; --ADDED
delete from public."WORK_ORDERS" where workshop_id = workshop_id_to_delete;
delete from public."BUDGETS" where package_id in
(select package_id from public."PACKAGES" where workshop_id = workshop_id_to_delete);
delete from public."PACKAGES" where workshop_id = workshop_id_to_delete; 
delete from public."SERVICE_TYPES" where workshop_id = workshop_id_to_delete;
delete from public."EMPLOYEES" where workshop_id = workshop_id_to_delete;
delete from public."RECEPTIONS" where workshop_id = workshop_id_to_delete;
delete from public."VEHICLES" where model_id in
(select model_id from public."MODELS" where workshop_id = workshop_id_to_delete);
delete from public."COLORS" where workshop_id = workshop_id_to_delete;
delete from public."MODELS" where workshop_id = workshop_id_to_delete;
delete from public."VEHICLE_TYPES" where workshop_id = workshop_id_to_delete;
delete from public."BRANDS" where workshop_id = workshop_id_to_delete;

delete from public."PERSONS" where person_id = any(wp_ids_to_delete);
delete from public."CONTRIBUTOR_TYPES" where workshop_id = workshop_id_to_delete;


--Por ULTIMO eliminamos el registro del taller en la tabla WORKSHOPS
delete from public."WORKSHOPS" where workshop_id = workshop_id_to_delete;
RAISE NOTICE 'Workshop eliminada correctamente:%', workshop_id_to_delete;

end if;

--No es necesario que le ponga then rollback, porque lo hace implicito en una exception
exception when others 
then raise exception 'Ocurrio un error eliminando la workshop. Error: %', sqlerrm;
commit;

end;
$$ language plpgsql;






