package api;

import config.Conexion;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.Base64;

@WebServlet("/subirFoto")
@MultipartConfig(maxFileSize = 2097152)
public class SubirFotoServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        Integer userId = (Integer) req.getSession().getAttribute("id_usuario");
        if (userId == null) {
            resp.sendRedirect("login.jsp");
            return;
        }
        Part filePart = req.getPart("fotoPerfil");
        if (filePart == null || filePart.getSize() == 0) {
            resp.sendRedirect("perfil.jsp");
            return;
        }
        String mime = filePart.getContentType();
        if (mime == null || !mime.startsWith("image/")) {
            resp.sendRedirect("perfil.jsp");
            return;
        }
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        try (InputStream is = filePart.getInputStream()) {
            byte[] buf = new byte[4096];
            int n;
            while ((n = is.read(buf)) != -1) baos.write(buf, 0, n);
        }
        String b64 = Base64.getEncoder().encodeToString(baos.toByteArray());
        String dataUri = "data:" + mime + ";base64," + b64;
        if (dataUri.length() > 500000) {
            resp.sendRedirect("perfil.jsp?error=La imagen es demasiado grande");
            return;
        }
        try (Connection con = new Conexion().getConnection();
             PreparedStatement ps = con.prepareStatement("UPDATE usuarios SET foto_perfil = ? WHERE id_usuario = ?")) {
            ps.setString(1, dataUri);
            ps.setInt(2, userId);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
        resp.sendRedirect("perfil.jsp");
    }
}
