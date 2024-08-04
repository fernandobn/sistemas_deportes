using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;

namespace sistemas_deportes
{
    public partial class registro_noticias : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                // Solo se abre el modal la primera vez que se carga la página
                ScriptManager.RegisterStartupScript(this, GetType(), "openModal", "openModal();", true);
            }
        }


        [WebMethod(EnableSession = true)]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string guardardatos(string titulo, string contenido, string fecha)
        {
            // Autenticar la solicitud
            if (!HttpContext.Current.User.Identity.IsAuthenticated)
            {
                return "{\"success\":false,\"message\":\"No autenticado\"}";
            }

            DateTime fechaPublicacion;
            try
            {
                // Intenta parsear la fecha en el formato esperado
                fechaPublicacion = DateTime.ParseExact(fecha, "dd/MM/yyyy", null);
            }
            catch (FormatException ex)
            {
                // Devuelve un mensaje de error en caso de fallo al parsear la fecha
                return $"{{\"success\":false,\"message\":\"Error al parsear la fecha: {ex.Message}\"}}";
            }

            string cadenaConexion = ConfigurationManager.ConnectionStrings["conexiondeportes"].ConnectionString;
            using (SqlConnection conexion = new SqlConnection(cadenaConexion))
            {
                SqlCommand comandoInsercion = new SqlCommand("sp_agregar_noticia", conexion);
                comandoInsercion.CommandType = System.Data.CommandType.StoredProcedure;
                // Agrega los parámetros al comando
                comandoInsercion.Parameters.AddWithValue("@titulo", titulo);
                comandoInsercion.Parameters.AddWithValue("@contenido", contenido);
                comandoInsercion.Parameters.AddWithValue("@fecha", fechaPublicacion);

                try
                {
                    conexion.Open();
                    int rowsAffected = comandoInsercion.ExecuteNonQuery();
                    // Devuelve un mensaje de éxito con el número de filas afectadas
                    return $"{{\"success\":true,\"message\":\"Noticia guardada exitosamente\", \"rowsAffected\": {rowsAffected}}}";
                }
                catch (SqlException sqlEx)
                {
                    // Devuelve un mensaje de error en caso de fallo de SQL
                    return $"{{\"success\":false,\"message\":\"Error de SQL: {sqlEx.Message}\"}}";
                }
                catch (Exception ex)
                {
                    // Devuelve un mensaje de error para otros tipos de excepciones
                    return $"{{\"success\":false,\"message\":\"Error: {ex.Message}\"}}";
                }
            }
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            // Abre el modal cuando se hace clic en el botón
            ScriptManager.RegisterStartupScript(this, GetType(), "openModal", "openModal();", true);
        }
    }
}
