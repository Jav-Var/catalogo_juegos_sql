import zipfile
import csv
import io

# 1. GENEROS (30 registros)
generos_data = [
    (1, "Acción"), (2, "Aventura"), (3, "RPG"), (4, "Estrategia"), (5, "Simulación"),
    (6, "Deportes"), (7, "Carreras"), (8, "Plataformas"), (9, "Puzle"), (10, "Terror"),
    (11, "Metroidvania"), (12, "Roguelike"), (13, "Supervivencia"), (14, "Disparos FPS"), (15, "Disparos TPS"),
    (16, "Peleas"), (17, "Musical"), (18, "Party Game"), (19, "Novela Visual"), (20, "MMORPG"),
    (21, "Arcade"), (22, "Sigilo"), (23, "Hack and Slash"), (24, "Sandbox"), (25, "Mundo Abierto"),
    (26, "Estrategia Táctica"), (27, "Educativo"), (28, "Cartas"), (29, "Novela Gráfica"), (30, "Misterio")
]

# 2. DESARROLLADORES (20 registros ampliados para dar variedad)
desarrolladores_data = [
    (1, "Nintendo", "https://www.nintendo.com"),
    (2, "Sony Interactive Entertainment", "https://www.playstation.com"),
    (3, "Xbox Game Studios", "https://www.xbox.com"),
    (4, "Valve Corporation", "https://www.valvesoftware.com"),
    (5, "Epic Games", "https://www.epicgames.com"),
    (6, "Electronic Arts", "https://www.ea.com"),
    (7, "Ubisoft", "https://www.ubisoft.com"),
    (8, "Square Enix", "https://www.square-enix.com"),
    (9, "Capcom", "https://www.capcom.com"),
    (10, "CD Projekt Red", "https://en.cdprojektred.com"),
    (11, "Team Cherry", "https://www.teamcherry.com.au"),
    (12, "Mojang Studios", "https://www.minecraft.net"),
    (13, "Toby Fox", "https://undertale.com"),
    (14, "FromSoftware", "https://www.fromsoftware.jp"),
    (15, "Rockstar Games", "https://www.rockstargames.com"),
    (16, "Konami", "https://www.konami.com"),
    (17, "Sega", "https://www.sega.com"),
    (18, "Atari", "https://www.atari.com"),
    (19, "Daedalic Entertainment", "https://www.daedalic.com"),
    (20, "Game Freak", "https://www.gamefreak.co.jp")
]

