<%@page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%@include file="header.jsp" %>

<%
    String cursoParam = request.getParameter("curso");
    String leccionParam = request.getParameter("leccion");
    if (cursoParam == null || leccionParam == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    int idCurso = Integer.parseInt(cursoParam);
    int orden = Integer.parseInt(leccionParam);

    String tituloCurso = "", tituloLeccion = "", contenido = "";
    int totalLecciones = 0;
    boolean encontrado = false;

    try (Connection con = new config.Conexion().getConnection()) {
        PreparedStatement ps = con.prepareStatement(
            "SELECT c.titulo_curso, cnt.titulo, cnt.contenido, (SELECT COUNT(*) FROM contenidos WHERE id_curso = c.id_curso) AS total " +
            "FROM cursos c INNER JOIN contenidos cnt ON c.id_curso = cnt.id_curso " +
            "WHERE c.id_curso = ? AND cnt.orden = ?");
        ps.setInt(1, idCurso);
        ps.setInt(2, orden);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            tituloCurso = rs.getString("titulo_curso");
            tituloLeccion = rs.getString("titulo");
            contenido = rs.getString("contenido");
            totalLecciones = rs.getInt("total");
            encontrado = true;
        }
    } catch (Exception e) { }

    if (!encontrado) {
        response.sendRedirect("index.jsp");
        return;
    }

    Integer userId = (Integer) session.getAttribute("id_usuario");
    if (userId == null) {
        String userName = (String) session.getAttribute("usuario");
        if (userName != null) {
            try (Connection con = new config.Conexion().getConnection();
                 PreparedStatement ps = con.prepareStatement("SELECT id_usuario FROM usuarios WHERE nombre_usuario = ?")) {
                ps.setString(1, userName);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    userId = rs.getInt("id_usuario");
                    session.setAttribute("id_usuario", userId);
                }
            } catch (Exception e) { }
        }
    }
    if (userId != null) {
        try (Connection con = new config.Conexion().getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                "INSERT IGNORE INTO progreso_usuario (id_usuario, id_contenido) VALUES (?, " +
                "(SELECT id_contenido FROM contenidos WHERE id_curso = ? AND orden = ?))");
            ps.setInt(1, userId);
            ps.setInt(2, idCurso);
            ps.setInt(3, orden);
            ps.executeUpdate();
        } catch (Exception e) { }
    }
%>

