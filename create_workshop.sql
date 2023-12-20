CREATE OR REPLACE PROCEDURE CREATE_WORKSHOP(
    p_workshop_id INT, 
    p_country_code INT) 
    LANGUAGE plpgsql AS $$ 
	DECLARE 
    invoice_type_ids INT [],
	brand_ids INT [],
	motorcycle_type_id INT,
	p_service_type_id INT,
	p_currency_factor DOUBLE PRECISION,
	package_ids INT [],
	process_ids INT [];


BEGIN 
--Create invoice types
--List<InvoiceType> createdInvoiceTypes = invoiceTypeRepository.saveAll(GenerateInvoiceTypes.generate(createdWorkshopId));
INSERT INTO
    "INVOICE_TYPES" (
        "invoice_type_name",
        "invoice_type_code",
        "invoice_type_active",
        "workshop_id",
        "created_at",
        "updated_at"
    )
VALUES (
        'Ticket',
        1,
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP
    ), (
        'Factura comercial',
        2,
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP
    ), (
        'Crédito fiscal',
        3,
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP
    ) RETURNING invoice_type_id INTO invoice_type_ids;
--Create vehicles types
--List<VehicleType> createdVehicleTypes = vehicleTypeRepository.saveAll(GenerateVehicleTypes.generate(createdWorkshopId));
INSERT INTO
    "VEHICLE_TYPES" (
        "vehicle_type_name",
        "vehicle_type_active",
        "workshop_id",
        "created_at",
        "updated_at"
    )
VALUES (
        'AUTOMÓVIL',
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP
    ), (
        'MICROBÚS',
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP
    ), (
        'PANEL',
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP
    ), (
        'AUTOBÚS',
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP
    ), (
        'CAMIÓN',
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP
    ), (
        'CABEZAL',
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP
    ), (
        'MOTOCICLETA',
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP
    ), (
        'CUADRIMOTO',
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP
    ), (
        'TRICIMOTO',
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP
    ), (
        'PICK UP',
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP
    ), (
        'REMOLQUE',
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP
    );
--Create series (invoice types needed)
--serieRepository.saveAll(GenerateSeries.generate(createdWorkshopId, createdInvoiceTypes));

--Obtener lista de invoice_type_id para el workshop_id dado
-- SELECT
--     ARRAY_AGG(invoice_type_id) INTO invoice_type_ids
-- FROM "INVOICE_TYPES"
-- WHERE
--     workshop_id = p_workshop_id;

INSERT INTO
    "SERIES" (
        "serie_number",
        "serie_begin",
        "serie_end",
        "serie_actual_number",
        "serie_length",
        "serie_active",
        "workshop_id",
        "invoice_type_id",
        "created_at",
        "updated_at"
    )
VALUES (
        'Ticket',
        1,
        1000000,
        1,
        1000000,
        1,
        p_workshop_id,
        invoice_type_ids [1],
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP
    ), (
        'Factura comercial',
        1,
        1000000,
        1,
        1000000,
        1,
        p_workshop_id,
        invoice_type_ids [2],
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP
    ), (
        'Crédito fiscal',
        1,
        1000000,
        1,
        1000000,
        1,
        p_workshop_id,
        invoice_type_ids [3],
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP
    );
--Create brands
--List<Brand> createdBrands = brandRepository.saveAll(GenerateBrands.generate(createdWorkshopId));
INSERT INTO
    "BRANDS" (
        "brand_name",
        "brand_active",
        "workshop_id",
        "created_at",
        "updated_at",
        "brand_logo_url"
    )
