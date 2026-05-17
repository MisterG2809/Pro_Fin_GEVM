package rss;

import modelos.ArticuloIA;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.List;

public class LectorRSS {

    public List<ArticuloIA> obtenerNoticias() {
        List<ArticuloIA> articulos = new ArrayList<>();
        String[][] fuentes = {
            {"https://hnrss.org/frontpage?count=5", "Hacker News"},
            {"https://hnrss.org/newest?q=AI&count=5", "Hacker News AI"}
        };

        for (String[] fuente : fuentes) {
            try {
                URLConnection conn = new URL(fuente[0]).openConnection();
                conn.setConnectTimeout(5000);
                conn.setReadTimeout(5000);
                DocumentBuilder builder = DocumentBuilderFactory.newInstance().newDocumentBuilder();
                Document doc = builder.parse(conn.getInputStream());
                NodeList items = doc.getElementsByTagName("item");

                for (int i = 0; i < Math.min(items.getLength(), 5); i++) {
                    Element item = (Element) items.item(i);
                    String titulo = getText(item, "title");
                    String link = getText(item, "link");
                    String desc = getText(item, "description");
                    if (titulo != null && link != null) {
                        articulos.add(new ArticuloIA(titulo, link, desc, fuente[1]));
                    }
                }
            } catch (Exception e) {
                System.err.println("Error leyendo RSS " + fuente[0] + ": " + e.getMessage());
            }
        }
        return articulos;
    }

    private String getText(Element parent, String tag) {
        NodeList list = parent.getElementsByTagName(tag);
        if (list.getLength() > 0) {
            String text = list.item(0).getTextContent();
            return text != null ? text.trim() : null;
        }
        return null;
    }
}
