<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="registro_usuario_log.aspx.cs" Inherits="sistemas_deportes.registro_usuario_log" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <link href="estilos/estilos_registro_log.css" rel="stylesheet" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/izitoast/1.4.0/js/iziToast.min.js" integrity="sha512-Zq9o+E00xhhR/7vJ49mxFNJ0KQw1E1TMWkPTxrWcnpfEFDEXgUiwJHIKit93EW/XxE31HSI5GEOW06G6BF1AtA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/izitoast/1.4.0/css/iziToast.css" integrity="sha512-DIW4FkYTOxjCqRt7oS9BFO+nVOwDL4bzukDyDtMO7crjUZhwpyrWBFroq+IqRe6VnJkTpRAS6nhDvf0w+wHmxg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <title>Registro de Usuario</title>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container-fluid">
            <div class="row no-gutters">
                <div class="col-md-6 bg-color">
                    <div class="" style="height: 100%;">
                        <asp:Button ID="btn_regresar" runat="server" Text="Regresar" CssClass="btn btn-primary" OnClick="Button1_Click" CausesValidation="False" />
                        <div class="align-content-center">
                            <asp:Image ID="Image1" runat="server" ImageUrl="~/img/6e37c5cb-b20e-42cd-8d1a-7bc846ce0825-removebg-preview.png" Height="108px" />
                            <br />
                            <h1>Registrate</h1>
                            <br />
                            <h2>Registrate para continuar</h2>
                            <br />
                            <div>
                                <asp:Label ID="lb_nombre" runat="server" Text="Nombre"></asp:Label>
                                <asp:TextBox ID="txt_nombre" runat="server" Width="75%" CssClass="form-control" onfocus="if(this.value=='Ingrese su nombre') { this.value=''; }" onblur="if(this.value=='') { this.value='Ingrese su nombre'; }">Ingrese su nombre</asp:TextBox>
                                <asp:RegularExpressionValidator ID="rev_nombre" runat="server" ControlToValidate="txt_nombre" ValidationExpression="^[A-Za-zñÑáéíóúÁÉÍÓÚ]+$" ErrorMessage="Nombre debe contener solo letras y caracteres especiales como 'ñ' y tildes" ForeColor="Red" />

                                <br />

                                <asp:Label ID="lb_apellido" runat="server" Text="Apellido"></asp:Label>
                                <asp:TextBox ID="txt_apellido" runat="server" Width="75%" CssClass="form-control" onfocus="if(this.value=='Ingrese su apellido') { this.value=''; }" onblur="if(this.value=='') { this.value='Ingrese su apellido'; }">Ingrese su apellido</asp:TextBox>
                                <asp:RegularExpressionValidator ID="rev_apellido" runat="server" ControlToValidate="txt_apellido" ValidationExpression="^[A-Za-zñÑáéíóúÁÉÍÓÚ]+$" ErrorMessage="Apellido debe contener solo letras y caracteres especiales como 'ñ' y tildes" ForeColor="Red" />
                                <br />

                                <asp:Label ID="lb_correo" runat="server" Text="Correo"></asp:Label>
                                <asp:TextBox ID="txt_correo" runat="server" Width="75%" CssClass="form-control" onfocus="if(this.value=='Ingrese su correo') { this.value=''; }" onblur="if(this.value=='') { this.value='Ingrese su correo'; }">Ingrese su correo</asp:TextBox>
                                <asp:RegularExpressionValidator ID="rev_correo" runat="server" ControlToValidate="txt_correo" ValidationExpression="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$" ErrorMessage="Correo inválido" ForeColor="Red" />
                                <asp:CustomValidator ID="cv_correo" runat="server" ControlToValidate="txt_correo" OnServerValidate="cv_correo_ServerValidate" ErrorMessage="Correo ya registrado" ForeColor="Red" />
                                <br />

                                <asp:Label ID="lb_contrasena" runat="server" Text="Contraseña"></asp:Label>
                                <asp:TextBox ID="txt_contrasena" runat="server" Width="75%" CssClass="form-control" TextMode="Password" onfocus="if(this.value=='') { this.value=''; }" onblur="if(this.value=='') { this.value=''; }"></asp:TextBox>
                                <asp:RegularExpressionValidator ID="rev_contrasena" runat="server" ControlToValidate="txt_contrasena" ValidationExpression="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$" ErrorMessage="Contraseña debe tener al menos 8 caracteres, letras y números" ForeColor="Red" />
                                <br />

                                <asp:CheckBox ID="chk_mostrar_contrasena" runat="server" Text="¿Quieres ver la contraseña?" OnCheckedChanged="chk_mostrar_contrasena_CheckedChanged" AutoPostBack="true" />
                                <br />

                                <asp:Button ID="btn_entrar" runat="server" Text="Registrar" Width="75%" CssClass="btn btn-success" OnClick="btn_entrar_Click" />
                                &nbsp;&nbsp;&nbsp;
                                <asp:Button ID="btn_cancelar" runat="server" Text="Cancelar" Width="75%" CssClass="btn btn-danger" OnClick="btn_cancelar_Click" />
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
