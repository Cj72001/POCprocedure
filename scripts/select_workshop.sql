SELECT workshop_id,
        workshop_name,
        workshop_address,
        city_id,
        workshop_latitude,
        workshop_longitude,
        workshop_urlimg,
        workshop_phone,
        workshop_email,
        workshop_start_subscription,
        subscription_package_id,
        workshop_active,
        orders_limit,
        workshop_type,
        country_code FROM public."WORKSHOPS" where workshop_id = 200;

--UPDATE "WORKSHOPS"
--SET workshop_grade = '0'
--WHERE workshop_id = 200;