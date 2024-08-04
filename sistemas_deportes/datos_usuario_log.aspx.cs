using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace sistemas_deportes
{
    public partial class datos_usuario_log : System.Web.UI.Page
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
                    this.consultar_usuarios(); // Cargando datos en la tabla
                    ScriptManager.RegisterStartupScript(this, GetType(), "openModal", "openModal();", true);
                }
            }
            else
            {
                // Handle the case when the connection string is not found
                throw new InvalidOperationException("Connection string 'conexionAgencia' not found.");
            }
        }
        /// METODOS DEL CRUD
        protected void lst_usuarios_log_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            lst_usuarios_log.EditIndex = -1;
            consultar_usuarios();
        }

        protected void lst_usuarios_log_RowEditing(object sender, GridViewEditEventArgs e)
        {
            lst_usuarios_log.EditIndex = e.NewEditIndex;
            consultar_usuarios();
        }

        protected void lst_usuarios_log_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            // Obtén el ID de la fila a eliminar
            int id = Convert.ToInt32(lst_usuarios_log.DataKeys[e.RowIndex].Value);

            // Llama al método para eliminar la noticia
            eliminarNoticia(id);

            // Actualiza el GridView
            cargargrilla();
            consultar_usuarios();
        }

        protected void lst_usuarios_log_RowUpdated(object sender, GridViewUpdatedEventArgs e)
        {
            
        }
        // Metodos o funciones
        protected void cargargrilla()
        {
            // Obtener los datos de la base de datos
            DataTable datosNoticias = ObtenerDatosDeNoticias();

            // Enlazar los datos al GridView
            lst_usuarios_log.DataSource = datosNoticias;
            lst_usuarios_log.DataBind();
        }
        public DataTable ObtenerDatosDeNoticias()
        {
            DataTable dt = new DataTable();
            using (SqlConnection conexion = new SqlConnection(cadenaConexion))
            {
                string query = "SELECT * FROM LoginUsuarios"; // Ajusta la consulta según tus necesidades
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
        public void consultar_usuarios()
        {
            // Crear un comando para ejecutar el procedimiento almacenado 
            SqlCommand comandoconsulta = new SqlCommand("sp_buscar_usuario_log", this.conexion);
            comandoconsulta.CommandType = CommandType.StoredProcedure;
            try
            {
                conexion.Open();
                SqlDataAdapter adaptador = new SqlDataAdapter(comandoconsulta);
                DataTable tabla = new DataTable();
                adaptador.Fill(tabla);
                lst_usuarios_log.DataSource = tabla;
                lst_usuarios_log.DataBind();
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
        public void Actualizar_usuario(int id, string Nombre, string Apellido, string Correo, string Constraseña)
        {
            SqlCommand comandoActualizar = new SqlCommand("sp_actualizar_log_usuario", this.conexion);
            comandoActualizar.CommandType = CommandType.StoredProcedure;
            comandoActualizar.Parameters.AddWithValue("@id", id);
            comandoActualizar.Parameters.AddWithValue("@nombre", Nombre);
            comandoActualizar.Parameters.AddWithValue("@apellido", Apellido);
            comandoActualizar.Parameters.AddWithValue("@correo", Correo);
            comandoActualizar.Parameters.AddWithValue("@contraseña", Constraseña);

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
        public void eliminarNoticia(int id)
        {
            using (SqlCommand comandoEliminar = new SqlCommand("sp_eliminar_usuario_log", this.conexion))
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

        protected void lst_usuarios_log_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow fila = lst_usuarios_log.Rows[e.RowIndex];
            int id = Convert.ToInt32(lst_usuarios_log.DataKeys[e.RowIndex].Value);
            string Nombre = (fila.FindControl("txt_nombre") as TextBox).Text;
            string Apellido = (fila.FindControl("txt_apellido") as TextBox).Text;
            string Correo = (fila.FindControl("txt_correo") as TextBox).Text;
            string Contraseña = (fila.FindControl("txt_contraseña") as TextBox).Text;

            Actualizar_usuario(id, Nombre, Apellido, Correo, Correo);
            lst_usuarios_log.EditIndex = -1;
            consultar_usuarios();
        }
    }
}