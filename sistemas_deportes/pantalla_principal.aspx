<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="pantalla_principal.aspx.cs" Inherits="sistemas_deportes.pantalla_principal" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <link href="estilos/estilos.css" rel="stylesheet" />
    <title>Pantalla Principal</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Image ID="Image1" runat="server" Height="118px" ImageUrl="~/img/6e37c5cb-b20e-42cd-8d1a-7bc846ce0825-removebg-preview.png" Width="160px" />
        </div>
        <div class="container h-100">
            <div class="row h-100 justify-content-center align-items-center">
                <div class="text-center">
                    <asp:Label ID="Label1" runat="server" Text="Free Sports" CssClass="display-1"></asp:Label>
                    <br />
                    <asp:Button ID="Button1" runat="server" Text="Iniciar" CssClass="btn btn-success mt-4" OnClick="Button1_Click" />
                </div>
            </div>
        </div>
    </form>
    <script src="Scripts/jquery-3.7.0.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>
</body>
</html>
