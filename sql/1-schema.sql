CREATE DATABASE IF NOT EXISTS agencia_viajes;

USE agencia_viajes;

CREATE TABLE autobuses(
    id_autobus NUMERIC(9) NOT NULL,
    nombre_autobus VARCHAR(30),
    fecha_fabricacion DATE,
    modelo VARCHAR(30),
    tipo_autobus VARCHAR(30)
);
ALTER TABLE autobuses ADD CONSTRAINT tren_pk PRIMARY KEY (id_autobus);

CREATE TABLE salida(
    id_salida NUMERIC(9) NOT NULL,
    fecha_hora_prevista DATETIME NOT NULL,
    fecha_hora_real DATETIME,
    incidencias VARCHAR(350),
    cancelacion CHAR(1) NOT NULL,
    viaje_id_viaje NUMERIC(9) NOT NULL,
    id_autobus NUMERIC(9) NOT NULL
);
ALTER TABLE salida ADD CONSTRAINT salida_pk PRIMARY KEY (id_salida);

CREATE TABLE estacion(
    id_estacion CHAR(7) NOT NULL,
    nombre_estacion VARCHAR(50),
    direccion VARCHAR(100),
    poblacion VARCHAR(50) NOT NULL,
    provincia VARCHAR(40) NOT NULL,
    telefono NUMERIC(9)
);
ALTER TABLE estacion ADD CONSTRAINT estacion_pk PRIMARY KEY (id_estacion);

CREATE TABLE viaje(
    id_viaje NUMERIC(9) NOT NULL,
    dias_semana CHAR(7),
    hora VARCHAR(20),
    estacion_salida CHAR(7) NOT NULL,
    estacion_llegada CHAR(7) NOT NULL,
    descripcion VARCHAR(125),
    tipo VARCHAR(125)
);
ALTER TABLE viaje ADD CONSTRAINT viaje_pk PRIMARY KEY (id_viaje);

ALTER TABLE viaje ADD CONSTRAINT estacion_llegada_fk FOREIGN KEY (estacion_llegada)
    REFERENCES estacion(id_estacion);
ALTER TABLE viaje ADD CONSTRAINT estacion_salida_fk FOREIGN KEY (estacion_salida)
    REFERENCES estacion(id_estacion);
ALTER TABLE salida ADD CONSTRAINT salida_autobuses_fk FOREIGN KEY (id_autobus)
    REFERENCES autobuses(id_autobus);
ALTER TABLE salida ADD CONSTRAINT salida_viaje_fk FOREIGN KEY (viaje_id_viaje)
    REFERENCES viaje(id_viaje);

CREATE TABLE secuencia_estaciones (
    id_viaje NUMERIC(9) NOT NULL,
    id_estacion CHAR(7) NOT NULL,
    orden NUMERIC(3) NOT NULL,
    CONSTRAINT pk_sec_est PRIMARY KEY (id_viaje, id_estacion),
    CONSTRAINT fk_viaje FOREIGN KEY (id_viaje) REFERENCES viaje(id_viaje),
    CONSTRAINT fk_estacion FOREIGN KEY (id_estacion) REFERENCES estacion(id_estacion)
);

CREATE TABLE asiento(
    num_asiento NUMERIC(3) NOT NULL,
    id_autobus NUMERIC(9) NOT NULL,
    CONSTRAINT pk_asiento PRIMARY KEY (num_asiento, id_autobus),
    CONSTRAINT fk_autobus FOREIGN KEY (id_autobus) REFERENCES autobuses(id_autobus)
);

CREATE TABLE billete(
    id_billete NUMERIC(9) NOT NULL,
    fecha_emision DATETIME,
    precio DECIMAL(4,2) NOT NULL,
    num_asiento NUMERIC(3) NOT NULL,
    num_autobus NUMERIC(9) NOT NULL,
    id_salida NUMERIC(9) NOT NULL,
    estacion_salida CHAR(7) NOT NULL,
    estacion_llegada CHAR(7) NOT NULL,
    CONSTRAINT pk_billete PRIMARY KEY (id_billete),
    CONSTRAINT fk_asiento FOREIGN KEY (num_asiento, num_autobus) REFERENCES asiento(num_asiento, id_autobus),
    CONSTRAINT fk_salida FOREIGN KEY (id_salida) REFERENCES salida(id_salida),
    CONSTRAINT fk_estacion_salida FOREIGN KEY (estacion_salida) REFERENCES estacion(id_estacion),
    CONSTRAINT fk_estacion_llegada FOREIGN KEY (estacion_llegada) REFERENCES estacion(id_estacion)
);