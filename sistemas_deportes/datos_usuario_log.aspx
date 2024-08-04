<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="datos_usuario_log.aspx.cs" Inherits="sistemas_deportes.datos_usuario_log" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Datos de Usuarios</title>
    <link rel="stylesheet" href="Content/bootstrap.min.css" />
    <link href="estilos/estilos_administrador.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.12.4/dist/sweetalert2.all.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.12.4/dist/sweetalert2.min.css" rel="stylesheet" />
    <style>
        .error {
            border-color: red;
        }

        .swal2-validation-message {
            color: red;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container-fluid">
            <div class="row">
                <nav class="col-md-2 d-none d-md-block bg-dark sidebar">
                    <div class="sidebar-sticky">
                        <div class="text-center">
                            <h2 class="text-white">Free Sports</h2>
                        </div>
                        <ul class="nav flex-column">
                            <li class="nav-item">
                                <a class="nav-link" href="#">
                                    <img src="img/hecho.png" alt="Eventos" />
                                    Eventos
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="registro_noticias.aspx">
                                    <img src="img/periodico.png" alt="Noticias" />
                                    Noticias
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="datos_usuario_log.aspx">
                                    <img src="img/agregar-usuario.png" alt="Usuarios" />
                                    Usuarios
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#">
                                    <img src="img/partido-de-futbol.png" alt="Partidos" />
                                    Partidos
                                </a>
                            </li>
                        </ul>
                    </div>
                </nav>
                <div class="col-md-10">
                    <div class="row align-items-center">
                        <div class="col-md-3">
                            <asp:Image ID="Image1" runat="server" ImageUrl="~/img/6e37c5cb-b20e-42cd-8d1a-7bc846ce0825-removebg-preview.png" CssClass="img-fluid d-block" Height="75%" Width="50%" />
                        </div>
                        <div class="col-md-6">
                            <h1 class="text-center">Registro de datos de usuario</h1>
                            <br />
                            <asp:GridView ID="lst_usuarios_log" runat="server" AutoGenerateColumns="False" DataKeyNames="ID_Login_user" OnRowCancelingEdit="lst_usuarios_log_RowCancelingEdit" OnRowDeleting="lst_usuarios_log_RowDeleting" OnRowEditing="lst_usuarios_log_RowEditing" OnRowUpdated="lst_usuarios_log_RowUpdated"  CssClass="table table-striped table-bordered" OnRowUpdating="lst_usuarios_log_RowUpdating">
                                <Columns>
                                    <asp:BoundField DataField="ID_Login_user" HeaderText="ID" ReadOnly="True" SortExpression="ID_Login_user" />
                                    <asp:TemplateField HeaderText="Nombre" SortExpression="Nombre">
                                        <ItemTemplate>
                                            <%# Eval("Nombre") %>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txt_nombre" runat="server" Text='<%# Bind("Nombre") %>' CssClass="form-control"></asp:TextBox>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Apellido" SortExpression="Apellido">
                                        <ItemTemplate>
                                            <%# Eval("Apellido") %>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txt_apellido" runat="server" Text='<%# Bind("Apellido") %>' CssClass="form-control"></asp:TextBox>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Correo" SortExpression="Correo">
                                        <ItemTemplate>
                                            <%# Eval("Correo") %>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txt_correo" runat="server" Text='<%# Bind("Correo") %>' CssClass="form-control"></asp:TextBox>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Contraseña" SortExpression="Contraseña">
                                        <ItemTemplate>
                                            <%# Eval("Contraseña") %>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txt_contraseña" runat="server" Text='<%# Bind("Contraseña") %>' CssClass="form-control"></asp:TextBox>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" />
                                </Columns>
                            </asp:GridView>
                            <br />
                            <asp:Button ID="Button2" runat="server" Text="Button" />
                        </div>
                        <div class="col-md-1 text-right">
                            <asp:Button ID="Button1" runat="server" Text="Cerrar Sesión" CssClass="btn btn-success mx-auto d-block" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
