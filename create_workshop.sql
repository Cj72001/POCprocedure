--call create_workshop(1, 503, 3884.84);

CREATE OR REPLACE PROCEDURE create_workshop(p_workshop_id INT, p_country_code INT, p_currency_parameter NUMERIC) 
    LANGUAGE PLPGSQL
    AS $$
    DECLARE 
    invoice_type_ids INT [] := '{}'; 
	invoice_type_record RECORD;
	brand_ids INT [] := '{}';
	motorcycle_type_id INT;
	p_service_type_id INT;
	p_currency_factor NUMERIC;
	package_ids INT [] := '{}';
	process_ids INT [] := '{}';
	temp_invoice_id INT;  -- Variable temporal para almacenar un solo ID

	BEGIN 

    --Create invoice types
	--List<InvoiceType> createdInvoiceTypes = invoiceTypeRepository.saveAll(GenerateInvoiceTypes.generate(createdWorkshopId));
	INSERT INTO
	    INVOICE_TYPES (
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
	    );
		
		--Guardando los ids
    	SELECT ARRAY(SELECT invoice_type_id FROM INVOICE_TYPES WHERE workshop_id = p_workshop_id)
    	INTO invoice_type_ids;

    	--Probando imprimir ids:
    	RAISE NOTICE 'IDs: %', invoice_type_ids;
		
	
	--Create vehicles types
	--List<VehicleType> createdVehicleTypes = vehicleTypeRepository.saveAll(GenerateVehicleTypes.generate(createdWorkshopId));
	INSERT INTO
	    VEHICLE_TYPES (
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
	    SERIES (
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
	    BRANDS (
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
	    );
		
		--Guardando los ids
    	SELECT ARRAY(SELECT brand_id FROM BRANDS WHERE workshop_id = p_workshop_id)
    	INTO brand_ids;

    	--Probando imprimir ids:
    	RAISE NOTICE 'IDs: %', brand_ids;


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
	    MODELS (
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
	    ), (
	        'CARGO 150CC',
	        brand_ids [1],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'FURIA 200CC',
	        brand_ids [1],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'RIDER 125CC',
	        brand_ids [1],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'TRX 250CC',
	        brand_ids [1],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'RTX 200CC',
	        brand_ids [2],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'AK 150CC',
	        brand_ids [2],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'TT 200',
	        brand_ids [2],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'RTX 150CC',
	        brand_ids [2],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'AK 150 R4',
	        brand_ids [2],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'AK 150 SL',
	        brand_ids [2],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'AK 200CC',
	        brand_ids [2],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'AK 180CC',
	        brand_ids [2],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'EVO 150 NE',
	        brand_ids [2],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'MOTORD 200',
	        brand_ids [3],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CARGO 125CC',
	        brand_ids [3],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'PULSAR 125 CC',
	        brand_ids [4],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'PLATINA 125CC',
	        brand_ids [4],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'PULSAR 180CC',
	        brand_ids [4],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'PULSAR 220CC',
	        brand_ids [4],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'BOXER 150CC',
	        brand_ids [4],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'PULSAR AS 150CC',
	        brand_ids [4],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'PULSAR NS 150CC',
	        brand_ids [4],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'PULSAR 135CC',
	        brand_ids [4],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'DISCOVER 150CC',
	        brand_ids [4],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'PULSAR NS 125',
	        brand_ids [4],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'QUTE',
	        brand_ids [4],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'DISCOVER 135',
	        brand_ids [4],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'PULSAR NS 160CC',
	        brand_ids [4],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'PULSAR 150CC',
	        brand_ids [4],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'PLATINA 100CC',
	        brand_ids [4],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'RE MAXIMA 220CC',
	        brand_ids [4],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'PULSAR AS 200CC',
	        brand_ids [4],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'PULSAR RS 200CC',
	        brand_ids [4],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'DOMINAR 400CC',
	        brand_ids [4],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'AVENGER 220CC',
	        brand_ids [4],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'DISCOVER 125CC',
	        brand_ids [4],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CT 100CC',
	        brand_ids [4],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'PULSAR NS 200CC',
	        brand_ids [4],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'TNT 135',
	        brand_ids [5],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        '302R',
	        brand_ids [5],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'TNT 25',
	        brand_ids [5],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'TRK 251',
	        brand_ids [5],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'RKR 180',
	        brand_ids [5],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        '150 TNT',
	        brand_ids [5],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'NK 150CC',
	        brand_ids [6],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CF 150CC',
	        brand_ids [7],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CF 250CC',
	        brand_ids [7],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'DY 125CC',
	        brand_ids [8],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'DY 150CC',
	        brand_ids [8],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'DY 200',
	        brand_ids [8],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'JH 100CC',
	        brand_ids [9],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'SPITZER 200CC',
	        brand_ids [9],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CRII',
	        brand_ids [9],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'LX 150-30',
	        brand_ids [9],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'F 51 200',
	        brand_ids [9],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'AVATAR 200CC',
	        brand_ids [9],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'SPITZER 150CC',
	        brand_ids [9],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'FENIX 125CC',
	        brand_ids [9],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'FALCON 250CC',
	        brand_ids [9],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'LOYALTY 125 CC',
	        brand_ids [9],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'WY 125CC',
	        brand_ids [9],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'MAVERICK 125CC',
	        brand_ids [9],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CR II',
	        brand_ids [9],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'SPITZER 250',
	        brand_ids [9],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'DEFENDER 200',
	        brand_ids [9],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CR1 150CC',
	        brand_ids [9],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'COLT 125CC',
	        brand_ids [9],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'FIRE 125CC',
	        brand_ids [9],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'FIRE 150CC',
	        brand_ids [9],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'NEW FIRE 150CC',
	        brand_ids [9],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'LX 150CC',
	        brand_ids [9],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'SUPER LIFE 150CC',
	        brand_ids [9],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'SPACE 125CC',
	        brand_ids [9],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CR4 250CC',
	        brand_ids [9],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'COLT 150',
	        brand_ids [9],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'HJ 150CC',
	        brand_ids [10],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'XM 250CC',
	        brand_ids [10],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'GTX 200CC',
	        brand_ids [10],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'XM125 GY B',
	        brand_ids [10],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'GX 250 R',
	        brand_ids [10],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'VM 125CC',
	        brand_ids [10],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'DA',
	        brand_ids [10],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'GXT 200',
	        brand_ids [10],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'HJ 125CC',
	        brand_ids [10],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'KA 150',
	        brand_ids [10],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'GXT 200CC',
	        brand_ids [10],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'HJ150-9A',
	        brand_ids [11],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'HUNK i3s 150CC',
	        brand_ids [12],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'SUPER SPLENODO 125CC',
	        brand_ids [12],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'HUNK 150',
	        brand_ids [12],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'HUNK 200',
	        brand_ids [12],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'SPLENDOR',
	        brand_ids [12],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'GLAMOUR 125CC',
	        brand_ids [12],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'GLAMOUR',
	        brand_ids [12],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'HUNK 150CC',
	        brand_ids [12],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'PLEASURE 125CC',
	        brand_ids [12],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'IGNITOR',
	        brand_ids [12],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'DAWN 150',
	        brand_ids [12],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'DASH',
	        brand_ids [12],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'DAWN 125',
	        brand_ids [12],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'ISMART 110CC',
	        brand_ids [12],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'THRILLER 200CC',
	        brand_ids [12],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'KARIZMA 230CC',
	        brand_ids [12],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'THRILLER 150CC',
	        brand_ids [12],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'ACHIEVER 150',
	        brand_ids [12],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'DAWN 150CC',
	        brand_ids [12],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'DAWN 125CC',
	        brand_ids [12],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'IGNITOR 125CC',
	        brand_ids [12],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'HUNK 200R',
	        brand_ids [12],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'KARIZMA ZMR',
	        brand_ids [12],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'T REX 150',
	        brand_ids [12],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'DREAM NEO 110CC',
	        brand_ids [13],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CG 200CC',
	        brand_ids [13],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CRF 230CC',
	        brand_ids [13],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'STORM 125CC',
	        brand_ids [13],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CB HORNET 160CC',
	        brand_ids [13],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'NXR 125CC',
	        brand_ids [13],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CB 125CC',
	        brand_ids [13],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CB UNICORN 160CC',
	        brand_ids [13],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'STORM 150CC',
	        brand_ids [13],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CBF 125CC',
	        brand_ids [13],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CGL 125CC',
	        brand_ids [13],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'SC125 CC ELITE',
	        brand_ids [13],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CB 190 R',
	        brand_ids [13],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CB 110CC',
	        brand_ids [13],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'NAVI 110',
	        brand_ids [13],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'XR 200 R',
	        brand_ids [13],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'V-MEN 125CC',
	        brand_ids [13],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'XR 250CC',
	        brand_ids [13],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CB 190CC',
	        brand_ids [13],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'GLH 125CC',
	        brand_ids [13],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CBX 250CC TWISTER',
	        brand_ids [13],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CB160F',
	        brand_ids [13],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CG 100CC',
	        brand_ids [13],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CBR 250CC',
	        brand_ids [13],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'SHADOW 150CC',
	        brand_ids [13],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CB1',
	        brand_ids [13],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CBR 300CC',
	        brand_ids [13],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CB110',
	        brand_ids [13],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CBF 110CC',
	        brand_ids [13],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CRF 250CC',
	        brand_ids [13],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CB INVICTA 150CC',
	        brand_ids [13],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'XR 150CC',
	        brand_ids [13],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'XL 200CC',
	        brand_ids [13],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'SHINE SP 125',
	        brand_ids [13],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CB 150 INVICT',
	        brand_ids [13],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'TUCSON',
	        brand_ids [14],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'JH 125 16',
	        brand_ids [15],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'JH 125CC',
	        brand_ids [15],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'JH 150CC',
	        brand_ids [15],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CG 150CC',
	        brand_ids [16],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CR 150',
	        brand_ids [16],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'EAGLE 250CC',
	        brand_ids [16],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'KN 160',
	        brand_ids [16],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'R1 200',
	        brand_ids [16],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'R1 200CC',
	        brand_ids [16],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'SMX 150',
	        brand_ids [16],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'SMX 200',
	        brand_ids [16],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        '650 R NINJA',
	        brand_ids [17],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'EN 650CC VULCAN',
	        brand_ids [17],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'ER 650 C NINJA',
	        brand_ids [17],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'EX 250CC',
	        brand_ids [17],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'EX 300 NINJA',
	        brand_ids [17],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'EX 400',
	        brand_ids [17],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'EX 650CC',
	        brand_ids [17],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'KX 250CC',
	        brand_ids [17],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'ZR 1000 B8F',
	        brand_ids [17],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAFE RACER 152CC',
	        brand_ids [18],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'K-LIGHT 202',
	        brand_ids [18],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'RK',
	        brand_ids [18],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'RK III 150',
	        brand_ids [18],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'RKR 180',
	        brand_ids [18],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'RKS 150CC',
	        brand_ids [18],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'RKV 125CC',
	        brand_ids [18],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'RKV 200CC',
	        brand_ids [18],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'SILVER BLADE 125CC',
	        brand_ids [18],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'SILVER BLADE 150CC',
	        brand_ids [18],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'SUPERLIGHT 200CC',
	        brand_ids [18],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'TX 200CC',
	        brand_ids [18],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'DUKE 390',
	        brand_ids [19],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'LX 150CC',
	        brand_ids [20],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'BULL 250CC',
	        brand_ids [21],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'BULL 4 W',
	        brand_ids [21],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'BULL 4W150',
	        brand_ids [21],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'HANDY 150',
	        brand_ids [21],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'RAD 125',
	        brand_ids [21],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'RAD 200',
	        brand_ids [21],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'TR 200',
	        brand_ids [21],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'TR 250CC',
	        brand_ids [21],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'TR 400CC',
	        brand_ids [21],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'VINTAGE  200 CC',
	        brand_ids [21],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'VINTAGE 400CC',
	        brand_ids [21],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'SL 110CC',
	        brand_ids [22],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'SL 125CC',
	        brand_ids [22],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'SL 150CC',
	        brand_ids [22],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'SL 6 200CC',
	        brand_ids [22],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'SLG 150CC',
	        brand_ids [22],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'VIPER 250CC',
	        brand_ids [23],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'ASPID 150CC',
	        brand_ids [23],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'BOA 150',
	        brand_ids [23],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'COBRA 150CC',
	        brand_ids [23],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'DEFENDER',
	        brand_ids [23],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'DRACO 200CC',
	        brand_ids [23],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'DRACO 250',
	        brand_ids [23],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'DRAGON 250CC',
	        brand_ids [23],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'DRAVIDIAN 150CC',
	        brand_ids [23],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'FORZA 150CC',
	        brand_ids [23],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'NAGA 200CC',
	        brand_ids [23],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'PREDATOR 250CC',
	        brand_ids [23],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'PYTHON',
	        brand_ids [23],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'RAPTOR',
	        brand_ids [23],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'RS2 125 CC',
	        brand_ids [23],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'SPIRIT 250CC',
	        brand_ids [23],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'TAYPAN 150CC',
	        brand_ids [23],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'YARA 200',
	        brand_ids [23],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'XY 150CC',
	        brand_ids [24],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'XY 250-7',
	        brand_ids [24],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'KP 150CC',
	        brand_ids [25],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'KPR 200',
	        brand_ids [25],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'KPR 200CC',
	        brand_ids [25],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'SG 150 11',
	        brand_ids [25],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'SG 150 13',
	        brand_ids [25],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'THUNDER 150',
	        brand_ids [25],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'SK 125CC',
	        brand_ids [26],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'AN 125CC',
	        brand_ids [27],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'AX 100CC',
	        brand_ids [27],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'C 50 BOULEVAR',
	        brand_ids [27],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'EN 125CC',
	        brand_ids [27],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'GIXXER 150 GS',
	        brand_ids [27],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'GIXXER 150CC',
	        brand_ids [27],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'GIXXER 155CC',
	        brand_ids [27],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'GN 125 F',
	        brand_ids [27],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'GN 125 H',
	        brand_ids [27],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'GN 125CC',
	        brand_ids [27],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'GSX 125CC',
	        brand_ids [27],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'SP 250 Z',
	        brand_ids [27],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'TS 125 ERZ',
	        brand_ids [27],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'NHX',
	        brand_ids [28],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'Model 3',
	        brand_ids [29],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'APACHE RTR 160CC',
	        brand_ids [30],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'APACHE RTR 180CC',
	        brand_ids [30],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'APACHE RTR 200CC',
	        brand_ids [30],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'DASH 125CC',
	        brand_ids [30],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'PHOENIX 125',
	        brand_ids [30],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'SCOOTY ZEST',
	        brand_ids [30],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'STAR SPORT 100CC',
	        brand_ids [30],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'STAR SPORT 125CC',
	        brand_ids [30],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'STRYKER 125CC',
	        brand_ids [30],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'DRACO 200CC',
	        brand_ids [31],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'DSR 200CC',
	        brand_ids [31],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'DSR 230CC',
	        brand_ids [31],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'DURAMAX 140CC',
	        brand_ids [31],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'FASTWIND 150CC',
	        brand_ids [31],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'FASTWIND 200CC',
	        brand_ids [31],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'HYPERSPORT 230CC',
	        brand_ids [31],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'MAGNETIC 150CC',
	        brand_ids [31],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'MAX 125CC',
	        brand_ids [31],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'MAX 150 LS',
	        brand_ids [31],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'MAX 150CC',
	        brand_ids [31],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'NEW RENEGADE COMANDO 200CC',
	        brand_ids [31],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'NITROX 150CC',
	        brand_ids [31],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'REGEGADE CAFE URBOR 150CC',
	        brand_ids [31],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'RENEGADE 200CC',
	        brand_ids [31],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'RENEGADE LIMITED 200CC',
	        brand_ids [31],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'RENEGADE SPORT 200CC',
	        brand_ids [31],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'RENEGADE URBA 150CC',
	        brand_ids [31],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'SPORT 200',
	        brand_ids [31],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'SR XFIRE',
	        brand_ids [31],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'SR XRAY 125',
	        brand_ids [31],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'XRAY 125',
	        brand_ids [31],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'XTREET 140CC',
	        brand_ids [31],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'XTREET 150CC',
	        brand_ids [31],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'XTREET 180CC',
	        brand_ids [31],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'XTREET 200CC',
	        brand_ids [31],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'XTREET 230CC',
	        brand_ids [31],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'XTREET 250CC',
	        brand_ids [31],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'XTREET SS 250',
	        brand_ids [31],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'DURAMAX',
	        brand_ids [32],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'NITROX 180',
	        brand_ids [32],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'SR 421 R',
	        brand_ids [32],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'XPEED 150X',
	        brand_ids [32],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'REBELLIAN 250CC',
	        brand_ids [33],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CRUX 110CC',
	        brand_ids [34],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'DT 175CC',
	        brand_ids [34],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'FZ-N 150CC',
	        brand_ids [34],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'FZ-S 150CC',
	        brand_ids [34],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'FZ 07 700CC',
	        brand_ids [34],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'FZ ST 150CC',
	        brand_ids [34],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'FZ16 150CC',
	        brand_ids [34],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'FZ2.0 150CC',
	        brand_ids [34],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'FZN 150 D',
	        brand_ids [34],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'FZN 250',
	        brand_ids [34],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'MT 07',
	        brand_ids [34],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'MTN 320',
	        brand_ids [34],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'N/D',
	        brand_ids [34],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'RXS 100CC',
	        brand_ids [34],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'SZ 150 D',
	        brand_ids [34],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'SZ 150CC',
	        brand_ids [34],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'SZ 16 R',
	        brand_ids [34],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'V-STAR 250CC',
	        brand_ids [34],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'XA 125',
	        brand_ids [34],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'XC 115CC',
	        brand_ids [34],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'XT 1200 Z',
	        brand_ids [34],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'XTZ 125 E',
	        brand_ids [34],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'XVS 950 V START',
	        brand_ids [34],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'YB 125CC',
	        brand_ids [34],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'YBR 125 ED',
	        brand_ids [34],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'YBR 125CC',
	        brand_ids [34],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'YD 110 D 4',
	        brand_ids [34],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'YD 110 S',
	        brand_ids [34],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'YD 110CC',
	        brand_ids [34],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'YW 125',
	        brand_ids [34],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'YZF 320 A',
	        brand_ids [34],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'YZF R15',
	        brand_ids [34],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'YZF R3',
	        brand_ids [34],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'YZF R6',
	        brand_ids [34],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'BIT 125CC',
	        brand_ids [35],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'PASOLA 125CC',
	        brand_ids [35],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'SURF 125CC',
	        brand_ids [35],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'VX 150CC',
	        brand_ids [35],
	        motorcycle_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    );
		
	--Create service types
	--List<ServiceType> createdServiceTypes = serviceTypeRepository.saveAll(GenerateServiceTypes.generate(createdWorkshopId));
	INSERT INTO
	    SERVICE_TYPES (
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
	FROM SERVICE_TYPES
	WHERE
	workshop_id = p_workshop_id
	AND service_type_name = 'TALLER';

	--Definiendo el factor de conversion en funcion del codigo de pais
	--Factor de conversion a pesos colombianos
	IF p_country_code = 57 THEN p_currency_factor := p_currency_parameter;
	--Sin conversion para otras monedas
	ELSE 
	p_currency_factor := 1.0;
	END IF;
	
	
	INSERT INTO
	    PACKAGES(
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
	    ), (
	        'MTTO BASICO CROSS',
	        p_currency_factor * 20.0,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'MTTO MEDIO CROSS',
	        p_currency_factor * 30.0,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CROSS MAYOR',
	        p_currency_factor * 33.9,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CROSS MAYOR',
	        p_currency_factor * 40.0,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CUSTOM BASICO',
	        p_currency_factor * 15.0,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CUSTOM MEDIO',
	        p_currency_factor * 25.0,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CUSTOM MAYOR',
	        p_currency_factor * 38.9,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'RACING BASICO',
	        p_currency_factor * 15.0,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'RACING MEDIO',
	        p_currency_factor * 25.0,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'RACING MAYOR',
	        p_currency_factor * 43.9,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'SCOOTER BASICO',
	        p_currency_factor * 15.0,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'SCOOTER MEDIO',
	        p_currency_factor * 25.0,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'SCOOTER MAYOR',
	        p_currency_factor * 45.0,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'SCOOTER BASICO',
	        p_currency_factor * 15.0,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'SCOOTER MEDIO',
	        p_currency_factor * 25.0,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'SCOOTER MAYOR',
	        p_currency_factor * 38.9,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'TOURING MAYOR',
	        p_currency_factor * 35.0,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'NAKED MAYOR',
	        p_currency_factor * 45.0,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'MTTO BASICO NAKED',
	        p_currency_factor * 25.0,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'MANTENIMIENTO BASICO CROSS',
	        p_currency_factor * 20.0,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'MANTENIMIENTO MEDIO CROSS',
	        p_currency_factor * 30.0,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'MANTENIMIENTO MAYOR CROSS',
	        p_currency_factor * 40.0,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'MANTENIMIENTO BASICO NAKED',
	        p_currency_factor * 25.0,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'MANTENIMIENTO MEDIO NAKED',
	        p_currency_factor * 35.0,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'MANTENIMIENTO MAYOR NAKED',
	        p_currency_factor * 45.0,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'MANTENIMIENTO BASICO CUSTOM',
	        p_currency_factor * 25.0,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'MTTO MEDIO CROSS',
	        p_currency_factor * 30.0,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'MANTENIMIENTO MEDIO CUSTOM',
	        p_currency_factor * 35.0,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'MANTENIMIENTO MAYOR CUSTOM',
	        p_currency_factor * 45.0,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'MANTENIMIENTO BASICO SCOOTER',
	        p_currency_factor * 25.0,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'MANTENIMIENTO MEDIO SCOOTER',
	        p_currency_factor * 35.0,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'MANTENIMIENTO MAYOR SCOOTER',
	        p_currency_factor * 45.0,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'MANTENIMIENTO BASICO RACING',
	        p_currency_factor * 35.0,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'MANTENIMIENTO MEDIO RACING',
	        p_currency_factor * 45.0,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'MANTENIMIENTO MAYOR RACING',
	        p_currency_factor * 55.0,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'MANTENIMIENTO GARANTIA',
	        p_currency_factor * 0.0,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'MANTENIMIENTO BASICO COMSI',
	        p_currency_factor * 13.9,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'MANTENIMIENTO MEDIO COMSI',
	        p_currency_factor * 19.9,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'MANTENIMIENTO MAYOR COMSI',
	        p_currency_factor * 27.9,
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
	        'MANTENIMIENTO BASICO NAKED',
	        p_currency_factor * 15.0,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'MANTENIMIENTO MAYOR NAKED',
	        p_currency_factor * 45.0,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'MANTENIMIENTO BASICO RACING',
	        p_currency_factor * 25.0,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'MANTENIMIENTO MAYOR RACING',
	        p_currency_factor * 65.0,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'MANTENIMIENTO BASICO CROSS',
	        p_currency_factor * 15.0,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'MANTENIMIENTO BASICO CROSS',
	        p_currency_factor * 40.0,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'MANTENIMIENTO MAYOR CROSS',
	        p_currency_factor * 40.0,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'MANTENIMIENTO BASICO SCOOTER',
	        p_currency_factor * 15.0,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'MANTENIMIENTO MAYOR SCOOTER',
	        p_currency_factor * 45.0,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'MANTENIMIENTO MEDIO',
	        p_currency_factor * 25.0,
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
	        'MANTENIMIENTO BASICO TOURING',
	        p_currency_factor * 15.0,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'MANTENIMIENTO 500KM',
	        p_currency_factor * 9.99,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'MANTENIMIENTO MAYOR CUADRIMOTO',
	        p_currency_factor * 47.0,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'MANTENIMIENTO MAYOR KAWASAKI',
	        p_currency_factor * 75.0,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'MANTENIMIENTO MEDIO 200CC',
	        p_currency_factor * 35.0,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'MANTENIMIENTO MEDIO RACING',
	        p_currency_factor * 45.0,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'MANTENIMIENTO FULL NIVEL 1',
	        p_currency_factor * 39.5,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'MANTENIMIENTO MAYOR NIVEL 2',
	        p_currency_factor * 49.5,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'MANTENIENTO GARANTIA UMA',
	        p_currency_factor * 23.0,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'MANTENIMIENTO BÁSICO NIVEL 1',
	        p_currency_factor * 17.5,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'MANTENIMIENTO MEDIO NIVEL 1',
	        p_currency_factor * 29.5,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'MANTENIMIENTO FULL RACING +300cc',
	        p_currency_factor * 42.0,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'AJUSTE DE MOTOR NIVEL 3',
	        p_currency_factor * 122.0,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'Revisión electrica 2',
	        p_currency_factor * 25.0,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'MANTENIMIENTO BÁSICO NS200',
	        p_currency_factor * 18.5,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'MANTENIMIENTO MEDIO NIVEL 2',
	        p_currency_factor * 39.5,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE SELLOS DE BARRA',
	        p_currency_factor * 20.0,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'Paquete de prueba',
	        p_currency_factor * 34.0,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'Escala de diagnóstico NIVEL 1',
	        p_currency_factor * 20.0,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'Escala de diagnóstico ACELERACIÓN Fase 2',
	        p_currency_factor * 32.0,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'MANTENIMIENTO FULL NIVEL 3',
	        p_currency_factor * 60.0,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'MANTENIMIENTO BASICO R3',
	        p_currency_factor * 30.0,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'MANTENIMIENTO FULL AUTOMÁTICA ',
	        p_currency_factor * 39.5,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'MANTENIMIENTO FULL NIVEL 4',
	        p_currency_factor * 37.0,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'AJUSTE DE MOTOR NIVEL 1',
	        p_currency_factor * 80.0,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'AJUSTE DE MOTOR 200CC',
	        p_currency_factor * 90.0,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'MANTENIMIENTO NIVEL 2',
	        p_currency_factor * 41.0,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'MANTENIMIENTO FULL QUTE',
	        p_currency_factor * 70.0,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'AJUSTE DE MOTOR NIVEL 2',
	        p_currency_factor * 90.0,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'Revisión de moto (para compra/venta)',
	        p_currency_factor * 15.0,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'REVISION DE SISTEMA ELECTRICA',
	        p_currency_factor * 15.0,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'ESCALA DE DIAGNÓSTICO P/MOTO NO ARRANCA',
	        p_currency_factor * 55.0,
	        p_service_type_id,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    );

		--Guardando los ids
    	SELECT ARRAY(SELECT package_id FROM PACKAGES WHERE workshop_id = p_workshop_id)
    	INTO package_ids;

    	--Probando imprimir ids:
    	RAISE NOTICE 'IDs: %', package_ids;
		
		
		
		
	--Create process
	--List<Process> createdProcesses = processRepository.saveAll(GenerateProcesses.generate(createdWorkshopId, countryCode));
	INSERT INTO
	    PROCESS (
	        process_name,
	        process_estimated_time,
	        process_price,
	        process_active,
	        workshop_id,
	        created_at,
	        updated_at
	    )
	VALUES (
	        'Cambio de cable de velocimetro',
	        10,
	        p_currency_factor * 2.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'Cambio de aceite ',
	        10,
	        p_currency_factor * 1.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'calibrado de valvula nivel 1',
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
	    ), (
	        'ADAPTE DE REGULADOR DE VOLTAJE',
	        30,
	        p_currency_factor * 12.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'ARMADO DE MOTOR',
	        0,
	        p_currency_factor * 0.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'ASENTADO DE 2 VALVULAS',
	        0,
	        p_currency_factor * 0.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'ASENTADO DE 4 VALVULAS',
	        0,
	        p_currency_factor * 0.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'DESARME DE MOTOR',
	        60,
	        p_currency_factor * 30.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CALIBRACION DE PUNTERIAS',
	        15,
	        p_currency_factor * 12.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE CABLE ACELERADOR',
	        20,
	        p_currency_factor * 4.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE PIÑON DE ATAQUE',
	        20,
	        p_currency_factor * 6.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE ACEITE DE MOTOR STANDAR',
	        20,
	        p_currency_factor * 2.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE ACEITE DE BARRA 100CC-200CC',
	        120,
	        p_currency_factor * 10.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE AMPOLLETA DE FRENO (DELANTERA)',
	        10,
	        p_currency_factor * 1.5,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE AMPOLLETA DE FRENO (TRASERA)',
	        20,
	        p_currency_factor * 5.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE ARBOL DE LEVAS',
	        0,
	        p_currency_factor * 0.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE BALANCINES',
	        80,
	        p_currency_factor * 20.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE BALEROS DE ARBOL DE LEVAS',
	        40,
	        p_currency_factor * 20.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE BALEROS DE RIN DELANTERO',
	        45,
	        p_currency_factor * 10.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE BALEROS DE RIN TRASERO',
	        50,
	        p_currency_factor * 15.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE BASE DE CLUTCH',
	        20,
	        p_currency_factor * 4.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE BATERIA',
	        20,
	        p_currency_factor * 5.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE BOBINA DE ARRANQUE',
	        40,
	        p_currency_factor * 15.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE BOBINA DE ALTA',
	        30,
	        p_currency_factor * 15.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE BOMBA DE ACEITE',
	        45,
	        p_currency_factor * 15.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE BOMBA DE FRENO (DELANTERA)',
	        45,
	        p_currency_factor * 12.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE BOMBA DE FRENO (TRASERA)',
	        50,
	        p_currency_factor * 12.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE BUSHING DE TIJERA TNT 150',
	        90,
	        p_currency_factor * 45.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE BUJIA ',
	        10,
	        p_currency_factor * 1.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE CABLE DE CLUTCH',
	        10,
	        p_currency_factor * 3.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE CABLE DE CLUTCH',
	        10,
	        p_currency_factor * 4.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE CABLE DE SHOCK',
	        10,
	        p_currency_factor * 4.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE CABLE DE VELOCIMETRO',
	        10,
	        p_currency_factor * 2.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE CADENA',
	        15,
	        p_currency_factor * 5.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE CAJA DE VELOCIDADES',
	        0,
	        p_currency_factor * 0.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE CAPUCHON DE BUJIA',
	        5,
	        p_currency_factor * 2.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE CAPUCHON DE BUJIA CENTRAL',
	        25,
	        p_currency_factor * 8.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE CARBURADOR',
	        30,
	        p_currency_factor * 5.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE CDI ',
	        15,
	        p_currency_factor * 6.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE CLUTCH AUTOMATICO',
	        30,
	        p_currency_factor * 25.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE CUNAS CILINDRADA ALTA ',
	        90,
	        p_currency_factor * 25.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE DESLIZADORES DE CADENILLA  ',
	        0,
	        p_currency_factor * 0.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE DISCO DE FRENO (DELANTERO)',
	        20,
	        p_currency_factor * 8.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE DISCO DE FRENO (TRASERO)',
	        30,
	        p_currency_factor * 10.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE DISCOS DE CLUTCH',
	        50,
	        p_currency_factor * 15.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE EMPAQUE DE CLUTCH',
	        20,
	        p_currency_factor * 8.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE EMPAQUE DE ESCAPE',
	        25,
	        p_currency_factor * 5.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE EMPAQUE DE MAGNETO',
	        25,
	        p_currency_factor * 8.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE EMPAQUE DE PUNTERIA',
	        30,
	        p_currency_factor * 6.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE EMPAQUE DE TIEMPO',
	        20,
	        p_currency_factor * 4.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE ESCAPE',
	        30,
	        p_currency_factor * 10.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE ESPARRAGOS DE ESCAPE',
	        30,
	        p_currency_factor * 8.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE ESPARRAGOS DE CULATA',
	        90,
	        p_currency_factor * 40.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE ESTRIBOS',
	        15,
	        p_currency_factor * 4.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE FAROL',
	        30,
	        p_currency_factor * 10.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE FILTRO DE ACEITE',
	        15,
	        p_currency_factor * 2.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE FILTRO DE AIRE ',
	        10,
	        p_currency_factor * 3.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE FILTRO DE GASOLINA',
	        5,
	        p_currency_factor * 2.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE FOCO DE LAGRIMA',
	        20,
	        p_currency_factor * 3.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE FOCO DE SILVIN',
	        20,
	        p_currency_factor * 3.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE FOCO DE VIA',
	        10,
	        p_currency_factor * 2.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE FOCO DE STOP',
	        10,
	        p_currency_factor * 2.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE HULES DE CATARINA ',
	        30,
	        p_currency_factor * 8.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE KIT COMPLETO DE EMPAQUES DE MOTOR',
	        0,
	        p_currency_factor * 0.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE KIT DE CADENILLA DE TIEMPO',
	        0,
	        p_currency_factor * 0.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE KIT DE TRACCION',
	        40,
	        p_currency_factor * 12.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE KIT MEDIO DE EMPAQUES DE MOTOR ',
	        0,
	        p_currency_factor * 0.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE LLANTA (DELANTERA)',
	        30,
	        p_currency_factor * 5.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE LLANTA (TRASERA)',
	        50,
	        p_currency_factor * 5.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE LLAVINES',
	        60,
	        p_currency_factor * 15.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE MANECILLA DE CLUTCH',
	        15,
	        p_currency_factor * 2.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE MANECILLA DE FRENO',
	        15,
	        p_currency_factor * 2.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE MANIFUL',
	        25,
	        p_currency_factor * 6.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE MANUBRIO',
	        20,
	        p_currency_factor * 8.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE MONO SHOCK',
	        90,
	        p_currency_factor * 22.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE OJO DE ANGEL (INTERNO)',
	        90,
	        p_currency_factor * 15.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE PASTILLAS (DELANTERAS)',
	        20,
	        p_currency_factor * 3.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE PASTILLAS (TRASERAS)',
	        20,
	        p_currency_factor * 4.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE PEDAL DE CAMBIO',
	        15,
	        p_currency_factor * 3.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE PIÑON DE ATAQUE',
	        16,
	        p_currency_factor * 6.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE PIÑON DE TIEMPO',
	        50,
	        p_currency_factor * 40.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE PRENSA DE CLUCHT',
	        60,
	        p_currency_factor * 22.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE PROTECTOR DE PIÑON DE ATAQUE',
	        15,
	        p_currency_factor * 2.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE REFRIGERANTE',
	        30,
	        p_currency_factor * 10.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'REVISION O CAMBIO DE REGULADOR DE VOLTAJE ',
	        20,
	        p_currency_factor * 10.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE REGULADOR DE CADENA',
	        20,
	        p_currency_factor * 6.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE RETENEDOR DE PIÑON DE ATAQUE',
	        20,
	        p_currency_factor * 5.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE RETENEDORES DE EJE DE CAMBIOS',
	        30,
	        p_currency_factor * 15.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE SELLOS DE BARRA',
	        120,
	        p_currency_factor * 20.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE SELLOS DE VALVULA',
	        0,
	        p_currency_factor * 0.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE SILVIN ',
	        40,
	        p_currency_factor * 10.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE SOCKET DE FOCO DEL SILVIN',
	        20,
	        p_currency_factor * 8.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE SOLUCION FRENO (DELANTERO)',
	        30,
	        p_currency_factor * 6.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE SOLUCION FRENO (TRASERO)',
	        30,
	        p_currency_factor * 8.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE TABLERO',
	        40,
	        p_currency_factor * 10.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE TAPADERA DE PUNTERIA',
	        30,
	        p_currency_factor * 4.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE TENSOR DE CADENILLA',
	        120,
	        p_currency_factor * 40.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE TERMINALES DE BATERIA',
	        20,
	        p_currency_factor * 5.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CARGA DE BATERIA',
	        60,
	        p_currency_factor * 5.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'PRE-DIAGNOSTICO',
	        30,
	        p_currency_factor * 5.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'DIAGNOSTICO',
	        90,
	        p_currency_factor * 15.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'ENGRASE DE CADENA',
	        5,
	        p_currency_factor * 3.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'ENGRASE DE CUNAS',
	        40,
	        p_currency_factor * 15.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE ASIENTO',
	        15,
	        p_currency_factor * 5.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE ESPEJOS',
	        10,
	        p_currency_factor * 5.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'INSTALACION DE FOCO LED',
	        20,
	        p_currency_factor * 10.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'INSTALACION DE HALOGENOS',
	        40,
	        p_currency_factor * 15.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'INSTALACION DE PARRILLA',
	        30,
	        p_currency_factor * 10.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'INSTALACION DE PERNO DE ESTRIBO',
	        20,
	        p_currency_factor * 2.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE PITO',
	        10,
	        p_currency_factor * 4.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'INSTALACION DE TIRAS LED',
	        35,
	        p_currency_factor * 5.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'LIMPIEZA DE CADENA',
	        20,
	        p_currency_factor * 4.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'LIMPIEZA DE CALIPER',
	        30,
	        p_currency_factor * 10.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'LIMPIEZA DE CARBURADOR',
	        45,
	        p_currency_factor * 12.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'LIMPIEZA DE FRENOS (DELANTEROS)',
	        20,
	        p_currency_factor * 4.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'LIMPIEZA DE FRENOS (TRASEROS)',
	        15,
	        p_currency_factor * 4.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'LUBRICACION DE CABLE DE CLUTCH',
	        7,
	        p_currency_factor * 2.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'REAPRETE DE CUNAS DE DIRECCIÓN ',
	        15,
	        p_currency_factor * 15.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'RECTIFICACION DE YUGO ',
	        60,
	        p_currency_factor * 35.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'RECTIFICADO DE PRENSA',
	        60,
	        p_currency_factor * 45.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'REGULACION DE CABLE DE CLUTCH',
	        5,
	        p_currency_factor * 3.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'REGULACION DE CABLE DE FRENO',
	        10,
	        p_currency_factor * 2.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'REGULACION DE CARBURADOR',
	        60,
	        p_currency_factor * 12.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'REVISION DE BOBINA DE ALTA',
	        30,
	        p_currency_factor * 10.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'REVISION DE BUJIA',
	        5,
	        p_currency_factor * 1.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'TENSADO DE CADENA',
	        5,
	        p_currency_factor * 2.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'LUBRICACION DE CABLE DE FRENO',
	        15,
	        p_currency_factor * 2.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'LUBRICACION DE CABLE DE ACELERADOR',
	        8,
	        p_currency_factor * 2.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'LIMPIEZA DE BUJIA',
	        5,
	        p_currency_factor * 2.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'DESARMADO DE MOTOR',
	        0,
	        p_currency_factor * 0.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'ENGRASE DE EJE (DELANTERO)',
	        10,
	        p_currency_factor * 2.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'ENGRASE DE EJE (TRASERO)',
	        10,
	        p_currency_factor * 3.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'ENGRASE DE EJE DE TIJERA',
	        10,
	        p_currency_factor * 3.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CALIBRACION DE AIRE EN LLANTAS',
	        10,
	        p_currency_factor * 1.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'ENGRASE DE MANECILLA DE CLUTCH',
	        10,
	        p_currency_factor * 2.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'ENGRASE DE MANECILLA DE FRENO',
	        10,
	        p_currency_factor * 2.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'LIMPIEZA O CAMBIO BASICO TOURING',
	        30,
	        p_currency_factor * 11.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'LUBRICACION BASICO TOURING',
	        30,
	        p_currency_factor * 2.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'ENGRASE BASICO TOURING',
	        20,
	        p_currency_factor * 2.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'LIMPIEZA O CAMBIO MEDIO TOURING',
	        60,
	        p_currency_factor * 14.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'LUBRICACION MEDIO TOURING',
	        30,
	        p_currency_factor * 2.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'ENGRASE MEDIO TOURING ',
	        20,
	        p_currency_factor * 3.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CALIBRACION MEDIO TOURING',
	        30,
	        p_currency_factor * 4.5,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'REAPRIETE MEDIO TOURING',
	        10,
	        p_currency_factor * 1.5,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'LIMPIEZA O CAMBIO MAYOR',
	        70,
	        p_currency_factor * 8.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'LUBRICACION MAYOR',
	        20,
	        p_currency_factor * 3.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'ENGRASE MAYOR',
	        15,
	        p_currency_factor * 4.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CALIBRACION MAYOR',
	        35,
	        p_currency_factor * 18.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'REAPRIETE MAYOR',
	        20,
	        p_currency_factor * 2.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO EMPAQUE DE TENSOR DE CADENILLA',
	        20,
	        p_currency_factor * 4.5,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'REVISION ELECTRICA MOTOCICLETA CARBURADA',
	        75,
	        p_currency_factor * 20.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE BALEROS DE MOTOR',
	        60,
	        p_currency_factor * 75.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE FAJA',
	        45,
	        p_currency_factor * 15.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE INDICADORES DE VELOCIDAD',
	        0,
	        p_currency_factor * 0.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE ESTRELLA SELECTORA',
	        0,
	        p_currency_factor * 0.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'ENDEREZADO DE BARRAS',
	        30,
	        p_currency_factor * 15.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'NIVELADO DE RIN DE ESTRELLA',
	        0,
	        p_currency_factor * 0.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'NIVELADO DE RIN DE RAYO',
	        0,
	        p_currency_factor * 0.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'RECTIFICADO DE YUGO',
	        80,
	        p_currency_factor * 45.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'RECTIFICADO DE PRENSA',
	        50,
	        p_currency_factor * 45.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'REPARACION DE BASE DE ESTRIBO',
	        0,
	        p_currency_factor * 0.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'REVISION DE RADIADOR',
	        45,
	        p_currency_factor * 20.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'REVISION DE VELOCIMETRO',
	        20,
	        p_currency_factor * 5.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'REVISION DE CARGA DE BATERIA',
	        5,
	        p_currency_factor * 3.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'ELABORACION DE EMPAQUE DE CILINDRO',
	        0,
	        p_currency_factor * 0.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'ENDEREZADO DE MANUBRIO',
	        0,
	        p_currency_factor * 0.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'ENDEREZADO DE PATA DE CAMBIOS',
	        30,
	        p_currency_factor * 5.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'ENDEREZADO DE PATA DOBLE',
	        20,
	        p_currency_factor * 60.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'INSTALACION DE ASIENTO',
	        5,
	        p_currency_factor * 20.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'INSTALACION DE ESPEJOS',
	        30,
	        p_currency_factor * 5.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'INSTALACION DE FOCO LED',
	        30,
	        p_currency_factor * 10.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'INSTALACION DE PITO',
	        15,
	        p_currency_factor * 4.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'REAPRETE DE PERNOS DE MOTOR',
	        25,
	        p_currency_factor * 8.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE CABLE DE ACELERADOR',
	        20,
	        p_currency_factor * 5.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'REVISION DE CABLE DE ACELERADOR',
	        20,
	        p_currency_factor * 3.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE CABLE DE FRENO',
	        20,
	        p_currency_factor * 4.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'REVISION DE CABLE DE CLUTCH',
	        20,
	        p_currency_factor * 4.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'REVISION DE CABLE DE FRENO',
	        20,
	        p_currency_factor * 4.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'REVISION DE CUNAS',
	        60,
	        p_currency_factor * 15.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'REVISION DE NIVEL DE ACIDO DE BATERIA',
	        15,
	        p_currency_factor * 6.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'REVISION DE PITO',
	        20,
	        p_currency_factor * 5.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'REVISION DE PRENSA',
	        60,
	        p_currency_factor * 18.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CALIBRACION DE PUNTERIAS NS200',
	        60,
	        p_currency_factor * 15.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'REVISION DE SISTEMA DE ENCENDIDO',
	        120,
	        p_currency_factor * 15.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'REVISIÓN DE SWITCH DERECHO',
	        30,
	        p_currency_factor * 6.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'REVISION DE SWITCH DE VIA',
	        6,
	        p_currency_factor * 30.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'REVISION DE TABLERO',
	        30,
	        p_currency_factor * 10.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'SOLDADURA DE ESCAPE',
	        60,
	        p_currency_factor * 20.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE CALIPER (DELANTERO)',
	        30,
	        p_currency_factor * 8.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE CALIPER (TRASERO)',
	        40,
	        p_currency_factor * 8.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE BASE DE FRENO',
	        4,
	        p_currency_factor * 20.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'TRABAJO TORNO',
	        0,
	        p_currency_factor * 0.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'LIMPIEZA O CAMBIO BASICO CROSS',
	        35,
	        p_currency_factor * 16.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'LUBRICACION BASICO CROSS',
	        35,
	        p_currency_factor * 2.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'ENGRASE BASICO CROSS',
	        25,
	        p_currency_factor * 2.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'LIMPIEZA O CAMBIO BASICO NAKED',
	        40,
	        p_currency_factor * 19.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'LUBRICACION BASICO NAKED',
	        40,
	        p_currency_factor * 3.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'ENGRASE BASICO NAKED',
	        30,
	        p_currency_factor * 3.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'LIMPIEZA O CAMBIO BASICO CUSTOM',
	        40,
	        p_currency_factor * 19.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'LUBRICACION BASICO CUSTOM',
	        40,
	        p_currency_factor * 3.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'ENGRASE BASICO CUSTOM',
	        30,
	        p_currency_factor * 3.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'LIMPIEZA O CAMBIO BASICO SCOOTER',
	        45,
	        p_currency_factor * 19.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'LUBRICACION BASICO SCOOTER',
	        45,
	        p_currency_factor * 3.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'ENGRASE BASICO SCOOTER',
	        35,
	        p_currency_factor * 3.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'LIMPIEZA O CAMBIO BASICO RACING',
	        50,
	        p_currency_factor * 29.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'LUBRICACION BASICO RACING',
	        50,
	        p_currency_factor * 3.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'ENGRASE BASICO RACING',
	        40,
	        p_currency_factor * 3.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'LIMPIEZA O CAMBIO MEDIO CROSS',
	        65,
	        p_currency_factor * 19.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'LUBRICACION MEDIO CROSS',
	        35,
	        p_currency_factor * 2.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'ENGRASE MEDIO CROSS',
	        25,
	        p_currency_factor * 2.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CALIBRACION MEDIO CROSS',
	        35,
	        p_currency_factor * 5.5,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'REAPRIETE MEDIO CROSS',
	        15,
	        p_currency_factor * 1.5,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'LIMPIEZA O CAMBIO MEDIO NAKED',
	        70,
	        p_currency_factor * 21.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'LUBRICACION MEDIO NAKED',
	        40,
	        p_currency_factor * 3.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'ENGRASE MEDIO NAKED',
	        30,
	        p_currency_factor * 3.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CALIBRACION MEDIO NAKED',
	        40,
	        p_currency_factor * 6.5,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'REAPRIETE MEDIO NAKED',
	        20,
	        p_currency_factor * 1.5,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'LIMPIEZA O CAMBIO MEDIO CUSTOM',
	        70,
	        p_currency_factor * 21.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'LUBRICACION MEDIO CUSTOM',
	        40,
	        p_currency_factor * 3.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'ENGRASE MEDIO CUSTOM',
	        30,
	        p_currency_factor * 3.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CALIBRACION MEDIO CUSTOM',
	        40,
	        p_currency_factor * 6.5,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'REAPRIETE MEDIO CUSTOM',
	        20,
	        p_currency_factor * 1.5,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'LIMPIEZA O CAMBIO MEDIO SCOOTER',
	        75,
	        p_currency_factor * 21.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'LUBRICACION MEDIO SCOOTER',
	        45,
	        p_currency_factor * 3.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'ENGRASE MEDIO SCOOTER',
	        35,
	        p_currency_factor * 3.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CALIBRACION MEDIO SCOOTER',
	        45,
	        p_currency_factor * 6.5,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'REAPRIETE MEDIO SCOOTER',
	        25,
	        p_currency_factor * 1.5,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'LIMPIEZA O CAMBIO MEDIO RACING',
	        80,
	        p_currency_factor * 29.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'LUBRICACION MEDIO RACING',
	        50,
	        p_currency_factor * 3.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'ENGRASE MEDIO RACING',
	        40,
	        p_currency_factor * 3.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CALIBRACION MEDIO RACING',
	        50,
	        p_currency_factor * 8.5,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'REAPRIETE MEDIO RACING',
	        30,
	        p_currency_factor * 1.5,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'LIMPIEZA O CAMBIO MAYOR TOURING',
	        60,
	        p_currency_factor * 17.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'LUBRICACION MAYOR TOURING',
	        30,
	        p_currency_factor * 6.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'ENGRASE MAYOR TOURING',
	        20,
	        p_currency_factor * 3.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CALIBRACION MAYOR TOURING',
	        60,
	        p_currency_factor * 7.5,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'REAPRIETE MAYOR TOURING',
	        10,
	        p_currency_factor * 1.5,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'LIMPIEZA O CAMBIO MAYOR CROSS',
	        35,
	        p_currency_factor * 22.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'LUBRICACION MAYOR CROSS',
	        35,
	        p_currency_factor * 6.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'ENGRASE MAYOR CROSS',
	        25,
	        p_currency_factor * 2.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CALIBRACION MAYOR CROSS',
	        65,
	        p_currency_factor * 8.5,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'REAPRIETE MAYOR CROSS',
	        15,
	        p_currency_factor * 1.5,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'LIMPIEZA O CAMBIO MAYOR CUSTOM',
	        70,
	        p_currency_factor * 23.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'LUBRICACION MAYOR CUSTOM',
	        40,
	        p_currency_factor * 6.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'ENGRASE MAYOR CUSTOM',
	        30,
	        p_currency_factor * 3.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CALIBRACION MAYOR CUSTOM',
	        70,
	        p_currency_factor * 11.5,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'REAPRIETE MAYOR CUSTOM',
	        20,
	        p_currency_factor * 1.5,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'LIMPIEZA O CAMBIO MAYOR SCOOTER',
	        75,
	        p_currency_factor * 23.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'LUBRICACION MAYOR SCOOTER',
	        45,
	        p_currency_factor * 6.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'ENGRASE MAYOR SCOOTER',
	        35,
	        p_currency_factor * 3.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CALIBRACION MAYOR SCOOTER',
	        75,
	        p_currency_factor * 11.5,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'REAPRIETE MAYOR SCOOTER',
	        25,
	        p_currency_factor * 1.5,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'LIMPIEZA O CAMBIO MAYOR RACING',
	        80,
	        p_currency_factor * 34.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'LUBRICACION MAYOR RACING',
	        50,
	        p_currency_factor * 6.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'ENGRASE MAYOR RACING',
	        40,
	        p_currency_factor * 3.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CALIBRACION MAYOR RACING',
	        80,
	        p_currency_factor * 13.5,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'REAPRIETE MAYOR RACING',
	        30,
	        p_currency_factor * 1.5,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'REBOBINADO',
	        0,
	        p_currency_factor * 50.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'LIMPIEZA O CAMBIO MAYOR NAKED',
	        70,
	        p_currency_factor * 23.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'LUBRICACION MAYOR NAKED',
	        40,
	        p_currency_factor * 6.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'ENGRASE MAYOR NAKED',
	        30,
	        p_currency_factor * 3.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CALIBRACION MAYOR NAKED',
	        70,
	        p_currency_factor * 11.5,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'REAPRIETE MAYOR NAKED',
	        20,
	        p_currency_factor * 1.5,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'DESARME Y ARME DE CABEZAL',
	        0,
	        p_currency_factor * 0.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'DESARME Y ARME DE MOTOR',
	        0,
	        p_currency_factor * 0.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'INSTALACION DE VIA',
	        30,
	        p_currency_factor * 8.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'REGULACION DE CADENA',
	        20,
	        p_currency_factor * 3.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'REVISION DE LLAVIN',
	        60,
	        p_currency_factor * 5.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'VERIFICAR FUGAS DE FLUIDOS',
	        5,
	        p_currency_factor * 0.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'REVISION DE VOLTAJE Y NIVEL DE ACIDO DE BATERIA',
	        10,
	        p_currency_factor * 0.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE ACEITE',
	        10,
	        p_currency_factor * 0.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'LIMPIEZA DE FILTRO DE AIRE',
	        10,
	        p_currency_factor * 0.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'VERIFICAR Y DRENAR CARBURADOR',
	        20,
	        p_currency_factor * 0.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'VERIFICAR Y CALIBRAR BUJIAS',
	        30,
	        p_currency_factor * 0.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CALIBRACION DE VALVULAS',
	        30,
	        p_currency_factor * 10.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'VERIFICACION MTTO GARANTIA',
	        15,
	        p_currency_factor * 0.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'LIMPIEZA O CAMBIO MTTO GARANTIA',
	        30,
	        p_currency_factor * 0.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CALIBRACION MTTO GARANTIA',
	        20,
	        p_currency_factor * 0.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'REAPRIETE MTTO GARANTIA',
	        10,
	        p_currency_factor * 0.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE VENTILADOR DE RADIADOR',
	        120,
	        p_currency_factor * 30.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'REPARACION DE PISTONES DE FRENO',
	        30,
	        p_currency_factor * 12.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE PATA DE PARQUEO',
	        20,
	        p_currency_factor * 3.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE ZAPATAS (DELANTERAS)',
	        20,
	        p_currency_factor * 3.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE ZAPATAS (TRASERAS)',
	        20,
	        p_currency_factor * 4.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE BOBINA DE MAGNETO',
	        50,
	        p_currency_factor * 15.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE CADENILLA DE TIEMPO',
	        60,
	        p_currency_factor * 30.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'ENGRASE MTTO GARANTIA',
	        50,
	        p_currency_factor * 10.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'ARMADO DE CARENADO ',
	        180,
	        p_currency_factor * 40.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'LAVADO DE MOTOCICLETA',
	        20,
	        p_currency_factor * 2.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'REMACHADO DE PRENSA',
	        0,
	        p_currency_factor * 65.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'REPARACION DE ROSCA DE DRENADO DE ACEITE',
	        30,
	        p_currency_factor * 15.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'SOLDADURA DE RIN',
	        0,
	        p_currency_factor * 0.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'SOLDADURA DE CLABLE',
	        0,
	        p_currency_factor * 2.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'REVISION DE LLANTA TRASERA',
	        0,
	        p_currency_factor * 0.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'ACENTADO DE VALVULAS',
	        0,
	        p_currency_factor * 15.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'REVISION DE FRENO DELANTERO',
	        20,
	        p_currency_factor * 5.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'REVISION DE FRENO TRASERO',
	        25,
	        p_currency_factor * 5.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'REVISION DE SISTEMA ELECTRICO',
	        0,
	        p_currency_factor * 0.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'MOLDURA LADO DERECHO',
	        0,
	        p_currency_factor * 0.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'AFINADO MAYOR',
	        0,
	        p_currency_factor * 65.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'LAVADO DE TANQUE',
	        40,
	        p_currency_factor * 20.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'INSTALACION DE SLIDERS',
	        0,
	        p_currency_factor * 0.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'REVISION Y CALIBRACION DE CARBURACION',
	        60,
	        p_currency_factor * 15.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'REAPRIETE DE SLIDERS',
	        0,
	        p_currency_factor * 0.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE EJE DELANTERO',
	        15,
	        p_currency_factor * 3.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'REVISION DE BOBINA DE CARGA',
	        20,
	        p_currency_factor * 15.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE AMPOLLETA DE NEUTRO',
	        60,
	        p_currency_factor * 0.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'INSTALACION DE HALOGENOS LED',
	        60,
	        p_currency_factor * 15.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'SOLDADURA DE CARTER',
	        180,
	        p_currency_factor * 55.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'REVISION DE FILTRO DE AIRE',
	        30,
	        p_currency_factor * 3.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'REVISIÓN DE KIT DE TRACCIÓN',
	        20,
	        p_currency_factor * 5.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE TOLVA (DERECHA)',
	        20,
	        p_currency_factor * 10.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE AMORTIGUADORES',
	        60,
	        p_currency_factor * 15.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE TOLVA (IZQUIERDA)',
	        20,
	        p_currency_factor * 10.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE KIT DE TRACCION',
	        40,
	        p_currency_factor * 20.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE ORRINES',
	        0,
	        p_currency_factor * 1.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'REHASER ROSCA ',
	        30,
	        p_currency_factor * 15.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'TRABAJO CON FIBRA',
	        420,
	        p_currency_factor * 45.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'ENDEREZADO DE CHASIS',
	        0,
	        p_currency_factor * 0.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'ENDEREZADO DE YUGO',
	        0,
	        p_currency_factor * 0.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'Desarme',
	        30,
	        p_currency_factor * 3.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE PERNOS DE CATARINA',
	        30,
	        p_currency_factor * 10.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'PARTE DELANTERA (B): FRENOS DELANTEROS, EJE DELANTERO, CABLES, MANECILLAS',
	        40,
	        p_currency_factor * 0.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'PARTE MEDIA (B): BUJIA, FILTRO DE GASOLINA',
	        10,
	        p_currency_factor * 0.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'PARTE TRASERA (B): FRENOS TRASEROS, EJE TRASERO, KIT DE TRACCION',
	        40,
	        p_currency_factor * 0.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE ACEITE',
	        20,
	        p_currency_factor * 0.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'PARTE DELANTERA (M): FRENOS DELANTEROS, EJE DELANTERO, CABLES, MANECILLAS',
	        40,
	        p_currency_factor * 0.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'PARTE MEDIA (M): PUNTERIAS, BUJIA, CARBURADOR, FILTRO DE GASOLINA, FILTRO DE AIRE, EJE DE TIJERA, BATERIA',
	        90,
	        p_currency_factor * 0.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'PARTE TRASERA (M): FRENOS TRASEROS, KIT DE TRACCION',
	        40,
	        p_currency_factor * 0.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE ACEITE (M): ACEITE, REAPRIETE GENERAL, LLANTAS',
	        30,
	        p_currency_factor * 0.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE BAJA ',
	        130,
	        p_currency_factor * 25.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'REVISON PARTE TRASERA  POR ENDEREZAR',
	        120,
	        p_currency_factor * 35.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE RETENEDORES DE SIGUEÑAL ',
	        200,
	        p_currency_factor * 25.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'DESARME Y PRESUPUESTO (MOTO CHOCADA) NIVEL 1',
	        140,
	        p_currency_factor * 35.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE LLANTA',
	        15,
	        p_currency_factor * 3.5,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'Mantenimiento mayor con TOLVAS',
	        180,
	        p_currency_factor * 45.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'ARMADO DE MOTOR',
	        500,
	        p_currency_factor * 45.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'ASENTADO DE VALVULAS',
	        30,
	        p_currency_factor * 45.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'ASENTADO DE VALVULAS 5',
	        30,
	        p_currency_factor * 45.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'ASENTADO DE 5 VALVULAS',
	        30,
	        p_currency_factor * 45.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'LIMPIEZA DE BOBINAS DE BAJA',
	        15,
	        p_currency_factor * 10.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'LAVADO DE MOTOR ',
	        20,
	        p_currency_factor * 10.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE TIMON',
	        20,
	        p_currency_factor * 10.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE PEDAL DE VELOCIDADES',
	        15,
	        p_currency_factor * 5.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE MANGUILLOS',
	        15,
	        p_currency_factor * 5.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'CAMBIO DE EJE DE CAMBIOS',
	        20,
	        p_currency_factor * 12.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'REVISIÓN DE BALEROS ',
	        20,
	        p_currency_factor * 15.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'RECTIFICADO DE CHASIS',
	        215,
	        p_currency_factor * 0.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'sellar ojo de bomba de freno delantera',
	        25,
	        p_currency_factor * 5.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'RECTIFICADO DE BARRAS',
	        215,
	        p_currency_factor * 0.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'RECTIFICADO DE RIN',
	        215,
	        p_currency_factor * 60.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'PINTADO ESPEFICICO',
	        215,
	        p_currency_factor * 0.0,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	    ), (
	        'cambio de chiclero',
	        30,
	        p_currency_factor * 5.95,
	        1,
	        p_workshop_id,
	        CURRENT_TIMESTAMP,
	        CURRENT_TIMESTAMP
	), (
	    'LUBRICACION DE EJE DE RIN',
	    20,
	    p_currency_factor * 3.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'LUBRICACION DE CABLES',
	    20,
	    p_currency_factor * 5.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'FILTRO DE ACEITE QUTE',
	    10,
	    p_currency_factor * 10.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE RAMAL COMPLETO',
	    220,
	    p_currency_factor * 48.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'DIAGNOSTICO REVISION ELECTRICA RAMAL COMPLETO',
	    220,
	    p_currency_factor * 45.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'LIMPIEZA DE CONTACTOS ELETRICOS',
	    30,
	    p_currency_factor * 15.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE MANDO IZQUIERDO ',
	    30,
	    p_currency_factor * 10.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'INSTALACION DE MANGUILLOS',
	    30,
	    p_currency_factor * 15.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'REPARACION DE SISTEMA ELECTRICO',
	    2890,
	    p_currency_factor * 0.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'INSTALACIÓN DE STOP',
	    30,
	    p_currency_factor * 0.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'PORTEO DE CULATA',
	    1820,
	    p_currency_factor * 0.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'REPARACION SOPORTE DE TIMÓN ',
	    150,
	    p_currency_factor * 26.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'INSTALACION DE SOPORTE ',
	    30,
	    p_currency_factor * 12.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE VIAS ',
	    35,
	    p_currency_factor * 10.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE CATARINA',
	    30,
	    p_currency_factor * 12.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'AJUSTE HULES DE TANQUE',
	    25,
	    p_currency_factor * 10.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'SERVICIO DE GRÚA',
	    120,
	    p_currency_factor * 12.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'DELIVERY',
	    45,
	    p_currency_factor * 12.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'RECTIFICADO DE DISCO DE FRENO',
	    45,
	    p_currency_factor * 25.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE SIGUEÑAL',
	    120,
	    p_currency_factor * 80.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE CONJUNTO DE CILINDRO',
	    45,
	    p_currency_factor * 35.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE ARBOL DE LEVAS',
	    215,
	    p_currency_factor * 30.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'Cambio de resorte pata de freno',
	    15,
	    p_currency_factor * 3.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'Sondeo de radiador',
	    60,
	    p_currency_factor * 45.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE TAPÓN DE DRENADO DE ACEITE',
	    10,
	    p_currency_factor * 3.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'TAPISADO',
	    60,
	    p_currency_factor * 0.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'REVISION DE EJE DE CAMBIOS ',
	    50,
	    p_currency_factor * 15.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'REVISION DE SISTEMA DE CARGA',
	    30,
	    p_currency_factor * 20.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE MANECILLA COMPLETA',
	    10,
	    p_currency_factor * 5.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE SELENOIDE ',
	    10,
	    p_currency_factor * 5.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE MOTOR DE ARRANQUE',
	    30,
	    p_currency_factor * 10.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'Ajuste de pedal de freno',
	    20,
	    p_currency_factor * 4.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'REPARACIÓN DE FUGA DE ACEITE',
	    60,
	    p_currency_factor * 15.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'ARME DE MOTOR',
	    300,
	    p_currency_factor * 40.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'REPARACION DE ESCAPE ',
	    69,
	    p_currency_factor * 15.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'REVISION DE FAJA DE TRACCION',
	    55,
	    p_currency_factor * 15.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CODIFICACION DE COMPUTADORA',
	    78,
	    p_currency_factor * 45.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE CUNAS ',
	    59,
	    p_currency_factor * 22.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE CILINDRO',
	    30,
	    p_currency_factor * 30.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'DESCARBONADO DE CULATA',
	    45,
	    p_currency_factor * 40.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE BUSHING DE CATARINA',
	    60,
	    p_currency_factor * 45.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE BARRAS',
	    45,
	    p_currency_factor * 20.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE BALERO DE CATARINA',
	    35,
	    p_currency_factor * 8.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'ARMADO DE CARROCERÍA',
	    130,
	    p_currency_factor * 40.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'PARQUEO DIARIO',
	    0,
	    p_currency_factor * 1.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'FABRICACION DE EMPAQUES',
	    59,
	    p_currency_factor * 10.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'LIMPIEZA DE BOMBA DE GASOLINA ',
	    30,
	    p_currency_factor * 25.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'LIMPIEZA DE FILTRO DE GASOLINA',
	    20,
	    p_currency_factor * 3.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE FILTRO DE AIRE',
	    20,
	    p_currency_factor * 3.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE EMPAQUES DE MOTOR KAWASAKI 650',
	    200,
	    p_currency_factor * 50.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'MANTENIENTO MEDIO',
	    105,
	    p_currency_factor * 35.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'DESARMADO Y ARMADO DE MOTOR',
	    0,
	    p_currency_factor * 80.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'SOLDADURA EN CHASÍS',
	    90,
	    p_currency_factor * 15.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE SELLOS DE BARRAS',
	    90,
	    p_currency_factor * 20.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'cambio de switch de vias',
	    25,
	    p_currency_factor * 8.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'cambio de switch de encendido ',
	    25,
	    p_currency_factor * 8.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'REPARACION DE VIA ',
	    20,
	    p_currency_factor * 3.5,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'Soldadura de pata lateral',
	    60,
	    p_currency_factor * 20.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'DESARME DE MOTOR ',
	    60,
	    p_currency_factor * 40.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'armado de motor',
	    60,
	    p_currency_factor * 40.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'diagnostico de piezas de motor ',
	    25,
	    p_currency_factor * 20.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'Lavado de piezas de motor',
	    25,
	    p_currency_factor * 0.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'EXTRACCION DE PERNO TORNO',
	    128,
	    p_currency_factor * 32.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'DIAGNOSTICO Y CORRECCION',
	    60,
	    p_currency_factor * 20.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE FOCO DE SILVIN A LED H4',
	    60,
	    p_currency_factor * 8.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE SELLOS DE BARRAS,SIN PATA DOBLE 300cc-6000cc',
	    120,
	    p_currency_factor * 30.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO O LIMPIEZA DE SENSOR DE VELOCIMETRO',
	    30,
	    p_currency_factor * 5.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'LIMPIEZA Y CORRECCIÓN DE CONTACTOS',
	    60,
	    p_currency_factor * 10.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE ACEITE DE BARRAS KAWASAKI',
	    120,
	    p_currency_factor * 20.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE LEVA DE FRENO',
	    30,
	    p_currency_factor * 4.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE EMPAQUES YBR 125',
	    60,
	    p_currency_factor * 30.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'REVISION DE CUNAS 300CC + 1000CC',
	    120,
	    p_currency_factor * 20.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE CUNAS 300CC -1000CC',
	    120,
	    p_currency_factor * 40.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE ACEITE Y FILTRO DE ACEITE DE MOTOR 300CC -1000CC',
	    30,
	    p_currency_factor * 5.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE EMPAQUE DE PUNTERÍA NS200-NS125',
	    60,
	    p_currency_factor * 15.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'REVISION ELECTRICA MOTOCICLETA INYECTADA',
	    60,
	    p_currency_factor * 25.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'DESARME DE BARRAS',
	    30,
	    p_currency_factor * 10.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE SELLOS DE BARRAS',
	    45,
	    p_currency_factor * 20.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'ARME DE BARRAS',
	    30,
	    p_currency_factor * 10.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'DESARME DE CABEZAL DE MOTOR',
	    60,
	    p_currency_factor * 15.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'ARMADO DE CABEZAL DE MOTOR',
	    60,
	    p_currency_factor * 25.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'REVISIÓN Y LIMPIEZA DE KALIPER',
	    60,
	    p_currency_factor * 15.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'Medición de compresion de motor 300cc-1000cc',
	    30,
	    p_currency_factor * 20.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    ' Medición de compresion de motor 100cc-200cc',
	    10,
	    p_currency_factor * 5.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'LIMPIEZA DE CARBURADOR NS160-NS200',
	    45,
	    p_currency_factor * 25.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE BUJIAS NS',
	    45,
	    p_currency_factor * 12.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE FILTRO DE AIRE NS ',
	    30,
	    p_currency_factor * 10.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE EMPAQUES BOMBA DE ACEITE',
	    90,
	    p_currency_factor * 25.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE RETENEDOR DE TAPA CLUCTH',
	    30,
	    p_currency_factor * 8.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'ALQUILER DE MOTO ',
	    1440,
	    p_currency_factor * 5.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'LIMPIEZA DE INYECTORES',
	    60,
	    p_currency_factor * 25.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE VÁLVULA DE GASOLINA NS200',
	    60,
	    p_currency_factor * 12.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'SOLDADURA EN TANQUE DE GASOLINA',
	    240,
	    p_currency_factor * 35.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE BALINERA DE MAGNETO ',
	    40,
	    p_currency_factor * 12.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'REVISIÓN DE BALINERA DE MAGNETO ',
	    30,
	    p_currency_factor * 8.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'ESCALA DE DIAGNÓSTICO ELÉCTRICO ',
	    160,
	    p_currency_factor * 40.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'REPARACION DE ROSCA ',
	    60,
	    p_currency_factor * 12.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'INSPECCION DE BOMBA DE ACEITE',
	    30,
	    p_currency_factor * 15.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'PINTADO DE RIN DELANTERO ',
	    60,
	    p_currency_factor * 15.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'LIMPIEZA DE BUJÍAS NS ',
	    45,
	    p_currency_factor * 12.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE O-RIN DE MOTOR DE ARRANQUE',
	    20,
	    p_currency_factor * 3.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE MEMBRANA DE CARBURADOR',
	    25,
	    p_currency_factor * 8.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'SOLDADURA DE CABLE ',
	    15,
	    p_currency_factor * 2.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'INSTALACION DE SWITH ENCENDIDO Y APAGADO',
	    20,
	    p_currency_factor * 6.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE BALEROS DE EJE DE LEVAS',
	    60,
	    p_currency_factor * 12.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'LIMPIEZA DE CARBURADOR KAWA 250',
	    90,
	    p_currency_factor * 27.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'REVISION DE FUGAS 360',
	    45,
	    p_currency_factor * 15.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'LAVADO DE MOTO ',
	    20,
	    p_currency_factor * 3.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'REVISION DE CADENILLA DE MOTOR',
	    60,
	    p_currency_factor * 15.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'REVISION DE EJE DE LEVAS',
	    45,
	    p_currency_factor * 12.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'REVISION DE BOMBA DE FRENO DELANTERO',
	    45,
	    p_currency_factor * 10.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'REVISION DE TABLERO DIGITAL',
	    60,
	    p_currency_factor * 15.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'AISLAR CABLES',
	    20,
	    p_currency_factor * 5.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'SOLDADURA EN ESPEJO IZQUIERDO',
	    60,
	    p_currency_factor * 15.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'REVISION DE VÍAS ',
	    30,
	    p_currency_factor * 5.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE DISCOS DE CLUCHT NS200',
	    90,
	    p_currency_factor * 20.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'MODIFICACIÓN DE CONFIGURACIÓN MAGNÉTICA ',
	    360,
	    p_currency_factor * 90.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'SOLDADURA DE RADIADOR',
	    45,
	    p_currency_factor * 17.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'REVISION DE CARGA BOBINA CDI Y REGULADOR DE VOLTAJE',
	    30,
	    p_currency_factor * 12.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'ADAPTE DE PULSOR',
	    40,
	    p_currency_factor * 20.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'ALINEADO DE RIN DELANTERO ',
	    60,
	    p_currency_factor * 14.8,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'ALINEADO DE RIN TRASERO ',
	    60,
	    p_currency_factor * 25.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE VÍAS ',
	    30,
	    p_currency_factor * 5.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'DIAGNÓSTICO Y CORRECCIÓN DE PITO',
	    60,
	    p_currency_factor * 25.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE TORNILLOS DE CARROCERÍA ',
	    25,
	    p_currency_factor * 5.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE MANGUERA DE RADIADOR NS200',
	    60,
	    p_currency_factor * 15.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'ARME DE CABEZAL DE MOTOR',
	    45,
	    p_currency_factor * 20.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'ENDEREZADO DE REGULADORES',
	    20,
	    p_currency_factor * 3.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'MANO DE OBRA',
	    400,
	    p_currency_factor * 60.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE EMPAQUE DE CILINDRO',
	    30,
	    p_currency_factor * 10.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE EMPAQUE DE CULATA',
	    20,
	    p_currency_factor * 6.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'REVISION DE SENSORES',
	    60,
	    p_currency_factor * 20.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'Limpieza de ventilador ',
	    30,
	    p_currency_factor * 10.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'Mantenimiento de carbones ',
	    10,
	    p_currency_factor * 5.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'SOLDADURA DE PARRILLA',
	    0,
	    p_currency_factor * 20.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'ENDEREZADO SOPORTE SILVIN',
	    0,
	    p_currency_factor * 18.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'PRESUPUESTO',
	    75,
	    p_currency_factor * 20.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'DIAGNÓSTICO DE PIEZAS DE MOTOR',
	    25,
	    p_currency_factor * 0.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE VALVULA DE LLANTA',
	    25,
	    p_currency_factor * 5.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'LIMPIEZA,REGULACIÓN Y ENGRASE DE CADENA',
	    15,
	    p_currency_factor * 6.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'Instalacion de portacelulares',
	    30,
	    p_currency_factor * 7.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'REVISION DE FUGA DE GASOLINA ',
	    30,
	    p_currency_factor * 8.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'LIMPIEZA DE CONTACTOS TPS',
	    10,
	    p_currency_factor * 2.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE PERNO ',
	    60,
	    p_currency_factor * 10.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'COLOCACION DE CARGADOR',
	    20,
	    p_currency_factor * 2.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE SELLOS DE BOMBA DE AGUA NS200',
	    60,
	    p_currency_factor * 20.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'Instalacion Electrica',
	    120,
	    p_currency_factor * 15.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'Extracción  de perno ',
	    60,
	    p_currency_factor * 15.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'REVISION DE LUZ CORTESIA',
	    60,
	    p_currency_factor * 15.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'SWITCH VIAS INTERMITENTES ',
	    60,
	    p_currency_factor * 5.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'INSTALACION DE SWITH PARA VIAS INTERMITENTES',
	    40,
	    p_currency_factor * 10.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'REPARACION LLANTA ',
	    30,
	    p_currency_factor * 3.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'REVISION DE SIRENA',
	    25,
	    p_currency_factor * 5.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'REVISION DE AMPOLLETA DE FRENO DELANTERO',
	    10,
	    p_currency_factor * 3.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'Mantenimiento Full 125CC/150CC Con Orden De Proceso Ya Creada ',
	    345,
	    p_currency_factor * 35.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE SIRENA',
	    20,
	    p_currency_factor * 5.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'PRESUPUESTO Y REPARACIÓN DE MOTO INSERVIBLE ',
	    360,
	    p_currency_factor * 90.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'LIMPIEZA Y DIAGNOSTICO DE INYECTOR EN LABORATORIO',
	    120,
	    p_currency_factor * 35.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'INSTALACION DE PROTECTORES DE MANECILLA',
	    60,
	    p_currency_factor * 15.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE ACEITE DE CAJA TRANSMISION',
	    30,
	    p_currency_factor * 10.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'REVISION DE LUZ DE FRENO',
	    30,
	    p_currency_factor * 8.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'Revisión de foco de farol',
	    45,
	    p_currency_factor * 12.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE EMPAQUE FILTRO DE ACEITE',
	    20,
	    p_currency_factor * 3.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'AJUSTE DE MOTOR',
	    100,
	    p_currency_factor * 70.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE O-RING DE MOTOR',
	    15,
	    p_currency_factor * 5.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'EXTRACCION DE TORNILLOS DE BOMBA DE FRENO',
	    20,
	    p_currency_factor * 4.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'INSTALACION DE LODERA UNIVERSAL',
	    20,
	    p_currency_factor * 6.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'LAVADO Y PINTADO EN MOTOR',
	    60,
	    p_currency_factor * 15.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'INSTALACIÓN DE PORTAPLACA',
	    60,
	    p_currency_factor * 15.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'Rectificado rin vespa',
	    30,
	    p_currency_factor * 30.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'REPARACION DE NUCLEOS DE BOBINA ',
	    65,
	    p_currency_factor * 40.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'ENDEREZADO DE PERNOS ',
	    60,
	    p_currency_factor * 15.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'SOLDADURA DE BASE DE POSAPIE',
	    120,
	    p_currency_factor * 30.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'RESET TRIP ODOMETRO ',
	    5,
	    p_currency_factor * 0.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'Pintura de capó',
	    240,
	    p_currency_factor * 75.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'REVISION DE LUZ DE SILVIN',
	    15,
	    p_currency_factor * 5.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'PRE-DIAGNOSTICO',
	    30,
	    p_currency_factor * 0.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'Torno',
	    60,
	    p_currency_factor * 12.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'LIMPIEZA DE TOLVAS INTERNAS',
	    30,
	    p_currency_factor * 7.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'REVISION DE FILTRO DE AIRE MOTOS TODO TERRENO',
	    15,
	    p_currency_factor * 4.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'INSTALACION DE PATA DE PARQUEO',
	    20,
	    p_currency_factor * 5.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'REVISION LADO MAGNETO',
	    30,
	    p_currency_factor * 15.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'MANTENIMIENTO DE FRENO DELANTERO ',
	    60,
	    p_currency_factor * 15.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE LODERA DELANTERA',
	    20,
	    p_currency_factor * 5.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'COLOCACIÓN DE TORNILLOS ',
	    35,
	    p_currency_factor * 8.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'LIMPIEZA DE CULATA',
	    40,
	    p_currency_factor * 10.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'LIMPIEZA DE CILINDRO',
	    40,
	    p_currency_factor * 10.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE RETENEDOR DE TAPADERA MAGNETO',
	    5,
	    p_currency_factor * 5.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE RETENEDOR DE TAPADERA MAGNETO',
	    5,
	    p_currency_factor * 5.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'REVISION DE PEDAL DE CAMBIOS',
	    60,
	    p_currency_factor * 15.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'REVISION DE PEDAL DE CAMBIOS',
	    60,
	    p_currency_factor * 15.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'REVISION DE PEDAL DE CAMBIOS',
	    60,
	    p_currency_factor * 15.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'DESINSTALACIÓN DE CONEXIÓN ',
	    60,
	    p_currency_factor * 15.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'REAPRETE DE PERNOS DE TIMON',
	    15,
	    p_currency_factor * 3.75,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'REVISIÓN DE FUGA DE GASOLINA EN TANQUE ',
	    60,
	    p_currency_factor * 15.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE KIT DE RODOS DE CADENILLA DE TIEMPO ',
	    90,
	    p_currency_factor * 15.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'EXTRACCIÓN DE BALEROS E INSTALACIÓN ',
	    80,
	    p_currency_factor * 20.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'REPARACION DE PRENSA ',
	    340,
	    p_currency_factor * 85.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE BAQUELITA DE ACELERADOR',
	    30,
	    p_currency_factor * 7.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'ENGRASE DE BALEROS DE RIN DELANTERO ',
	    15,
	    p_currency_factor * 7.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'ENGRASE DE BALEROS DE RIN TRASERO ',
	    25,
	    p_currency_factor * 9.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'PRUEBA DE SENSORES CON ESCANER',
	    30,
	    p_currency_factor * 8.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'LECTURA DE CODIGO',
	    20,
	    p_currency_factor * 5.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'LIMPIEZA Y CALIBRACION DE SENSORES ',
	    90,
	    p_currency_factor * 23.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'LIMPIEZA DE CUERPO DE ACELERACION ',
	    60,
	    p_currency_factor * 15.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO SOLUCIÓN DE FRENO ',
	    30,
	    p_currency_factor * 7.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE RODOS DE GUIA DE CADENILLA',
	    90,
	    p_currency_factor * 20.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE BANCADA',
	    90,
	    p_currency_factor * 20.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'Cambio de cunas de dirección NS200',
	    120,
	    p_currency_factor * 30.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'LIMPIEZA MOTOR DE ARRANQUE',
	    60,
	    p_currency_factor * 15.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'TAPIZADO ',
	    180,
	    p_currency_factor * 45.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'TAPIZADO ',
	    180,
	    p_currency_factor * 45.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'REPARACION LUZ PORTA PLACA',
	    60,
	    p_currency_factor * 15.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE BALERO CATARINA',
	    15,
	    p_currency_factor * 8.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'DESARME Y ARME DE CARENADO ',
	    180,
	    p_currency_factor * 30.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'REPARACION CONTAINER REFRIGERANTE',
	    45,
	    p_currency_factor * 5.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'REVISION DE BOMBA DE FRENO TRASERO',
	    30,
	    p_currency_factor * 8.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'REVISION DE TRACCION',
	    45,
	    p_currency_factor * 12.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE RODOS DE CLUTCH',
	    60,
	    p_currency_factor * 15.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'REVISION DE CAJA DE TRACCION AUTOMÁTICAº',
	    60,
	    p_currency_factor * 15.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'REVISION DE DIRECCION ',
	    15,
	    p_currency_factor * 5.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'REVISION DE MONOSHOCK ',
	    60,
	    p_currency_factor * 15.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'FABRICACIÓN EMPAQUE TAPA MAGNETO ',
	    30,
	    p_currency_factor * 8.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'FABRICACIÓN EMPAQUE TAPA MAGNETO ',
	    30,
	    p_currency_factor * 8.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE ACEITE PARA NS200',
	    30,
	    p_currency_factor * 5.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE RELAY',
	    30,
	    p_currency_factor * 6.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'Cambio de eje trasero',
	    15,
	    p_currency_factor * 5.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'Cambio de sensor de velocidades ',
	    30,
	    p_currency_factor * 7.5,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE RIN TRASERO',
	    60,
	    p_currency_factor * 15.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE CENTRIFUGÓ DE ACEITE ',
	    60,
	    p_currency_factor * 15.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE TAPA DE CLUTCH',
	    20,
	    p_currency_factor * 5.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'REVISION DE CLUTCH',
	    90,
	    p_currency_factor * 25.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'REVISION DE SILVIN',
	    20,
	    p_currency_factor * 6.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'QUITAR Y PONER CARBURADOR CON  MANIFUL',
	    30,
	    p_currency_factor * 12.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'REVISION DE AMPOLLETA DE CLUTCH',
	    10,
	    p_currency_factor * 2.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'LAVADO DE RECIPIENTES DE REFRIGERANTE ',
	    15,
	    p_currency_factor * 12.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE EMPAQUE DE TENSOR DE CADENILLA DE TIEMPO',
	    20,
	    p_currency_factor * 5.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'Cambio de aceite y filtro de aceite nivel 1',
	    25,
	    p_currency_factor * 3.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'LIMPIEZA DE CENTRIFUGO DE ACEITE',
	    60,
	    p_currency_factor * 15.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'REVISION DE REFRIGERANTE ',
	    20,
	    p_currency_factor * 5.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE RETENEDOR DE TRANSMISIÓN SCOOTER AUTOMÁTICA ',
	    30,
	    p_currency_factor * 10.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE RETENEDOR DE TRANSMISIÓN SCOOTER AUTOMÁTICA ',
	    30,
	    p_currency_factor * 10.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'Revisión de batería',
	    5,
	    p_currency_factor * 3.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'Revisión de suspensión y sistema de frenos (externa)',
	    20,
	    p_currency_factor * 7.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'Revisión de carrocería y kit de tracción (externa)',
	    10,
	    p_currency_factor * 5.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'Revisión de carrocería y kit de tracción (externa)',
	    10,
	    p_currency_factor * 5.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE RETENEDOR DE ACEITE',
	    24,
	    p_currency_factor * 6.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO DE MANGUERA',
	    8,
	    p_currency_factor * 2.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'ESCALA DE DIAGNÓSTICO MECÁNICA ',
	    160,
	    p_currency_factor * 40.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'LUBRICACION  DE EJE CENTRAL',
	    16,
	    p_currency_factor * 4.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'CAMBIO BENDIX  AUTOMÁTICA ',
	    32,
	    p_currency_factor * 8.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'Servicio de grúa',
	    90,
	    p_currency_factor * 23.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'REPARACIÓN Y PINTADO DE TOLVAS',
	    588,
	    p_currency_factor * 147.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'REVISION Y LIMPIEZA DE VENTILADOR',
	    60,
	    p_currency_factor * 15.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'REVISIÓN DE FUGA DE ACEITE ',
	    45,
	    p_currency_factor * 10.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'LAVADO DE BOMBA DE GASOLINA ',
	    60,
	    p_currency_factor * 15.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'DESARME Y PRESUPUESTO (MOTO CHOCADA) NIVEL 2',
	    480,
	    p_currency_factor * 120.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'ENDEREZADO DE DEFENZA Y PINTADO',
	    40,
	    p_currency_factor * 10.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	), (
	    'INSTALACION CARBURADOR NS200',
	    40,
	    p_currency_factor * 10.0,
	    1,
	    p_workshop_id,
	    CURRENT_TIMESTAMP,
	    CURRENT_TIMESTAMP
	);
	--Guardando los ids
    SELECT ARRAY(SELECT process_id FROM PROCESS WHERE workshop_id = p_workshop_id)
    INTO process_ids;

    --Probando imprimir ids:
    RAISE NOTICE 'IDs: %', process_ids;	



	--Create package process
	--processByPackageRepository.saveAll(GenerateProcessesByPackages.generate(createdWorkshopId, createdPackages, createdProcesses));
	INSERT INTO
	    PACKAGE_PROCESS (
	        package_id,
	        process_id,
	        process_sequence
	    )
	VALUES (
    package_ids [1],
    process_ids [4],
    1
), (
    package_ids [77],
    process_ids [5],
    1
), (
    package_ids [73],
    process_ids [5],
    4
), (
    package_ids [80],
    process_ids [10],
    17
), (
    package_ids [67],
    process_ids [10],
    2
), (
    package_ids [87],
    process_ids [10],
    5
), (
    package_ids [83],
    process_ids [10],
    11
), (
    package_ids [82],
    process_ids [10],
    8
), (
    package_ids [77],
    process_ids [10],
    3
), (
    package_ids [79],
    process_ids [10],
    2
), (
    package_ids [66],
    process_ids [10],
    9
), (
    package_ids [71],
    process_ids [10],
    1
), (
    package_ids [77],
    process_ids [11],
    2
), (
    package_ids [77],
    process_ids [12],
    4
), (
    package_ids [81],
    process_ids [13],
    10
), (
    package_ids [80],
    process_ids [13],
    1
), (
    package_ids [75],
    process_ids [13],
    5
), (
    package_ids [74],
    process_ids [13],
    7
), (
    package_ids [69],
    process_ids [13],
    10
), (
    package_ids [87],
    process_ids [13],
    1
), (
    package_ids [82],
    process_ids [13],
    1
), (
    package_ids [66],
    process_ids [13],
    17
), (
    package_ids [86],
    process_ids [13],
    1
), (
    package_ids [70],
    process_ids [13],
    1
), (
    package_ids [83],
    process_ids [13],
    1
), (
    package_ids [87],
    process_ids [57],
    2
), (
    package_ids [74],
    process_ids [57],
    12
), (
    package_ids [80],
    process_ids [57],
    15
), (
    package_ids [86],
    process_ids [57],
    16
), (
    package_ids [73],
    process_ids [63],
    2
), (
    package_ids [79],
    process_ids [74],
    1
), (
    package_ids [87],
    process_ids [85],
    11
), (
    package_ids [73],
    process_ids [93],
    3
), (
    package_ids [73],
    process_ids [100],
    1
), (
    package_ids [67],
    process_ids [103],
    17
), (
    package_ids [83],
    process_ids [103],
    6
), (
    package_ids [80],
    process_ids [103],
    4
), (
    package_ids [68],
    process_ids [103],
    6
), (
    package_ids [66],
    process_ids [103],
    12
), (
    package_ids [71],
    process_ids [103],
    10
), (
    package_ids [86],
    process_ids [103],
    3
), (
    package_ids [69],
    process_ids [103],
    9
), (
    package_ids [81],
    process_ids [103],
    9
), (
    package_ids [75],
    process_ids [103],
    8
), (
    package_ids [68],
    process_ids [113],
    4
), (
    package_ids [81],
    process_ids [113],
    7
), (
    package_ids [67],
    process_ids [113],
    13
), (
    package_ids [86],
    process_ids [113],
    2
), (
    package_ids [83],
    process_ids [113],
    7
), (
    package_ids [69],
    process_ids [113],
    7
), (
    package_ids [75],
    process_ids [113],
    6
), (
    package_ids [66],
    process_ids [113],
    3
), (
    package_ids [80],
    process_ids [113],
    2
), (
    package_ids [91],
    process_ids [115],
    3
), (
    package_ids [82],
    process_ids [115],
    7
), (
    package_ids [67],
    process_ids [115],
    1
), (
    package_ids [66],
    process_ids [115],
    8
), (
    package_ids [80],
    process_ids [116],
    12
), (
    package_ids [71],
    process_ids [116],
    6
), (
    package_ids [2],
    process_ids [116],
    2
), (
    package_ids [70],
    process_ids [116],
    4
), (
    package_ids [75],
    process_ids [116],
    4
), (
    package_ids [82],
    process_ids [116],
    5
), (
    package_ids [86],
    process_ids [116],
    8
), (
    package_ids [66],
    process_ids [116],
    1
), (
    package_ids [87],
    process_ids [116],
    8
), (
    package_ids [67],
    process_ids [116],
    5
), (
    package_ids [70],
    process_ids [117],
    5
), (
    package_ids [66],
    process_ids [117],
    2
), (
    package_ids [82],
    process_ids [117],
    6
), (
    package_ids [87],
    process_ids [117],
    9
), (
    package_ids [75],
    process_ids [117],
    3
), (
    package_ids [86],
    process_ids [117],
    7
), (
    package_ids [67],
    process_ids [117],
    6
), (
    package_ids [71],
    process_ids [117],
    7
), (
    package_ids [80],
    process_ids [117],
    13
), (
    package_ids [74],
    process_ids [118],
    3
), (
    package_ids [75],
    process_ids [118],
    1
), (
    package_ids [80],
    process_ids [118],
    5
), (
    package_ids [69],
    process_ids [118],
    1
), (
    package_ids [86],
    process_ids [118],
    11
), (
    package_ids [68],
    process_ids [118],
    1
), (
    package_ids [67],
    process_ids [118],
    7
), (
    package_ids [81],
    process_ids [118],
    1
), (
    package_ids [70],
    process_ids [118],
    6
), (
    package_ids [87],
    process_ids [118],
    6
), (
    package_ids [2],
    process_ids [118],
    3
), (
    package_ids [83],
    process_ids [118],
    2
), (
    package_ids [71],
    process_ids [118],
    4
), (
    package_ids [66],
    process_ids [118],
    5
), (
    package_ids [70],
    process_ids [122],
    13
), (
    package_ids [74],
    process_ids [122],
    2
), (
    package_ids [69],
    process_ids [123],
    4
), (
    package_ids [79],
    process_ids [124],
    4
), (
    package_ids [90],
    process_ids [125],
    3
), (
    package_ids [81],
    process_ids [126],
    3
), (
    package_ids [83],
    process_ids [126],
    10
), (
    package_ids [71],
    process_ids [126],
    8
), (
    package_ids [91],
    process_ids [126],
    2
), (
    package_ids [82],
    process_ids [126],
    10
), (
    package_ids [87],
    process_ids [126],
    3
), (
    package_ids [66],
    process_ids [127],
    4
), (
    package_ids [68],
    process_ids [128],
    3
), (
    package_ids [67],
    process_ids [128],
    8
), (
    package_ids [2],
    process_ids [128],
    5
), (
    package_ids [81],
    process_ids [128],
    2
), (
    package_ids [80],
    process_ids [128],
    6
), (
    package_ids [82],
    process_ids [128],
    2
), (
    package_ids [66],
    process_ids [129],
    6
), (
    package_ids [71],
    process_ids [129],
    5
), (
    package_ids [83],
    process_ids [129],
    3
), (
    package_ids [70],
    process_ids [129],
    7
), (
    package_ids [80],
    process_ids [129],
    7
), (
    package_ids [75],
    process_ids [129],
    2
), (
    package_ids [87],
    process_ids [129],
    7
), (
    package_ids [86],
    process_ids [129],
    12
), (
    package_ids [68],
    process_ids [129],
    2
), (
    package_ids [69],
    process_ids [129],
    2
), (
    package_ids [67],
    process_ids [129],
    9
), (
    package_ids [74],
    process_ids [129],
    4
), (
    package_ids [70],
    process_ids [130],
    9
), (
    package_ids [67],
    process_ids [130],
    3
), (
    package_ids [75],
    process_ids [130],
    9
), (
    package_ids [68],
    process_ids [130],
    7
), (
    package_ids [86],
    process_ids [130],
    9
), (
    package_ids [74],
    process_ids [130],
    8
), (
    package_ids [66],
    process_ids [130],
    7
), (
    package_ids [80],
    process_ids [130],
    8
), (
    package_ids [78],
    process_ids [130],
    2
), (
    package_ids [69],
    process_ids [130],
    3
), (
    package_ids [79],
    process_ids [130],
    3
), (
    package_ids [2],
    process_ids [132],
    1
), (
    package_ids [69],
    process_ids [132],
    11
), (
    package_ids [67],
    process_ids [132],
    11
), (
    package_ids [66],
    process_ids [132],
    15
), (
    package_ids [70],
    process_ids [132],
    2
), (
    package_ids [80],
    process_ids [132],
    9
), (
    package_ids [82],
    process_ids [132],
    3
), (
    package_ids [86],
    process_ids [132],
    6
), (
    package_ids [71],
    process_ids [132],
    2
), (
    package_ids [83],
    process_ids [132],
    4
), (
    package_ids [75],
    process_ids [132],
    11
), (
    package_ids [71],
    process_ids [133],
    3
), (
    package_ids [74],
    process_ids [133],
    11
), (
    package_ids [67],
    process_ids [133],
    12
), (
    package_ids [66],
    process_ids [133],
    14
), (
    package_ids [83],
    process_ids [133],
    5
), (
    package_ids [86],
    process_ids [133],
    5
), (
    package_ids [82],
    process_ids [133],
    4
), (
    package_ids [75],
    process_ids [133],
    10
), (
    package_ids [70],
    process_ids [133],
    3
), (
    package_ids [80],
    process_ids [133],
    10
), (
    package_ids [75],
    process_ids [135],
    13
), (
    package_ids [66],
    process_ids [135],
    19
), (
    package_ids [86],
    process_ids [135],
    15
), (
    package_ids [67],
    process_ids [135],
    19
), (
    package_ids [80],
    process_ids [135],
    18
), (
    package_ids [68],
    process_ids [135],
    11
), (
    package_ids [82],
    process_ids [135],
    15
), (
    package_ids [74],
    process_ids [136],
    1
), (
    package_ids [68],
    process_ids [136],
    8
), (
    package_ids [86],
    process_ids [136],
    13
), (
    package_ids [2],
    process_ids [137],
    4
), (
    package_ids [68],
    process_ids [137],
    9
), (
    package_ids [86],
    process_ids [137],
    14
), (
    package_ids [22],
    process_ids [138],
    1
), (
    package_ids [19],
    process_ids [138],
    1
), (
    package_ids [13],
    process_ids [138],
    1
), (
    package_ids [16],
    process_ids [138],
    1
), (
    package_ids [16],
    process_ids [139],
    2
), (
    package_ids [19],
    process_ids [139],
    2
), (
    package_ids [13],
    process_ids [139],
    2
), (
    package_ids [22],
    process_ids [139],
    2
), (
    package_ids [13],
    process_ids [140],
    3
), (
    package_ids [16],
    process_ids [140],
    3
), (
    package_ids [19],
    process_ids [140],
    3
), (
    package_ids [22],
    process_ids [140],
    3
), (
    package_ids [20],
    process_ids [141],
    1
), (
    package_ids [17],
    process_ids [141],
    1
), (
    package_ids [14],
    process_ids [141],
    1
), (
    package_ids [23],
    process_ids [141],
    1
), (
    package_ids [23],
    process_ids [142],
    2
), (
    package_ids [20],
    process_ids [142],
    2
), (
    package_ids [17],
    process_ids [142],
    2
), (
    package_ids [14],
    process_ids [142],
    2
), (
    package_ids [14],
    process_ids [143],
    3
), (
    package_ids [23],
    process_ids [143],
    3
), (
    package_ids [20],
    process_ids [143],
    3
), (
    package_ids [17],
    process_ids [143],
    3
), (
    package_ids [23],
    process_ids [144],
    4
), (
    package_ids [14],
    process_ids [144],
    4
), (
    package_ids [20],
    process_ids [144],
    4
), (
    package_ids [17],
    process_ids [144],
    4
), (
    package_ids [14],
    process_ids [145],
    5
), (
    package_ids [20],
    process_ids [145],
    5
), (
    package_ids [23],
    process_ids [145],
    5
), (
    package_ids [17],
    process_ids [145],
    5
), (
    package_ids [24],
    process_ids [146],
    1
), (
    package_ids [18],
    process_ids [146],
    1
), (
    package_ids [15],
    process_ids [146],
    1
), (
    package_ids [12],
    process_ids [146],
    1
), (
    package_ids [21],
    process_ids [146],
    1
), (
    package_ids [12],
    process_ids [147],
    2
), (
    package_ids [24],
    process_ids [147],
    2
), (
    package_ids [18],
    process_ids [147],
    2
), (
    package_ids [15],
    process_ids [147],
    2
), (
    package_ids [21],
    process_ids [147],
    2
), (
    package_ids [12],
    process_ids [148],
    3
), (
    package_ids [15],
    process_ids [148],
    3
), (
    package_ids [24],
    process_ids [148],
    3
), (
    package_ids [18],
    process_ids [148],
    3
), (
    package_ids [12],
    process_ids [149],
    4
), (
    package_ids [15],
    process_ids [149],
    4
), (
    package_ids [24],
    process_ids [149],
    4
), (
    package_ids [18],
    process_ids [149],
    4
), (
    package_ids [12],
    process_ids [150],
    5
), (
    package_ids [24],
    process_ids [150],
    5
), (
    package_ids [18],
    process_ids [150],
    5
), (
    package_ids [15],
    process_ids [150],
    5
), (
    package_ids [75],
    process_ids [165],
    12
), (
    package_ids [83],
    process_ids [165],
    8
), (
    package_ids [91],
    process_ids [165],
    1
), (
    package_ids [89],
    process_ids [165],
    4
), (
    package_ids [82],
    process_ids [165],
    11
), (
    package_ids [90],
    process_ids [165],
    1
), (
    package_ids [80],
    process_ids [165],
    11
), (
    package_ids [70],
    process_ids [165],
    11
), (
    package_ids [87],
    process_ids [165],
    10
), (
    package_ids [71],
    process_ids [165],
    9
), (
    package_ids [66],
    process_ids [165],
    16
), (
    package_ids [67],
    process_ids [165],
    10
), (
    package_ids [66],
    process_ids [174],
    11
), (
    package_ids [70],
    process_ids [174],
    12
), (
    package_ids [67],
    process_ids [174],
    16
), (
    package_ids [82],
    process_ids [176],
    12
), (
    package_ids [91],
    process_ids [186],
    8
), (
    package_ids [9],
    process_ids [194],
    1
), (
    package_ids [45],
    process_ids [194],
    1
), (
    package_ids [45],
    process_ids [195],
    2
), (
    package_ids [9],
    process_ids [195],
    2
), (
    package_ids [45],
    process_ids [196],
    3
), (
    package_ids [9],
    process_ids [196],
    3
), (
    package_ids [27],
    process_ids [197],
    1
), (
    package_ids [27],
    process_ids [198],
    2
), (
    package_ids [27],
    process_ids [199],
    3
), (
    package_ids [35],
    process_ids [209],
    1
), (
    package_ids [10],
    process_ids [209],
    1
), (
    package_ids [46],
    process_ids [209],
    1
), (
    package_ids [10],
    process_ids [210],
    2
), (
    package_ids [35],
    process_ids [210],
    2
), (
    package_ids [46],
    process_ids [210],
    2
), (
    package_ids [46],
    process_ids [211],
    3
), (
    package_ids [10],
    process_ids [211],
    3
), (
    package_ids [46],
    process_ids [212],
    4
), (
    package_ids [10],
    process_ids [212],
    4
), (
    package_ids [46],
    process_ids [213],
    5
), (
    package_ids [10],
    process_ids [213],
    5
), (
    package_ids [42],
    process_ids [229],
    1
), (
    package_ids [42],
    process_ids [230],
    2
), (
    package_ids [42],
    process_ids [231],
    3
), (
    package_ids [42],
    process_ids [232],
    4
), (
    package_ids [42],
    process_ids [233],
    5
), (
    package_ids [25],
    process_ids [234],
    1
), (
    package_ids [25],
    process_ids [235],
    2
), (
    package_ids [25],
    process_ids [236],
    3
), (
    package_ids [25],
    process_ids [237],
    4
), (
    package_ids [25],
    process_ids [238],
    5
), (
    package_ids [43],
    process_ids [254],
    1
), (
    package_ids [43],
    process_ids [255],
    2
), (
    package_ids [43],
    process_ids [256],
    3
), (
    package_ids [43],
    process_ids [257],
    4
), (
    package_ids [43],
    process_ids [258],
    5
), (
    package_ids [67],
    process_ids [268],
    14
), (
    package_ids [71],
    process_ids [268],
    11
), (
    package_ids [69],
    process_ids [268],
    8
), (
    package_ids [75],
    process_ids [268],
    7
), (
    package_ids [81],
    process_ids [268],
    8
), (
    package_ids [86],
    process_ids [268],
    4
), (
    package_ids [80],
    process_ids [268],
    3
), (
    package_ids [68],
    process_ids [268],
    5
), (
    package_ids [91],
    process_ids [269],
    7
), (
    package_ids [44],
    process_ids [277],
    1
), (
    package_ids [44],
    process_ids [278],
    2
), (
    package_ids [44],
    process_ids [279],
    3
), (
    package_ids [44],
    process_ids [280],
    4
), (
    package_ids [72],
    process_ids [290],
    7
), (
    package_ids [74],
    process_ids [297],
    5
), (
    package_ids [81],
    process_ids [297],
    5
), (
    package_ids [69],
    process_ids [297],
    5
), (
    package_ids [74],
    process_ids [298],
    9
), (
    package_ids [81],
    process_ids [298],
    6
), (
    package_ids [69],
    process_ids [298],
    6
), (
    package_ids [78],
    process_ids [304],
    1
), (
    package_ids [73],
    process_ids [307],
    5
), (
    package_ids [90],
    process_ids [307],
    2
), (
    package_ids [66],
    process_ids [311],
    13
), (
    package_ids [82],
    process_ids [311],
    9
), (
    package_ids [83],
    process_ids [311],
    9
), (
    package_ids [87],
    process_ids [311],
    4
), (
    package_ids [86],
    process_ids [311],
    10
), (
    package_ids [81],
    process_ids [311],
    4
), (
    package_ids [70],
    process_ids [311],
    8
), (
    package_ids [75],
    process_ids [311],
    15
), (
    package_ids [71],
    process_ids [311],
    12
), (
    package_ids [91],
    process_ids [311],
    4
), (
    package_ids [67],
    process_ids [311],
    4
), (
    package_ids [68],
    process_ids [331],
    10
), (
    package_ids [85],
    process_ids [338],
    3
), (
    package_ids [88],
    process_ids [338],
    3
), (
    package_ids [72],
    process_ids [338],
    4
), (
    package_ids [84],
    process_ids [338],
    3
), (
    package_ids [82],
    process_ids [390],
    13
), (
    package_ids [78],
    process_ids [402],
    3
), (
    package_ids [85],
    process_ids [413],
    1
), (
    package_ids [88],
    process_ids [413],
    1
), (
    package_ids [72],
    process_ids [413],
    1
), (
    package_ids [84],
    process_ids [413],
    1
), (
    package_ids [84],
    process_ids [415],
    2
), (
    package_ids [88],
    process_ids [415],
    2
), (
    package_ids [72],
    process_ids [416],
    2
), (
    package_ids [76],
    process_ids [431],
    1
), (
    package_ids [76],
    process_ids [432],
    2
), (
    package_ids [76],
    process_ids [433],
    3
), (
    package_ids [67],
    process_ids [437],
    15
), (
    package_ids [72],
    process_ids [437],
    5
), (
    package_ids [89],
    process_ids [437],
    3
), (
    package_ids [80],
    process_ids [437],
    16
), (
    package_ids [66],
    process_ids [438],
    10
), (
    package_ids [91],
    process_ids [438],
    5
), (
    package_ids [85],
    process_ids [438],
    5
), (
    package_ids [80],
    process_ids [445],
    14
), (
    package_ids [87],
    process_ids [445],
    12
), (
    package_ids [72],
    process_ids [452],
    3
), (
    package_ids [85],
    process_ids [452],
    4
), (
    package_ids [84],
    process_ids [452],
    4
), (
    package_ids [75],
    process_ids [454],
    14
), (
    package_ids [82],
    process_ids [469],
    14
), (
    package_ids [91],
    process_ids [473],
    6
), (
    package_ids [90],
    process_ids [473],
    4
), (
    package_ids [85],
    process_ids [492],
    2
), (
    package_ids [74],
    process_ids [494],
    6
), (
    package_ids [70],
    process_ids [494],
    10
), (
    package_ids [72],
    process_ids [528],
    6
), (
    package_ids [74],
    process_ids [597],
    10
), (
    package_ids [89],
    process_ids [598],
    2
), (
    package_ids [89],
    process_ids [599],
    1
), (
    package_ids [67],
    process_ids [604],
    18
), (
    package_ids [66],
    process_ids [604],
    18
);

	COMMIT;
	END;
	$$
