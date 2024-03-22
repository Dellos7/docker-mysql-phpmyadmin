USE agencia_viajes;

-- ESTACIONES
INSERT INTO estacion (id_estacion, nombre_estacion, poblacion, provincia)
    VALUES ('0000001', 'Castellón de la Plana', 'Castelló', 'Castellón');
INSERT INTO estacion (id_estacion, nombre_estacion, poblacion, provincia)
    VALUES ('0000002', 'Almazora', 'Almazora', 'Castellón');
INSERT INTO estacion (id_estacion, nombre_estacion, poblacion, provincia)
    VALUES ('0000003', 'Vila-real', 'Vila-real', 'Castellón');
INSERT INTO estacion (id_estacion, nombre_estacion, poblacion, provincia)
    VALUES ('0000004', 'Burriana', 'Burriana', 'Castellón');
INSERT INTO estacion (id_estacion, nombre_estacion, poblacion, provincia)
    VALUES ('0000005', 'Nules', 'Nules', 'Castellón');
INSERT INTO estacion (id_estacion, nombre_estacion, poblacion, provincia)
    VALUES ('0000006', 'Vinaroz', 'Vinaroz', 'Castellón');
INSERT INTO estacion (id_estacion, nombre_estacion, poblacion, provincia)
    VALUES ('0000007', 'Sagunto', 'Sagunto', 'Valencia');
INSERT INTO estacion (id_estacion, nombre_estacion, poblacion, provincia)
    VALUES ('0000008', 'Valencia - Font de Sant Lluís', 'Valencia', 'Valencia');
INSERT INTO estacion (id_estacion, nombre_estacion, poblacion, provincia)
    VALUES ('0000009', 'Valencia - Nord', 'Valencia', 'Valencia');

-- VIAJES
-- Viaje Castellón-Nules
INSERT INTO viaje (id_viaje, estacion_salida, estacion_llegada, descripcion)
    VALUES (1, '0000001', '0000005', 'Viaje Castellón-Nules');
-- Viaje Sagunto-Valencia
INSERT INTO viaje (id_viaje, estacion_salida, estacion_llegada, descripcion)
    VALUES (2, '0000007', '0000009', 'Viaje Sagunto-Valencia');

-- SECUENCIA ESTACIONES
-- Para el viaje 1 (Castellón-Burriana)
INSERT INTO secuencia_estaciones (id_viaje, id_estacion, orden)
    VALUES (1, '0000001', 1);
INSERT INTO secuencia_estaciones (id_viaje, id_estacion, orden)
    VALUES (1, '0000002', 2);
INSERT INTO secuencia_estaciones (id_viaje, id_estacion, orden)
    VALUES (1, '0000003', 3);
INSERT INTO secuencia_estaciones (id_viaje, id_estacion, orden)
    VALUES (1, '0000004', 4);
INSERT INTO secuencia_estaciones (id_viaje, id_estacion, orden)
    VALUES (1, '0000005', 5);
-- Para el viaje 2 (Sagunto-Valencia)
INSERT INTO secuencia_estaciones (id_viaje, id_estacion, orden)
    VALUES (2, '0000007', 1);
INSERT INTO secuencia_estaciones (id_viaje, id_estacion, orden)
    VALUES (2, '0000008', 2);
INSERT INTO secuencia_estaciones (id_viaje, id_estacion, orden)
    VALUES (2, '0000009', 3);

-- AUTOBUSES
INSERT INTO autobuses (id_autobus, modelo) VALUES (1, 'Mercedes Vito');

-- ASIENTOS
-- Para el autobús 1
INSERT INTO asiento (id_autobus, num_asiento) VALUES (1, 1);
INSERT INTO asiento (id_autobus, num_asiento) VALUES (1, 2);
INSERT INTO asiento (id_autobus, num_asiento) VALUES (1, 3);
INSERT INTO asiento (id_autobus, num_asiento) VALUES (1, 4);
INSERT INTO asiento (id_autobus, num_asiento) VALUES (1, 5);
INSERT INTO asiento (id_autobus, num_asiento) VALUES (1, 6);
INSERT INTO asiento (id_autobus, num_asiento) VALUES (1, 7);
INSERT INTO asiento (id_autobus, num_asiento) VALUES (1, 8);
INSERT INTO asiento (id_autobus, num_asiento) VALUES (1, 9);
INSERT INTO asiento (id_autobus, num_asiento) VALUES (1, 10);

-- SALIDAS
-- Salida programada para el viaje Castellón-Nules (1) y autobús Mercedes Vito (1)
INSERT INTO salida (id_salida, fecha_hora_prevista, cancelacion, viaje_id_viaje, id_autobus)
    VALUES (1, '2021-02-10 17:00:00', 'N', 1, 1);

-- Salida programada para el viaje Sagunto-Valencia (2) y autobús Mercedes Vito (1)
INSERT INTO salida (id_salida, fecha_hora_prevista, cancelacion, viaje_id_viaje, id_autobus)
    VALUES (2, '2021-02-11 13:00:00', 'N', 2, 1);

-- BILLETES

-- Para la salida Castellón-Nules (1)
-- Asiento 2 ocupado de Castellón a Almazora
INSERT INTO billete
    (id_billete, precio, num_asiento, num_autobus, id_salida, estacion_salida, estacion_llegada)
    VALUES (1, 5.2, 2, 1, 1, '0000001', '0000002');
-- Asiento 5 ocupado todo el viaje
INSERT INTO billete
    (id_billete, precio, num_asiento, num_autobus, id_salida, estacion_salida, estacion_llegada)
    VALUES (2, 20.5, 5, 1, 1, '0000001', '0000005');
-- Asiento 7 ocupado de Burriana a Nules
INSERT INTO billete
    (id_billete, precio, num_asiento, num_autobus, id_salida, estacion_salida, estacion_llegada)
    VALUES (3, 10, 7, 1, 1, '0000004', '0000005');
-- Asiento 6 ocupado de Almazora a Burriana
INSERT INTO billete
    (id_billete, precio, num_asiento, num_autobus, id_salida, estacion_salida, estacion_llegada)
    VALUES (4, 8.3, 6, 1, 1, '0000002', '0000004');

-- Para la salida Sagunto-Valencia (2)
-- Asiento 1 ocupado de Sagunto a Valencia-Font Sant Lluiís
INSERT INTO billete
    (id_billete, precio, num_asiento, num_autobus, id_salida, estacion_salida, estacion_llegada)
    VALUES (5, 4.2, 1, 1, 2, '0000007', '0000008');
-- Asiento 9 ocupado de Sagunto a Valencia-Norte
INSERT INTO billete
    (id_billete, precio, num_asiento, num_autobus, id_salida, estacion_salida, estacion_llegada)
    VALUES (6, 6.3, 9, 1, 2, '0000007', '0000009');