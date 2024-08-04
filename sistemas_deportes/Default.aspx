<%@ Page Title="Noticias" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="sistemas_deportes._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <main>
        <section class="row" aria-labelledby="aspnetTitle">
            <div class="row">
                <div class="col-md-4">
                    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/img/6e37c5cb-b20e-42cd-8d1a-7bc846ce0825-removebg-preview.png" Height="60%" Width="45%" ImageAlign="Top" OnClick="ImageButton1_Click" />
                </div>
                <div class=" col-md-8 text-center">
                    <h1 id="aspnetTitle">Bienvienidos a Free Sports</h1>
                    <br />
                    <p class="lead">Aquí encontrarás toda la información que necesitas para estar al día con tus deportes favoritos</p>
                </div>
            </div>
        </section>
        <div id="carouselExampleCaptions" class="carousel slide">
            <div class="carousel-indicators">
                <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="0" class="active"
                    aria-current="true" aria-label="Diapositiva 1">
                </button>
                <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="1"
                    aria-label="Diapositiva 2">
                </button>
                <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="2"
                    aria-label="Diapositiva 3">
                </button>
            </div>
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <svg class="bd-placeholder-img bd-placeholder-img-lg d-block w-100" width="800" height="400"
                        role="img" aria-label="Marcador de posición: Primera diapositiva" focusable="false"
                        preserveAspectRatio="xMidYMid slice" xmlns="http://www.w3.org/2000/svg">
                        <title>Marcador de posición</title>
                        <rect width="100%" height="100%" fill="#777"></rect><text x="50%" y="50%" fill="#555"
                            dy=".3em">Primera diapositiva</text>
                    </svg>
                    <div class="carousel-caption d-none d-md-block">
                        <h5>Primera etiqueta de diapositiva</h5>
                        <p>Algún contenido de marcador de posición representativo para la primera diapositiva.</p>
                    </div>
                </div>
                <div class="carousel-item">
                    <svg class="bd-placeholder-img bd-placeholder-img-lg d-block w-100" width="800" height="400"
                        role="img" aria-label="Marcador de posición: Segunda diapositiva" focusable="false"
                        preserveAspectRatio="xMidYMid slice" xmlns="http://www.w3.org/2000/svg">
                        <title>Marcador de posición</title>
                        <rect width="100%" height="100%" fill="#666"></rect><text x="50%" y="50%" fill="#444"
                            dy=".3em">Segunda diapositiva</text>
                    </svg>
                    <div class="carousel-caption d-none d-md-block">
                        <h5>Etiqueta de la segunda diapositiva</h5>
                        <p>Algún contenido de marcador de posición representativo para la segunda diapositiva.</p>
                    </div>
                </div>
                <div class="carousel-item">
                    <svg class="bd-placeholder-img bd-placeholder-img-lg d-block w-100" width="800" height="400"
                        role="img" aria-label="Marcador de posición: Tercera diapositiva" focusable="false"
                        preserveAspectRatio="xMidYMid slice" xmlns="http://www.w3.org/2000/svg">
                        <title>Marcador de posición</title>
                        <rect width="100%" height="100%" fill="#555"></rect><text x="50%" y="50%" fill="#333"
                            dy=".3em">Tercera diapositiva</text>
                    </svg>
                    <div class="carousel-caption d-none d-md-block">
                        <h5>Etiqueta de la tercera diapositiva</h5>
                        <p>Algún contenido de marcador de posición representativo para la tercera diapositiva.</p>
                    </div>
                </div>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleCaptions"
                data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Anterior</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleCaptions"
                data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Siguiente</span>
            </button>
        </div>
        <br />
        <br />
        <div class="row">
            <div class="text-center">
                <h2>NUEVAS NOTICIAS</h2>
                <br />
                <p>¡Mantente al día con las últimas novedades del mundo de deportes </p>
            </div>
        </div>
        <div class="row">
            <div class="col-md-8">
                <asp:Repeater ID="Repeater1" runat="server"></asp:Repeater>
            </div>
            <div class="col-md-4">
                <h3 class="text-center">
                    Los mejores equipos de fútbol
                </h3>
                <br />
                <asp:Image ID="Image1" runat="server" ImageUrl="~/img/images.jpeg" Width="45%" Height="75%" CssClass="rounded mx-auto d-block" />
            </div>
        </div>
    </main>
</asp:Content>
