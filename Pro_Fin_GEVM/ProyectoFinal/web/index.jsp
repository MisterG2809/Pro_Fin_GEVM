<%@page import="modelos.ArticuloIA, config.Conexion, java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.util.ArrayList, java.util.List" %>
<%@include file="header.jsp" %>

<style>
    .hero-section {
        background: var(--dark-surface);
        padding: 80px 0;
        border-bottom: 1px solid var(--border);
        position: relative;
        overflow: hidden;
    }
    
    .hero-logo-bg {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        width: 500px;
        height: 500px;
        pointer-events: none;
        opacity: 0.1;
        transition: opacity 0.3s;
        will-change: transform;
    }
    
    .hero-logo-bg .logo-diamond {
        width: 100%;
        height: 100%;
        background: transparent;
        transform: rotate(45deg);
        border-radius: 20px;
        border: 2px solid var(--primary);
        position: relative;
        animation: hero-logo-float 6s ease-in-out infinite;
    }
    
    .hero-logo-bg .logo-diamond::before {
        content: '';
        position: absolute;
        inset: -4px;
        border-radius: 22px;
        padding: 3px;
        background: conic-gradient(from 0deg, var(--primary), var(--neon-cyan), var(--neon-purple), var(--primary));
        -webkit-mask: linear-gradient(#000 0 0) content-box, linear-gradient(#000 0 0);
        -webkit-mask-composite: xor;
        mask-composite: exclude;
        opacity: 0.8;
        animation: border-rotate 6s linear infinite;
    }
    
    .hero-logo-bg .logo-diamond::after {
        content: '';
        position: absolute;
        inset: 18%;
        background: linear-gradient(135deg, var(--primary), var(--neon-cyan));
        transform: rotate(45deg);
        border-radius: 8px;
        opacity: 0.4;
        box-shadow: 0 0 30px rgba(0,255,136,0.2);
    }
    
    @keyframes hero-logo-float {
        0%, 100% { transform: rotate(45deg) scale(1); }
        50% { transform: rotate(45deg) scale(1.05); }
    }
    
    .hero-section h1 {
        font-family: 'Orbitron', sans-serif;
        font-weight: 600;
        font-size: 2.4rem;
        color: var(--text-primary);
        position: relative;
        letter-spacing: 4px;
        text-transform: uppercase;
        text-shadow: 0 0 30px rgba(0,255,136,0.15);
    }
    
    .hero-section .lead {
        font-size: 1rem;
        color: var(--text-muted);
        max-width: 500px;
        margin: 0.75rem auto 1.5rem;
        position: relative;
    }
    
    .btn-cta {
        background: var(--primary);
        color: var(--dark-bg) !important;
        border: none;
        padding: 0.7rem 2rem;
        font-weight: 600;
        font-size: 0.9rem;
        border-radius: 8px;
        position: relative;
        transition: all 0.2s ease;
        font-family: 'JetBrains Mono', monospace;
        letter-spacing: 1px;
    }
    
    .btn-cta:hover {
        background: var(--secondary);
        transform: translateY(-2px);
        box-shadow: 0 0 25px rgba(0,255,136,0.3);
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
        .hero-logo-bg { width: 300px; height: 300px; opacity: 0.08; }
    }

    html { scroll-behavior: smooth; }
    
    .welcome-toast {
        position: fixed;
        top: 90px;
        left: 50%;
        transform: translateX(-50%);
        background: rgba(8, 11, 16, 0.92);
        border: 1px solid rgba(0,255,136,0.25);
        border-radius: 14px;
        padding: 14px 28px;
        z-index: 99999;
        display: flex;
        align-items: center;
        gap: 14px;
        backdrop-filter: blur(16px);
        box-shadow: 0 8px 40px rgba(0,0,0,0.5), 0 0 30px rgba(0,255,136,0.06);
        animation: welcome-in 0.5s ease forwards;
        pointer-events: none;
    }
    .welcome-toast.hide {
        animation: welcome-out 0.5s ease forwards;
    }
    @keyframes welcome-in {
        from { opacity: 0; transform: translateX(-50%) translateY(-20px) scale(0.95); }
        to { opacity: 1; transform: translateX(-50%) translateY(0) scale(1); }
    }
    @keyframes welcome-out {
        from { opacity: 1; transform: translateX(-50%) translateY(0) scale(1); }
        to { opacity: 0; transform: translateX(-50%) translateY(-20px) scale(0.95); }
    }
    .welcome-icon {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        background: rgba(0,255,136,0.12);
        border: 1px solid rgba(0,255,136,0.2);
        display: flex;
        align-items: center;
        justify-content: center;
        color: var(--primary);
        font-size: 1.1rem;
        flex-shrink: 0;
    }
    .welcome-text {
        font-family: 'JetBrains Mono', monospace;
        font-size: 0.95rem;
        color: var(--text-primary);
    }
    .welcome-text strong {
        color: var(--primary);
    }
    .welcome-sub {
        font-size: 0.75rem;
        color: var(--text-muted);
        margin-top: 2px;
    }
</style>

<header class="hero-section text-center" id="hero">
    <div class="hero-logo-bg" id="hero-logo">
        <div class="logo-diamond"></div>
    </div>
    <div class="container">
        <%
            String bienvenidoSes = (String) session.getAttribute("bienvenido");
            String primerNombre = "";
            if (bienvenidoSes != null) {
                session.removeAttribute("bienvenido");
                String username = (String) session.getAttribute("usuario");
                primerNombre = username.split(" ")[0];
        %>
            <div id="welcome-toast" class="welcome-toast">
                <div class="welcome-icon"><i class="fa-solid fa-hand-wave"></i></div>
                <div class="welcome-text">Bienvenido, <strong><%= primerNombre %></strong></div>
                <div class="welcome-sub">Explora cursos, tips y mas 🌌</div>
            </div>
            <script>
                setTimeout(function() {
                    var wt = document.getElementById('welcome-toast');
                    if (wt) {
                        wt.classList.add('hide');
                        setTimeout(function() { if (wt) wt.remove(); }, 500);
                    }
                }, 3000);
            </script>
        <% } %>
        <h1 class="mb-2">OBLIVION</h1>
        <p class="lead">Cursos especializados en Inteligencia Artificial y Programacion.</p>
    </div>
</header>

<script>
(function() {
    const logo = document.getElementById('hero-logo');
    if (!logo) return;
    let ticking = false;
    window.addEventListener('scroll', function() {
        if (!ticking) {
            window.requestAnimationFrame(function() {
                const scrollY = window.scrollY;
                const hero = document.getElementById('hero');
                if (!hero) return;
                const rect = hero.getBoundingClientRect();
                if (rect.bottom > -200) {
                    const move = scrollY * 0.15;
                    logo.style.transform = 'translate(calc(-50% + ' + move * 0.3 + 'px), calc(-50% - ' + move + 'px))';
                }
                ticking = false;
            });
            ticking = true;
        }
    });
})();
</script>

<main class="container my-4">
    
    <%
        List<Object[]> cursos = new ArrayList<>();
        try {
            Connection con = new Conexion().getConnection();
            if (con != null) {
                PreparedStatement ps = con.prepareStatement("SELECT id_curso, titulo_curso, COALESCE(descripcion,'') AS descripcion, nivel FROM cursos WHERE estado = 'activo' OR estado IS NULL ORDER BY fecha_creacion DESC");
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    Object[] curso = new Object[4];
                    curso[0] = rs.getInt("id_curso");
                    curso[1] = rs.getString("titulo_curso");
                    curso[2] = rs.getString("descripcion");
                    curso[3] = rs.getString("nivel");
                    cursos.add(curso);
                }
                rs.close();
                ps.close();
                con.close();
            }
        } catch (Exception e) { 
            e.printStackTrace();
        }
    %>
    <section id="cursos">
        <h2 class="section-title">
            <i class="fa-solid fa-graduation-cap me-2" style="color: var(--primary);"></i>
            Cursos disponibles
        </h2>
        <div class="row g-4">
            <%
                for (Object[] c : cursos) {
            %>
                <div class="col-md-6 col-lg-4">
                    <div class="course-card">
                        <h5><%= c[1] %></h5>
                        <p><%= c[2] != null ? (((String)c[2]).length() > 100 ? ((String)c[2]).substring(0, 100) + "..." : c[2]) : "" %></p>
                        <span class="badge-level"><%= c[3] %></span>
                        <a href="curso.jsp?id=<%= c[0] %>" class="btn btn-outline-primary btn-sm w-100">Ver curso</a>
                    </div>
                </div>
            <%
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