# 3. JUEGOS (200 registros reales: Clásicos, Indies, Terror, Retro y "Malos")
juegos_data = [
    # Nintendo (1-15)
    (1, 1, "Super Mario Odyssey", 10, "2017-10-27"),
    (2, 1, "The Legend of Zelda: Breath of the Wild", 10, "2017-03-03"),
    (3, 1, "Splatoon 2", 8, "2017-07-21"),
    (4, 1, "Mario Kart 8 Deluxe", 9, "2017-04-28"),
    (5, 1, "Animal Crossing: New Horizons", 9, "2020-03-20"),
    (6, 1, "The Legend of Zelda: Tears of the Kingdom", 10, "2023-05-12"),
    (7, 1, "Super Smash Bros. Ultimate", 10, "2018-12-07"),
    (8, 1, "Luigi's Mansion 3", 9, "2019-10-31"),
    (9, 1, "Metroid Dread", 9, "2021-10-08"),
    (10, 1, "Xenoblade Chronicles 3", 9, "2022-07-29"),
    (11, 1, "Fire Emblem Engage", 8, "2023-01-20"),
    (12, 1, "Super Mario Bros. Wonder", 9, "2023-10-20"),
    (13, 1, "Donkey Kong Country: Tropical Freeze", 9, "2014-02-21"),
    (14, 1, "Pikmin 4", 9, "2023-07-21"),
    (15, 1, "Kirby and the Forgotten Land", 9, "2022-03-25"),
    # Sony (16-30)
    (16, 2, "God of War", 10, "2018-04-20"),
    (17, 2, "Marvel's Spider-Man", 9, "2018-09-07"),
    (18, 2, "The Last of Us Part II", 9, "2020-06-19"),
    (19, 2, "Horizon Zero Dawn", 9, "2017-02-28"),
    (20, 2, "Bloodborne", 10, "2015-03-24"),
    (21, 2, "Uncharted 4: A Thief's End", 10, "2016-05-10"),
    (22, 2, "Ghost of Tsushima", 9, "2020-07-17"),
    (23, 2, "God of War Ragnarok", 10, "2022-11-09"),
    (24, 2, "Gran Turismo 7", 8, "2022-03-04"),
    (25, 2, "Ratchet & Clank: Rift Apart", 9, "2021-06-11"),
    (26, 2, "Days Gone", 7, "2019-04-26"),
    (27, 2, "The Last of Us Part I", 9, "2022-09-02"),
    (28, 2, "Horizon Forbidden West", 9, "2022-02-18"),
    (29, 2, "Infamous Second Son", 8, "2014-03-21"),
    (30, 2, "Killzone Shadow Fall", 7, "2013-11-15"),
    # Xbox (31-45)
    (31, 3, "Halo Infinite", 8, "2021-12-08"),
    (32, 3, "Forza Horizon 5", 10, "2021-11-09"),
    (33, 3, "Gears 5", 8, "2019-09-10"),
    (34, 3, "Sea of Thieves", 7, "2018-03-20"),
    (35, 3, "Microsoft Flight Simulator", 9, "2020-08-18"),
    (36, 3, "Halo: The Master Chief Collection", 9, "2014-11-11"),
    (37, 3, "Forza Motorsport", 7, "2023-10-10"),
    (38, 3, "Gears of War 4", 8, "2016-10-11"),
    (39, 3, "State of Decay 2", 7, "2018-05-22"),
    (40, 3, "Sunset Overdrive", 8, "2014-10-28"),
    (41, 3, "Quantum Break", 7, "2016-04-05"),
    (42, 3, "Ori and the Will of the Wisps", 10, "2020-03-11"),
    (43, 3, "Psychonauts 2", 9, "2021-08-25"),
    (44, 3, "Starfield", 7, "2023-09-06"),
    (45, 3, "Redfall", 3, "2023-05-02"),  # MALO
    # Valve (46-55)
    (46, 4, "Half-Life: Alyx", 10, "2020-03-23"),
    (47, 4, "Portal 2", 10, "2011-04-18"),
    (48, 4, "Left 4 Dead 2", 9, "2009-11-17"),
    (49, 4, "Dota 2", 8, "2013-07-09"),
    (50, 4, "Counter-Strike 2", 8, "2023-09-27"),
    (51, 4, "Half-Life 2", 10, "2004-11-16"),
    (52, 4, "Portal", 10, "2007-10-10"),
    (53, 4, "Team Fortress 2", 9, "2007-10-10"),
    (54, 4, "Left 4 Dead", 9, "2008-11-18"),
    (55, 4, "Half-Life", 10, "1998-11-19"),
    # Epic Games (56-65)
    (56, 5, "Fortnite", 8, "2017-07-25"),
    (57, 5, "Rocket League", 9, "2015-07-07"),
    (58, 5, "Unreal Tournament 3", 7, "2007-11-19"),
    (59, 5, "Gears of War", 9, "2006-11-07"),
    (60, 5, "Shadow Complex", 9, "2009-08-19"),
    (61, 5, "Bulletstorm", 8, "2011-02-22"),
    (62, 5, "Gears of War 2", 9, "2008-11-07"),
    (63, 5, "Gears of War 3", 9, "2011-09-20"),
    (64, 5, "Unreal Gold", 8, "1998-05-22"),
    (65, 5, "Paragon", 5, "2016-03-18"),
    # Electronic Arts (66-80)
    (66, 6, "FIFA 23", 7, "2022-09-27"),
    (67, 6, "The Sims 4", 8, "2014-09-02"),
    (68, 6, "Battlefield 1", 9, "2016-10-21"),
    (69, 6, "Apex Legends", 9, "2019-02-04"),
    (70, 6, "Mass Effect Legendary Edition", 10, "2021-05-14"),
    (71, 6, "Dead Space Remake", 10, "2023-01-27"),
    (72, 6, "Star Wars Jedi: Survivor", 9, "2023-04-28"),
    (73, 6, "It Takes Two", 10, "2021-03-26"),
    (74, 6, "Need for Speed Unbound", 7, "2022-12-02"),
    (75, 6, "Battlefield 2042", 5, "2021-11-19"),
    (76, 6, "Anthem", 4, "2019-02-22"),  # MALO
    (77, 6, "Mass Effect: Andromeda", 6, "2017-03-21"),
    (78, 6, "Dragon Age: Inquisition", 9, "2014-11-18"),
    (79, 6, "Titanfall 2", 10, "2016-10-28"),
    (80, 6, "SimCity (2013)", 5, "2013-03-05"),
    # Ubisoft (81-95)
    (81, 7, "Assassin's Creed Valhalla", 8, "2020-11-10"),
    (82, 7, "Far Cry 6", 7, "2021-10-07"),
    (83, 7, "Rainbow Six Siege", 9, "2015-12-01"),
    (84, 7, "Watch Dogs: Legion", 6, "2020-10-29"),
    (85, 7, "Rayman Legends", 9, "2013-08-29"),
    (86, 7, "Assassin's Creed II", 10, "2009-11-17"),
    (87, 7, "Far Cry 3", 10, "2012-11-29"),
    (88, 7, "Tom Clancy's The Division 2", 8, "2019-03-15"),
    (89, 7, "Ghost Recon Breakpoint", 5, "2019-10-04"),
    (90, 7, "Immortal Fenyx Rising", 8, "2020-12-03"),
    (91, 7, "Assassin's Creed Unity", 6, "2014-11-11"),
    (92, 7, "South Park: The Stick of Truth", 9, "2014-03-04"),
    (93, 7, "Prince of Persia: The Sands of Time", 9, "2003-11-06"),
    (94, 7, "Skull and Bones", 4, "2024-02-16"),  # MALO
    (95, 7, "Just Dance 2024", 7, "2023-10-24"),
    # Square Enix (96-110)
    (96, 8, "Final Fantasy VII Remake", 9, "2020-04-10"),
    (97, 8, "Kingdom Hearts III", 8, "2019-01-25"),
    (98, 8, "NieR: Automata", 10, "2017-02-23"),
    (99, 8, "Dragon Quest XI", 9, "2017-07-29"),
    (100, 8, "Tomb Raider", 8, "2013-03-05"),
    (101, 8, "Chrono Trigger", 10, "1995-03-11"),  # RETRO
    (102, 8, "Final Fantasy VI", 10, "1994-04-02"),  # RETRO
    (103, 8, "Final Fantasy XVI", 9, "2023-06-22"),
    (104, 8, "Octopath Traveler II", 9, "2023-02-24"),
    (105, 8, "Deus Ex: Mankind Divided", 8, "2016-08-23"),
    (106, 8, "Just Cause 4", 6, "2018-12-04"),
    (107, 8, "Babylon's Fall", 2, "2022-03-03"),  # MUY MALO
    (108, 8, "Left Alive", 3, "2019-03-05"),  # MALO
    (109, 8, "Life is Strange", 9, "2015-01-30"),
    (110, 8, "Sleeping Dogs", 9, "2012-08-14"),
    # Capcom (111-125)
    (111, 9, "Resident Evil Village", 9, "2021-05-07"),  # TERROR
    (112, 9, "Monster Hunter: World", 10, "2018-01-26"),
    (113, 9, "Street Fighter V", 7, "2016-02-16"),
    (114, 9, "Devil May Cry 5", 10, "2019-03-08"),
    (115, 9, "Mega Man 11", 8, "2018-10-02"),
    (116, 9, "Resident Evil 4 Remake", 10, "2023-03-24"),
    (117, 9, "Resident Evil 7: Biohazard", 9, "2017-01-24"),  # TERROR
    (118, 9, "Monster Hunter Rise", 9, "2021-03-26"),
    (119, 9, "Street Fighter 6", 10, "2023-06-02"),
    (120, 9, "Dead Rising", 8, "2006-08-08"),
    (121, 9, "Okami", 10, "2006-04-20"),
    (122, 9, "Phoenix Wright: Ace Attorney", 9, "2001-10-12"),
    (123, 9, "Resident Evil 2 (1998)", 10, "1998-01-21"),  # RETRO/TERROR
    (124, 9, "Umbrella Corps", 2, "2016-06-21"),  # MALO
    (125, 9, "Exoprimal", 6, "2023-07-14"),
    # CD Projekt Red (126-132)
    (126, 10, "The Witcher 3: Wild Hunt", 10, "2015-05-19"),
    (127, 10, "Cyberpunk 2077", 9, "2020-12-10"),
    (128, 10, "Gwent: The Witcher Card Game", 8, "2018-10-23"),
    (129, 10, "Thronebreaker: The Witcher Tales", 8, "2018-10-23"),
    (130, 10, "The Witcher 2: Assassins of Kings", 9, "2011-05-17"),
    (131, 10, "The Witcher: Enhanced Edition", 7, "2007-10-30"),
    (132, 10, "Cyberpunk 2077: Phantom Liberty", 10, "2023-09-26"),
    # Team Cherry (133-135) - INDIE / METROIDVANIA
    (133, 11, "Hollow Knight", 10, "2017-02-24"),
    (134, 11, "Hollow Knight: Voidheart Edition", 10, "2018-09-25"),
    (135, 11, "Hollow Knight: Silksong (Demo)", 8, "2019-06-11"),
    # Mojang (136-138) - INDIE / SANDBOX
    (136, 12, "Minecraft", 10, "2011-11-18"),
    (137, 12, "Minecraft Dungeons", 7, "2020-05-26"),
    (138, 12, "Minecraft Legends", 6, "2023-04-18"),
    # Toby Fox (139-141) - INDIE / RETRO
    (139, 13, "Undertale", 10, "2015-09-15"),
    (140, 13, "Deltarune Chapter 1", 9, "2018-10-31"),
    (141, 13, "Deltarune Chapter 2", 10, "2021-09-17"),
    # FromSoftware (142-155)
    (142, 14, "Elden Ring", 10, "2022-02-25"),
    (143, 14, "Dark Souls", 10, "2011-09-22"),
    (144, 14, "Dark Souls II", 8, "2014-03-11"),
    (145, 14, "Dark Souls III", 10, "2016-03-24"),
    (146, 14, "Sekiro: Shadows Die Twice", 10, "2019-03-22"),
    (147, 14, "Armored Core VI: Fires of Rubicon", 9, "2023-08-25"),
    (148, 14, "Demon's Souls", 9, "2009-02-05"),
    (149, 14, "Bloodborne: The Old Hunters", 10, "2015-11-24"),
    (150, 14, "Armored Core V", 7, "2012-03-20"),
    (151, 14, "King's Field", 7, "1994-12-16"),  # RETRO
    (152, 14, "Otogi: Myth of Demons", 8, "2002-12-12"),
    (153, 14, "Ninja Blade", 5, "2009-01-29"),
    (154, 14, "Dark Souls Remastered", 9, "2018-05-24"),
    (155, 14, "Elden Ring: Shadow of the Erdtree", 10, "2024-06-21"),
    # Rockstar Games (156-170)
    (156, 15, "Grand Theft Auto V", 10, "2013-09-17"),
    (157, 15, "Red Dead Redemption 2", 10, "2018-10-26"),
    (158, 15, "Grand Theft Auto: San Andreas", 10, "2004-10-26"),  # RETRO
    (159, 15, "Red Dead Redemption", 10, "2010-05-18"),
    (160, 15, "Bully", 9, "2006-10-17"),
    (161, 15, "L.A. Noire", 9, "2011-05-17"),
    (162, 15, "Max Payne 3", 9, "2012-05-15"),
    (163, 15, "Grand Theft Auto IV", 10, "2008-04-29"),
    (164, 15, "Grand Theft Auto: Vice City", 10, "2002-10-29"),  # RETRO
    (165, 15, "Grand Theft Auto III", 9, "2001-10-22"),  # RETRO
    (166, 15, "Manhunt", 8, "2003-11-18"),  # TERROR
    (167, 15, "Midnight Club 3: DUB Edition", 9, "2005-04-11"),
    (168, 15, "GTA: The Trilogy - Definitive Edition", 4, "2021-11-11"),  # MALO
    (169, 15, "Red Dead Revolver", 7, "2004-05-04"),
    (170, 15, "The Warriors", 9, "2005-10-17"),
    # Konami (171-180)
    (171, 16, "Metal Gear Solid 3: Snake Eater", 10, "2004-11-17"),  # RETRO
    (172, 16, "Silent Hill 2", 10, "2001-09-24"),  # RETRO / TERROR
    (173, 16, "Castlevania: Symphony of the Night", 10, "1997-03-20"),  # RETRO
    (174, 16, "Metal Gear Solid V: The Phantom Pain", 9, "2015-09-01"),
    (175, 16, "Silent Hill 3", 9, "2003-05-23"),  # TERROR
    (176, 16, "Contra", 9, "1987-02-20"),  # RETRO
    (177, 16, "eFootball 2022", 2, "2021-09-30"),  # MALO
    (178, 16, "Metal Gear Solid", 10, "1998-09-03"),  # RETRO
    (179, 16, "Super Bomberman R", 6, "2017-03-03"),
    (180, 16, "Metal Gear Survive", 4, "2018-02-20"),  # MALO
    # Sega (181-190)
    (181, 17, "Sonic the Hedgehog", 9, "1991-06-23"),  # RETRO
    (182, 17, "Yakuza 0", 10, "2015-03-12"),
    (183, 17, "Persona 5 Royal", 10, "2019-10-31"),
    (184, 17, "Sonic Mania", 9, "2017-08-15"),
    (185, 17, "Sonic the Hedgehog (2006)", 3, "2006-11-14"),  # MALO
    (186, 17, "Yakuza: Like a Dragon", 9, "2020-01-16"),
    (187, 17, "Alien: Isolation", 9, "2014-10-07"),  # TERROR
    (188, 17, "Total War: WARHAMMER III", 8, "2022-02-17"),
    (189, 17, "Sonic Frontiers", 8, "2022-11-08"),
    (190, 17, "Sonic Forces", 5, "2017-11-07"),
    # Atari (191-195)
    (191, 18, "E.T. the Extra-Terrestrial", 1, "1982-12-01"),  # MALO HISTORICO
    (192, 18, "Asteroids", 8, "1979-11-01"),  # RETRO
    (193, 18, "Centipede", 8, "1981-06-01"),  # RETRO
    (194, 18, "Pong", 8, "1972-11-29"),  # RETRO
    (195, 18, "RollerCoaster Tycoon", 10, "1999-03-31"),  # RETRO
    # Daedalic Entertainment (196-198)
    (196, 19, "The Lord of the Rings: Gollum", 2, "2023-05-25"),  # MALO
    (197, 19, "Deponia", 8, "2012-01-27"),
    (198, 19, "The Pillars of the Earth", 8, "2017-08-15"),
    # Game Freak (199-200)
    (199, 20, "Pokemon Scarlet", 6, "2022-11-18"),
    (200, 20, "Pokemon Violet", 6, "2022-11-18")
]

