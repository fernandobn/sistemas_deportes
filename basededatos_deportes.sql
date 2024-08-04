-- Crear la tabla de Roles con valores predeterminados
CREATE TABLE Roles (
    ID_Rol INT PRIMARY KEY IDENTITY(1,1),
    Nombre_Rol NVARCHAR(50) NOT NULL
);

-- Insertar roles predeterminados
INSERT INTO Roles (Nombre_Rol)
VALUES ('Usuario'), ('Administrador');

-- Tabla de Login para Usuarios
CREATE TABLE LoginUsuarios (
    ID_Login INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(50) NOT NULL,
    Correo NVARCHAR(100) NOT NULL,
    Contraseña NVARCHAR(100) NOT NULL,
    ID_Rol INT DEFAULT 1,  -- Por defecto es 'Usuario'
    FOREIGN KEY (ID_Rol) REFERENCES Roles(ID_Rol)
);

-- Tabla de Usuarios con detalles completos
CREATE TABLE Usuarios (
    ID_Usuario INT PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    Correo VARCHAR(100) NOT NULL,
    FechaNacimiento DATE,
    Teléfono VARCHAR(20),
);

-- Tabla de Login para Administradores
CREATE TABLE LoginAdministradores (
    ID_Login INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(50) NOT NULL,
    Correo NVARCHAR(100) NOT NULL,
    Contraseña NVARCHAR(100) NOT NULL,
    ID_Rol INT DEFAULT 2,  -- Por defecto es 'Administrador'
    FOREIGN KEY (ID_Rol) REFERENCES Roles(ID_Rol)
);

-- Tabla de Categorías
CREATE TABLE Categorías (
    ID_Categoria INT PRIMARY KEY IDENTITY(1,1),
    Nombre_Categoria NVARCHAR(50) NOT NULL
);

-- Tabla de Eventos
CREATE TABLE Eventos (
    ID_Evento INT PRIMARY KEY IDENTITY(1,1),
    Nombre_Evento VARCHAR(100) NOT NULL,
    Descripción VARCHAR(MAX),
    Fecha DATE NOT NULL,
    Hora TIME NOT NULL,
    Ubicación NVARCHAR(100),
    ID_Categoria INT,
    FOREIGN KEY (ID_Categoria) REFERENCES Categorías(ID_Categoria)
);

-- Tabla de Inscripciones
CREATE TABLE Inscripciones (
    ID_Inscripcion INT PRIMARY KEY IDENTITY(1,1),
    ID_Usuario INT,
    ID_Evento INT,
    Fecha_Inscripcion DATE,
    FOREIGN KEY (ID_Usuario) REFERENCES Usuarios(ID_Usuario),
    FOREIGN KEY (ID_Evento) REFERENCES Eventos(ID_Evento)
);

-- Tabla de Partidos
CREATE TABLE Partidos (
    ID_Partido INT PRIMARY KEY IDENTITY(1,1),
    ID_Evento INT,
    Fecha DATE NOT NULL,
    Hora TIME NOT NULL,
    Equipos NVARCHAR(100),
    Resultado NVARCHAR(50),
    FOREIGN KEY (ID_Evento) REFERENCES Eventos(ID_Evento)
);

-- Tabla de Noticias
CREATE TABLE Noticias (
    ID_Noticia INT PRIMARY KEY IDENTITY(1,1),
    Titulo NVARCHAR(100) NOT NULL,
    Contenido NVARCHAR(MAX),
    Fecha_Publicacion DATE NOT NULL
);

-- Tabla de Reportes
CREATE TABLE Reportes (
    ID_Reporte INT PRIMARY KEY IDENTITY(1,1),
    ID_Evento INT,
    Descripción NVARCHAR(MAX),
    Fecha_Generacion DATE,
    FOREIGN KEY (ID_Evento) REFERENCES Eventos(ID_Evento)
);
