
SELECT  employee_name,
        employee_lastname,
        employee_phone,
        employee_phone2,
        employee_email,
        employee_address,
        employee_dui,
        employee_nit,
        employee_code,
        employee_start_date,
        employee_username,
        employee_password,
        rol_id, 
        workshop_id,
        employee_urlimg,
        employee_active,
        country_code,
        is_sena_certified,
        created_at  FROM public."EMPLOYEES" 
where workshop_id = 200;

--UPDATE "EMPLOYEES"
--SET employee_password = 'taller'
--WHERE employee_id = 134;
