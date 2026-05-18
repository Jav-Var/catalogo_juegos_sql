SET GLOBAL local_infile = 1;

-- Seleccionar la base de datos
USE catalogo_juegos;

-- ==============================================================================
-- FASE 1: Tablas independientes (Sin llaves foráneas)
-- ==============================================================================

LOAD DATA LOCAL INFILE 'Data csv/desarrollador.csv'
INTO TABLE desarrollador
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS; -- Ignora la cabecera del CSV

LOAD DATA LOCAL INFILE 'Data csv/generos.csv'
INTO TABLE generos
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'Data csv/plataforma_venta.csv'
INTO TABLE plataforma_venta
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'Data csv/usuario.csv'
INTO TABLE usuario
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- ==============================================================================
-- FASE 2: Tablas con dependencias de primer nivel
-- ==============================================================================

-- Depende de: desarrollador
LOAD DATA LOCAL INFILE 'Data csv/juego.csv'
INTO TABLE juego
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- ==============================================================================
-- FASE 3: Tablas con dependencias de segundo nivel (Tablas intermedias)
-- ==============================================================================

-- Depende de: juego y generos
LOAD DATA LOCAL INFILE 'Data csv/juego_genero.csv'
INTO TABLE juego_genero
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Depende de: plataforma_venta y juego
LOAD DATA LOCAL INFILE 'Data csv/plataforma_juego.csv'
INTO TABLE plataforma_juego
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Depende de: juego y usuario
LOAD DATA LOCAL INFILE 'Data csv/resena.csv'
INTO TABLE resena
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Depende de: usuario y juego
LOAD DATA LOCAL INFILE 'Data csv/usuario_juego_guardado.csv'
INTO TABLE usuario_juego_guardado
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;