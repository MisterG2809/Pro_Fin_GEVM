<%@include file="header.jsp" %>

<style>
    .login-section {
        background: var(--dark-surface);
        min-height: calc(100vh - 200px);
        display: flex;
        align-items: center;
        padding: 40px 0;
    }
    
    .login-card {
        background: var(--dark-elevated);
        border: 1px solid var(--border);
        border-radius: 12px;
        padding: 2rem;
        box-shadow: 0 8px 24px rgba(0,0,0,0.2);
    }
    
    .login-card .icon-wrapper {
        width: 60px;
        height: 60px;
        background: var(--dark-surface);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 1rem;
        border: 1px solid var(--border);
    }
    
    .login-card .icon-wrapper i {
        font-size: 1.5rem;
        color: var(--primary);
    }
    
    .login-card h2 {
        font-family: 'JetBrains Mono', monospace;
        font-weight: 600;
        font-size: 1.3rem;
        color: var(--text-primary);
        text-align: center;
    }
    
    .login-card .form-label {
        color: var(--text-muted);
        font-weight: 500;
        font-size: 0.85rem;
    }
    
    .login-card .form-control {
        background: var(--dark-bg);
        border: 1px solid var(--border);
        color: var(--text-primary);
        padding: 0.7rem 0.9rem;
        border-radius: 8px;
        font-size: 0.9rem;
    }
    
    .login-card .form-control:focus {
        background: var(--dark-bg);
        border-color: var(--primary);
        box-shadow: 0 0 0 2px rgba(110, 182, 255, 0.1);
        color: var(--text-primary);
    }
    
    .login-card .form-control::placeholder {
        color: var(--text-muted);
        opacity: 0.6;
    }
    
    .btn-login-submit {
        background: var(--primary);
        color: var(--dark-bg) !important;
        border: none;
        padding: 0.75rem;
        font-weight: 500;
        font-size: 0.9rem;
        border-radius: 8px;
        transition: all 0.2s ease;
    }
    
    .btn-login-submit:hover {
        background: var(--secondary);
    }
    
    .register-link {
        color: var(--primary);
        text-decoration: none;
        font-weight: 500;
    }
    
    .register-link:hover {
        color: var(--secondary);
    }
    
    .alert-tech {
        background: rgba(248, 81, 73, 0.1);
        border: 1px solid rgba(248, 81, 73, 0.3);
        border-radius: 8px;
        color: #f85149;
        font-size: 0.85rem;
    }
</style>

<div class="login-section">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-5 col-lg-4">
                <div class="login-card">
                    <div class="text-center">
                        <div class="icon-wrapper">
                            <i class="fa-solid fa-user"></i>
                        </div>
                        <h2 class="mb-1">ANDRÓMEDA</h2>
                        <p class="text-muted small">Aprende IAG</p>
                    </div>
                    
                    <form action="Controlador" method="POST" class="mt-4">
                        <div class="mb-3">
                            <label class="form-label">Correo</label>
                            <input type="email" class="form-control" name="correo" required placeholder="correo@ejemplo.com">
                        </div>
                        <div class="mb-4">
                            <label class="form-label">Contraseña</label>
                            <input type="password" class="form-control" name="password" required placeholder="********">
                        </div>
                        <button type="submit" name="accion" value="IniciarSesion" class="btn btn-login-submit w-100">
                            Iniciar Sesión
                        </button>
                    </form>
                    
                    <div class="text-center mt-4">
                        <span class="small text-muted">¿No tienes cuenta? </span>
                        <a href="registro.jsp" class="register-link">Regístrate</a>
                    </div>
                </div>
                
                <% if(request.getAttribute("error") != null) { %>
                    <div class="alert alert-tech mt-3 text-center py-2" role="alert">
                        <%= request.getAttribute("error") %>
                    </div>
                <% } %>
            </div>
        </div>
    </div>
</div>

<%@include file="footer.jsp" %>