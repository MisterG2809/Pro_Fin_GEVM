<%@page import="modelos.ArticuloIA, modelos.Curso, config.Conexion, java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.util.ArrayList, java.util.List" %>
<%@include file="header.jsp" %>

<style>
    .hero-section {
        background: var(--dark-surface);
        padding: 60px 0;
        border-bottom: 1px solid var(--border);
    }
    
    .hero-section h1 {
        font-family: 'JetBrains Mono', monospace;
        font-weight: 600;
        font-size: 2rem;
        color: var(--text-primary);
    }
    
    .hero-section .lead {
        font-size: 1rem;
        color: var(--text-muted);
        max-width: 500px;
        margin: 0.75rem auto 1.5rem;
    }
    
    .btn-cta {
        background: var(--primary);
        color: var(--dark-bg) !important;
        border: none;
        padding: 0.6rem 1.5rem;
        font-weight: 500;
        font-size: 0.9rem;
        border-radius: 8px;
    }
    
    .btn-cta:hover {
        background: var(--secondary);
    }
    
    .section-title {
        font-family: 'JetBrains Mono', monospace;
        font-weight: 600;
        font-size: 1.2rem;
        color: var(--text-primary);
        margin-bottom: 1.25rem;
    }
    
    .course-card {
        background: var(--dark-elevated);
        border: 1px solid var(--border);
        border-radius: 12px;
        padding: 1.25rem;
        height: 100%;
        transition: all 0.2s ease;
    }
    
    .course-card:hover {
        border-color: var(--primary);
        transform: translateY(-4px);
    }
    
    .course-card .card-body {
        padding: 0;
    }
    
    .course-card h5 {
        font-weight: 600;
        font-size: 0.95rem;
        color: var(--text-primary);
        margin-bottom: 0.5rem;
    }
    
    .course-card p {
        color: var(--text-muted);
        font-size: 0.8rem;
        line-height: 1.4;
        margin-bottom: 0.75rem;
    }
    
    .course-card .badge-level {
        font-size: 0.7rem;
        padding: 0.25rem 0.5rem;
        border-radius: 4px;
        background: var(--dark-surface);
        border: 1px solid var(--border);
        color: var(--text-muted);
    }
    
    .course-card .btn {
        border-radius: 6px;
        font-size: 0.75rem;
        margin-top: 0.5rem;
    }
    
    .btn-outline-primary {
        border-color: var(--primary);
        color: var(--primary);
    }
    
    .btn-outline-primary:hover {
        background: var(--primary);
        color: var(--dark-bg);
    }
    
    .divider-gradient {
        height: 1px;
        background: var(--border);
        margin: 2rem 0;
    }
    
    .article-card {
        background: var(--dark-elevated);
        border: 1px solid var(--border);
        border-radius: 10px;
        overflow: hidden;
        height: 100%;
        transition: all 0.2s ease;
    }
    
    .article-card:hover {
        border-color: var(--secondary);
        transform: translateY(-3px);
    }
    
    .article-card img {
        width: 100%;
        height: 120px;
        object-fit: cover;
    }
    
    .article-card .content {
        padding: 1rem;
    }
    
    .article-card .badge {
        background: var(--dark-surface);
        border: 1px solid var(--border);
        font-size: 0.65rem;
        padding: 0.2rem 0.5rem;
        color: var(--text-muted);
    }
    
    .article-card h5 {
        font-weight: 500;
        font-size: 0.85rem;
        color: var(--text-primary);
        margin: 0.5rem 0 0.25rem;
    }
    
    .article-card p {
        color: var(--text-muted);
        font-size: 0.75rem;
        line-height: 1.4;
    }
    
    .article-card .btn {
        border-radius: 5px;
        font-size: 0.7rem;
        margin-top: 0.5rem;
    }
    
    @media (max-width: 768px) {
        .hero-section h1 { font-size: 1.5rem; }
    }
</style>