# 4. USUARIOS (50 registros balanceados)
usuarios_data = []
nombres = ["Carlos", "Lucia", "Mario", "Ana", "Jorge", "Elena", "David", "Laura", "Pedro", "Sofia"]
apellidos = ["Gomez", "Fernandez", "Bros", "Martinez", "Perez", "Ruiz", "Sanchez", "Diaz", "Ramirez", "Torres"]
for i in range(1, 51):
    nom = nombres[(i - 1) % 10]
    ape = apellidos[(i * 3) % 10]
    handle = f"Gamer_{nom}_{i}"
    correo = f"user_{i}@catalogo.com"
    fecha = f"2024-{((i-1)%12)+1:02d}-15"
    usuarios_data.append((i, handle, correo, fecha, nom, ape))

# 5. RESEÑAS (100 registros realistas mapeados a juegos buenos y malos)
resenas_data = []
comentarios_buenos = [
    "Una absoluta obra maestra. Recomendado totalmente.",
    "Excelente jugabilidad y una historia inolvidable.",
    "No puedo dejar de jugarlo, vale cada centavo.",
    "El apartado visual y la banda sonora son increibles."
]
comentarios_malos = [
    "Un desastre total, lleno de fallos y roto de salida.",
    "Aburrido, sin ritmo y una decepcion absoluta.",
    "Es injugable, no entiendo como lanzaron esto al mercado.",
    "Dinero tirado a la basura. Evitenlo a toda costa."
]

