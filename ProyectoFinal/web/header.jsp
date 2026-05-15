<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Maverick AI Academy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* Estructura para empujar el footer al fondo */
        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh; /* */
            margin: 0;
        }
        .flex-content {
            flex: 1 0 auto; /* */
        }
        .navbar { background-color: #1a237e; }
        .hero-section { 
            background: linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.6)), 
                        url('https://images.unsplash.com/photo-1677442136019-21780ecad995?auto=format&fit=crop&q=80&w=1920'); 
            background-size: cover; 
            color: white; 
            padding: 80px 0; 
        }
    </style>
</head>
<body>
    <div class="flex-content"> <nav class="navbar navbar-expand-lg navbar-dark sticky-top">
            <div class="container">
                <a class="navbar-brand fw-bold" href="index.jsp">Maverick AI</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item"><a class="nav-link" href="index.jsp">Inicio</a></li>
                        <li class="nav-item"><a class="nav-link" href="recursos.jsp">Tips y Consejos</a></li>
                        <li class="nav-item"><a class="nav-link" href="normativa.jsp">Normatividad</a></li>
                        <li class="nav-item"><a class="btn btn-outline-light ms-lg-3" href="login.jsp">Iniciar Sesión</a></li>
                    </ul>
                </div>
            </div>
        </nav>