<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ANDRÓMEDA</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #6eb6ff;
            --secondary: #9d7bea;
            --accent: #c792ea;
            --dark-bg: #0d1117;
            --dark-surface: #161b22;
            --dark-elevated: #21262d;
            --card-bg: rgba(22, 27, 34, 0.8);
            --text-primary: #c9d1d9;
            --text-muted: #8b949e;
            --border: #30363d;
            --success: #3fb950;
        }
        
        * { font-family: 'Inter', sans-serif; }
        
        body {
            background: var(--dark-bg);
            color: var(--text-primary);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        
        .flex-content { flex: 1 0 auto; }
        
        .navbar {
            background: var(--dark-surface) !important;
            border-bottom: 1px solid var(--border);
            padding: 0.75rem 0;
        }
        
        .navbar-brand {
            font-family: 'JetBrains Mono', monospace;
            font-size: 1.4rem;
            font-weight: 600;
            color: var(--primary) !important;
            letter-spacing: 1px;
        }
        
        .nav-link {
            color: var(--text-muted) !important;
            font-weight: 400;
            padding: 0.5rem 1rem !important;
            transition: all 0.2s ease;
            font-size: 0.9rem;
        }
        
        .nav-link:hover {
            color: var(--text-primary) !important;
            background: rgba(255,255,255,0.05);
            border-radius: 6px;
        }
        
        .btn-login {
            background: var(--primary);
            color: var(--dark-bg) !important;
            border: none;
            padding: 0.4rem 1rem;
            font-weight: 500;
            font-size: 0.85rem;
            border-radius: 6px;
            transition: all 0.2s ease;
        }
        
        .btn-login:hover {
            background: var(--secondary);
            transform: translateY(-1px);
        }
        
        .btn-logout {
            background: transparent;
            border: 1px solid var(--border);
            color: var(--text-muted);
            padding: 0.4rem 1rem;
            font-size: 0.85rem;
            border-radius: 6px;
            transition: all 0.2s ease;
        }
        
        .btn-logout:hover {
            border-color: #f85149;
            color: #f85149;
        }
    </style>
</head>
<body>
    <div class="flex-content">
        <nav class="navbar navbar-expand-lg navbar-dark sticky-top">
            <div class="container">
                <a class="navbar-brand" href="index.jsp">
                    <i class="fa-solid fa-brain me-2"></i>ANDRÓMEDA
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto align-items-center">
                        <li class="nav-item"><a class="nav-link" href="index.jsp"><i class="fa-solid fa-house me-1"></i>Inicio</a></li>
                        <li class="nav-item"><a class="nav-link" href="Controlador?accion=listar"><i class="fa-solid fa-code me-1"></i>Codigo</a></li>
                        <li class="nav-item"><a class="nav-link" href="articulos.jsp"><i class="fa-solid fa-robot me-1"></i>IA</a></li>
                        <li class="nav-item"><a class="nav-link" href="normativa.jsp"><i class="fa-solid fa-gavel me-1"></i>Legal</a></li>
                        <%
                            String user = (String) session.getAttribute("usuario");
                            if (user != null) {
                        %>
                            <li class="nav-item ms-lg-3">
                                <a class="nav-link" href="perfil.jsp" style="color: var(--primary) !important;">
                                    <i class="fa-solid fa-user-astronaut me-1"></i><%= user %>
                                </a>
                            </li>
                            <li class="nav-item ms-lg-2">
                                <a class="btn btn-logout" href="Controlador?accion=CerrarSesion">Salir</a>
                            </li>
                        <% } else { %>
                            <li class="nav-item ms-lg-3">
                                <a class="btn btn-login" href="login.jsp">Iniciar Sesión</a>
                            </li>
                        <% } %>
                    </ul>
                </div>
            </div>
        </nav>