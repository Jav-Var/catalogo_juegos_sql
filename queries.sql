
-- --------- --
-- Consultas --
-- --------- --

-- Juegos con mejor calificacion de cada desarrollador (Puede ser mas de uno si hay varios con la mejor calificacion para ese desarrollador)
SELECT 
    d.nombre AS nombre_desarrollador,
    j.nombre AS nombre_juego,
    j.calificacion
FROM desarrollador d
INNER JOIN juego j ON d.id_desarrollador = j.id_desarrollador
WHERE j.calificacion = (
    -- Subconsulta correlacionada: busca el máximo para el desarrollador actual
    SELECT MAX(j2.calificacion)
    FROM juego j2
    WHERE j2.id_desarrollador = d.id_desarrollador
);


-- Lista de genero, junto a cuantos juegos hay de cada genero 
SELECT 
    g.nombre AS genero, 
    COUNT(jg.id_juego) AS total_juegos
FROM genero g
LEFT JOIN juego_genero jg ON g.id_genero = jg.id_genero
GROUP BY g.id_genero, g.nombre
ORDER BY total_juegos DESC;

-- Desarrolladores exclusivos: aquellos cuyos juegos se venden en una sola plataforma de distribución.
SELECT 
    d.nombre AS desarrollador,
    COUNT(DISTINCT pj.id_plataforma) AS plataformas_distintas,
    MAX(pv.nombre) AS plataforma_exclusiva
FROM desarrollador d
INNER JOIN juego j ON d.id_desarrollador = j.id_desarrollador
INNER JOIN plataforma_juego pj ON j.id_juego = pj.id_juego
INNER JOIN plataforma_venta pv ON pj.id_plataforma = pv.id_plataforma
GROUP BY d.id_desarrollador, d.nombre
HAVING COUNT(DISTINCT pj.id_plataforma) = 1;


-- ------------------- --
-- Consultas avanzadas --
-- ------------------- --

SELECT 
    j.nombre AS nombre_juego,
    d.nombre AS desarrollador,
    COUNT(r.id_resena) AS total_resenas,
    ROUND(AVG(r.calificacion), 2) AS calificacion_promedio_usuarios,
    MAX(r.calificacion) AS mejor_nota_recibida
FROM juego j
JOIN desarrollador d ON j.id_desarrollador = d.id_desarrollador
JOIN resena r ON j.id_juego = r.id_juego
GROUP BY j.id_juego, j.nombre, d.nombre
HAVING COUNT(r.id_resena) >= 3
ORDER BY calificacion_promedio_usuarios DESC, total_resenas DESC
LIMIT 10;


SELECT 
    d.nombre AS estudio_desarrollador,
    COUNT(DISTINCT j.id_juego) AS juegos_publicados,
    COUNT(r.id_resena) AS total_resenas_recibidas,
    SUM(CASE WHEN r.calificacion >= 8 THEN 1 ELSE 0 END) AS resenas_positivas,
    ROUND(AVG(j.calificacion), 2) AS nota_oficial_promedio
FROM desarrollador d
LEFT JOIN juego j ON d.id_desarrollador = j.id_desarrollador
LEFT JOIN resena r ON j.id_juego = r.id_juego
GROUP BY d.id_desarrollador, d.nombre
ORDER BY total_resenas_recibidas DESC;

SELECT 
    u.handle AS nombre_usuario,
    u.fecha_registro,
    COUNT(r.id_resena) AS cantidad_resenas_escritas,
    ROUND(AVG(r.calificacion), 2) AS promedio_notas_otorgadas,
    MIN(r.fecha_publicacion) AS fecha_primera_resena,
    MAX(r.fecha_publicacion) AS fecha_ultima_resena
FROM usuario u
JOIN resena r ON u.id_usuario = r.id_usuario
GROUP BY u.id_usuario, u.handle, u.fecha_registro
ORDER BY cantidad_resenas_escritas DESC
LIMIT 20;


