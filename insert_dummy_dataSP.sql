
CREATE OR REPLACE PROCEDURE insert_dummy_data()
LANGUAGE plpgsql
AS $$
BEGIN

    INSERT INTO PACKAGES (package_name, package_price, service_type_id, workshop_id, package_active, created_at, update_at) 
    VALUES ('Paquete 1', 100.0, 1, 1, 1, '2023-01-01', '2023-01-02');

    INSERT INTO PACKAGE_PROCESS (package_id, process_id, process_sequence) 
    VALUES (1, 1, 1);

    INSERT INTO PROCESS (process_name, process_estimated_time, process_price, workshop_id, process_active, created_at, update_at) 
    VALUES ('Proceso 1', 60, 200.0, 1, 1, '2023-01-01', '2023-01-02');

    INSERT INTO SCREENS (screen_name, screen_code) 
    VALUES ('Pantalla 1', 101);

    INSERT INTO SCREEN_ROLES (screen_id, rol_id, can_read, can_write, can_edit, can_delete, workshop_id) 
    VALUES (1, 1, 1, 1, 1, 1, 1);
END;
$$;













---------------------------------------------

    select * from PACKAGES;
    select * from PACKAGE_PROCESS;
    select * from PROCESS;
    select * from SCREENS;
    select * from SCREEN_ROLES;

    delete from PACKAGES;
	delete from PACKAGE_PROCESS;
	delete from PROCESS;
	delete from SCREENS;
	delete from SCREEN_ROLES;
