<%@include file="header.jsp" %>
<%@page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%
    String nombreUsuario = (String) session.getAttribute("usuario");
    String rol = (String) session.getAttribute("rol");
    if (nombreUsuario == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    Integer cachedCount = (Integer) application.getAttribute("totalTipsCache");
    if (cachedCount == null) {
        try (Connection con = new config.Conexion().getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) FROM tips_ia");
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) cachedCount = rs.getInt(1);
            else cachedCount = 0;
        } catch (Exception e) { cachedCount = 0; }
        application.setAttribute("totalTipsCache", cachedCount);
    }
    int totalTips = cachedCount;
    int objetivo = Math.max(totalTips, 5);
    int porcentaje = Math.min(100, (0 * 100) / objetivo);
%>

<style>
    .profile-section {
        background: var(--dark-surface);
        min-height: calc(100vh - 200px);
        padding: 40px 0;
    }
    
    .profile-card {
        background: var(--dark-elevated);
        border: 1px solid var(--border);
        border-radius: 12px;
        padding: 1.5rem;
        text-align: center;
    }
    
    .profile-card img {
        border: 2px solid var(--primary);
        border-radius: 50%;
    }
    
    .profile-card h4 {
        font-family: 'JetBrains Mono', monospace;
        font-weight: 600;
        color: var(--primary);
        margin-top: 1rem;
    }
    
    .profile-card .role {
        color: var(--secondary);
        font-weight: 500;
    }
    
    .btn-logout {
        background: transparent;
        border: 1px solid var(--border);
        color: var(--text-muted);
        padding: 0.5rem 1.25rem;
        font-weight: 500;
        border-radius: 6px;
        transition: all 0.2s ease;
    }
    
    .btn-logout:hover {
        border-color: #f85149;
        color: #f85149;
    }
    
    .content-card {
        background: var(--dark-elevated);
        border: 1px solid var(--border);
        border-radius: 12px;
        padding: 1.25rem;
    }
    
    .content-card h3 {
        font-family: 'JetBrains Mono', monospace;
        font-weight: 600;
        font-size: 1rem;
        color: var(--text-primary);
        margin-bottom: 1rem;
    }
    
    .fav-item {
        background: var(--dark-surface);
        border: 1px solid var(--border);
        border-radius: 8px;
        padding: 0.75rem;
        margin-bottom: 0.75rem;
    }
    
    .fav-item .fw-bold {
        color: var(--primary);
        font-size: 0.9rem;
    }
    
    .fav-item .badge {
        background: var(--dark-bg);
        border: 1px solid var(--border);
        font-size: 0.7rem;
    }
    
    .progress-card {
        background: var(--dark-elevated);
        border: 1px solid var(--border);
        border-radius: 12px;
        padding: 1.25rem;
        margin-top: 1.5rem;
    }
    
    .progress-card h5 {
        font-family: 'JetBrains Mono', monospace;
        font-weight: 600;
        font-size: 0.95rem;
        color: var(--text-primary);
    }
    
    .progress {
        background: var(--dark-bg);
        border-radius: 20px;
        height: 24px;
    }
    
    .progress-bar {
        background: var(--primary);
        border-radius: 20px;
        font-size: 0.75rem;
        font-weight: 500;
    }
    
    .achievement-card {
        background: var(--dark-elevated);
        border: 1px solid var(--border);
        border-radius: 12px;
        padding: 1.25rem;
        margin-top: 1.5rem;
    }
    
    .achievement-card h5 {
        font-family: 'JetBrains Mono', monospace;
        font-weight: 600;
        font-size: 0.95rem;
        color: var(--text-primary);
    }
    
    .achievement-card .achievement {
        text-align: center;
        opacity: 0.4;
    }
    
    .achievement-card .achievement.active {
        opacity: 1;
    }
</style>

<div class="profile-section">
    <div class="container">
        <div class="row">
            <div class="col-md-4 mb-4">
                <div class="profile-card">
                    <img src="https://ui-avatars.com/api/?name=<%=nombreUsuario%>&background=161b22&color=6eb6ff&size=128" 
                         class="rounded-circle mb-3" alt="Avatar">
                    <h4><%= nombreUsuario %></h4>
                    <p class="role"><%= rol != null ? rol : "Usuario" %></p>
                    <hr style="border-color: var(--border);">
                    <a href="Controlador?accion=CerrarSesion" class="btn btn-logout">
                        <i class="fa-solid fa-sign-out-alt me-2"></i>Cerrar Sesion
                    </a>
                </div>
            </div>

            <div class="col-md-8">
                <div class="content-card">
                    <h3><i class="fa-solid fa-star me-2" style="color: var(--accent);"></i>Recursos</h3>
                    
                    <div class="fav-item d-flex justify-content-between align-items-center">
                        <div>
                            <div class="fw-bold">Tips de Programacion</div>
                            <small style="color: var(--text-muted);">Aprende a usar IA para codigo</small>
                        </div>
                        <span class="badge">Explorar</span>
                    </div>
                    
                    <div class="fav-item d-flex justify-content-between align-items-center">
                        <div>
                            <div class="fw-bold">Noticias de IA</div>
                            <small style="color: var(--text-muted);">Ultimas tendencias</small>
                        </div>
                        <span class="badge">Ver</span>
                    </div>
                    
                    <div class="fav-item d-flex justify-content-between align-items-center">
                        <div>
                            <div class="fw-bold">Prompt Engineering</div>
                            <small style="color: var(--text-muted);">Mejora tus prompts</small>
                        </div>
                        <span class="badge">Estudiar</span>
                    </div>
                </div>
                
                <div class="progress-card">
                    <div class="d-flex justify-content-between align-items-center mb-2">
                        <h5><i class="fa-solid fa-chart-line me-2" style="color: var(--primary);"></i>Progreso</h5>
                        <span class="badge" style="background: var(--dark-surface); border: 1px solid var(--border);">
                            <%= totalTips %> recursos
                        </span>
                    </div>
                    <div class="progress">
                        <div class="progress-bar" style="width: <%= porcentaje %>%;">
                            <%= porcentaje %>% - Continua aprendiendo
                        </div>
                    </div>
                </div>
                
                <div class="achievement-card">
                    <h5><i class="fa-solid fa-trophy me-2" style="color: #ffd700;"></i>Logros</h5>
                    <div class="row mt-3">
                        <div class="col-4 text-center">
                            <div class="achievement <%= totalTips >= 1 ? "active" : "" %>">
                                <i class="fa-solid fa-code" style="font-size: 1.5rem; color: <%= totalTips >= 1 ? "var(--primary)" : "gray" %>;"></i>
                                <p class="small mt-2" style="color: var(--text-muted);">Primer recurso</p>
                            </div>
                        </div>
                        <div class="col-4 text-center">
                            <div class="achievement <%= totalTips >= 5 ? "active" : "" %>">
                                <i class="fa-solid fa-graduation-cap" style="font-size: 1.5rem; color: <%= totalTips >= 5 ? "var(--secondary)" : "gray" %>;"></i>
                                <p class="small mt-2" style="color: var(--text-muted);">Explorador</p>
                            </div>
                        </div>
                        <div class="col-4 text-center">
                            <div class="achievement <%= rol != null && rol.equals("admin") ? "active" : "" %>">
                                <i class="fa-solid fa-crown" style="font-size: 1.5rem; color: <%= rol != null && rol.equals("admin") ? "#ffd700" : "gray" %>;"></i>
                                <p class="small mt-2" style="color: var(--text-muted);">Admin</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@include file="footer.jsp" %>