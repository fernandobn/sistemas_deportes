using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace sistemas_deportes
{
    public partial class pantalla_principal : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            // Redirige a la página "OtraPagina.aspx"
            Response.Redirect("login_usuario.aspx");
        }

    }
}