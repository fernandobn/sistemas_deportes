CREATE PROCEDURE sp_insertar_usuario_log
    @nombre varchar(50) ,
    @apellido varchar(50) ,
    @correo varchar(100) ,
    @contraseña varchar(100) 
AS
BEGIN
        INSERT INTO LoginUsuarios (Nombre, Apellido, Correo, Contraseña)
        VALUES (@nombre, @apellido, @correo, @contraseña);
END
--- sp para verificar correo
CREATE PROCEDURE VerificarParteUsuarioCorreo
    @usuario NVARCHAR(100),
    @existe BIT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    -- Verificar si existe alguna entrada con la misma parte antes del '@'
    IF EXISTS (
        SELECT 1
        FROM LoginUsuarios
        WHERE CHARINDEX('@', correo) > 0
          AND SUBSTRING(correo, 1, CHARINDEX('@', correo) - 1) = @usuario
    )
    BEGIN
        SET @existe = 1; -- Existe
    END
    ELSE
    BEGIN
        SET @existe = 0; -- No existe
    END
END
select * from LoginUsuarios

-- sp para buscar correo y contraseña

CREATE PROCEDURE VerificarUsuario
    @correo VARCHAR(100),
    @contraseña VARCHAR(100),
    @existe BIT OUTPUT,
    @ID_Rol INT OUTPUT
AS
BEGIN
    -- Inicializar los parámetros de salida
    SET @existe = 0
    SET @ID_Rol = NULL

    -- Verificar si el usuario existe
    IF EXISTS (SELECT 1 FROM LoginUsuarios WHERE correo = @correo AND contraseña = @contraseña)
    BEGIN
        SET @existe = 1
        -- Obtener el ID_Rol del usuario
        SELECT @ID_Rol = ID_Rol FROM LoginUsuarios WHERE correo = @correo AND contraseña = @contraseña
    END
END

