<%@include file="header.jsp" %>
<%@page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.util.HashSet" %>
<%
    String nombreUsuario = (String) session.getAttribute("usuario");
    String rol = (String) session.getAttribute("rol");
    if (nombreUsuario == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    Integer userId = (Integer) session.getAttribute("id_usuario");
    String fotoPerfil = null;
    String estado = "";
    if (userId == null) {
        try (Connection con = new config.Conexion().getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT id_usuario, foto_perfil, estado FROM usuarios WHERE nombre_usuario = ?")) {
            ps.setString(1, nombreUsuario);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) { userId = rs.getInt("id_usuario"); session.setAttribute("id_usuario", userId); fotoPerfil = rs.getString("foto_perfil"); estado = rs.getString("estado"); }
        } catch (Exception e) { }
    } else {
        try (Connection con = new config.Conexion().getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT foto_perfil, estado FROM usuarios WHERE id_usuario = ?")) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) { fotoPerfil = rs.getString("foto_perfil"); estado = rs.getString("estado"); }
        } catch (Exception e) { }
    }

    int totalCursos = 0, totalLecciones = 0, completadas = 0, progresoPorcentaje = 0;
    java.util.List<Object[]> progresoCursos = new java.util.ArrayList<>();
    if (userId != null) {
        try (Connection con = new config.Conexion().getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) FROM cursos");
            ResultSet rs = ps.executeQuery();
            if (rs.next()) totalCursos = rs.getInt(1);

            ps = con.prepareStatement("SELECT COUNT(*) FROM contenidos");
            rs = ps.executeQuery();
            if (rs.next()) totalLecciones = rs.getInt(1);

            ps = con.prepareStatement("SELECT COUNT(*) FROM progreso_usuario WHERE id_usuario = ?");
            ps.setInt(1, userId);
            rs = ps.executeQuery();
            if (rs.next()) completadas = rs.getInt(1);

            progresoPorcentaje = totalLecciones > 0 ? (completadas * 100 / totalLecciones) : 0;

            ps = con.prepareStatement(
                "SELECT c.id_curso, c.titulo_curso, COUNT(cnt.id_contenido) AS total, " +
                "(SELECT COUNT(*) FROM progreso_usuario pu " +
                " INNER JOIN contenidos cnt2 ON pu.id_contenido = cnt2.id_contenido " +
                " WHERE cnt2.id_curso = c.id_curso AND pu.id_usuario = ?) AS hechas " +
                "FROM cursos c INNER JOIN contenidos cnt ON c.id_curso = cnt.id_curso " +
                "GROUP BY c.id_curso ORDER BY c.id_curso");
            ps.setInt(1, userId);
            rs = ps.executeQuery();
            while (rs.next()) {
                progresoCursos.add(new Object[]{rs.getInt("id_curso"), rs.getString("titulo_curso"), rs.getInt("total"), rs.getInt("hechas")});
            }
        } catch (Exception e) { }
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
                    <div style="position:relative;display:inline-block;">
                        <img src="<%= fotoPerfil != null && !fotoPerfil.isEmpty() ? fotoPerfil : "https://ui-avatars.com/api/?name=" + java.net.URLEncoder.encode(nombreUsuario, "UTF-8") + "&background=161b22&color=6eb6ff&size=128" %>" 
                             class="rounded-circle mb-3" alt="Avatar" style="width:96px;height:96px;object-fit:cover;">
                        <label for="fotoUpload" class="btn btn-sm" style="position:absolute;bottom:8px;right:-4px;background:var(--dark-elevated);border:2px solid var(--primary);border-radius:50%;width:32px;height:32px;display:flex;align-items:center;justify-content:center;cursor:pointer;color:var(--primary);">
                            <i class="fa-solid fa-camera"></i>
                        </label>
                    </div>
                    <form action="subirFoto" method="POST" enctype="multipart/form-data" style="display:none;" id="fotoForm">
                        <input type="file" name="fotoPerfil" id="fotoUpload" accept="image/*" onchange="document.getElementById('fotoForm').submit();">
                    </form>
                    <h4>
                        <%= nombreUsuario %>
                        <% if (rol != null && rol.equals("administrador")) { %>
                            <span style="color:#ffd700;font-size:1.2rem;" title="Administrador">
                                <i class="fa-solid fa-crown"></i>
                            </span>
                        <% } else { %>
                            <span style="color:var(--primary);font-size:1rem;" title="Estudiante">
                                <i class="fa-solid fa-rocket"></i>
                            </span>
                        <% } %>
                    </h4>
                    <p class="role">
                        <%= rol != null ? rol : "Usuario" %>
                        <% if ("desarrollador".equals(rol)) { %>
                            <% if ("pendiente".equals(estado)) { %>
                                <span class="badge" style="background:#b8860b;font-size:0.6rem;vertical-align:middle;">Pendiente</span>
                            <% } else { %>
                                <span class="badge" style="background:var(--primary);font-size:0.6rem;vertical-align:middle;">Verificado</span>
                            <% } %>
                        <% } %>
                    </p>
                    <hr style="border-color: var(--border);">
                    <a href="Controlador?accion=CerrarSesion" class="btn btn-logout">
                        <i class="fa-solid fa-sign-out-alt me-2"></i>Cerrar Sesion
                    </a>
                </div>
            </div>

            <div class="col-md-8">
                <div class="content-card">
                    <h3><i class="fa-solid fa-star me-2" style="color: var(--accent);"></i>Recursos</h3>
                    
                    <a href="Controlador?accion=listar" style="text-decoration:none;color:inherit;">
                    <div class="fav-item d-flex justify-content-between align-items-center">
                        <div>
                            <div class="fw-bold">Tips de Programacion</div>
                            <small style="color: var(--text-muted);">Aprende a usar IA para codigo</small>
                        </div>
                        <span class="badge">Explorar <i class="fa-solid fa-arrow-right ms-1"></i></span>
                    </div>
                    </a>
                    
                    <a href="articulos.jsp" style="text-decoration:none;color:inherit;">
                    <div class="fav-item d-flex justify-content-between align-items-center">
                        <div>
                            <div class="fw-bold">Noticias de IA</div>
                            <small style="color: var(--text-muted);">Ultimas tendencias</small>
                        </div>
                        <span class="badge">Ver <i class="fa-solid fa-arrow-right ms-1"></i></span>
                    </div>
                    </a>
                    
                    <a href="prompt_maestro.jsp" style="text-decoration:none;color:inherit;">
                    <div class="fav-item d-flex justify-content-between align-items-center">
                        <div>
                            <div class="fw-bold">Prompt Engineering</div>
                            <small style="color: var(--text-muted);">Mejora tus prompts</small>
                        </div>
                        <span class="badge">Estudiar <i class="fa-solid fa-arrow-right ms-1"></i></span>
                    </div>
                    </a>
                </div>
                
                <div class="progress-card">
                    <div class="d-flex justify-content-between align-items-center mb-2">
                        <h5><i class="fa-solid fa-chart-line me-2" style="color: var(--primary);"></i>Progreso General</h5>
                        <span class="badge" style="background: var(--dark-surface); border: 1px solid var(--border);">
                            <%= completadas %>/<%= totalLecciones %> lecciones
                        </span>
                    </div>
                    <div class="progress">
                        <div class="progress-bar" style="width: <%= progresoPorcentaje %>%;">
                            <%= progresoPorcentaje %>%
                        </div>
                    </div>
                </div>

                <div class="progress-card">
                    <h5><i class="fa-solid fa-book me-2" style="color: var(--primary);"></i>Progreso por Curso</h5>
                    <% for (Object[] pc : progresoCursos) { 
                        int cursoId = (int) pc[0];
                        String cursoTit = (String) pc[1];
                        int totalL = (int) pc[2];
                        int hechas = (int) pc[3];
                        int pct = totalL > 0 ? (hechas * 100 / totalL) : 0;
                    %>
                    <div class="d-flex justify-content-between align-items-center mt-3">
                        <span style="font-size:0.85rem;"><%= cursoTit %></span>
                        <span style="font-size:0.8rem;color:var(--text-muted);"><%= hechas %>/<%= totalL %></span>
                    </div>
                    <div class="progress mt-1" style="height:10px;">
                        <div class="progress-bar" style="width:<%= pct %>%;font-size:0.6rem;"><%= pct %>%</div>
                    </div>
                    <% } %>
                </div>
                
                <div class="achievement-card">
                    <h5><i class="fa-solid fa-trophy me-2" style="color: #ffd700;"></i>Logros</h5>
                    <div class="row mt-3">
                        <div class="col-3 text-center">
                            <div class="achievement <%= completadas >= 1 ? "active" : "" %>">
                                <i class="fa-solid fa-play" style="font-size: 1.5rem; color: <%= completadas >= 1 ? "var(--primary)" : "gray" %>;"></i>
                                <p class="small mt-2" style="color: var(--text-muted);">Primera leccion</p>
                            </div>
                        </div>
                        <div class="col-3 text-center">
                            <div class="achievement <%= completadas >= 5 ? "active" : "" %>">
                                <i class="fa-solid fa-rocket" style="font-size: 1.5rem; color: <%= completadas >= 5 ? "var(--secondary)" : "gray" %>;"></i>
                                <p class="small mt-2" style="color: var(--text-muted);">5 lecciones</p>
                            </div>
                        </div>
                        <div class="col-3 text-center">
                            <div class="achievement <%= completadas >= 12 ? "active" : "" %>">
                                <i class="fa-solid fa-graduation-cap" style="font-size: 1.5rem; color: <%= completadas >= 12 ? "var(--accent)" : "gray" %>;"></i>
                                <p class="small mt-2" style="color: var(--text-muted);">Completaste todo</p>
                            </div>
                        </div>
                        <div class="col-3 text-center">
                            <div class="achievement <%= progresoPorcentaje >= 100 ? "active" : "" %>">
                                <i class="fa-solid fa-crown" style="font-size: 1.5rem; color: <%= progresoPorcentaje >= 100 ? "#ffd700" : "gray" %>;"></i>
                                <p class="small mt-2" style="color: var(--text-muted);">Maestro IA</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@include file="footer.jsp" %>