<header class="hero-section text-center">
    <div class="container">
        <h1 class="mb-2">ANDRÓMEDA</h1>
        <p class="lead">Cursos especializados en Inteligencia Artificial Generativa.</p>
        <a href="Controlador?accion=listar" class="btn btn-cta">
            Ver Cursos
        </a>
    </div>
</header>

<main class="container my-4">
    
    <%
        List<Curso> cursos = (List<Curso>) application.getAttribute("cursosCache");
        if (cursos == null) {
            cursos = new ArrayList<>();
            try (Connection con = new Conexion().getConnection();
                 PreparedStatement ps = con.prepareStatement("SELECT * FROM cursos ORDER BY fecha_creacion DESC");
                 ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    cursos.add(new Curso(
                        rs.getInt("id_curso"),
                        rs.getString("titulo_curso"),
                        rs.getString("descripcion"),
                        rs.getString("nivel"),
                        rs.getString("imagen_url")
                    ));
                }
            } catch (Exception e) { }
            application.setAttribute("cursosCache", cursos);
        }
    %>
    
    <section id="cursos">
        <h2 class="section-title">
            <i class="fa-solid fa-graduation-cap me-2" style="color: var(--primary);"></i>
            Cursos disponibles
        </h2>
        <div class="row g-4">
            <%
                if (!cursos.isEmpty()) {
                    for (Curso c : cursos) {
            %>
                <div class="col-md-6 col-lg-4">
                    <div class="course-card">
                        <h5><%= c.getTitulo() %></h5>
                        <p><%= c.getDescripcion().length() > 100 ? c.getDescripcion().substring(0, 100) + "..." : c.getDescripcion() %></p>
                        <span class="badge-level"><%= c.getNivel() %></span>
                        <a href="curso.jsp?id=<%= c.getId() %>" class="btn btn-outline-primary btn-sm w-100">Ver curso</a>
                    </div>
                </div>
            <%
                    }
                }
            %>
        </div>
    </section>

    <div class="divider-gradient"></div>

    <%
        List<ArticuloIA> noticias = (List<ArticuloIA>) application.getAttribute("articulosCache");
        if (noticias == null) {
            noticias = new ArrayList<>();
            try (Connection con = new Conexion().getConnection();
                 PreparedStatement ps = con.prepareStatement("SELECT * FROM articulos ORDER BY fecha_publicacion DESC");
                 ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    noticias.add(new ArticuloIA(
                        rs.getString("titulo"),
                        rs.getString("url"),
                        rs.getString("descripcion"),
                        rs.getString("fuente"),
                        rs.getString("imagen_url")
                    ));
                }
            } catch (Exception e) { }
            application.setAttribute("articulosCache", noticias);
        }
    %>

    <section id="articulos">
        <h2 class="section-title">
            <i class="fa-solid fa-newspaper me-2" style="color: var(--secondary);"></i>
            Últimas noticias de IA
        </h2>
        <div class="row g-4">
            <%
                if (!noticias.isEmpty()) {
                    for (ArticuloIA a : noticias) {
            %>
                <div class="col-md-6 col-lg-4">
                    <div class="article-card">
                        <img src="<%= a.getImagen() != null ? a.getImagen() : "https://images.unsplash.com/photo-1677442136019-21780ecad995?w=400&h=250&fit=crop" %>" alt="<%= a.getTitulo() %>">
                        <div class="content">
                            <span class="badge"><%= a.getFuente() %></span>
                            <h5><%= a.getTitulo() %></h5>
                            <% if (a.getDescripcion() != null && !a.getDescripcion().isEmpty()) { %>
                                <p><%= a.getDescripcion().length() > 80 ? a.getDescripcion().substring(0, 80) + "..." : a.getDescripcion() %></p>
                            <% } %>
                            <a href="<%= a.getLink() %>" target="_blank" class="btn btn-outline-primary btn-sm">
                                Leer más
                            </a>
                        </div>
                    </div>
                </div>
            <%
                    }
                }
            %>
        </div>
    </section>
</main>

<%@include file="footer.jsp" %>