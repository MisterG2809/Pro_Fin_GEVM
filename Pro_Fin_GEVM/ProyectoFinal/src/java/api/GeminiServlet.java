package api;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import javax.net.ssl.SSLContext;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;

@WebServlet(name = "GeminiServlet", urlPatterns = {"/api/gemini"})
public class GeminiServlet extends HttpServlet {

    private static final String GROQ_URL = "https://api.groq.com/openai/v1/chat/completions";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String apiKey = System.getProperty("GROQ_API_KEY");
        if (apiKey == null || apiKey.isEmpty()) {
            response.setStatus(400);
            response.getWriter().write("{\"error\":\"API key de Groq no configurada\"}");
            return;
        }

        String message = request.getParameter("message");
        if (message == null || message.trim().isEmpty()) {
            response.setStatus(400);
            response.getWriter().write("{\"error\":\"Mensaje vacio\"}");
            return;
        }

        try {
            String respuestaLocal = RespuestasLocal.getRespuesta(message, false);

            String jsonRequest = "{"
                + "\"model\":\"llama-3.3-70b-versatile\","
                + "\"messages\":["
                + "{\"role\":\"system\",\"content\":\"Eres Trinity, una asistente IA con personalidad futurista y estilo hacker. Hablas en español con emojis. Responde breve y directo, maximo 3 oraciones.\"},"
                + "{\"role\":\"user\",\"content\":\"" + escapeJson(message) + "\"}"
                + "],"
                + "\"temperature\":0.7,"
                + "\"max_tokens\":300"
                + "}";

            SSLContext sslContext = SSLContext.getInstance("TLS");
            sslContext.init(null, new TrustManager[]{
                new X509TrustManager() {
                    public void checkClientTrusted(java.security.cert.X509Certificate[] chain, String authType) {}
                    public void checkServerTrusted(java.security.cert.X509Certificate[] chain, String authType) {}
                    public java.security.cert.X509Certificate[] getAcceptedIssuers() { return new java.security.cert.X509Certificate[0]; }
                }
            }, null);
            HttpClient client = HttpClient.newBuilder().sslContext(sslContext).build();
            HttpRequest req = HttpRequest.newBuilder()
                .uri(URI.create(GROQ_URL))
                .header("Content-Type", "application/json")
                .header("Authorization", "Bearer " + apiKey)
                .POST(HttpRequest.BodyPublishers.ofString(jsonRequest, StandardCharsets.UTF_8))
                .build();

            HttpResponse<String> groqResponse = client.send(req, HttpResponse.BodyHandlers.ofString());

            if (groqResponse.statusCode() == 200) {
                String body = groqResponse.body();
                String texto = extractGroqText(body);
                if (texto != null) {
                    response.getWriter().write(
                        "{\"candidates\":[{\"content\":{\"parts\":[{\"text\":\"" + escapeJson(texto) + "\"}]}}]}"
                    );
                    return;
                }
            }

            String errorBody = groqResponse.body();
            if (errorBody != null && errorBody.contains("rate_limit")) {
                response.getWriter().write(
                    "{\"candidates\":[{\"content\":{\"parts\":[{\"text\":\"Limite de Groq alcanzado, proba en un minuto ⏳\"}]}}]}"
                );
                return;
            }

            response.getWriter().write(
                "{\"candidates\":[{\"content\":{\"parts\":[{\"text\":\"" + escapeJson(respuestaLocal) + "\"}]}}]}"
            );

        } catch (Exception e) {
            String respuestaLocal = RespuestasLocal.getRespuesta(message, false);
            response.getWriter().write(
                "{\"candidates\":[{\"content\":{\"parts\":[{\"text\":\"" + escapeJson(respuestaLocal) + "\"}]}}]}"
            );
        }
    }

    private String extractGroqText(String json) {
        try {
            int idx = json.indexOf("\"content\":\"");
            if (idx < 0) return null;
            idx += 11;
            int end = json.indexOf("\"", idx);
            if (end < 0) return null;
            return json.substring(idx, end).replace("\\n", " ").replace("\\\"", "\"");
        } catch (Exception e) {
            return null;
        }
    }

    private String escapeJson(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", " ")
                .replace("\r", " ");
    }
}
