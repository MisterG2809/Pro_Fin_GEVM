<%@include file="header.jsp" %>
<%@page import="jakarta.servlet.http.HttpServletRequest" %>
<%
    String errorMsg = (String) request.getAttribute("error");
%>
<style>
    .register-section { background: var(--dark-bg); min-height: 100vh; display: flex; align-items: center; padding: 40px 0; }
    .register-card { max-width: 420px; width: 100%; margin: auto; background: var(--dark-elevated); border: 1px solid var(--border); border-radius: 14px; overflow: hidden; box-shadow: 0 8px 40px rgba(0,0,0,0.3), 0 0 30px rgba(0,255,136,0.03); }
    .register-header { padding: 1.5rem; text-align: center; border-bottom: 1px solid var(--border); background: rgba(0,0,0,0.15); }
    .register-header .logo-mini { width: 40px; height: 40px; margin: 0 auto 0.75rem; position: relative; display: flex; align-items: center; justify-content: center; }
    .register-header .logo-mini .diamond { width: 100%; height: 100%; background: var(--dark-surface); transform: rotate(45deg); border-radius: 6px; display: flex; align-items: center; justify-content: center; border: 1.5px solid var(--primary); box-shadow: 0 0 12px rgba(0,255,136,0.15); }
    .register-header .logo-mini .diamond .inner { width: 62%; height: 62%; background: linear-gradient(135deg, var(--primary), var(--neon-cyan)); transform: rotate(45deg); border-radius: 3px; display: flex; align-items: center; justify-content: center; }
    .register-header .logo-mini .diamond .inner i { transform: rotate(-45deg); color: var(--dark-bg); font-size: 0.5rem; }
    .register-header h3 { font-family: 'Orbitron', sans-serif; font-weight: 600; font-size: 1rem; color: var(--text-primary); letter-spacing: 2px; text-transform: uppercase; margin: 0; }
    .register-header small { color: var(--text-muted); font-size: 0.8rem; }
    .register-body { padding: 1.5rem; }
    .form-label { color: var(--text-muted); font-weight: 500; font-size: 0.8rem; margin-bottom: 0.3rem; text-transform: uppercase; letter-spacing: 0.5px; }
    .input-group-text { background: var(--dark-bg); border: 1px solid var(--border); border-right: none; color: var(--text-muted); border-radius: 8px 0 0 8px; }
    .form-control { background: var(--dark-bg); border: 1px solid var(--border); border-left: none; color: var(--text-primary); padding: 0.65rem 0.85rem; border-radius: 0 8px 8px 0; font-size: 0.9rem; }
    .form-control:focus { background: var(--dark-bg); border-color: var(--primary); box-shadow: 0 0 0 2px rgba(0,255,136,0.06); color: var(--text-primary); }
    .form-control::placeholder { color: var(--text-muted); opacity: 0.5; }
    .btn-register { background: var(--primary); color: var(--dark-bg) !important; border: none; padding: 0.75rem; font-weight: 600; font-size: 0.85rem; border-radius: 8px; transition: all 0.2s ease; font-family: 'JetBrains Mono', monospace; letter-spacing: 1px; }
    .btn-register:hover { background: var(--secondary); transform: translateY(-1px); box-shadow: 0 0 20px rgba(0,255,136,0.2); }
    .btn-login-link { background: transparent; border: 1px solid var(--border); color: var(--text-muted); padding: 0.65rem; border-radius: 8px; font-size: 0.8rem; transition: all 0.2s ease; }
    .btn-login-link:hover { border-color: var(--primary); color: var(--primary); }
    .error-alert { background: rgba(255,0,0,0.06); border: 1px solid rgba(255,0,0,0.15); border-radius: 8px; padding: 0.6rem 1rem; font-size: 0.8rem; color: #f85149; margin-bottom: 1rem; }
    .role-option { background: var(--dark-bg); border: 1px solid var(--border); border-radius: 8px; padding: 0.6rem 0.8rem; cursor: pointer; transition: all 0.15s; flex: 1; text-align: center; }
    .role-option:hover { border-color: var(--primary); }
    .role-option input { display: none; }
    .role-option input:checked + label { color: var(--primary); }
    .role-option:has(input:checked) { border-color: var(--primary); background: rgba(0,255,136,0.04); }
    .role-option label { color: var(--text-muted); font-size: 0.8rem; cursor: pointer; margin: 0; width: 100%; }
    .register-body .divider { height: 1px; background: var(--border); margin: 1.25rem 0; }
</style>
<div class="register-section">
    <div class="container">
        <div class="register-card">
            <div class="register-header">
                <div class="logo-mini">
                    <div class="diamond"><div class="inner"><i class="fa-solid fa-bolt"></i></div></div>
                </div>
                <h3>Crear Cuenta</h3>
                <small>Unete al futuro del aprendizaje</small>
            </div>
            <div class="register-body">
                <% if (errorMsg != null) { %>
                    <div class="error-alert"><i class="fa-solid fa-circle-exclamation me-1"></i><%= errorMsg %></div>
                <% } %>
                <form action="Controlador" method="POST">
                    <div class="mb-3">
                        <label class="form-label"><i class="fa-solid fa-user me-1"></i>Nombre</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fa-solid fa-user"></i></span>
                            <input type="text" class="form-control" name="txtNombre" placeholder="Tu nombre" required>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label"><i class="fa-solid fa-envelope me-1"></i>Correo</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fa-solid fa-envelope"></i></span>
                            <input type="email" class="form-control" name="txtEmail" placeholder="correo@ejemplo.com" required>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label"><i class="fa-solid fa-lock me-1"></i>Contraseña</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fa-solid fa-lock"></i></span>
                            <input type="password" class="form-control" name="txtPass" placeholder="Min. 6 caracteres" required>
                        </div>
                    </div>
                    <div class="mb-4">
                        <label class="form-label"><i class="fa-solid fa-tag me-1"></i>Tipo de cuenta</label>
                        <div class="d-flex gap-2">
                            <label class="role-option">
                                <input type="radio" name="tipoCuenta" value="estudiante" checked>
                                <label><i class="fa-solid fa-graduation-cap me-1"></i>Estudiante</label>
                            </label>
                            <label class="role-option">
                                <input type="radio" name="tipoCuenta" value="desarrollador">
                                <label><i class="fa-solid fa-code me-1"></i>Desarrollador</label>
                            </label>
                        </div>
                        <small class="text-muted" style="font-size:0.65rem;display:block;margin-top:4px;">
                            Desarrolladores: sube tus cursos (requiere aprobacion del admin).
                        </small>
                    </div>
                    <div class="d-grid gap-2">
                        <button type="submit" name="accion" value="RegistrarUsuario" class="btn btn-register">
                            <i class="fa-solid fa-user-plus me-2"></i>Registrarse
                        </button>
                        <div class="divider"></div>
                        <a href="login.jsp" class="btn btn-login-link text-center text-decoration-none">
                            <i class="fa-solid fa-sign-in-alt me-2"></i>Ya tengo cuenta
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<%@include file="footer.jsp" %>