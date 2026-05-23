<%@page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.util.ArrayList, java.util.List" %>
<%@include file="header.jsp" %>
<%
    String rolUsr = (String) session.getAttribute("rol");
    if (rolUsr == null || !rolUsr.equals("administrador")) {
        response.sendRedirect("index.jsp");
        return;
    }
    String msg = request.getParameter("msg");
    String tab = request.getParameter("tab");
    if (tab == null) tab = "devs";

    List<Object[]> desarrolladores = new ArrayList<>();
    List<Object[]> cursosPendientes = new ArrayList<>();
    try (Connection con = new config.Conexion().getConnection()) {
        PreparedStatement ps = con.prepareStatement("SELECT id_usuario, nombre_usuario, email, estado FROM usuarios WHERE rol = 'desarrollador' ORDER BY id_usuario DESC");
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            desarrolladores.add(new Object[]{rs.getInt("id_usuario"), rs.getString("nombre_usuario"), rs.getString("email"), rs.getString("estado")});
        }
        ps = con.prepareStatement("SELECT c.id_curso, c.titulo_curso, c.estado, u.nombre_usuario FROM cursos c LEFT JOIN usuarios u ON c.id_autor = u.id_usuario WHERE c.estado IN ('pendiente','activo','rechazado') ORDER BY c.id_curso DESC");
        rs = ps.executeQuery();
        while (rs.next()) {
            cursosPendientes.add(new Object[]{rs.getInt("id_curso"), rs.getString("titulo_curso"), rs.getString("estado"), rs.getString("nombre_usuario")});
        }
    } catch (Exception e) { e.printStackTrace(); }
