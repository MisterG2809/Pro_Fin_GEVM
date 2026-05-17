package config;

import java.sql.Connection;
import java.sql.DriverManager;

public class Conexion {

    public Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/db_plataforma_ia?useSSL=false&serverTimezone=UTC&useUnicode=true&characterEncoding=UTF-8",
                "root", "");
        } catch (Exception e) {
            System.err.println(">>> [ERROR] No se pudo conectar: " + e.getMessage());
            return null;
        }
    }
}