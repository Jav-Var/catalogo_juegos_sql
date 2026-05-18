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
-- USANDO ARCHIVOS CON NOMBRES EN LUGAR DE IDs
-- ==============================================================================

-- 1. Depende de: juego y generos
LOAD DATA LOCAL INFILE 'Data csv/juego_genero_nombres.csv'
INTO TABLE juego_genero
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@nombre_juego, @nombre_genero) -- Leemos el CSV en variables temporales
SET 
  id_juego = (SELECT id_juego FROM juego WHERE nombre = @nombre_juego LIMIT 1),
  id_genero = (SELECT id_genero FROM generos WHERE nombre = @nombre_genero LIMIT 1);

-- 2. Depende de: plataforma_venta y juego
LOAD DATA LOCAL INFILE 'Data csv/plataforma_juego_nombres.csv'
INTO TABLE plataforma_juego
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@nombre_plataforma, @nombre_juego) -- Leemos el CSV en variables temporales
SET 
  id_plataforma = (SELECT id_plataforma FROM plataforma_venta WHERE nombre = @nombre_plataforma LIMIT 1),
  id_juego = (SELECT id_juego FROM juego WHERE nombre = @nombre_juego LIMIT 1);

-- 3. Depende de: usuario y juego
LOAD DATA LOCAL INFILE 'Data csv/usuario_juego_guardado_nombres.csv'
INTO TABLE usuario_juego_guardado
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@handle_usuario, @nombre_juego) -- Leemos el CSV en variables temporales
SET 
  id_usuario = (SELECT id_usuario FROM usuario WHERE handle = @handle_usuario LIMIT 1),
  id_juego = (SELECT id_juego FROM juego WHERE nombre = @nombre_juego LIMIT 1);