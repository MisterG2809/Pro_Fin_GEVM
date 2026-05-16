<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro - ANDRÓMEDA</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&family=JetBrains+Mono:wght@400;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #6eb6ff;
            --secondary: #9d7bea;
            --accent: #c792ea;
            --dark-bg: #0d1117;
            --dark-surface: #161b22;
            --dark-elevated: #21262d;
            --card-bg: rgba(22, 27, 34, 0.95);
            --text-primary: #c9d1d9;
            --text-muted: #8b949e;
            --border: #30363d;
            --success: #3fb950;
        }
        
        * { font-family: 'Inter', sans-serif; }
        
        body {
            background: var(--dark-surface);
            min-height: 100vh;
            display: flex;
            align-items: center;
            padding: 40px 0;
        }
        
        .card-register {
            max-width: 420px;
            width: 100%;
            margin: auto;
            background: var(--dark-elevated);
            border: 1px solid var(--border);
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 8px 24px rgba(0,0,0,0.2);
        }
        
        .card-header-register {
            background: var(--dark-bg);
            padding: 1.5rem;
            text-align: center;
            border-bottom: 1px solid var(--border);
        }
        
        .card-header-register h3 {
            font-family: 'JetBrains Mono', monospace;
            font-weight: 600;
            font-size: 1.2rem;
            color: var(--text-primary);
            margin: 0;
        }
        
        .card-body-register {
            padding: 1.5rem;
        }
        
        .form-label {
            color: var(--text-muted);
            font-weight: 500;
            font-size: 0.85rem;
            margin-bottom: 0.4rem;
        }
        
        .input-group-text {
            background: var(--dark-bg);
            border: 1px solid var(--border);
            border-right: none;
            color: var(--text-muted);
        }
        
        .form-control {
            background: var(--dark-bg);
            border: 1px solid var(--border);
            border-left: none;
            color: var(--text-primary);
            padding: 0.65rem 0.85rem;
            border-radius: 0 8px 8px 0;
            font-size: 0.9rem;
        }
        
        .form-control:focus {
            background: var(--dark-bg);
            border-color: var(--primary);
            box-shadow: 0 0 0 2px rgba(110, 182, 255, 0.1);
            color: var(--text-primary);
        }
        
        .form-control::placeholder {
            color: var(--text-muted);
            opacity: 0.6;
        }
        
        .btn-register {
            background: var(--primary);
            color: var(--dark-bg) !important;
            border: none;
            padding: 0.75rem;
            font-weight: 500;
            font-size: 0.9rem;
            border-radius: 8px;
            transition: all 0.2s ease;
        }
        
        .btn-register:hover {
            background: var(--secondary);
        }
        
        .btn-login-link {
            background: transparent;
            border: 1px solid var(--border);
            color: var(--text-muted);
            padding: 0.65rem;
            border-radius: 8px;
            font-size: 0.85rem;
            transition: all 0.2s ease;
        }
        
        .btn-login-link:hover {
            border-color: var(--primary);
            color: var(--primary);
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="card card-register">
            <div class="card-header-register">
                <h3><i class="fa-solid fa-user-plus me-2"></i>Crear Cuenta</h3>
                <small class="text-muted">Únete al centro de aprendizaje de IA</small>
            </div>
            <div class="card-body-register">
                <form action="Controlador" method="POST">
                    <div class="mb-3">
                        <label for="txtNombre" class="form-label">Nombre Completo</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fa-solid fa-user"></i></span>
                            <input type="text" class="form-control" id="txtNombre" name="txtNombre" placeholder="Juan Pérez" required>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="txtEmail" class="form-label">Correo Electrónico</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fa-solid fa-envelope"></i></span>
                            <input type="email" class="form-control" id="txtEmail" name="txtEmail" placeholder="correo@ejemplo.com" required>
                        </div>
                    </div>

                    <div class="mb-4">
                        <label for="txtPass" class="form-label">Contraseña</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fa-solid fa-lock"></i></span>
                            <input type="password" class="form-control" id="txtPass" name="txtPass" placeholder="Mínimo 6 caracteres" required>
                        </div>
                    </div>

                    <div class="d-grid gap-2">
                        <button type="submit" name="accion" value="RegistrarUsuario" class="btn btn-register text-white">
                            <i class="fa-solid fa-user-plus me-2"></i>Registrarse
                        </button>
                        <a href="login.jsp" class="btn btn-login-link text-center text-decoration-none">
                            <i class="fa-solid fa-sign-in-alt me-2"></i>Ya tengo cuenta
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>