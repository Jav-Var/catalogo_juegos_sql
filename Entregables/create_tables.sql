CREATE TABLE desarrollador (
  id_desarrollador int unsigned NOT NULL AUTO_INCREMENT,
  nombre           varchar(100) NOT NULL UNIQUE,
  pagina_web       varchar(255) UNIQUE DEFAULT NULL,
  PRIMARY KEY (id_desarrollador)
);

CREATE TABLE juego (
  id_juego          int unsigned NOT NULL AUTO_INCREMENT,
  id_desarrollador  int unsigned NOT NULL,
  nombre            varchar(150) NOT NULL,
  calificacion      tinyint unsigned NOT NULL,
  fecha_publicacion date DEFAULT NULL,
  PRIMARY KEY (id_juego),
  UNIQUE (nombre, id_desarrollador),
  CONSTRAINT juego_ibfk_1
    FOREIGN KEY (id_desarrollador)
    REFERENCES desarrollador (id_desarrollador) ON DELETE CASCADE,
  CONSTRAINT chk_rango_calificacion
    CHECK (calificacion BETWEEN 1 AND 10)
);

CREATE TABLE usuario (
  id_usuario     int unsigned NOT NULL AUTO_INCREMENT,
  handle         varchar(50)  NOT NULL,
  correo         varchar(150) NOT NULL,
  fecha_registro date         NOT NULL,
  nombre         varchar(50)  NOT NULL,
  apellido       varchar(50)  NOT NULL,
  PRIMARY KEY (id_usuario),
  UNIQUE KEY handle (handle),
  UNIQUE KEY correo (correo),
  CONSTRAINT chk_email_valido
    CHECK (regexp_like(correo,
      '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$'))
);

CREATE TABLE resena (
  id_resena         int unsigned NOT NULL AUTO_INCREMENT,
  id_juego          int unsigned NOT NULL,
  id_usuario        int unsigned NOT NULL,
  titulo            varchar(150) NOT NULL,
  comentario        text,
  calificacion      tinyint unsigned NOT NULL,
  fecha_publicacion date NOT NULL,
  PRIMARY KEY (id_resena),
  CONSTRAINT resena_ibfk_1
    FOREIGN KEY (id_juego)
    REFERENCES juego (id_juego) ON DELETE CASCADE,
  CONSTRAINT resena_ibfk_2
    FOREIGN KEY (id_usuario)
    REFERENCES usuario (id_usuario) ON DELETE CASCADE,
  CONSTRAINT chk_rango_calificacion_resena
    CHECK (calificacion BETWEEN 1 AND 10)
);

CREATE TABLE plataforma_venta (
  id_plataforma int unsigned NOT NULL AUTO_INCREMENT,
  nombre        varchar(100) NOT NULL UNIQUE,
  pagina_web    varchar(255) UNIQUE DEFAULT NULL,
  PRIMARY KEY (id_plataforma)
);

CREATE TABLE genero (
  id_genero int unsigned NOT NULL AUTO_INCREMENT,
  nombre    varchar(50)  NOT NULL UNIQUE,
  PRIMARY KEY (id_genero)
);

CREATE TABLE juego_genero (
  id_juego  int unsigned NOT NULL,
  id_genero int unsigned NOT NULL,
  PRIMARY KEY (id_juego, id_genero),
  CONSTRAINT fk_jg_juego
    FOREIGN KEY (id_juego)
    REFERENCES juego (id_juego)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_jg_genero
    FOREIGN KEY (id_genero)
    REFERENCES genero (id_genero)
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE plataforma_juego (
  id_plataforma int unsigned NOT NULL,
  id_juego      int unsigned NOT NULL,
  PRIMARY KEY (id_plataforma, id_juego),
  KEY id_juego (id_juego),
  CONSTRAINT plataforma_juego_ibfk_1
    FOREIGN KEY (id_plataforma)
    REFERENCES plataforma_venta (id_plataforma) ON DELETE CASCADE,
  CONSTRAINT plataforma_juego_ibfk_2
    FOREIGN KEY (id_juego)
    REFERENCES juego (id_juego) ON DELETE CASCADE
);

CREATE TABLE usuario_juego_guardado (
  id_usuario int unsigned NOT NULL,
  id_juego   int unsigned NOT NULL,
  PRIMARY KEY (id_usuario, id_juego),
  KEY id_juego (id_juego),
  CONSTRAINT usuario_juego_guardado_ibfk_1
    FOREIGN KEY (id_usuario)
    REFERENCES usuario (id_usuario) ON DELETE CASCADE,
  CONSTRAINT usuario_juego_guardado_ibfk_2
    FOREIGN KEY (id_juego)
    REFERENCES juego (id_juego) ON DELETE CASCADE
);