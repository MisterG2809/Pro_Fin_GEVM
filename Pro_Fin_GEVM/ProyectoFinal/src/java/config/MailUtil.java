package config;

import jakarta.mail.Message;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.io.InputStream;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

public class MailUtil {

    private static final Logger LOG = Logger.getLogger(MailUtil.class.getName());
    private static Properties smtpProps;
    private static boolean configured = false;

    static {
        smtpProps = new Properties();
        try (InputStream is = MailUtil.class.getClassLoader().getResourceAsStream("config/mail.properties")) {
            if (is != null) {
                smtpProps.load(is);
                configured = smtpProps.containsKey("mail.smtp.host");
                if (!configured) LOG.info("[MailUtil] mail.properties found but no mail.smtp.host set");
            } else {
                LOG.info("[MailUtil] mail.properties not found, email disabled");
            }
        } catch (Exception e) {
            LOG.log(Level.WARNING, "[MailUtil] Error loading mail.properties", e);
        }
    }

    public static void enviarCorreo(String to, String subject, String body) {
        if (!configured) {
            LOG.info("[MailUtil] Email not sent (no config): TO=" + to + " SUBJECT=" + subject);
            return;
        }
        try {
            Session session = Session.getInstance(smtpProps);
            MimeMessage msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(smtpProps.getProperty("mail.from", "noreply@oblivion.com")));
            msg.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
            msg.setSubject(subject);
            msg.setContent(body, "text/html; charset=UTF-8");
            Transport.send(msg);
            LOG.info("[MailUtil] Email sent to " + to);
        } catch (Exception e) {
            LOG.log(Level.WARNING, "[MailUtil] Error sending email: " + e.getMessage(), e);
        }
    }

    public static void enviarConfirmacionRegistro(String to, String nombre) {
        String subject = "Bienvenido a OBLIVION - Confirmacion de registro";
        String body = "<!DOCTYPE html><html><head><meta charset='UTF-8'>"
            + "<style>body{background:#080b10;color:#e0f0ea;font-family:'Inter',sans-serif;padding:40px 20px;}"
            + ".card{background:#141c2b;border:1px solid #1a2a3a;border-radius:14px;padding:2rem;max-width:480px;margin:0 auto;}"
            + "h1{font-family:'Orbitron',sans-serif;color:#00ff88;font-size:1.3rem;letter-spacing:2px;}"
            + "p{color:#6a7f8a;line-height:1.6;font-size:0.9rem;}"
            + ".highlight{color:#00ff88;font-weight:600;}"
            + ".footer{margin-top:1.5rem;font-size:0.75rem;color:#6a7f8a;border-top:1px solid #1a2a3a;padding-top:1rem;}"
            + "</style></head><body>"
            + "<div class='card'>"
            + "<h1>✨ OBLIVION</h1>"
            + "<p>Hola <span class='highlight'>" + nombre + "</span>,</p>"
            + "<p>Tu cuenta ha sido creada exitosamente. Ya puedes explorar cursos, tips de programacion con IA y mas.</p>"
            + "<p style='margin-top:1rem;'>🌌 <span class='highlight'>Bienvenido al futuro del aprendizaje.</span></p>"
            + "<div class='footer'>OBLIVION by MaverickTec · Plataforma de cursos IA</div>"
            + "</div></body></html>";
        enviarCorreo(to, subject, body);
    }
}
