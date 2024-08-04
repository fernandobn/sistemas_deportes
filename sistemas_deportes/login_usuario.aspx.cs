using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace sistemas_deportes
{
    public partial class login_usuario : Page
    {
        // Definición de atributos
        string cadenaConexion = "";
        SqlConnection conexion;

        protected void Page_Load(object sender, EventArgs e)
        {
            this.cadenaConexion = ConfigurationManager.ConnectionStrings["conexciondeportes"].ConnectionString;
            this.conexion = new SqlConnection(cadenaConexion);

            if (!Page.IsPostBack)
            {
                // Código para cargar datos si es necesario
            }
        }

        // Método para validar usuario
        protected void btn_entrar_Click(object sender, EventArgs e)
        {
            // Capturar los valores que ingresa el usuario
            string email = txt_email.Text;
            string password = TextBox1.Text;

            // Validar campos obligatorios
            if (Page.IsValid)
            {
                // Crear el comando para ejecutar el procedimiento almacenado
                SqlCommand comandoVerificar = new SqlCommand("VerificarUsuario", this.conexion);
                comandoVerificar.CommandType = System.Data.CommandType.StoredProcedure;
                comandoVerificar.Parameters.AddWithValue("@correo", email);
                comandoVerificar.Parameters.AddWithValue("@contraseña", password);

                // Parámetros de salida
                SqlParameter paramExisten = new SqlParameter("@existe", System.Data.SqlDbType.Bit)
                {
                    Direction = System.Data.ParameterDirection.Output
                };
                comandoVerificar.Parameters.Add(paramExisten);

                SqlParameter paramID_Rol = new SqlParameter("@ID_Rol", System.Data.SqlDbType.Int)
                {
                    Direction = System.Data.ParameterDirection.Output
                };
                comandoVerificar.Parameters.Add(paramID_Rol);

                try
                {
                    this.conexion.Open();
                    comandoVerificar.ExecuteNonQuery();
                    this.conexion.Close();

                    // Obtener el valor del parámetro de salida
                    bool existe = (bool)paramExisten.Value;
                    int idRol = (int)paramID_Rol.Value;

                    if (existe)
                    {
                        // Usuario encontrado, redirigir basado en el ID_Rol
                        if (idRol == 1)
                        {
                            Response.Redirect("default.aspx");
                        }
                        else if (idRol == 2)
                        {
                            Response.Redirect("pagina_administrador.aspx"); // Cambia por la página adecuada
                        }
                        else
                        {
                            // Manejar otros roles si es necesario
                            string script = "Confirmacion('Usuario autenticado exitosamente, pero el rol no está definido.');";
                            ClientScript.RegisterStartupScript(this.GetType(), "LoginSuccess", script, true);
                        }
                    }
                    else
                    {
                        // Usuario no encontrado, mostrar mensaje de error
                        string scripterror = "Error('Correo o contraseña incorrectos.');";
                        ClientScript.RegisterStartupScript(this.GetType(), "LoginError", scripterror, true);
                    }
                }
                catch (Exception ex)
                {
                    // Manejo de excepciones
                    string scripterror = "Error('Error al intentar autenticar al usuario.');";
                    ClientScript.RegisterStartupScript(this.GetType(), "LoginError", scripterror, true);
                }
            }
        }


        // Método para redirigir al formulario de registro
        protected void btn_registrar_Click(object sender, EventArgs e)
        {
            Response.Redirect("registro_usuario_log.aspx");
        }

        // Método para mostrar/ocultar contraseña
        protected void chk_mostrar_contrasena_CheckedChanged(object sender, EventArgs e)
        {
            if (chk_mostrar_contrasena.Checked)
            {
                TextBox1.TextMode = TextBoxMode.SingleLine;
            }
            else
            {
                TextBox1.TextMode = TextBoxMode.Password;
            }
        }

        // Método para redirigir a la página principal
        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("pantalla_principal.aspx");
        }
    }
}
