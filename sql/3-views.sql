USE agencia_viajes;

-- Vista de las estaciones de una salida en orden
CREATE VIEW estaciones_viaje AS
    SELECT s.id_salida, s.fecha_hora_prevista, v.descripcion, v.id_viaje, e1.id_estacion as id_estacion_salida, e1.nombre_estacion as estacion_salida, e2.id_estacion as id_estacion_llegada, e2.nombre_estacion as estacion_llegada, estaciones_viajes.salida_orden, estaciones_viajes.llegada_orden
FROM
(
    SELECT s1.id_salida AS id_salida, se1.id_estacion AS estacion_salida, se2.id_estacion AS estacion_llegada, se1.orden AS salida_orden, se2.orden AS llegada_orden
	FROM salida s1 JOIN secuencia_estaciones se1 ON (s1.viaje_id_viaje = se1.id_viaje)
	JOIN secuencia_estaciones se2 ON (se1.id_viaje = se2.id_viaje AND se1.orden+1 = se2.orden)
 ) AS estaciones_viajes JOIN estacion e1 ON (estaciones_viajes.estacion_salida = e1.id_estacion)
 	JOIN estacion e2 ON (estaciones_viajes.estacion_llegada = e2.id_estacion)
    JOIN salida s ON (estaciones_viajes.id_salida = s.id_salida)
    JOIN viaje v ON (s.viaje_id_viaje = v.id_viaje);


CREATE VIEW asientos_libres_ocupados AS
SELECT t.id_salida, t.salida, t.llegada, t.num_asiento, t.ocupacion
FROM
((
    -- ocupados
    SELECT ev.id_salida as id_salida, ev.salida_orden, ev.llegada_orden, e1.nombre_estacion as salida, e2.nombre_estacion as llegada, b.num_asiento,  'OCUPADO' as ocupacion
    FROM billete b JOIN estaciones_viaje ev ON (b.id_salida = ev.id_salida)
    JOIN estacion e1 ON (ev.id_estacion_salida = e1.id_estacion)
    JOIN estacion e2 ON (ev.id_estacion_llegada = e2.id_estacion)
    WHERE 
    -- Billete ocupado en 2 estaciones contiguas
    ( b.estacion_salida = ev.id_estacion_salida AND b.estacion_llegada = ev.id_estacion_llegada )
    OR
    -- Billetes vendidos para tramos que abarcan el actual
    ( b.id_billete IN (
        SELECT b2.id_billete
        FROM billete b2 JOIN secuencia_estaciones se1 ON (b2.estacion_salida = se1.id_estacion)
        JOIN secuencia_estaciones se2 ON (b2.estacion_llegada = se2.id_estacion)
        WHERE b2.id_salida = b.id_salida
        AND (
            (se1.orden < ev.salida_orden AND se2.orden >= ev.llegada_orden)
            OR
            (se1.orden <= ev.salida_orden AND se2.orden > ev.llegada_orden)
        )
    ) )
    
)
UNION
(
    -- libres: todos los asientos menos los ocupados
    SELECT _ev.id_salida as id_salida, _ev.salida_orden, _ev.llegada_orden, _e1.nombre_estacion as salida, _e2.nombre_estacion as llegada, _asi.num_asiento,  'LIBRE' as ocupacion
    FROM estaciones_viaje _ev JOIN salida _s USING (id_salida)
    JOIN autobuses _au USING (id_autobus)
    JOIN asiento _asi USING (id_autobus)
    JOIN estacion _e1 ON (_e1.id_estacion = _ev.id_estacion_salida)
    JOIN estacion _e2 ON (_e2.id_estacion = _ev.id_estacion_llegada)
    -- el not exists lo hacemos para quitar los ocupados
    WHERE NOT EXISTS (
        SELECT ev.id_salida as id_salida, ev.salida_orden, ev.llegada_orden, e1.nombre_estacion as salida, e2.nombre_estacion as llegada, b.num_asiento
        FROM billete b JOIN estaciones_viaje ev ON (b.id_salida = ev.id_salida)
        JOIN estacion e1 ON (ev.id_estacion_salida = e1.id_estacion)
        JOIN estacion e2 ON (ev.id_estacion_llegada = e2.id_estacion)
        WHERE ev.id_salida = _ev.id_salida AND _asi.num_asiento = b.num_asiento
                AND _ev.id_estacion_salida = ev.id_estacion_salida
                AND _ev.id_estacion_llegada = ev.id_estacion_llegada
        AND (
        -- Billete ocupado en 2 estaciones continuas
        ( b.estacion_salida = ev.id_estacion_salida AND b.estacion_llegada = ev.id_estacion_llegada )
        OR
        -- Billetes vendidos en tramos que abarcan el actual
        ( b.id_billete IN (
            SELECT b2.id_billete
            FROM billete b2 JOIN secuencia_estaciones se1 ON (b2.estacion_salida = se1.id_estacion)
            JOIN secuencia_estaciones se2 ON (b2.estacion_llegada = se2.id_estacion)
            WHERE b2.id_salida = b.id_salida
            AND (
                (se1.orden < ev.salida_orden AND se2.orden >= ev.llegada_orden)
                OR
                (se1.orden <= ev.salida_orden AND se2.orden > ev.llegada_orden)
            )
        ) )
        )
    )
)) AS t
ORDER BY t.salida_orden, t.llegada_orden, t.num_asiento;