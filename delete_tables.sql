-- Seleccionar la base de datos
USE catalogo_juegos;

-- 1. Desactivar temporalmente la verificación de llaves foráneas
SET FOREIGN_KEY_CHECKS = 0;

-- 2. Eliminar las tablas (el orden ya no importa gracias al paso 1)
DROP TABLE IF EXISTS usuario_juego_guardado;
DROP TABLE IF EXISTS plataforma_juego;
DROP TABLE IF EXISTS juego_genero;
DROP TABLE IF EXISTS resena;
DROP TABLE IF EXISTS generos;
DROP TABLE IF EXISTS plataforma_venta;
DROP TABLE IF EXISTS usuario;
DROP TABLE IF EXISTS juego;
DROP TABLE IF EXISTS desarrollador;

-- 3. Volver a activar la verificación de llaves foráneas (¡Muy importante!)
SET FOREIGN_KEY_CHECKS = 1;