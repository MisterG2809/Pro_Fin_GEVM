<%@page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%@include file="header.jsp" %>

<%
    String idParam = request.getParameter("id");
    if (idParam == null) { response.sendRedirect("dashboard.jsp"); return; }
    int idTip = Integer.parseInt(idParam);
    String titulo = "", contenido = "", categoria = "";
    boolean encontrado = false;
    try (Connection con = new config.Conexion().getConnection()) {
        PreparedStatement ps = con.prepareStatement(
            "SELECT t.*, c.nombre_categoria FROM tips_ia t " +
            "LEFT JOIN categorias c ON t.id_categoria = c.id_categoria WHERE t.id_tip = ?");
        ps.setInt(1, idTip);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            titulo = rs.getString("titulo");
            contenido = rs.getString("contenido");
            categoria = rs.getString("nombre_categoria");
            encontrado = true;
        }
    } catch (Exception e) { }
    if (!encontrado) { response.sendRedirect("dashboard.jsp"); return; }
%>

<style>
    .detail-page { background: var(--dark-surface); min-height: calc(100vh - 200px); padding: 40px 0; }
    .detail-card {
        background: var(--dark-elevated); border: 1px solid var(--border);
        border-radius: 16px; padding: 2rem; max-width: 800px; margin: 0 auto;
    }
    .detail-card h1 {
        font-family: 'Orbitron', sans-serif; font-weight: 600;
        font-size: 1.3rem; color: var(--text-primary); letter-spacing: 0.5px;
    }
    .detail-card .meta {
        color: var(--text-muted); font-size: 0.8rem; margin: 0.5rem 0 1.5rem;
    }
    .detail-card .body {
        line-height: 1.8; font-size: 0.95rem; color: var(--text-primary);
    }
</style>

<div class="detail-page">
    <div class="container">
        <a href="Controlador?accion=listar" class="btn btn-back mb-4 d-inline-block">
            <i class="fa-solid fa-arrow-left me-1"></i>Volver a Tips
        </a>
        <div class="detail-card">
            <span class="badge" style="background:var(--dark-surface);border:1px solid var(--border);font-size:0.7rem;">
                <%= categoria != null ? categoria : "General" %>
            </span>
            <h1 class="mt-2"><%= titulo %></h1>
            <div class="meta">Tip #<%= idTip %></div>
            <div class="body"><p><%= contenido.replace("\n", "</p><p>") %></p></div>
        </div>
    </div>
</div>

<%@include file="footer.jsp" %>
