<%@page import="modelos.ArticuloIA, config.Conexion, java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.util.ArrayList, java.util.List" %>
<%@include file="header.jsp" %>

<style>
    .articles-section {
        background: var(--dark-surface);
        min-height: calc(100vh - 200px);
        padding: 40px 0;
    }
    
    .page-title {
        font-family: 'JetBrains Mono', monospace;
        font-weight: 600;
        font-size: 1.5rem;
        color: var(--text-primary);
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
    
    .article-card {
        background: var(--dark-elevated);
        border: 1px solid var(--border);
        border-radius: 12px;
        padding: 1.25rem;
        height: 100%;
        transition: all 0.2s ease;
    }
    
    .article-card:hover {
        border-color: var(--primary);
        transform: translateY(-3px);
        background: var(--dark-bg);
    }
    
    .article-card .badge {
        background: var(--dark-bg);
        border: 1px solid var(--border);
        font-size: 0.65rem;
        padding: 0.2rem 0.5rem;
        color: var(--text-muted);
    }
    
    .article-card h5 {
        font-weight: 500;
        font-size: 1rem;
        margin: 0.75rem 0 0.5rem;
        color: var(--text-primary);
    }
    
    .article-card p {
        color: var(--text-muted);
        font-size: 0.85rem;
        line-height: 1.5;
    }
    
    .article-card .btn {
        border-radius: 6px;
        font-size: 0.8rem;
        margin-top: 0.75rem;
    }
    
    .btn-outline-primary {
        border-color: var(--primary);
        color: var(--primary);
    }
    
    .btn-outline-primary:hover {
        background: var(--primary);
        color: var(--dark-bg);
    }
    
    .empty-state {
        padding: 4rem 0;
        text-align: center;
    }
    
    .empty-state i {
        font-size: 3rem;
        color: var(--text-muted);
        opacity: 0.5;
        margin-bottom: 1rem;
    }
    
    .empty-state p {
        color: var(--text-muted);
    }
    
    .count-badge {
        background: var(--dark-elevated);
        border: 1px solid var(--border);
        padding: 0.3rem 0.8rem;
        border-radius: 20px;
        font-size: 0.8rem;
        color: var(--text-muted);
    }
</style>

<div class="articles-section">
    <div class="container">
        <div class="d-flex justify-content-between align-items-center mb-5">
            <h2 class="page-title">
                <i class="fa-solid fa-newspaper me-2" style="color: var(--primary);"></i>
                Catálogo de Artículos IA
            </h2>
            <a href="index.jsp" class="btn btn-back">
                <i class="fa-solid fa-arrow-left me-1"></i>Inicio
            </a>
        </div>
        
        <span class="count-badge">
            <i class="fa-solid fa-database me-1"></i>
            <%
                List<ArticuloIA> allArticles = (List<ArticuloIA>) application.getAttribute("articulosCache");
                if (allArticles == null) {
                    allArticles = new ArrayList<>();
                    try (Connection con = new Conexion().getConnection();
                         PreparedStatement ps = con.prepareStatement("SELECT * FROM articulos ORDER BY fecha_publicacion DESC");
                         ResultSet rs = ps.executeQuery()) {
                        while (rs.next()) {
                            allArticles.add(new ArticuloIA(
                                rs.getString("titulo"),
                                rs.getString("url"),
                                rs.getString("descripcion"),
                                rs.getString("fuente")
                            ));
                        }
                    } catch (Exception e) { }
                    application.setAttribute("articulosCache", allArticles);
                }
                out.print(allArticles.size() + " artículos");
            %>
        </span>
        
        <div class="row g-4 mt-3">
            <%
                if (!allArticles.isEmpty()) {
                    for (ArticuloIA a : allArticles) {
            %>
                <div class="col-md-6 col-lg-4">
                    <div class="article-card">
                        <span class="badge"><%= a.getFuente() %></span>
                        <h5><%= a.getTitulo() %></h5>
                        <% if (a.getDescripcion() != null && !a.getDescripcion().isEmpty()) { %>
                            <p><%= a.getDescripcion().length() > 120 ? a.getDescripcion().substring(0, 120) + "..." : a.getDescripcion() %></p>
                        <% } %>
                        <a href="<%= a.getLink() %>" target="_blank" class="btn btn-outline-primary btn-sm">
                            <i class="fa-solid fa-external-link me-1"></i>Leer más
                        </a>
                    </div>
                </div>
            <%
                    }
                } else {
            %>
                <div class="col-12 empty-state">
                    <i class="fa-solid fa-newspaper d-block"></i>
                    <p>No hay artículos disponibles.</p>
                </div>
            <%
                }
            %>
        </div>
    </div>
</div>

<%@include file="footer.jsp" %>