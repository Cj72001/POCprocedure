CREATE TABLE IF NOT EXISTS CATEGORIES (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(255),
    workshop_id INT,
    category_active INT,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

select * from BRANDS;
select * from INVOICE_TYPES;
select * from MODELS;
select * from PACKAGE_PROCESS;
select * from PACKAGES;
select * from PROCESS;
select * from SCREEN_ROLES;
select * from SERIES;
select * from SERVICE_TYPES;
select * from VEHICLE_TYPES;
select * from CATEGORIES;

