
-- FUNCION TERMINADA (SE NECESITA TEST)

CREATE OR REPLACE FUNCTION calcular_total_por_pais(codigo_pais int)
RETURNS TABLE(suma_process numeric, suma_product numeric, suma_total numeric) AS $$
DECLARE

    current_work_order_id int;
	
	-- Acumuladores:
    suma_process numeric := 0;
	suma_product numeric := 0;
	suma_total numeric := 0;
	
	-- Registro de INVOICE_DETAILS relacionado a la orden 
    detail_record record;
	
	
BEGIN
    FOR current_work_order_id IN 
        SELECT wo.work_order_id
        FROM public."WORKSHOPS" w
        JOIN public."WORK_ORDERS" wo ON w.workshop_id = wo.workshop_id
        WHERE w.country_code = codigo_pais
    LOOP
	
	
	FOR detail_record IN
		select * FROM public."INVOICE_DETAILS" where invoice_id in
		(select invoice_id FROM public."INVOICES" where work_order_id = current_work_order_id)
	
	LOOP
	
		-- Si es paquete o process
		IF (detail_record.product_id IS NULL AND detail_record.process_id IS NULL) 
		OR (detail_record.product_id IS NULL AND detail_record.process_id IS NOT NULL) THEN
		-- Se acumulara su total
    suma_process := suma_process + detail_record.invoice_detail_parcial_total;
		END IF;
	
		-- Si es producto
		IF (detail_record.product_id IS NOT NULL AND detail_record.process_id IS NULL) THEN
    suma_product := suma_product + detail_record.invoice_detail_parcial_total;
		END IF;

		END LOOP;
	
    END LOOP;
	
    RETURN QUERY SELECT suma_process, suma_product, suma_total;
END;	
$$ LANGUAGE plpgsql;

