select * from "WORKSHOPS" where workshop_id = 200;
select * from "EMPLOYEES" where workshop_id = 200;

select * from "BRANDS" where workshop_id = 200;
select * from "INVOICE_TYPES" where workshop_id = 200; --ne
select * from "MODELS" where workshop_id = 200;
select * from "PACKAGE_PROCESS" where package_id in
(select package_id from "PACKAGES" where workshop_id = 200);
select * from "PACKAGES" where workshop_id = 200;
select * from "PROCESS" where workshop_id = 200;
select * from "SCREEN_ROLES" where workshop_id = 200;
select * from "SERIES" where workshop_id = 200;
select * from "SERVICE_TYPES" where workshop_id = 200;
select * from "VEHICLE_TYPES" where workshop_id = 200;
select * from "CATEGORIES" where workshop_id = 200; --ne

--DELETE
call delete_workshop(200);





