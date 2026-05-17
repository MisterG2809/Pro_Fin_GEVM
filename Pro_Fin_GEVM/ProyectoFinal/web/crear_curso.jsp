<%@page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.util.ArrayList, java.util.List" %>
<%@include file="header.jsp" %>
<%
    Integer userId = (Integer) session.getAttribute("id_usuario");
    String rolUsr = (String) session.getAttribute("rol");
    if (userId == null || !"desarrollador".equals(rolUsr)) {
        response.sendRedirect("index.jsp");
        return;
    }
    String estadoDev = "activo";
    try (Connection con = new config.Conexion().getConnection();
         PreparedStatement ps = con.prepareStatement("SELECT estado FROM usuarios WHERE id_usuario = ?")) {
        ps.setInt(1, userId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) estadoDev = rs.getString("estado");
    } catch (Exception e) { e.printStackTrace(); }
    if (!"activo".equals(estadoDev)) {
        response.sendRedirect("perfil.jsp?msg=Tu cuenta de desarrollador aun no ha sido aprobada");
        return;
    }
    String success = request.getParameter("ok");
%>
<style>
    .dev-section { background: var(--dark-surface); min-height: calc(100vh - 200px); padding: 40px 0; }
    .dev-card { background: var(--dark-elevated); border: 1px solid var(--border); border-radius: 12px; padding: 1.5rem; max-width: 640px; margin: 0 auto; }
    .dev-card h3 { font-family: 'JetBrains Mono', monospace; font-weight: 600; font-size: 1.1rem; color: var(--text-primary); margin-bottom: 1.25rem; }
    .form-label { color: var(--text-muted); font-size: 0.85rem; font-weight: 500; margin-bottom: 0.4rem; }
    .form-control, .form-select { background: var(--dark-bg); border: 1px solid var(--border); color: var(--text-primary); padding: 0.6rem 0.8rem; border-radius: 8px; font-size: 0.9rem; }
    .form-control:focus, .form-select:focus { border-color: var(--primary); box-shadow: 0 0 0 2px rgba(0,255,136,0.08); }
    .form-control::placeholder { color: var(--text-muted); }
    .btn-submit { background: var(--primary); color: var(--dark-bg); border: none; padding: 0.7rem; border-radius: 8px; font-weight: 600; font-size: 0.9rem; transition: all 0.2s; }
    .btn-submit:hover { background: var(--secondary); }
    .alert-msg { background: rgba(0,255,136,0.08); border: 1px solid rgba(0,255,136,0.2); border-radius: 8px; padding: 0.6rem 1rem; font-size: 0.85rem; color: var(--text-primary); margin-bottom: 1rem; }
    .mis-cursos { max-width: 640px; margin: 1.5rem auto 0; }
    .curso-item { background: var(--dark-elevated); border: 1px solid var(--border); border-radius: 10px; padding: 1rem; margin-bottom: 0.75rem; display: flex; justify-content: space-between; align-items: center; }
    .curso-item .tit { color: var(--text-primary); font-weight: 500; font-size: 0.9rem; }
    .curso-item .est { font-size: 0.7rem; padding: 0.15rem 0.5rem; border-radius: 4px; }
    .badge-pendiente { background: #b8860b; color: #fff; }
    .badge-activo { background: var(--primary); color: var(--dark-bg); }
    .badge-rechazado { background: #f85149; color: #fff; }
</style>
<div class="dev-section">
    <div class="container">
        <div class="dev-card">
            <h3><i class="fa-solid fa-layer-group me-2" style="color:var(--primary);"></i>Crear nuevo curso</h3>
            <% if (success != null) { %>
                <div class="alert-msg"><i class="fa-solid fa-check-circle me-1"></i>Curso enviado para revision del administrador.</div>
            <% } %>
            <form action="Controlador" method="POST">
                <div class="mb-3">
                    <label class="form-label">Titulo del curso</label>
                    <input type="text" name="txtTituloCurso" class="form-control" placeholder="Ej: Introduccion a Machine Learning" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Descripcion</label>
                    <textarea name="txtDescripcion" class="form-control" rows="3" placeholder="Describe el contenido del curso" required></textarea>
                </div>
                <div class="mb-3">
                    <label class="form-label">Nivel</label>
                    <select name="cmbNivel" class="form-select">
                        <option value="Principiante">Principiante</option>
                        <option value="Intermedio">Intermedio</option>
                        <option value="Avanzado">Avanzado</option>
                    </select>
                </div>
                <p class="text-muted" style="font-size:0.75rem;">
                    <i class="fa-solid fa-info-circle me-1"></i>El curso se creara en estado "pendiente" hasta que un administrador lo apruebe.
                </p>
                <button type="submit" name="accion" value="CrearCurso" class="btn btn-submit w-100">
                    <i class="fa-solid fa-plus me-2"></i>Enviar curso para revision
                </button>
            </form>
        </div>

        <div class="mis-cursos">
            <h5 style="font-family:'JetBrains Mono',monospace;font-size:0.85rem;color:var(--text-muted);margin-bottom:0.75rem;">
                <i class="fa-solid fa-book me-1"></i>Mis cursos enviados
            </h5>
            <%
                try (Connection con = new config.Conexion().getConnection();
                     PreparedStatement ps = con.prepareStatement("SELECT id_curso, titulo_curso, estado FROM cursos WHERE id_autor = ? ORDER BY id_curso DESC")) {
                    ps.setInt(1, userId);
                    ResultSet rs = ps.executeQuery();
                    boolean hay = false;
                    while (rs.next()) {
                        hay = true;
                        int idC = rs.getInt("id_curso");
                        String tit = rs.getString("titulo_curso");
                        String est = rs.getString("estado");
            %>
                <div class="curso-item">
                    <span class="tit"><%= tit %></span>
                    <span class="est badge-<%= est %>"><%= est %></span>
                </div>
            <%
                    }
                    if (!hay) { out.println("<p class='text-muted' style='font-size:0.85rem;'>No has enviado cursos aun.</p>"); }
                } catch (Exception e) { e.printStackTrace(); }
            %>
        </div>
    </div>
</div>
<%@include file="footer.jsp" %>