VALUES (
        'AHM',
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP,
        'https://res.cloudinary.com/dhbfl4v4f/image/upload/v1696882285/brands/ihw3o2kvbi2xvdvzcazq.png'
    ), (
        'AKT',
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP,
        'https://res.cloudinary.com/dhbfl4v4f/image/upload/v1696882287/brands/ttkkiozcko4etaeigivl.png'
    ), (
        'ASIA HERO',
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP,
        'https://res.cloudinary.com/dhbfl4v4f/image/upload/v1696882285/brands/yaq8alrwklxl0endrqoi.png'
    ), (
        'BAJAJ',
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP,
        'https://res.cloudinary.com/dhbfl4v4f/image/upload/v1696882288/brands/n91xjnt7qahylxel45bl.png'
    ), (
        'BENELLI',
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP,
        'https://res.cloudinary.com/dhbfl4v4f/image/upload/v1696882287/brands/drdacjudiecneojlp44o.png'
    ), (
        'CFMOTO',
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP,
        'https://res.cloudinary.com/dhbfl4v4f/image/upload/v1696882285/brands/jds8mki7fe9djwcdcmke.png'
    ), (
        'CROSSFIRE',
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP,
        'https://res.cloudinary.com/dhbfl4v4f/image/upload/v1696882285/brands/wiesdihfufnjbds5pqqa.png'
    ), (
        'DAYUN',
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP,
        'https://res.cloudinary.com/dhbfl4v4f/image/upload/v1696882285/brands/k1snzjxyacaivk125ceg.png'
    ), (
        'FREEDOM',
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP,
        'https://res.cloudinary.com/dhbfl4v4f/image/upload/v1696882288/brands/jpnng8brkby333fmx2tg.png'
    ), (
        'GENESIS',
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP,
        'https://res.cloudinary.com/dhbfl4v4f/image/upload/v1696882286/brands/ekfzias2qamxlkmf59ef.png'
    ), (
        'HAOJUE',
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP,
        'https://res.cloudinary.com/dhbfl4v4f/image/upload/v1696882285/brands/eamtznhppd5mcm6vtqoa.png'
    ), (
        'HERO',
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP,
        'https://res.cloudinary.com/dhbfl4v4f/image/upload/v1696882288/brands/tzjnh1i816h5dvvprwm8.png'
    ), (
        'HONDA',
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP,
        'https://res.cloudinary.com/dhbfl4v4f/image/upload/v1696882288/brands/sqwwhccegi7rl3u6dbbn.png'
    ), (
        'HYUNDAI',
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP,
        'https://res.cloudinary.com/dhbfl4v4f/image/upload/v1696882284/brands/zihmp35ly61gelrhsx8c.png'
    ), (
        'JIALING',
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP,
        'https://res.cloudinary.com/dhbfl4v4f/image/upload/v1696882284/brands/yl0ia8eqi3jdfe3o8dz0.png'
    ), (
        'KATANA',
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP,
        'https://res.cloudinary.com/dhbfl4v4f/image/upload/v1696882287/brands/hxeyfxhyodb95isv4uzy.png'
    ), (
        'KAWASAKI',
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP,
        'https://res.cloudinary.com/dhbfl4v4f/image/upload/v1696882286/brands/ttkbqihizq9naarh9of7.png'
    ), (
        'KEEWAY',
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP,
        'https://res.cloudinary.com/dhbfl4v4f/image/upload/v1696882286/brands/f3aq94cvzpkzenm5guby.png'
    ), (
        'KTM',
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP,
        'https://res.cloudinary.com/dhbfl4v4f/image/upload/v1696882287/brands/qfwc2j1k5pj0lpb0swj1.png'
    ), (
        'LONCIN',
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP,
        'https://res.cloudinary.com/dhbfl4v4f/image/upload/v1696882283/brands/vxmuzc5bzsebngovb6zi.png'
    ), (
        'MRT',
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP,
        'https://res.cloudinary.com/dhbfl4v4f/image/upload/v1696882285/brands/lge01iv5brfqprfvrvzz.png'
    ), (
        'SANLG',
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP,
        'https://res.cloudinary.com/dhbfl4v4f/image/upload/v1696882286/brands/gpgv11wd8pj7bdyzezyh.png'
    ), (
        'SERPENTO',
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP,
        'https://res.cloudinary.com/dhbfl4v4f/image/upload/v1696882287/brands/o3ra6kgyu032ijdck6lh.png'
    ), (
        'SHINERAY',
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP,
        'https://res.cloudinary.com/dhbfl4v4f/image/upload/v1696882283/brands/xcsth4ixysgajjalf9mu.png'
    ), (
        'SKYGO',
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP,
        'https://res.cloudinary.com/dhbfl4v4f/image/upload/v1696882286/brands/mdmafcj6x32zuooxvotx.png'
    ), (
        'SUKIDA',
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP,
        'https://res.cloudinary.com/dhbfl4v4f/image/upload/v1697143466/brands/bpwkuc89y33ucdzem33p.png'
    ), (
        'SUZUKI',
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP,
        'https://res.cloudinary.com/dhbfl4v4f/image/upload/v1696882288/brands/ipodtwdkyhg8vobrwcly.png'
    ), (
        'SYM',
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP,
        'https://res.cloudinary.com/dhbfl4v4f/image/upload/v1697143466/brands/bpwkuc89y33ucdzem33p.png'
    ), (
        'TESLA',
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP,
        'https://res.cloudinary.com/dhbfl4v4f/image/upload/v1696888226/brands/ha4ntixklq3ymkjc8a0g.png'
    ), (
        'TVS',
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP,
        'https://res.cloudinary.com/dhbfl4v4f/image/upload/v1696882286/brands/fttnkbzt4tvrk0aselmf.png'
    ), (
        'UM',
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP,
        'https://res.cloudinary.com/dhbfl4v4f/image/upload/v1696882286/brands/yjlpwg7bo3ur6qf5jmlc.png'
    ), (
        'UNITED MOTORS',
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP,
        'https://res.cloudinary.com/dhbfl4v4f/image/upload/v1696882286/brands/yjlpwg7bo3ur6qf5jmlc.png'
    ), (
        'VENTO',
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP,
        'https://res.cloudinary.com/dhbfl4v4f/image/upload/v1696882285/brands/c5vnaq02wevc41wibunr.png'
    ), (
        'YAMAHA',
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP,
        'https://res.cloudinary.com/dhbfl4v4f/image/upload/v1696882288/brands/wgv7nshzko5wqgnqj3io.png'
    ), (
        'YUMBO',
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP,
        'https://res.cloudinary.com/dhbfl4v4f/image/upload/v1696882285/brands/wfs4jhra8qebph6ytqph.png'
    ) RETURNING brand_id INTO brand_ids;

