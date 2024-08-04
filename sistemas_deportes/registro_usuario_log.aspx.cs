using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace sistemas_deportes
{
    public partial class registro_usuario_log : Page
    {
        // Definición de atributos
        string cadenaConexion = "";
        SqlConnection conexion;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Abrir la conexión a la base de datos
            this.cadenaConexion = ConfigurationManager.ConnectionStrings["conexciondeportes"].ConnectionString;
            this.conexion = new SqlConnection(cadenaConexion);

            // Evitar errores
            if (!Page.IsPostBack)
            {
                this.cancelar();
            }
        }

        // Métodos SQL
        public void cancelar()
        {
            txt_nombre.Text = "Ingrese su nombre";
            txt_apellido.Text = "Ingrese su apellido";
            txt_correo.Text = "Ingrese su correo";
            txt_correo.Focus();
        }

        public bool insertar_usu_reg(string nombre, string apellido, string correo, string contraseña)
        {
            // Crear un comando para ejecutar el procedimiento almacenado
            SqlCommand comandoInsercion = new SqlCommand("sp_insertar_usuario_log", this.conexion);
            comandoInsercion.CommandType = System.Data.CommandType.StoredProcedure;

            // Pasar los parámetros
            comandoInsercion.Parameters.AddWithValue("@nombre", nombre);
            comandoInsercion.Parameters.AddWithValue("@apellido", apellido);
            comandoInsercion.Parameters.AddWithValue("@correo", correo);
            comandoInsercion.Parameters.AddWithValue("@contraseña", contraseña);

            try
            {
                this.conexion.Open();
                comandoInsercion.ExecuteNonQuery();
                this.conexion.Close();
                return true;
            }
            catch (Exception ex)
            {
                // Log the error (consider using a logging framework for persistence)
                Console.WriteLine("Error: " + ex.Message);
                return false;
            }
        }

        protected void btn_entrar_Click(object sender, EventArgs e)
        {
            // Capturar los valores que ingrese el usuario
            string name = txt_nombre.Text;
            string lastname = txt_apellido.Text;
            string email = txt_correo.Text;
            string password = txt_contrasena.Text;

            // Insertar usuario y mostrar mensaje apropiado
            bool insertSuccessful = insertar_usu_reg(name, lastname, email, password);
            if (insertSuccessful)
            {
                string script = "Confirmacion('Usuario registrado exitosamente');";
                ClientScript.RegisterStartupScript(this.GetType(), "InsertSuccess", script, true);
                limpiarformulario();
            }
            else
            {
                string scripterror = "Error('Error al registrar el usuario. Verifique los datos ingresados.');";
                ClientScript.RegisterStartupScript(this.GetType(), "InsertError", scripterror, true);
            }
        }

        public void limpiarformulario()
        {
            txt_nombre.Text = "Ingrese su nombre";
            txt_apellido.Text = "Ingrese su apellido";
            txt_correo.Text = "Ingrese su correo";
            txt_correo.Focus();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            // Redirige a la página "login_usuario.aspx"
            Response.Redirect("login_usuario.aspx");
        }

        protected void cv_correo_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string correo = args.Value;

            // Verificar si el correo contiene el carácter '@'
            if (!correo.Contains('@'))
            {
                args.IsValid = false;
                return;
            }

            // Extraer la parte antes del '@'
            string usuario = correo.Split('@')[0];

            // Crear el comando para ejecutar el procedimiento almacenado
            SqlCommand comandoVerificarCorreo = new SqlCommand("VerificarParteUsuarioCorreo", this.conexion);
            comandoVerificarCorreo.CommandType = System.Data.CommandType.StoredProcedure;
            comandoVerificarCorreo.Parameters.AddWithValue("@usuario", usuario);

            // Parámetro de salida
            SqlParameter paramExisten = new SqlParameter("@existe", System.Data.SqlDbType.Bit)
            {
                Direction = System.Data.ParameterDirection.Output
            };
            comandoVerificarCorreo.Parameters.Add(paramExisten);

            try
            {
                this.conexion.Open();
                comandoVerificarCorreo.ExecuteNonQuery();
                this.conexion.Close();

                // Obtener el valor del parámetro de salida
                bool existe = (bool)paramExisten.Value;
                args.IsValid = !existe;
            }
            catch (Exception ex)
            {
                // Manejo de excepciones
                args.IsValid = false;
            }
        }



        protected void chk_mostrar_contrasena_CheckedChanged(object sender, EventArgs e)
        {
            if (chk_mostrar_contrasena.Checked)
            {
                txt_contrasena.TextMode = TextBoxMode.SingleLine;
            }
            else
            {
                txt_contrasena.TextMode = TextBoxMode.Password;
            }
        }

        protected void btn_cancelar_Click(object sender, EventArgs e)
        {
            cancelar();
        }
    }
}
