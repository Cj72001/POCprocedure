CREATE TABLE IF NOT EXISTS CATEGORIES (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(255),
    workshop_id INT,
    category_active INT,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

select * from "BRANDS" where workshop_id = 200;
select * from "INVOICE_TYPES" where workshop_id = 200;
select * from "MODELS" where workshop_id = 200;
select * from "PACKAGE_PROCESS" where workshop_id = 200;
select * from "PACKAGES" where workshop_id = 200;
select * from "PROCESS" where workshop_id = 200;
select * from "SCREEN_ROLES" where workshop_id = 200;
select * from "SERIES" where workshop_id = 200;
select * from "SERVICE_TYPES" where workshop_id = 200;
select * from "VEHICLE_TYPES" where workshop_id = 200;
select * from "CATEGORIES" where workshop_id = 200;

--DELETES
call delete_workshop(200);
delete from "BRANDS" where workshop_id = 60;
delete from "INVOICE_TYPES" where workshop_id = 60;
delete from "MODELS" where workshop_id = 60;
delete from "PACKAGES" where workshop_id = 60;
delete from "PROCESS" where workshop_id = 60;

delete from "PACKAGE_PROCESS" where package_id in(
select package_id from "PACKAGES" where workshop_id = 60);

delete from "SERIES" where workshop_id = 60;
delete from "SERVICE_TYPES" where workshop_id = 60;
delete from "VEHICLE_TYPES" where workshop_id = 60;
delete from "CATEGORIES" where workshop_id = 60;

