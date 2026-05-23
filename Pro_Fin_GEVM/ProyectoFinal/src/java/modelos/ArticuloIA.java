package modelos;

public class ArticuloIA {
    private String titulo;
    private String link;
    private String descripcion;
    private String fuente;
    private String imagen;

    public ArticuloIA(String titulo, String link, String descripcion, String fuente) {
        this.titulo = titulo;
        this.link = link;
        this.descripcion = descripcion;
        this.fuente = fuente;
    }

    public ArticuloIA(String titulo, String link, String descripcion, String fuente, String imagen) {
        this.titulo = titulo;
        this.link = link;
        this.descripcion = descripcion;
        this.fuente = fuente;
        this.imagen = imagen;
    }

    public String getTitulo() { return titulo; }
    public String getLink() { return link; }
    public String getDescripcion() { return descripcion; }
    public String getFuente() { return fuente; }
    public String getImagen() { return imagen; }
}
