USE catalogo_juegos;

INSERT INTO desarrollador (nombre, pagina_web) VALUES
('CD Projekt Red', 'https://en.cdprojektred.com'),
('Valve Corporation', 'https://www.valvesoftware.com'),
('Larian Studios', 'https://larian.com'),
('Hello Games', 'https://hellogames.org'),
('FromSoftware', 'https://www.fromsoftware.jp');

INSERT INTO plataforma_venta (nombre, pagina_web) VALUES
('Steam', 'https://store.steampowered.com'),
('Epic Games Store', 'https://store.epicgames.com'),
('GOG.com', 'https://www.gog.com');

INSERT INTO usuario (handle, correo, fecha_registro, nombre, apellido) VALUES
('geralt_fan', 'witcher.fan@gmail.com', '2023-01-15', 'Carlos', 'Gomez'),
('rpg_master', 'rmaster99@outlook.com', '2023-05-20', 'Laura', 'Martinez'),
('noob_slayer', 'slayer_x@yahoo.com', '2021-11-05', 'Juan', 'Perez'),
('portal_cake', 'cake.lie@domain.net', '2022-03-10', 'Ana', 'Silva');

INSERT INTO juego (id_desarrollador, nombre, calificacion, fecha_publicacion) VALUES
(1, 'The Witcher 3: Wild Hunt', 10, '2015-05-18'),
(2, 'Portal 2', 10, '2011-04-18'),
(3, 'Baldur''s Gate 3', 10, '2023-08-03'),
(1, 'Cyberpunk 2077', 8, '2020-12-10'),
(4, 'No Man''s Sky', 7, '2016-08-09'),
(5, 'Elden Ring', 9, '2022-02-25');

INSERT INTO juego_genero (id_juego, genero) VALUES
(1, 'RPG'), (1, 'Mundo Abierto'),
(2, 'Puzzle'), (2, 'Plataformas'),
(3, 'RPG'), (3, 'Estrategia'), (3, 'Por Turnos'),
(4, 'RPG'), (4, 'Acción'), (4, 'Sci-Fi'),
(5, 'Supervivencia'), (5, 'Exploración'),
(6, 'RPG'), (6, 'Acción'), (6, 'Soulslike');

INSERT INTO resena (id_juego, id_usuario, titulo, comentario, calificacion, fecha_publicacion) VALUES
(1, 1, 'Una obra maestra absoluta', 'La historia de Geralt es increíble, las misiones secundarias son de lo mejor que he jugado.', 10, '2023-02-01'),
(3, 2, 'El mejor RPG de la década', 'Libertad total. Cada decisión importa.', 10, '2023-09-15'),
(4, 3, 'Buen juego, inicio difícil', 'Empezó con muchos bugs pero ahora es una experiencia fantástica.', 8, '2022-05-10'),
(2, 4, 'Divertido y brillante', 'La inteligencia artificial de GLaDOS es icónica.', 10, '2022-04-01'),
(5, 1, 'Increíble arco de redención', 'Hello Games no se rindió y ahora es un juegazo de exploración.', 8, '2023-08-20');

INSERT INTO plataforma_juego (id_plataforma, id_juego) VALUES
(1, 1), (2, 1), (3, 1), -- Witcher 3 está en Steam, Epic y GOG
(1, 2),                 -- Portal 2 solo en Steam
(1, 3), (3, 3),         -- BG3 en Steam y GOG
(1, 4), (2, 4), (3, 4), -- Cyberpunk 2077 en todos lados
(1, 5),                 -- No Man's Sky en Steam
(1, 6);                 -- Elden Ring en Steam

INSERT INTO usuario_juego_guardado (id_usuario, id_juego) VALUES
(1, 1), (1, 4), (1, 5), -- Usuario 1 tiene juegos de CDPR y NMS
(2, 3), (2, 6),         -- Usuario 2 guarda RPGs (BG3, Elden Ring)
(3, 4),                 -- Usuario 3 guardó Cyberpunk
(4, 2), (4, 1);         -- Usuario 4 tiene Portal y Witcher 3