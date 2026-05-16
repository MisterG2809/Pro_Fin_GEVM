package controlador;

import config.Conexion;
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
            case "CerrarSesion":
                request.getSession().invalidate();
                response.sendRedirect("index.jsp");
                break;
            default:
                response.sendRedirect("index.jsp");
                break;
        }
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
                        request.getSession().setAttribute("usuario", rs.getString("nombre_usuario"));
                        request.getSession().setAttribute("rol", rs.getString("rol"));
                        response.sendRedirect("Controlador?accion=listar");
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

            try (Connection con = new Conexion().getConnection();
                 PreparedStatement ps = con.prepareStatement("INSERT INTO usuarios (nombre_usuario, email, password, rol) VALUES (?, ?, ?, 'estudiante')")) {
                ps.setString(1, nombre);
                ps.setString(2, email);
                ps.setString(3, password);
                ps.executeUpdate();
                response.sendRedirect("login.jsp?registro=ok");
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Error al registrar: " + e.getMessage());
                request.getRequestDispatcher("registro.jsp").forward(request, response);
            }
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