%>
<style>
    .admin-section { background: var(--dark-surface); min-height: calc(100vh - 200px); padding: 40px 0; }
    .admin-card { background: var(--dark-elevated); border: 1px solid var(--border); border-radius: 12px; padding: 1.5rem; }
    .admin-card h3 { font-family: 'JetBrains Mono', monospace; font-weight: 600; font-size: 1.1rem; color: var(--text-primary); }
    .tabs { display: flex; gap: 0; border-bottom: 1px solid var(--border); margin: 1rem 0 1.25rem; }
    .tab { padding: 0.5rem 1rem; font-size: 0.8rem; color: var(--text-muted); cursor: pointer; border-bottom: 2px solid transparent; transition: all 0.15s; text-decoration: none; font-family: 'JetBrains Mono', monospace; }
    .tab:hover { color: var(--text-primary); }
    .tab.active { color: var(--primary); border-bottom-color: var(--primary); }
    .dev-row { display: flex; align-items: center; justify-content: space-between; padding: 0.75rem; border-bottom: 1px solid var(--border); }
    .dev-row:last-child { border-bottom: none; }
    .dev-info { display: flex; flex-direction: column; }
    .dev-name { color: var(--text-primary); font-weight: 500; font-size: 0.9rem; }
    .dev-email { color: var(--text-muted); font-size: 0.8rem; }
    .badge-pendiente { background: #b8860b; color: #fff; font-size: 0.7rem; padding: 0.15rem 0.5rem; border-radius: 4px; }
    .badge-activo { background: var(--primary); color: var(--dark-bg); font-size: 0.7rem; padding: 0.15rem 0.5rem; border-radius: 4px; }
    .badge-rechazado { background: #f85149; color: #fff; font-size: 0.7rem; padding: 0.15rem 0.5rem; border-radius: 4px; }
    .btn-sm { padding: 0.3rem 0.8rem; border-radius: 6px; font-size: 0.7rem; border: none; transition: all 0.15s; text-decoration: none; display: inline-block; }
    .btn-aprobar { background: rgba(0,255,136,0.1); border: 1px solid var(--primary); color: var(--primary); }
    .btn-aprobar:hover { background: var(--primary); color: var(--dark-bg); }
    .btn-rechazar { background: rgba(255,0,0,0.1); border: 1px solid #f85149; color: #f85149; }
    .btn-rechazar:hover { background: #f85149; color: #fff; }
    .btn-revocar { background: rgba(255,136,0,0.1); border: 1px solid #ff8800; color: #ff8800; }
    .btn-revocar:hover { background: #ff8800; color: #fff; }
    .alert-msg { background: rgba(0,255,136,0.08); border: 1px solid rgba(0,255,136,0.2); border-radius: 8px; padding: 0.6rem 1rem; font-size: 0.85rem; color: var(--text-primary); margin-bottom: 1rem; }
</style>
<div class="admin-section">
    <div class="container">
        <div class="admin-card">
            <h3><i class="fa-solid fa-shield-halved me-2" style="color:var(--primary);"></i>Panel de Administracion</h3>
            <% if (msg != null) { %>
                <div class="alert-msg"><i class="fa-solid fa-check-circle me-1"></i><%= msg %></div>
            <% } %>
            
            <div class="tabs">
                <a href="admin.jsp?tab=devs" class="tab <%= "devs".equals(tab) ? "active" : "" %>">
                    <i class="fa-solid fa-users-gear me-1"></i>Desarrolladores
                </a>
                <a href="admin.jsp?tab=cursos" class="tab <%= "cursos".equals(tab) ? "active" : "" %>">
                    <i class="fa-solid fa-book me-1"></i>Cursos
                </a>
            </div>

            <% if ("devs".equals(tab)) { %>
            <div id="tab-devs">
                <h5 style="font-family:'JetBrains Mono',monospace;font-size:0.85rem;color:var(--text-muted);margin-bottom:1rem;">
                    <i class="fa-solid fa-users-gear me-1"></i>Desarrolladores registrados
                </h5>
                <% if (desarrolladores.isEmpty()) { %>
                    <p class="text-muted" style="font-size:0.85rem;">No hay desarrolladores registrados aun.</p>
                <% } else {
                    for (Object[] d : desarrolladores) {
                        int idDev = (int) d[0];
                        String nombre = (String) d[1];
                        String email = (String) d[2];
                        String est = (String) d[3];
                %>
                    <div class="dev-row">
                        <div class="dev-info">
                            <span class="dev-name"><%= nombre %></span>
                            <span class="dev-email"><%= email %></span>
                        </div>
                        <div class="d-flex align-items-center gap-2">
                            <span class="<%= "pendiente".equals(est) ? "badge-pendiente" : "activo".equals(est) ? "badge-activo" : "badge-rechazado" %>">
                                <%= est %>
                            </span>
                            <% if ("pendiente".equals(est)) { %>
                                <a href="Controlador?accion=aprobarDev&id=<%= idDev %>" class="btn-sm btn-aprobar" onclick="return confirm('Aprobar a <%= nombre %> como desarrollador?');">
                                    <i class="fa-solid fa-check me-1"></i>Aprobar
                                </a>
                                <a href="Controlador?accion=rechazarDev&id=<%= idDev %>" class="btn-sm btn-rechazar" onclick="return confirm('Rechazar a <%= nombre %>?');">
                                    <i class="fa-solid fa-xmark me-1"></i>Rechazar
                                </a>
                            <% } else if ("activo".equals(est)) { %>
                                <a href="Controlador?accion=revocarDev&id=<%= idDev %>" class="btn-sm btn-revocar" onclick="return confirm('Revocar derechos de desarrollador a <%= nombre %>? (Pasara a ser estudiante)');">
                                    <i class="fa-solid fa-ban me-1"></i>Revocar
                                </a>
                            <% } %>
                        </div>
                    </div>
                <% } } %>
            </div>
            <% } %>

            <% if ("cursos".equals(tab)) { %>
            <div id="tab-cursos">
                <h5 style="font-family:'JetBrains Mono',monospace;font-size:0.85rem;color:var(--text-muted);margin-bottom:1rem;">
                    <i class="fa-solid fa-book me-1"></i>Cursos enviados por desarrolladores
                </h5>
                <% if (cursosPendientes.isEmpty()) { %>
                    <p class="text-muted" style="font-size:0.85rem;">No hay cursos pendientes de revision.</p>
                <% } else {
                    for (Object[] c : cursosPendientes) {
                        int idC = (int) c[0];
                        String tit = (String) c[1];
                        String est = (String) c[2];
                        String autor = (String) c[3];
                        if (autor == null) autor = "Desconocido";
                %>
                    <div class="dev-row">
                        <div class="dev-info">
                            <span class="dev-name"><%= tit %></span>
                            <span class="dev-email">por <%= autor %></span>
                        </div>
                        <div class="d-flex align-items-center gap-2">
                            <span class="<%= "pendiente".equals(est) ? "badge-pendiente" : "activo".equals(est) ? "badge-activo" : "badge-rechazado" %>">
                                <%= est %>
                            </span>
                            <% if ("pendiente".equals(est)) { %>
                                <a href="Controlador?accion=aprobarCurso&id=<%= idC %>" class="btn-sm btn-aprobar" onclick="return confirm('Aprobar curso: <%= tit %>?');">
                                    <i class="fa-solid fa-check me-1"></i>Aprobar
                                </a>
                                <a href="Controlador?accion=rechazarCurso&id=<%= idC %>" class="btn-sm btn-rechazar" onclick="return confirm('Rechazar curso: <%= tit %>?');">
                                    <i class="fa-solid fa-xmark me-1"></i>Rechazar
                                </a>
                            <% } %>
                        </div>
                    </div>
                <% } } %>
            </div>
            <% } %>
        </div>
    </div>
</div>
<%@include file="footer.jsp" %>