--Create models
--modelRepository.saveAll(GenerateModels.generate(createdWorkshopId, createdBrands, createdVehicleTypes));

-- SELECT
--     ARRAY_AGG(invoice_type_id) INTO invoice_type_ids
-- FROM "INVOICE_TYPES"
-- WHERE
--     workshop_id = p_workshop_id;

SELECT
    vehicle_type_id INTO motorcycle_type_id
FROM VEHICLE_TYPES
where
    workshop_id = p_workshop_id
    AND vehicle_type_name = 'MOTOCICLETA';

INSERT INTO
    "MODELS" (
        "model_name",
        "brand_id",
        "vehicle_type_id",
        "model_active",
        "workshop_id",
        "created_at",
        "updated_at"
    )
VALUES (
        'CARGO 125CC',
        brand_ids [1],
        motorcycle_type_id,
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP
    ),
    --TODO: Repetir para los demas modelos (
        'CARGO 125CC',
        brand_ids [34],
        motorcycle_type_id,
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP
    );
--Create service types
--List<ServiceType> createdServiceTypes = serviceTypeRepository.saveAll(GenerateServiceTypes.generate(createdWorkshopId));
INSERT INTO
    "SERVICE_TYPES" (
        "service_type_name",
        "service_type_active",
        "workshop_id",
        "created_at",
        "updated_at"
    )
VALUES (
        'TALLER',
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP
    ), (
        'VENTAS',
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP
    ), (
        'PINTURA',
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP
    ), (
        'CARWASH',
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP
    );

