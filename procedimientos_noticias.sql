select * from Noticias
EXEC sp_agregar_noticia 
    @titulo = 'Fc Barcelona', 
    @contenido = 'El mejor equipo del mundo Fc Barcelona',
    @fecha = '2024-08-03';
CREATE PROCEDURE sp_buscar_noticas
AS
BEGIN
    -- Example query
    SELECT * FROM Noticias;
END
use bdd_deportes;
CREATE PROCEDURE sp_eliminar_noticia
    @id INT
AS
BEGIN
    DELETE FROM Noticias
    WHERE ID_Noticia = @id;
END



CREATE PROCEDURE sp_buscar_noticias_titulo
    @titulo VARCHAR(255)
AS
BEGIN
    SELECT * FROM Noticias
    WHERE titulo LIKE '%' + @titulo + '%';
END
CREATE PROCEDURE sp_actualizar_noticia
    @id INT,
    @titulo VARCHAR(255),
    @contenido VARCHAR(MAX),
    @fecha DATE
AS
BEGIN
    UPDATE Noticias
    SET titulo = @titulo,
        contenido = @contenido,
        Fecha_Publicacion = @fecha
    WHERE ID_Noticia = @id;
END

