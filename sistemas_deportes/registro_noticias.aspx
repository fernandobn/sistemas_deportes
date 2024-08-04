<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Registro de Noticias</title>
    <link rel="stylesheet" href="Content/bootstrap.min.css" />
    <link href="estilos/estilos_administrador.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.12.4/dist/sweetalert2.all.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.12.4/dist/sweetalert2.min.css" rel="stylesheet">
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
                                <a class="nav-link" href="#">
                                    <img src="img/periodico.png" alt="Noticias" />
                                    Noticias
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#">
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
                            <h1 class="text-center">Registro de noticias</h1>
                            <br />
                            <asp:GridView ID="GridView1" runat="server"></asp:GridView>
                            <br />
                            <asp:Button ID="Button2" runat="server" Text="Agregar Noticia" CssClass="btn btn-secondary" OnClientClick="openModal(); return false;" />
                            <asp:Button ID="Button3" runat="server" Text="Eliminar Noticia" CssClass="btn btn-secondary" />
                            <asp:Button ID="Button4" runat="server" Text="Modificar Noticia" CssClass="btn btn-secondary" />
                        </div>
                        <div class="col-md-1 text-right">
                            <asp:Button ID="Button1" runat="server" Text="Cerrar Sesión" CssClass="btn btn-success mx-auto d-block" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <main>
            <!-- Contenido del frame -->
        </main>
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true" />
    </form>
    <script>
        // Función para validar los campos
        function validateField(field, validatorId) {
            const validator = document.getElementById(validatorId);
            if (!field.value.trim()) {
                field.classList.add('error');
                validator.style.display = 'block';
                return false;
            } else {
                field.classList.remove('error');
                validator.style.display = 'none';
                return true;
            }
        }

        // Función para formatear la fecha
        function formatDate(field) {
            const value = field.value.replace(/\D/g, '');
            if (value.length >= 2) {
                field.value = value.slice(0, 2) + '/' + value.slice(2);
            }
            if (value.length >= 4) {
                field.value = field.value.slice(0, 5) + '/' + value.slice(4);
            }
        }

        // Función para validar si la fecha tiene el formato correcto
        function isValidDate(dateString) {
            const regex = /^\d{2}\/\d{2}\/\d{4}$/;
            if (!regex.test(dateString)) return false;

            const parts = dateString.split('/');
            const day = parseInt(parts[0], 10);
            const month = parseInt(parts[1], 10);
            const year = parseInt(parts[2], 10);

            if (year < 1000 || year > 3000 || month === 0 || month > 12) return false;

            const monthLength = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

            if (year % 400 === 0 || (year % 100 !== 0 && year % 4 === 0)) {
                monthLength[1] = 29;
            }

            return day > 0 && day <= monthLength[month - 1];
        }

        function openModal() {
            Swal.fire({
                title: 'Registrar Datos',
                html: `
                <div class="swal2-label">Título</div>
                <input type="text" id="titulo" class="swal2-input" placeholder="Título" onblur="validateField(this, 'tituloValidator')">
                <div id="tituloValidator" class="swal2-validation-message" style="display: none;">Campo obligatorio</div>
                <div class="swal2-label">Contenido</div>
                <textarea id="contenido" class="swal2-textarea" placeholder="Contenido" onblur="validateField(this, 'contenidoValidator')"></textarea>
                <div id="contenidoValidator" class="swal2-validation-message" style="display: none;">Campo obligatorio</div>
                <div class="swal2-label">Fecha de Publicación (dd/mm/aaaa)</div>
                <input type="text" id="fecha" class="swal2-input" placeholder="dd/mm/aaaa" onblur="validateField(this, 'fechaValidator')" onkeyup="formatDate(this)" maxlength="10">
                <div id="fechaValidator" class="swal2-validation-message" style="display: none;">Campo obligatorio en formato dd/mm/aaaa</div>
            `,
                showCancelButton: true,
                confirmButtonText: 'Enviar',
                cancelButtonText: 'Cancelar',
                preConfirm: () => {
                    const titulo = Swal.getPopup().querySelector('#titulo');
                    const contenido = Swal.getPopup().querySelector('#contenido');
                    const fecha = Swal.getPopup().querySelector('#fecha');

                    let valid = true;
                    if (!validateField(titulo, 'tituloValidator')) valid = false;
                    if (!validateField(contenido, 'contenidoValidator')) valid = false;
                    if (!validateField(fecha, 'fechaValidator') || !isValidDate(fecha.value)) valid = false;

                    if (!valid) {
                        Swal.showValidationMessage('Por favor, completa todos los campos correctamente.');
                    }

                    return { titulo: titulo.value, contenido: contenido.value, fecha: fecha.value };
                }
            }).then((result) => {
                if (result.isConfirmed) {
                    const { titulo, contenido, fecha } = result.value;
                    fetch('https://localhost:44315/registro_noticias.aspx/guardardatos', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json; charset=utf-8'
                        },
                        body: JSON.stringify({ titulo, contenido, fecha }),
                        credentials: 'include'  // Incluye cookies en la solicitud si es necesario
                    })
                        .then(response => {
                            if (!response.ok) {
                                throw new Error('Network response was not ok.');
                            }
                            return response.json();
                        })
                        .then(data => {
                            if (data.success) {
                                Swal.fire('Éxito', data.message, 'success');
                            } else {
                                Swal.fire('Error', data.message, 'error');
                            }
                        })
                        .catch(error => Swal.fire('Error', 'Ocurrió un error al guardar los datos.', 'error'));
                }
            });
        }
    </script>

</body>
</html>
