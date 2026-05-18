

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


-- Generos, junto a cuantos juegos hay de ese genero 
SELECT 
    g.nombre AS genero, 
    COUNT(jg.id_juego) AS total_juegos
FROM generos g
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

-- Identificar a los usuarios "espectadores" (que han guardado juegos, pero nunca han escrito una reseña).
-- Útil para campañas de email marketing fomentando la participación. (no se chatgpt me dijo eso)
SELECT 
    u.handle, 
    u.correo, 
    COUNT(ujg.id_juego) AS juegos_guardados
FROM usuario u
INNER JOIN usuario_juego_guardado ujg ON u.id_usuario = ujg.id_usuario
LEFT JOIN resena r ON u.id_usuario = r.id_usuario
WHERE r.id_resena IS NULL
GROUP BY u.id_usuario, u.handle, u.correo;


-- Consultas sencillas

-- Lista los IDs de los desarrolladores junto a la cantidad total de títulos que tienen registrados.
SELECT 
    id_desarrollador, 
    COUNT(*) AS total_juegos_registrados
FROM juego
GROUP BY id_desarrollador;


-- Juegos rpg
SELECT 
    j.nombre AS nombre_juego, 
    g.nombre AS genero
FROM generos g
INNER JOIN juego_genero jg ON g.id_genero = jg.id_genero
LEFT JOIN juego j ON jg.id_juego = j.id_juego
WHERE g.nombre LIKE '%RPG%';
