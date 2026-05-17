package modelos;

public class Curso {
    private int id;
    private String titulo;
    private String descripcion;
    private String nivel;
    private String imagenUrl;

    public Curso(int id, String titulo, String descripcion, String nivel, String imagenUrl) {
        this.id = id;
        this.titulo = titulo;
        this.descripcion = descripcion;
        this.nivel = nivel;
        this.imagenUrl = imagenUrl;
    }

    public int getId() { return id; }
    public String getTitulo() { return titulo; }
    public String getDescripcion() { return descripcion; }
    public String getNivel() { return nivel; }
    public String getImagenUrl() { return imagenUrl; }
}