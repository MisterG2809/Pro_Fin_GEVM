package controlador;

import config.Conexion;
import config.MailUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import modelos.ArticuloIA;
import modelos.TipIA;
import rss.LectorRSS;

@WebServlet(name = "Controlador", urlPatterns = {"/Controlador"})
public class Controlador extends HttpServlet {
    
    // Métodos GET: Lectura y redirección de pantallas
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String accion = request.getParameter("accion");
        
        if (accion == null) {
            request.getRequestDispatcher("index.jsp").forward(request, response);
            return;
        }

        switch (accion) {
            case "listar":
                List<TipIA> listaGeneral = new ArrayList<>();
                try (Connection con = new Conexion().getConnection();
                     PreparedStatement ps = con.prepareStatement("SELECT * FROM tips_ia");
                     ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        TipIA t = new TipIA();
                        t.setId(rs.getInt("id_tip")); 
                        t.setTitulo(rs.getString("titulo"));
                        t.setContenido(rs.getString("contenido"));
                        listaGeneral.add(t);
                    }
                    request.setAttribute("misTips", listaGeneral);
                    request.getRequestDispatcher("dashboard.jsp").forward(request, response);
                } catch (Exception e) {
                    e.printStackTrace();
                }
                break;

            case "verNormatividad":
                List<TipIA> listaNormas = new ArrayList<>();
                try (Connection con = new Conexion().getConnection();
                     PreparedStatement ps = con.prepareStatement("SELECT * FROM tips_ia WHERE id_categoria = 3");
                     ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        TipIA t = new TipIA();
                        t.setId(rs.getInt("id_tip")); 
                        t.setTitulo(rs.getString("titulo"));
                        t.setContenido(rs.getString("contenido"));
                        listaNormas.add(t);
                    }
                    request.setAttribute("misNormas", listaNormas);
                    request.getRequestDispatcher("normativa.jsp").forward(request, response);
                } catch (Exception e) {
                    e.printStackTrace();
                }
                break;

            case "noticiasIA":
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                try (Connection con = new Conexion().getConnection();
                     PreparedStatement ps = con.prepareStatement("SELECT * FROM articulos ORDER BY fecha_publicacion DESC");
                     ResultSet rs = ps.executeQuery()) {
                    StringBuilder json = new StringBuilder("[");
                    boolean primero = true;
                    while (rs.next()) {
                        if (!primero) json.append(",");
                        json.append("{\"id\":").append(rs.getInt("id_articulo"))
                            .append(",\"titulo\":\"").append(escaparJson(rs.getString("titulo")))
                            .append("\",\"url\":\"").append(escaparJson(rs.getString("url")))
                            .append("\",\"fuente\":\"").append(escaparJson(rs.getString("fuente")))
                            .append("\",\"descripcion\":\"").append(escaparJson(rs.getString("descripcion")))
                            .append("\"}");
                        primero = false;
                    }
                    json.append("]");
                    response.getWriter().write(json.toString());
                } catch (Exception e) {
                    response.getWriter().write("[]");
                }
                break;
            case "aprobarDev":
                String idAprobar = request.getParameter("id");
                if (idAprobar != null && esAdmin(request)) {
                    try (Connection con = new Conexion().getConnection();
                         PreparedStatement ps = con.prepareStatement("UPDATE usuarios SET estado = 'activo' WHERE id_usuario = ? AND rol = 'desarrollador'")) {
                        ps.setInt(1, Integer.parseInt(idAprobar));
                        ps.executeUpdate();
                    } catch (Exception e) { e.printStackTrace(); }
                }
                response.sendRedirect("admin.jsp?msg=Desarrollador aprobado correctamente");
                break;
            case "rechazarDev":
                String idRechazar = request.getParameter("id");
                if (idRechazar != null && esAdmin(request)) {
                    try (Connection con = new Conexion().getConnection();
                         PreparedStatement ps = con.prepareStatement("UPDATE usuarios SET estado = 'rechazado' WHERE id_usuario = ? AND rol = 'desarrollador'")) {
                        ps.setInt(1, Integer.parseInt(idRechazar));
                        ps.executeUpdate();
                    } catch (Exception e) { e.printStackTrace(); }
                }
                response.sendRedirect("admin.jsp?msg=Desarrollador rechazado");
                break;
            case "revocarDev":
                String idRevocar = request.getParameter("id");
                if (idRevocar != null && esAdmin(request)) {
                    try (Connection con = new Conexion().getConnection();
                         PreparedStatement ps = con.prepareStatement("UPDATE usuarios SET rol = 'estudiante', estado = 'activo' WHERE id_usuario = ? AND rol = 'desarrollador'")) {
                        ps.setInt(1, Integer.parseInt(idRevocar));
                        ps.executeUpdate();
                    } catch (Exception e) { e.printStackTrace(); }
                }
                response.sendRedirect("admin.jsp?msg=Derechos de desarrollador revocados");
                break;
            case "aprobarCurso":
                String idCurso = request.getParameter("id");
                if (idCurso != null && esAdmin(request)) {
                    try (Connection con = new Conexion().getConnection();
                         PreparedStatement ps = con.prepareStatement("UPDATE cursos SET estado = 'activo' WHERE id_curso = ?")) {
                        ps.setInt(1, Integer.parseInt(idCurso));
                        ps.executeUpdate();
                    } catch (Exception e) { e.printStackTrace(); }
                }
                response.sendRedirect("admin.jsp?msg=Curso aprobado correctamente");
                break;
            case "rechazarCurso":
                String idCursoR = request.getParameter("id");
                if (idCursoR != null && esAdmin(request)) {
                    try (Connection con = new Conexion().getConnection();
                         PreparedStatement ps = con.prepareStatement("UPDATE cursos SET estado = 'rechazado' WHERE id_curso = ?")) {
                        ps.setInt(1, Integer.parseInt(idCursoR));
                        ps.executeUpdate();
                    } catch (Exception e) { e.printStackTrace(); }
                }
                response.sendRedirect("admin.jsp?msg=Curso rechazado");
                break;
            case "CerrarSesion":
                request.getSession().invalidate();
                response.sendRedirect("index.jsp");
                break;
            default:
                response.sendRedirect("index.jsp");
                break;
        }
    }

    private boolean esAdmin(HttpServletRequest req) {
        Object r = req.getSession().getAttribute("rol");
        return r != null && r.equals("administrador");
    }

    // Métodos POST: Escritura y procesamiento de formularios (Inserciones)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String accion = request.getParameter("accion");
        
        if (accion != null && accion.equals("IniciarSesion")) {
            String correo = request.getParameter("correo");
            String password = request.getParameter("password");

            try (Connection con = new Conexion().getConnection();
                 PreparedStatement ps = con.prepareStatement("SELECT * FROM usuarios WHERE email=? AND password=?")) {
                ps.setString(1, correo);
                ps.setString(2, password);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        request.getSession().setAttribute("id_usuario", rs.getInt("id_usuario"));
                        request.getSession().setAttribute("usuario", rs.getString("nombre_usuario"));
                        request.getSession().setAttribute("rol", rs.getString("rol"));
                        request.getSession().setAttribute("bienvenido", "1");
                        response.sendRedirect("index.jsp");
                    } else {
                        request.setAttribute("error", "Credenciales incorrectas");
                        request.getRequestDispatcher("login.jsp").forward(request, response);
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Error de conexión");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } else if (accion != null && accion.equals("RegistrarUsuario")) {
            String nombre = request.getParameter("txtNombre");
            String email = request.getParameter("txtEmail");
            String password = request.getParameter("txtPass");
            String tipoCuenta = request.getParameter("tipoCuenta");
            if (tipoCuenta == null) tipoCuenta = "estudiante";

            String estado = tipoCuenta.equals("desarrollador") ? "pendiente" : "activo";

            try (Connection con = new Conexion().getConnection();
                 PreparedStatement ps = con.prepareStatement("INSERT INTO usuarios (nombre_usuario, email, password, rol, estado) VALUES (?, ?, ?, ?, ?)")) {
                ps.setString(1, nombre);
                ps.setString(2, email);
                ps.setString(3, password);
                ps.setString(4, tipoCuenta);
                ps.setString(5, estado);
                ps.executeUpdate();
                MailUtil.enviarConfirmacionRegistro(email, nombre);
                response.sendRedirect("login.jsp?registro=ok");
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Error al registrar: " + e.getMessage());
                request.getRequestDispatcher("registro.jsp").forward(request, response);
            }
        } else if (accion != null && accion.equals("CrearCurso")) {
            Integer idAutor = (Integer) request.getSession().getAttribute("id_usuario");
            if (idAutor != null) {
                String titulo = request.getParameter("txtTituloCurso");
                String desc = request.getParameter("txtDescripcion");
                String nivel = request.getParameter("cmbNivel");
                try (Connection con = new Conexion().getConnection();
                     PreparedStatement ps = con.prepareStatement("INSERT INTO cursos (titulo_curso, descripcion, nivel, id_autor, estado) VALUES (?, ?, ?, ?, 'pendiente')")) {
                    ps.setString(1, titulo);
                    ps.setString(2, desc);
                    ps.setString(3, nivel);
                    ps.setInt(4, idAutor);
                    ps.executeUpdate();
                } catch (Exception e) { e.printStackTrace(); }
            }
            response.sendRedirect("crear_curso.jsp?ok=1");
        } else if (accion != null && accion.equals("Guardar")) {
            String titulo = request.getParameter("txtTitulo");
            String contenido = request.getParameter("txtContenido");
            int categoria = Integer.parseInt(request.getParameter("cmbCategoria"));
            
            try (Connection con = new Conexion().getConnection();
                 PreparedStatement ps = con.prepareStatement("INSERT INTO tips_ia (titulo, contenido, id_categoria) VALUES (?, ?, ?)")) {
                ps.setString(1, titulo);
                ps.setString(2, contenido);
                ps.setInt(3, categoria);
                ps.executeUpdate();
                
                if (categoria == 3) {
                    response.sendRedirect("Controlador?accion=verNormatividad");
                } else {
                    response.sendRedirect("Controlador?accion=listar");
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    private String escaparJson(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\").replace("\"", "\\\"").replace("\n", " ").replace("\r", " ");
    }
}