SELECT j.nombre AS nombre_juego, g.nombre AS nombre_genero
FROM juego_genero jg
JOIN juego j ON jg.id_juego = j.id_juego
JOIN generos g ON jg.id_genero = g.id_genero;

SELECT pv.nombre AS nombre_plataforma, j.nombre AS nombre_juego
FROM plataforma_juego pj
JOIN plataforma_venta pv ON pj.id_plataforma = pv.id_plataforma
JOIN juego j ON pj.id_juego = j.id_juego;

SELECT u.handle AS handle_usuario, j.nombre AS nombre_juego
FROM usuario_juego_guardado ujg
JOIN usuario u ON ujg.id_usuario = u.id_usuario
JOIN juego j ON ujg.id_juego = j.id_juego;