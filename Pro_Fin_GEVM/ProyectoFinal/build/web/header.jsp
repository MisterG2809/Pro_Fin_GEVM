<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OBLIVION</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;600;900&family=Inter:wght@300;400;600;700&family=JetBrains+Mono:wght@400;500;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #00ff88;
            --secondary: #00cc88;
            --accent: #ff0088;
            --dark-bg: #080b10;
            --dark-surface: #0d1219;
            --dark-elevated: #141c2b;
            --card-bg: rgba(12, 16, 24, 0.85);
            --text-primary: #e0f0ea;
            --text-muted: #6a7f8a;
            --border: #1a2a3a;
            --success: #00ff88;
            --neon-cyan: #00e5ff;
            --neon-purple: #b400ff;
            --trinity-cyan: #00fff7;
            --trinity-purple: #a855f7;
            --trinity-glow: rgba(0, 255, 247, 0.4);
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
            border-color: var(--primary);
            color: var(--primary);
        }

        .logo-link {
            display: flex;
            align-items: center;
            gap: 12px;
            text-decoration: none;
        }
        
        .logo-mark {
            width: 38px;
            height: 38px;
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }
        
        .logo-diamond {
            width: 100%;
            height: 100%;
            background: var(--dark-surface);
            transform: rotate(45deg);
            border-radius: 6px;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            border: 1.5px solid var(--primary);
            box-shadow: 0 0 12px rgba(0,255,136,0.15), inset 0 0 12px rgba(0,255,136,0.05);
            animation: logo-glow 3s ease-in-out infinite alternate;
        }
        
        .logo-diamond::before {
            content: '';
            position: absolute;
            inset: -3px;
            border-radius: 8px;
            padding: 2px;
            background: conic-gradient(from 0deg, var(--primary), var(--neon-cyan), var(--neon-purple), var(--primary));
            -webkit-mask: linear-gradient(#000 0 0) content-box, linear-gradient(#000 0 0);
            -webkit-mask-composite: xor;
            mask-composite: exclude;
            opacity: 0.6;
            animation: border-rotate 4s linear infinite;
        }
        
        .logo-inner {
            width: 62%;
            height: 62%;
            background: linear-gradient(135deg, var(--primary), var(--neon-cyan));
            transform: rotate(45deg);
            border-radius: 3px;
            box-shadow: 0 0 8px rgba(0,255,136,0.3);
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .logo-inner i {
            transform: rotate(-45deg);
            color: var(--dark-bg);
            font-size: 0.6rem;
        }
        
        @keyframes logo-glow {
            from { box-shadow: 0 0 12px rgba(0,255,136,0.15), inset 0 0 12px rgba(0,255,136,0.05); }
            to { box-shadow: 0 0 25px rgba(0,255,136,0.3), inset 0 0 20px rgba(0,255,136,0.08); }
        }
        
        @keyframes border-rotate {
            to { transform: rotate(360deg); }
        }
        
        .logo-text {
            font-family: 'Orbitron', sans-serif;
            font-size: 1.3rem;
            font-weight: 600;
            color: var(--text-primary);
            letter-spacing: 3px;
            text-transform: uppercase;
            text-shadow: 0 0 20px rgba(0,255,136,0.2);
            line-height: 1;
        }
        
        .logo-text .dot {
            color: var(--primary);
        }

        .orb-container {
            position: fixed;
            bottom: 24px;
            right: 24px;
            z-index: 9999;
            cursor: pointer;
        }

        .orb {
            width: 64px;
            height: 64px;
            background: radial-gradient(circle at 30% 30%, #0a1a2e, #06101f);
            border-radius: 20% 50% 20% 50%;
            box-shadow: 0 0 25px var(--trinity-glow), 0 0 50px rgba(168,85,247,0.2), inset 0 0 30px rgba(0,255,247,0.05);
            animation: trinity-float 4s ease-in-out infinite, trinity-rotate 8s linear infinite;
            transition: all 0.3s ease;
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
            border: 1px solid rgba(0,255,247,0.2);
        }

        .orb::before {
            content: '';
            position: absolute;
            inset: -2px;
            border-radius: 20% 50% 20% 50%;
            padding: 2px;
            background: conic-gradient(var(--trinity-cyan), var(--trinity-purple), var(--trinity-cyan));
            -webkit-mask: linear-gradient(#000 0 0) content-box, linear-gradient(#000 0 0);
            -webkit-mask-composite: xor;
            mask-composite: exclude;
            opacity: 0.6;
            animation: border-spin 3s linear infinite;
        }

        @keyframes border-spin {
            to { transform: rotate(360deg); }
        }

        .eye-wrapper {
            width: 32px;
            height: 32px;
            background: radial-gradient(circle at 40% 35%, #0a1628, #06101f);
            border-radius: 50%;
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: inset 0 2px 10px rgba(0,0,0,0.5), 0 0 10px rgba(0,255,247,0.15);
            transition: height 0.12s ease, margin 0.12s ease;
            overflow: hidden;
            border: 1px solid rgba(0,255,247,0.15);
        }

        .eye-wrapper.closed {
            height: 3px;
            margin-top: 14px;
            margin-bottom: 15px;
            background: linear-gradient(90deg, var(--trinity-cyan), var(--trinity-purple));
            border-radius: 3px;
            border: none;
        }

        .iris {
            width: 16px;
            height: 16px;
            background: radial-gradient(circle at 35% 35%, #00fff7, #0369a1, #0a1628);
            border-radius: 50%;
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: transform 0.1s ease;
            box-shadow: 0 0 10px rgba(0,255,247,0.3), inset 0 0 6px rgba(0,255,247,0.1);
        }

        .iris::before {
            content: '';
            position: absolute;
            width: 100%;
            height: 100%;
            border-radius: 50%;
            border: 1px solid rgba(168,85,247,0.2);
            animation: iris-pulse 2s ease-in-out infinite alternate;
        }

        @keyframes iris-pulse {
            from { transform: scale(1); opacity: 0.5; }
            to { transform: scale(1.3); opacity: 0; }
        }

        .pupil {
            width: 5px;
            height: 8px;
            background: #000814;
            border-radius: 40%;
            position: relative;
            transition: all 0.1s ease;
        }

        .pupil::after {
            content: '';
            position: absolute;
            width: 2px;
            height: 2px;
            background: rgba(0,255,247,0.8);
            border-radius: 50%;
            top: 1px;
            left: 1px;
            box-shadow: 0 0 3px rgba(0,255,247,0.5);
        }

        .orb:hover {
            transform: scale(1.15) rotate(5deg);
            box-shadow: 0 0 40px var(--trinity-glow), 0 0 80px rgba(168,85,247,0.3);
            cursor: pointer;
        }

        .orb:active {
            transform: scale(0.9);
        }

        @keyframes trinity-float {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-6px); }
        }

        @keyframes trinity-rotate {
            0% { border-radius: 20% 50% 20% 50%; }
            25% { border-radius: 50% 20% 50% 20%; }
            50% { border-radius: 30% 60% 30% 60%; }
            75% { border-radius: 60% 30% 60% 30%; }
            100% { border-radius: 20% 50% 20% 50%; }
        }

        .chat-panel {
            position: absolute;
            bottom: 85px;
            right: 0;
            width: 340px;
            max-height: 460px;
            background: rgba(10, 18, 28, 0.96);
            border: 1px solid rgba(0,255,247,0.2);
            border-radius: 14px;
            box-shadow: 0 8px 40px rgba(0,0,0,0.6), 0 0 30px rgba(0,255,247,0.06);
            backdrop-filter: blur(14px);
            display: none;
            flex-direction: column;
            overflow: hidden;
            z-index: 10000;
            transition: opacity 0.2s ease, transform 0.2s ease;
        }
        .chat-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 12px 16px;
            border-bottom: 1px solid rgba(0,255,247,0.1);
            background: rgba(0,255,247,0.03);
        }
        .chat-header-title {
            font-family: 'JetBrains Mono', monospace;
            font-size: 0.8rem;
            font-weight: 600;
            color: var(--text-primary);
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .chat-dot {
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background: var(--trinity-cyan);
            box-shadow: 0 0 8px var(--trinity-cyan);
            animation: chat-dot-pulse 1.5s ease-in-out infinite;
        }
        @keyframes chat-dot-pulse {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.4; }
        }
        .chat-close {
            background: none;
            border: none;
            color: var(--text-muted);
            font-size: 1rem;
            cursor: pointer;
            padding: 4px 8px;
            border-radius: 6px;
            transition: all 0.15s ease;
            line-height: 1;
        }
        .chat-close:hover {
            color: var(--text-primary);
            background: rgba(255,255,255,0.06);
        }
        .chat-body {
            flex: 1;
            overflow-y: auto;
            padding: 12px 16px;
            display: flex;
            flex-direction: column;
            gap: 10px;
            max-height: 300px;
            scroll-behavior: smooth;
        }
        .chat-body::-webkit-scrollbar {
            width: 4px;
        }
        .chat-body::-webkit-scrollbar-track {
            background: transparent;
        }
        .chat-body::-webkit-scrollbar-thumb {
            background: rgba(0,255,247,0.2);
            border-radius: 4px;
        }
        .chat-msg {
            display: flex;
            flex-direction: column;
            max-width: 90%;
            animation: msg-in 0.2s ease;
        }
        @keyframes msg-in {
            from { opacity: 0; transform: translateY(6px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .chat-msg.user {
            align-self: flex-end;
        }
        .chat-msg.ai {
            align-self: flex-start;
        }
        .msg-content {
            padding: 8px 12px;
            border-radius: 10px;
            font-size: 0.8rem;
            line-height: 1.45;
            word-wrap: break-word;
            white-space: pre-wrap;
        }
        .chat-msg.user .msg-content {
            background: rgba(0,255,136,0.12);
            border: 1px solid rgba(0,255,136,0.2);
            color: var(--text-primary);
            border-bottom-right-radius: 3px;
        }
        .chat-msg.ai .msg-content {
            background: rgba(0,255,247,0.05);
            border: 1px solid rgba(0,255,247,0.12);
            color: var(--text-primary);
            border-bottom-left-radius: 3px;
        }
        .chat-msg.ai.loading .msg-content {
            color: var(--text-muted);
            font-style: italic;
        }
        .msg-label {
            font-size: 0.65rem;
            color: var(--text-muted);
            margin: 2px 6px;
        }
        .chat-footer {
            display: flex;
            align-items: center;
            gap: 6px;
            padding: 10px 12px;
            border-top: 1px solid rgba(0,255,247,0.08);
            background: rgba(0,0,0,0.2);
        }
        .chat-input {
            flex: 1;
            background: rgba(0,255,247,0.04);
            border: 1px solid rgba(0,255,247,0.15);
            border-radius: 8px;
            padding: 8px 12px;
            font-size: 0.78rem;
            color: var(--text-primary);
            outline: none;
            transition: border-color 0.2s;
        }
        .chat-input:focus {
            border-color: var(--trinity-cyan);
        }
        .chat-input::placeholder {
            color: var(--text-muted);
        }
        .chat-send {
            background: rgba(0,255,247,0.08);
            border: 1px solid rgba(0,255,247,0.2);
            border-radius: 8px;
            color: var(--trinity-cyan);
            padding: 8px 12px;
            cursor: pointer;
            transition: all 0.15s;
            font-size: 0.85rem;
            line-height: 1;
        }
        .chat-send:hover {
            background: rgba(0,255,247,0.18);
            border-color: var(--trinity-cyan);
        }

        .speech-bubble {
            position: absolute;
            bottom: 75px;
            right: 0;
            background: rgba(12, 20, 30, 0.95);
            border: 1px solid rgba(0,255,247,0.3);
            border-radius: 12px;
            padding: 10px 14px;
            font-size: 0.75rem;
            color: var(--text-primary);
            max-width: 260px;
            text-align: center;
            opacity: 0;
            transform: translateY(10px);
            transition: all 0.3s ease;
            pointer-events: none;
            box-shadow: 0 4px 20px rgba(0,0,0,0.5), 0 0 15px rgba(0,255,247,0.05);
            backdrop-filter: blur(10px);
        }

        .speech-bubble::after {
            content: '';
            position: absolute;
            bottom: -6px;
            right: 24px;
            width: 12px;
            height: 12px;
            background: rgba(12, 20, 30, 0.95);
            border-right: 1px solid rgba(0,255,247,0.3);
            border-bottom: 1px solid rgba(0,255,247,0.3);
            transform: rotate(45deg);
        }

        .orb-container:hover .speech-bubble {
            opacity: 1;
            transform: translateY(0);
        }
        
        @media (max-width: 768px) {
            .orb { width: 48px; height: 48px; }
            .eye-wrapper { width: 24px; height: 24px; }
            .iris { width: 12px; height: 12px; }
            .pupil { width: 4px; height: 6px; }
            .speech-bubble { max-width: 170px; font-size: 0.7rem; }
            .chat-panel { width: calc(100vw - 32px); right: 0; bottom: 75px; max-height: 60vh; }
            .chat-body { max-height: 40vh; }
        }
    </style>
</head>
<body>
    <div class="orb-container" id="ai-orb">
        <div class="chat-panel" id="chat-panel">
            <div class="chat-header">
                <span class="chat-header-title">
                    <span class="chat-dot"></span>
                    Trinity AI
                </span>
                <button class="chat-close" id="chat-close" title="Cerrar">
                    <i class="fa-solid fa-times"></i>
                </button>
            </div>
            <div class="chat-body" id="chat-body">
                <div class="chat-msg ai">
                    <div class="msg-content">Hola, soy Trinity. Preguntame lo que quieras 🌌</div>
                </div>
            </div>
            <div class="chat-footer">
                <input class="chat-input" id="chat-input" type="text" placeholder="Escribe tu mensaje...">
                <button class="chat-send" id="chat-send">
                    <i class="fa-solid fa-paper-plane"></i>
                </button>
            </div>
        </div>
        <div class="speech-bubble" id="orb-speech">Trinity online 🌌</div>
        <div class="orb" id="orb">
            <div class="eye-wrapper" id="eyelid">
                <div class="iris" id="iris">
                    <div class="pupil" id="pupil"></div>
                </div>
            </div>
        </div>
    </div>
    <div class="flex-content">
        <nav class="navbar navbar-expand-lg navbar-dark sticky-top">
            <div class="container">
                <a class="logo-link" href="index.jsp">
                    <div class="logo-mark">
                        <div class="logo-diamond">
                            <div class="logo-inner">
                                <i class="fa-solid fa-bolt"></i>
                            </div>
                        </div>
                    </div>
                    <span class="logo-text">OBLIVION<span class="dot">·</span></span>
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto align-items-center">
                        <li class="nav-item"><a class="nav-link" href="index.jsp"><i class="fa-solid fa-house me-1"></i>Inicio</a></li>
                        <li class="nav-item"><a class="nav-link" href="Controlador?accion=listar"><i class="fa-solid fa-code me-1"></i>Codigo</a></li>
                        <li class="nav-item"><a class="nav-link" href="articulos.jsp"><i class="fa-solid fa-robot me-1"></i>IA</a></li>
                        <%
                            String user = (String) session.getAttribute("usuario");
                            if (user != null) {
                        %>
                            <% if (session.getAttribute("rol") != null && session.getAttribute("rol").equals("administrador")) { %>
                                <li class="nav-item"><a class="nav-link" href="admin.jsp"><i class="fa-solid fa-shield-halved me-1"></i>Admin</a></li>
                            <% } else if (session.getAttribute("rol") != null && session.getAttribute("rol").equals("desarrollador")) { %>
                                <li class="nav-item"><a class="nav-link" href="crear_curso.jsp"><i class="fa-solid fa-plus-circle me-1"></i>Curso</a></li>
                            <% } %>
                            <li class="nav-item ms-lg-3">
                                <a class="nav-link" href="perfil.jsp" style="color: var(--primary) !important;">
                                    <i class="fa-solid fa-user-astronaut me-1"></i><%= user %>
                                    <% if (session.getAttribute("rol") != null && session.getAttribute("rol").equals("administrador")) { %>
                                        <i class="fa-solid fa-crown ms-1" style="color:#ffd700;font-size:0.8rem;"></i>
                                    <% } else { %>
                                        <i class="fa-solid fa-rocket ms-1" style="color:var(--primary);font-size:0.8rem;"></i>
                                    <% } %>
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