--Create package
--List<Package> createdPackages = packageRepository.saveAll(GeneratePackages.generate(createdWorkshopId, createdServiceTypes, countryCode));
--Id del servicio, en este caso TALLER

SELECT
    service_type_id INTO p_service_type_id
FROM "SERVICE_TYPES"
WHERE
    workshop_id = p_workshop_id
    AND service_type_name = 'TALLER';

--Definiendo el factor de conversion en funcion del codigo de pais
--Factor de conversion a pesos colombianos
IF p_country_code = 57 THEN 
p_currency_factor := 3500.0;
ELSE 
--Sin conversion para otras monedas
p_currency_factor := 1.0;
END IF;

INSERT INTO
    "PACKAGES" (
        "package_name",
        "package_price",
        "service_type_id",
        "package_active",
        "workshop_id",
        "created_at",
        "updated_at"
    )
VALUES (
        'Mantenimiento Basico',
        p_currency_factor * 15.0,
        p_service_type_id,
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP
    ), (
        'MANTENIMIENTO BASICO',
        p_currency_factor * 12.0,
        p_service_type_id,
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP
    ), (
        'MANTENIMIENTO BASICO TOURING',
        p_currency_factor * 2.0,
        p_service_type_id,
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP
    ), (
        'MANTENIMIENTO MEDIO TOURING',
        p_currency_factor * 25.0,
        p_service_type_id,
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP
    ), (
        'TOURING MAYOR',
        p_currency_factor * 28.9,
        p_service_type_id,
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP
    ), (
        'MANTENIMIENTO MAYOR TOURING',
        p_currency_factor * 35.0,
        p_service_type_id,
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP
    ), (
        'MTTO MEDIO NAKED',
        p_currency_factor * 35.0,
        p_service_type_id,
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP
    ), (
        'NAKED MAYOR',
        p_currency_factor * 38.9,
        p_service_type_id,
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP
    ),
    --TODO: Repetir para los demas packages 
    (
        'MTTO BASICO CROSS',
        p_currency_factor * 20.0,
        v_service_type_id,
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP
    ) RETURNING package_id INTO package_ids;


--Create process
--List<Process> createdProcesses = processRepository.saveAll(GenerateProcesses.generate(createdWorkshopId, countryCode));
INSERT INTO
    "PROCESS" (
        process_name,
        process_estimated_time,
        process_price,
        process_active,
        workshop_id,
        created_at,
        updated_at
    )
VALUES (
        'Cambio de cable de velocímetro',
        10,
        p_currency_factor * 2.0,
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP
    ), (
        'Cambio de aceite',
        10,
        p_currency_factor * 1.0,
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP
    ), (
        'Calibrado de válvula nivel 1',
        30,
        p_currency_factor * 6.0,
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP
    ), (
        'Desarmar',
        30,
        p_currency_factor * 7.7,
        1,
        p_workshop_id,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP
    ) RETURNING process_id INTO process_ids;

--Create package process
--processByPackageRepository.saveAll(GenerateProcessesByPackages.generate(createdWorkshopId, createdPackages, createdProcesses));
INSERT INTO
    "PACKAGE_PROCESS" (
        package_id,
        process_id,
        process_sequence
    )
VALUES (
        packages_ids [1],
        process_ids [4],
        1
    ), (
        packages_ids [77],
        process_ids [5],
        1
    ), (
        packages_ids [73],
        process_ids [5],
        4
    ), (
        packages_ids [74],
        process_ids [10],
        17
    ), (
        packages_ids [67],
        process_ids [10],
        2
    ), (
        packages_ids [87],
        process_ids [10],
        5
    ), (
        packages_ids [83],
        process_ids [10],
        11
    ), (
        packages_ids [82],
        process_ids [10],
        8
    ), (
        packages_ids [77],
        process_ids [10],
        3
    ), (
        packages_ids [79],
        process_ids [10],
        2
    ),
    --TODO: Repetir para los demas processes de packages 
    (
        packages_ids [66],
        process_ids [10],
        9
    );

COMMIT;
END;
$$;
