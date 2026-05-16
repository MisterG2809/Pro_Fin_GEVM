<%@page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%@include file="header.jsp" %>

<%
    String idParam = request.getParameter("id");
    if (idParam == null || idParam.isEmpty()) {
        response.sendRedirect("index.jsp");
        return;
    }
    
    int idCurso = Integer.parseInt(idParam);
    
    String titulo = "", descripcion = "", nivel = "", imagen = "";
    boolean encontrado = false;
    
    try (Connection con = new config.Conexion().getConnection()) {
        PreparedStatement ps = con.prepareStatement("SELECT * FROM cursos WHERE id_curso = ?");
        ps.setInt(1, idCurso);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            titulo = rs.getString("titulo_curso");
            descripcion = rs.getString("descripcion");
            nivel = rs.getString("nivel");
            imagen = rs.getString("imagen_url");
            encontrado = true;
        }
    } catch (Exception e) { }
    
    if (!encontrado) {
        response.sendRedirect("index.jsp");
        return;
    }
%>

<style>
    .course-detail {
        background: var(--dark-surface);
        min-height: calc(100vh - 200px);
        padding: 40px 0;
    }
    
    .course-header {
        background: var(--dark-elevated);
        border: 1px solid var(--border);
        border-radius: 16px;
        padding: 1.5rem;
        margin-bottom: 2rem;
    }
    
    .course-header .content {
        padding: 0;
    }
    
    .course-header h1 {
        font-family: 'JetBrains Mono', monospace;
        font-weight: 600;
        font-size: 1.5rem;
        color: var(--text-primary);
        margin-bottom: 0.5rem;
    }
    
    .course-header .badge-level {
        font-size: 0.75rem;
        padding: 0.3rem 0.7rem;
        border-radius: 6px;
        background: var(--dark-surface);
        border: 1px solid var(--border);
        color: var(--text-muted);
    }
    
    .course-header p {
        color: var(--text-muted);
        font-size: 0.95rem;
        line-height: 1.6;
        margin-top: 1rem;
    }
    
    .btn-back {
        background: var(--dark-elevated);
        border: 1px solid var(--border);
        color: var(--text-muted);
        padding: 0.5rem 1rem;
        border-radius: 6px;
        font-size: 0.85rem;
        transition: all 0.2s ease;
    }
    
    .btn-back:hover {
        border-color: var(--primary);
        color: var(--primary);
    }
    
    .section-title {
        font-family: 'JetBrains Mono', monospace;
        font-weight: 600;
        font-size: 1.1rem;
        color: var(--text-primary);
        margin-bottom: 1rem;
    }
    
    .lesson-card {
        background: var(--dark-elevated);
        border: 1px solid var(--border);
        border-radius: 10px;
        padding: 1.25rem;
        margin-bottom: 1rem;
        transition: all 0.2s ease;
    }
    
    .lesson-card:hover {
        border-color: var(--primary);
        transform: translateX(5px);
    }
    
    .lesson-card .lesson-number {
        width: 32px;
        height: 32px;
        background: var(--dark-surface);
        border: 1px solid var(--border);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-family: 'JetBrains Mono', monospace;
        font-size: 0.85rem;
        color: var(--primary);
        margin-bottom: 0.75rem;
    }
    
    .lesson-card h4 {
        font-weight: 500;
        font-size: 1rem;
        color: var(--text-primary);
        margin-bottom: 0.5rem;
    }
    
    .lesson-card p {
        color: var(--text-muted);
        font-size: 0.85rem;
        line-height: 1.5;
        margin: 0;
    }
    
    .btn-start {
        background: var(--primary);
        color: var(--dark-bg) !important;
        border: none;
        padding: 0.75rem 1.5rem;
        font-weight: 500;
        font-size: 0.9rem;
        border-radius: 8px;
        margin-top: 1rem;
        width: 100%;
    }
    
    .btn-start:hover {
        background: var(--secondary);
    }
    
    .empty-state {
        text-align: center;
        padding: 3rem;
        color: var(--text-muted);
    }
</style>

<div class="course-detail">
    <div class="container">
        <a href="index.jsp" class="btn btn-back mb-4 d-inline-block">
            <i class="fa-solid fa-arrow-left me-1"></i>Volver a Cursos
        </a>
        
        <div class="course-header">
            <div class="content">
                <div class="d-flex justify-content-between align-items-start">
                    <h1><%= titulo %></h1>
                    <span class="badge-level"><%= nivel %></span>
                </div>
                <p><%= descripcion %></p>
            </div>
        </div>
        
        <h2 class="section-title">
            <i class="fa-solid fa-book-open me-2" style="color: var(--primary);"></i>
            Contenido del Curso
        </h2>
        
        <div class="row">
            <div class="col-lg-8">
                <%
                    try (Connection con = new config.Conexion().getConnection()) {
                        PreparedStatement ps = con.prepareStatement(
                            "SELECT * FROM contenidos WHERE id_curso = ? ORDER BY orden");
                        ps.setInt(1, idCurso);
                        ResultSet rs = ps.executeQuery();
                        
                        while (rs.next()) {
                %>
                    <div class="lesson-card">
                        <div class="lesson-number"><%= rs.getInt("orden") %></div>
                        <h4><%= rs.getString("titulo") %></h4>
                        <%
                            String contenido = rs.getString("contenido");
                            if (contenido != null && contenido.length() > 150) {
                                contenido = contenido.substring(0, 150) + "...";
                            }
                        %>
                        <p><%= contenido %></p>
                    </div>
                <%
                        }
                    } catch (Exception e) { }
                %>
            </div>
            
            <div class="col-lg-4">
                <div class="lesson-card" style="position: sticky; top: 20px;">
                    <h4 style="font-size: 0.95rem;">¿Comenzar este curso?</h4>
                    <p style="font-size: 0.8rem;">Accede a todos los contenidos y completes las lecciones a tu propio ritmo.</p>
                    <button class="btn btn-start">
                        <i class="fa-solid fa-play me-2"></i>Iniciar Curso
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<%@include file="footer.jsp" %>