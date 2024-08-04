<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login_usuario.aspx.cs" Inherits="sistemas_deportes.login_usuario" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <link href="estilos/estilos_login_user.css" rel="stylesheet" />
     <script src="https://cdnjs.cloudflare.com/ajax/libs/izitoast/1.4.0/js/iziToast.min.js" integrity="sha512-Zq9o+E00xhhR/7vJ49mxFNJ0KQw1E1TMWkPTxrWcnpfEFDEXgUiwJHIKit93EW/XxE31HSI5GEOW06G6BF1AtA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
     <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/izitoast/1.4.0/css/iziToast.css" integrity="sha512-DIW4FkYTOxjCqRt7oS9BFO+nVOwDL4bzukDyDtMO7crjUZhwpyrWBFroq+IqRe6VnJkTpRAS6nhDvf0w+wHmxg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <title>Login Usuario</title>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container-fluid">
            <div class="row no-gutters">
                <div class="col-md-6 bg-color">
                    <div class="" style="height: 100%;">
                        <asp:Button ID="btn_regresar" runat="server" Text="Regresar" BorderColor="Lime" ForeColor="Black" OnClick="Button1_Click" CausesValidation="False" />
                        <div class="align-content-center">
                            <h1>Log in</h1>
                            <br />
                            <h2>Inicia sesión para continuar</h2>
                            <br />
                            <div>
                                <asp:Label ID="lb_email" runat="server" Text="Email"></asp:Label>
                                <asp:TextBox ID="txt_email" runat="server" Width="75%" Text="Ingrese su correo" CssClass="form-control"
                                    onfocus="if(this.value=='Ingrese su correo') { this.value=''; }"
                                    onblur="if(this.value=='') { this.value='Ingrese su correo'; }" />
                                <asp:RequiredFieldValidator ID="rfv_email" runat="server" ControlToValidate="txt_email"
                                    ErrorMessage="Campo obligatorio" ForeColor="Red" Display="Dynamic" />
                                <br />
                                <asp:Label ID="lb_contraseña" runat="server" Text="Contraseña"></asp:Label>
                                <asp:TextBox ID="TextBox1" runat="server" Width="75%" Text="Ingrese su contraseña" CssClass="form-control"
                                    TextMode="Password"
                                    onfocus="if(this.value=='Ingrese su contraseña') { this.value=''; }"
                                    onblur="if(this.value=='') { this.value='Ingrese su contraseña'; }" />
                                <asp:RequiredFieldValidator ID="rfv_contrasena" runat="server" ControlToValidate="TextBox1"
                                     ErrorMessage="Campo obligatorio" ForeColor="Red" Display="Dynamic" />
                                <br />
                                <asp:CheckBox ID="chk_mostrar_contrasena" runat="server" Text="Mostrar contraseña" AutoPostBack="True" OnCheckedChanged="chk_mostrar_contrasena_CheckedChanged" />
                                <br />
                                <asp:Button ID="btn_entrar" runat="server" Text="Entrar" Width="75%" CssClass="btn btn-success" OnClick="btn_entrar_Click" />
                                <br />
                                <asp:Button ID="btn_registrar" runat="server" Text="Registrate" Width="75%" CssClass="btn btn-secondary" OnClick="btn_registrar_Click" />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 bg-image">
                    <label>pon aqui la imagen</label>
                </div>
            </div>
        </div>
        <script>
            function Confirmacion(mensaje) {
                iziToast.success({
                    title: 'Confirmación',
                    message: mensaje,
                    position: 'topRight'
                });

            }
            //Confirmacion('Hola mundo :)')
            function Error(mensaje) {
                iziToast.error({
                    title: 'Error',
                    message: mensaje,
                    position: 'topRight'
                });
            }
        </script>
    </form>
</body>
</html>
