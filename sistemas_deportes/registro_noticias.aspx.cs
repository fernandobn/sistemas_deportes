using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace sistemas_deportes
{
    public partial class registro_noticias : System.Web.UI.Page
    {
        // Definición de atributos
        string cadenaConexion = "";
        SqlConnection conexion;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Retrieve connection string from web.config
            var connectionStringSetting = ConfigurationManager.ConnectionStrings["conexciondeportes"];

            if (connectionStringSetting != null)
            {
                this.cadenaConexion = connectionStringSetting.ConnectionString;
                this.conexion = new SqlConnection(cadenaConexion);
                if (!Page.IsPostBack)
                {
                    this.cargargrilla();
                    this.consultar_lugares(); // Cargando datos en la tabla
                    ScriptManager.RegisterStartupScript(this, GetType(), "openModal", "openModal();", true);
                }
            }
            else
            {
                // Handle the case when the connection string is not found
                throw new InvalidOperationException("Connection string 'conexionAgencia' not found.");
            }
        }

        protected void cargargrilla()
        {
            // Obtener los datos de la base de datos
            DataTable datosNoticias = ObtenerDatosDeNoticias();

            // Enlazar los datos al GridView
            lista_noticias.DataSource = datosNoticias;
            lista_noticias.DataBind();
        }


        protected void Button2_Click(object sender, EventArgs e)
        {
            // Abre el modal cuando se hace clic en el botón
            ScriptManager.RegisterStartupScript(this, GetType(), "openModal", "openModal();", true);
        }

        public void consultar_lugares()
        {
            // Crear un comando para ejecutar el procedimiento almacenado 
            SqlCommand comandoconsulta = new SqlCommand("sp_buscar_noticas", this.conexion);
            comandoconsulta.CommandType = CommandType.StoredProcedure;
            try
            {
                conexion.Open();
                SqlDataAdapter adaptador = new SqlDataAdapter(comandoconsulta);
                DataTable tabla = new DataTable();
                adaptador.Fill(tabla);
                lista_noticias.DataSource = tabla;
                lista_noticias.DataBind();
            }
            catch (Exception ex)
            {
                throw new Exception("Error retrieving data: " + ex.Message);
            }
            finally
            {
                conexion.Close();
            }
        }

         
        

        public void actualizarNoticia(int id, string titulo, string contenido, DateTime fecha)
        {
            SqlCommand comandoActualizar = new SqlCommand("sp_actualizar_noticia", this.conexion);
            comandoActualizar.CommandType = CommandType.StoredProcedure;
            comandoActualizar.Parameters.AddWithValue("@id", id);
            comandoActualizar.Parameters.AddWithValue("@titulo", titulo);
            comandoActualizar.Parameters.AddWithValue("@contenido", contenido);
            comandoActualizar.Parameters.AddWithValue("@fecha", fecha);

            try
            {
                conexion.Open();
                comandoActualizar.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw new Exception("Error updating data: " + ex.Message);
            }
            finally
            {
                conexion.Close();
            }
        }

        protected void lista_noticias_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void lista_noticias_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            lista_noticias.EditIndex = -1;
            consultar_lugares();
        }

        protected void lista_noticias_RowEditing(object sender, GridViewEditEventArgs e)
        {
            lista_noticias.EditIndex = e.NewEditIndex;
            consultar_lugares();
        }

        protected void lista_noticias_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            // Obtén el ID de la fila a eliminar
            int id = Convert.ToInt32(lista_noticias.DataKeys[e.RowIndex].Value);

            // Llama al método para eliminar la noticia
            eliminarNoticia(id);

            // Actualiza el GridView
            cargargrilla();
            consultar_lugares();
        }







        protected void lista_noticias_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow fila = lista_noticias.Rows[e.RowIndex];
            int id = Convert.ToInt32(lista_noticias.DataKeys[e.RowIndex].Value);
            string titulo = (fila.FindControl("txt_titulo") as TextBox).Text;
            string contenido = (fila.FindControl("txt_contenido") as TextBox).Text;
            DateTime fecha;
            if (DateTime.TryParse((fila.FindControl("txt_fecha") as TextBox).Text, out fecha))
            {
                actualizarNoticia(id, titulo, contenido, fecha);
                lista_noticias.EditIndex = -1;
                consultar_lugares();
            }
        }
        public void eliminarNoticia(int id)
        {
            using (SqlCommand comandoEliminar = new SqlCommand("sp_eliminar_noticia", this.conexion))
            {
                comandoEliminar.CommandType = CommandType.StoredProcedure;
                comandoEliminar.Parameters.AddWithValue("@id", id);

                try
                {
                    conexion.Open();
                    comandoEliminar.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    throw new Exception("Error al eliminar datos: " + ex.Message);
                }
                finally
                {
                    conexion.Close();
                }
            }
        }

        public DataTable ObtenerDatosDeNoticias()
        {
            DataTable dt = new DataTable();
            using (SqlConnection conexion = new SqlConnection(cadenaConexion))
            {
                string query = "SELECT * FROM Noticias"; // Ajusta la consulta según tus necesidades
                using (SqlCommand comando = new SqlCommand(query, conexion))
                {
                    try
                    {
                        conexion.Open();
                        SqlDataAdapter adapter = new SqlDataAdapter(comando);
                        adapter.Fill(dt);
                    }
                    catch (Exception ex)
                    {
                        // Manejo de errores
                        throw new Exception("Error al obtener datos: " + ex.Message);
                    }
                }
            }
            return dt;
        }




    }
}