<style>
    .lesson-page {
        background: var(--dark-surface);
        min-height: calc(100vh - 200px);
        padding: 40px 0;
    }

    .lesson-header {
        background: var(--dark-elevated);
        border: 1px solid var(--border);
        border-radius: 16px;
        padding: 1.5rem;
        margin-bottom: 1.5rem;
    }

    .lesson-header .breadcrumb {
        font-size: 0.8rem;
        color: var(--text-muted);
        margin-bottom: 0.75rem;
    }

    .lesson-header .breadcrumb a {
        color: var(--primary);
        text-decoration: none;
    }

    .lesson-header .breadcrumb a:hover {
        text-decoration: underline;
    }

    .lesson-header h1 {
        font-family: 'Orbitron', sans-serif;
        font-weight: 600;
        font-size: 1.3rem;
        color: var(--text-primary);
        margin-bottom: 0.5rem;
        letter-spacing: 0.5px;
    }

    .lesson-header .lesson-meta {
        color: var(--text-muted);
        font-size: 0.8rem;
    }

    .lesson-body {
        background: var(--dark-elevated);
        border: 1px solid var(--border);
        border-radius: 16px;
        padding: 2rem;
        margin-bottom: 1.5rem;
        line-height: 1.8;
        font-size: 0.95rem;
        color: var(--text-primary);
    }

    .lesson-body p {
        margin-bottom: 1rem;
    }

    .lesson-body code {
        background: var(--dark-surface);
        border: 1px solid var(--border);
        padding: 0.2rem 0.5rem;
        border-radius: 4px;
        font-family: 'JetBrains Mono', monospace;
        font-size: 0.85rem;
        color: var(--primary);
    }

    .lesson-body pre {
        background: var(--dark-bg);
        border: 1px solid var(--border);
        border-radius: 10px;
        padding: 1.25rem;
        overflow-x: auto;
        margin: 1rem 0;
        font-family: 'JetBrains Mono', monospace;
        font-size: 0.85rem;
        color: var(--text-primary);
        line-height: 1.6;
    }

    .lesson-body ul, .lesson-body ol {
        margin-bottom: 1rem;
        padding-left: 1.5rem;
    }

    .lesson-body li {
        margin-bottom: 0.5rem;
    }

    .lesson-body strong {
        color: var(--primary);
    }

    .lesson-body blockquote {
        border-left: 3px solid var(--primary);
        padding: 0.75rem 1rem;
        margin: 1rem 0;
        background: var(--card-bg);
        border-radius: 0 8px 8px 0;
        color: var(--text-muted);
        font-style: italic;
    }

    .lesson-nav {
        display: flex;
        justify-content: space-between;
        align-items: center;
        gap: 1rem;
        margin-top: 1.5rem;
    }

    .btn-nav {
        background: var(--dark-elevated);
        border: 1px solid var(--border);
        color: var(--text-muted);
        padding: 0.7rem 1.5rem;
        border-radius: 8px;
        font-size: 0.85rem;
        transition: all 0.2s ease;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        gap: 0.5rem;
    }

    .btn-nav:hover {
        border-color: var(--primary);
        color: var(--primary);
        text-decoration: none;
    }

    .btn-nav:disabled, .btn-nav.disabled {
        opacity: 0.3;
        pointer-events: none;
    }

    .btn-nav-primary {
        background: var(--primary);
        color: var(--dark-bg) !important;
        border: none;
        font-weight: 600;
    }

    .btn-nav-primary:hover {
        background: var(--secondary);
        color: var(--dark-bg) !important;
        box-shadow: 0 0 20px rgba(0,255,136,0.2);
    }

    .progress-bar-wrapper {
        background: var(--dark-surface);
        border: 1px solid var(--border);
        border-radius: 20px;
        height: 8px;
        overflow: hidden;
        margin-bottom: 1.5rem;
    }

    .progress-bar-fill {
        height: 100%;
        background: linear-gradient(90deg, var(--primary), var(--neon-cyan));
        border-radius: 20px;
        transition: width 0.5s ease;
        width: <%= (orden * 100 / totalLecciones) %>%;
    }

    @media (max-width: 768px) {
        .lesson-body { padding: 1.25rem; }
        .lesson-nav { flex-direction: column; }
        .btn-nav { width: 100%; justify-content: center; }
    }
</style>

<div class="lesson-page">
    <div class="container">
        <div class="lesson-header">
            <div class="breadcrumb">
                <a href="index.jsp">Inicio</a>
                <span class="mx-2">/</span>
                <a href="curso.jsp?id=<%= idCurso %>"><%= tituloCurso %></a>
                <span class="mx-2">/</span>
                <span>Leccion <%= orden %></span>
            </div>
            <h1><%= tituloLeccion %></h1>
            <div class="lesson-meta">
                Leccion <%= orden %> de <%= totalLecciones %>
            </div>
        </div>

        <div class="progress-bar-wrapper">
            <div class="progress-bar-fill"></div>
        </div>

        <div class="lesson-body">
            <%= contenido %>
        </div>

        <div class="lesson-nav">
            <% if (orden > 1) { %>
                <a href="leccion.jsp?curso=<%= idCurso %>&leccion=<%= orden - 1 %>" class="btn-nav">
                    <i class="fa-solid fa-arrow-left"></i> Anterior
                </a>
            <% } else { %>
                <span></span>
            <% } %>

            <a href="curso.jsp?id=<%= idCurso %>" class="btn-nav">
                <i class="fa-solid fa-list"></i> Lecciones
            </a>

            <% if (orden < totalLecciones) { %>
                <a href="leccion.jsp?curso=<%= idCurso %>&leccion=<%= orden + 1 %>" class="btn-nav btn-nav-primary">
                    Siguiente <i class="fa-solid fa-arrow-right"></i>
                </a>
            <% } else { %>
                <a href="curso.jsp?id=<%= idCurso %>" class="btn-nav btn-nav-primary">
                    <i class="fa-solid fa-check"></i> Completado
                </a>
            <% } %>
        </div>
    </div>
</div>

<%@include file="footer.jsp" %>