for i in range(1, 101):
    # Alternar entre juegos top (como Elden Ring, Mario, etc.) y juegos malos
    if i % 4 == 0:
        juego_id = 45 if i % 2 == 0 else 196  # Redfall o Gollum
        usuario_id = ((i * 7) % 50) + 1
        titulo = "Una estafa" if i % 2 == 0 else "Decepcion absoluta"
        comentario = comentarios_malos[i % 4]
        calif = 2
    elif i % 5 == 0:
        juego_id = 191 if i % 2 == 0 else 124  # E.T. o Umbrella Corps
        usuario_id = ((i * 3) % 50) + 1
        titulo = "Horrible"
        comentario = comentarios_malos[(i + 1) % 4]
        calif = 1
    else:
        juego_id = ((i * 2) % 200) + 1  # Distribuido
        if juego_id in [45, 107, 108, 124, 168, 177, 180, 185, 191, 196]:
            juego_id = 142  # Forzar a Elden Ring si cae en uno malo para mantener balance positivo mayoritario
        usuario_id = ((i * 2) % 50) + 1
        titulo = "Juegazo!" if i % 2 == 0 else "Muy recomendado"
        comentario = comentarios_buenos[i % 4]
        calif = 9 if i % 2 == 0 else 10

    fecha = f"2025-{((i-1)%12)+1:02d}-20"
    resenas_data.append((i, juego_id, usuario_id, titulo, comentario, calif, fecha))

