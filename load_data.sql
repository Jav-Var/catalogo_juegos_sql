SET GLOBAL local_infile = 1;

USE catalogo_juegos;

-- ==============================================================================
-- FASE 1: Tablas independientes (Sin llaves foráneas)
-- ==============================================================================

LOAD DATA LOCAL INFILE 'Data csv/desarrollador.csv'
INTO TABLE desarrollador
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id_desarrollador, nombre, @pagina_web)
SET pagina_web = NULLIF(REPLACE(@pagina_web, '\r', ''), '');

LOAD DATA LOCAL INFILE 'Data csv/genero.csv'
INTO TABLE genero
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id_genero, @nombre)
SET nombre = REPLACE(@nombre, '\r', '');

LOAD DATA LOCAL INFILE 'Data csv/plataforma_venta.csv'
INTO TABLE plataforma_venta
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id_plataforma, nombre, @pagina_web)
SET pagina_web = NULLIF(REPLACE(@pagina_web, '\r', ''), '');

LOAD DATA LOCAL INFILE 'Data csv/usuario.csv'
INTO TABLE usuario
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id_usuario, handle, correo, fecha_registro, nombre, @apellido)
SET apellido = REPLACE(@apellido, '\r', '');

-- ==============================================================================
-- FASE 2: Tablas con dependencias de primer nivel
-- ==============================================================================

LOAD DATA LOCAL INFILE 'Data csv/juego.csv'
INTO TABLE juego
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id_juego, id_desarrollador, nombre, calificacion, @fecha_publicacion)
SET fecha_publicacion = NULLIF(REPLACE(@fecha_publicacion, '\r', ''), '');

LOAD DATA LOCAL INFILE 'Data csv/resena.csv'
INTO TABLE resena
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id_resena, id_juego, id_usuario, titulo, comentario,
 calificacion, @fecha_publicacion)
SET fecha_publicacion = REPLACE(@fecha_publicacion, '\r', '');

-- ==============================================================================
-- FASE 3: Tablas con dependencias de segundo nivel (Tablas intermedias)
-- ==============================================================================

LOAD DATA LOCAL INFILE 'Data csv/juego_genero.csv'
INTO TABLE juego_genero
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id_juego, @id_genero)
SET id_genero = REPLACE(@id_genero, '\r', '');

LOAD DATA LOCAL INFILE 'Data csv/plataforma_juego.csv'
INTO TABLE plataforma_juego
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id_plataforma, @id_juego)
SET id_juego = REPLACE(@id_juego, '\r', '');

LOAD DATA LOCAL INFILE 'Data csv/usuario_juego_guardado.csv'
INTO TABLE usuario_juego_guardado
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id_usuario, @id_juego)
SET id_juego = REPLACE(@id_juego, '\r', '');