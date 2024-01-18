--TABLA COLORS:
--Primero crear la columna que contendra el valor hexa del color_name	
ALTER TABLE colors
ADD COLUMN color_hex VARCHAR[];

--Funcion para retornar el valor hexa (o los valores) dado un nombre de color:
CREATE OR REPLACE FUNCTION get_color_hex(color_name VARCHAR)
RETURNS VARCHAR[] 
LANGUAGE plpgsql
AS $$
DECLARE
hex_codes VARCHAR[];
BEGIN
SELECT ARRAY_AGG(
CASE
WHEN unnest(string_to_array(color_name, '/')) = 'ROJO' THEN '#FF0000'
WHEN unnest(string_to_array(color_name, '/')) = 'AZUL' THEN '#0000FF'
WHEN unnest(string_to_array(color_name, '/')) = 'NEGRO' THEN '#000000'
WHEN unnest(string_to_array(color_name, '/')) = 'BLANCO' THEN '#FFFFFF'
WHEN unnest(string_to_array(color_name, '/')) = 'GRIS' THEN '#808080'
WHEN unnest(string_to_array(color_name, '/')) = 'AMARILLO' THEN '#FFFF00'
WHEN unnest(string_to_array(color_name, '/')) = 'VERDE' THEN '#008000'
WHEN unnest(string_to_array(color_name, '/')) = 'CAFE' THEN '#A52A2A'
ELSE NULL
END)
INTO hex_codes;

RETURN hex_codes;
END;
$$;

--Ahora vamos a insertar los colores hex, en funcion de sus nombres
UPDATE colors
SET color_hex = get_color_hex(color_name);

--TABLA VEHICLES:
--Ahora solo copiamos el valor hexa del color en funcion del id
UPDATE vehicles AS v
SET colors = c.color_hex
FROM colors AS c
WHERE v.color_id IS NOT NULL
AND v.colors IS NULL
AND v.color_id = c.color_id;