# 6. JUEGO_GENERO (100 mapeos coherentes)
juego_genero_data = []
for i in range(1, 101):
    jg_juego = i * 2  # Asignar a juegos pares (2, 4, 6... 200)
    # Asignaciones logicas basadas en el ID de juego mapeado en la lista real
    if jg_juego <= 30:  # Nintendo / Sony
        jg_genero = 8 if jg_juego <= 15 else 1   # Plataformas o Accion
    elif jg_juego <= 60:  # Xbox / Valve
        jg_genero = 14 if jg_juego <= 55 else 15 # FPS o TPS
    elif jg_juego <= 110: # EA / Ubisoft / Square
        jg_genero = 3 if jg_juego >= 96 else 2   # RPG o Aventura
    elif jg_juego <= 132: # Capcom / CDPR
        jg_genero = 10 if jg_juego <= 124 else 3 # Terror o RPG
    elif jg_juego <= 155: # FromSoftware
        jg_genero = 3 if jg_juego != 147 else 23 # RPG o Hack and Slash
    else:
        jg_genero = 25  # Mundo Abierto (Rockstar, Sega, etc.)
    
    juego_genero_data.append((jg_juego, jg_genero))

# 7. PLATAFORMA_VENTA (10 registros)
plataforma_venta_data = [
    (1, "Steam", "https://store.steampowered.com"),
    (2, "Epic Games Store", "https://store.epicgames.com"),
    (3, "PlayStation Store", "https://store.playstation.com"),
    (4, "Microsoft Store", "https://www.microsoft.com/store"),
    (5, "Nintendo eShop", "https://www.nintendo.com/store"),
    (6, "GOG.com", "https://www.gog.com"),
    (7, "Origin", "https://www.origin.com"),
    (8, "Ubisoft Connect", "https://ubisoftconnect.com"),
    (9, "Battle.net", "https://us.shop.battle.net"),
    (10, "Humble Bundle", "https://www.humblebundle.com")
]

# 8. PLATAFORMA_JUEGO (20 registros cruzados)
plataforma_juego_data = [(5, i) for i in range(1, 11)] + [(1, i) for i in range(46, 56)]

# 9. USUARIO_JUEGO_GUARDADO (20 registros cruzados)
usuario_juego_guardado_data = [(i, i * 3) for i in range(1, 21)]


# ---- CONFIGURACIÓN ----
CREAR_ZIP = False  # Cambia a False si deseas guardar archivos CSV individuales

# ---- EMPAQUETADO EN ZIP VIRTUAL ----
nombre_zip = "Data csv.zip"

def generar_csv_string(headers, rows):
    output = io.StringIO()
    writer = csv.writer(output, lineterminator='\n')
    writer.writerow(headers)
    writer.writerows(rows)
    return output.getvalue()

archivos_csv = {
    "generos.csv": generar_csv_string(["id_genero", "nombre"], generos_data),
    "desarrollador.csv": generar_csv_string(["id_desarrollador", "nombre", "pagina_web"], desarrolladores_data),
    "juego.csv": generar_csv_string(["id_juego", "id_desarrollador", "nombre", "calificacion", "fecha_publicacion"], juegos_data),
    "usuario.csv": generar_csv_string(["id_usuario", "handle", "correo", "fecha_registro", "nombre", "apellido"], usuarios_data),
    "resena.csv": generar_csv_string(["id_resena", "id_juego", "id_usuario", "titulo", "comentario", "calificacion", "fecha_publicacion"], resenas_data),
    "juego_genero.csv": generar_csv_string(["id_juego", "id_genero"], juego_genero_data),
    "plataforma_venta.csv": generar_csv_string(["id_plataforma", "nombre", "pagina_web"], plataforma_venta_data),
    "plataforma_juego.csv": generar_csv_string(["id_plataforma", "id_juego"], plataforma_juego_data),
    "usuario_juego_guardado.csv": generar_csv_string(["id_usuario", "id_juego"], usuario_juego_guardado_data)
}

if CREAR_ZIP:
    with zipfile.ZipFile(nombre_zip, 'w', zipfile.ZIP_DEFLATED) as zipf:
        for nombre, contenido in archivos_csv.items():
            zipf.writestr(nombre, contenido)
    print(f"¡Exito! Se ha creado '{nombre_zip}' con todas tus especificaciones exactas.")
else:
    from pathlib import Path
    carpeta_datos = Path("Data csv")
    carpeta_datos.mkdir(exist_ok=True)
    for nombre, contenido in archivos_csv.items():
        archivo_path = carpeta_datos / nombre
        archivo_path.write_text(contenido, encoding='utf-8')
    print(f"¡Exito! Se han creado los archivos CSV individuales en la carpeta '{carpeta_datos}'")