<div align="center">

# ✦ Andrómeda

**Plataforma de aprendizaje sobre Inteligencia Artificial**

Cursos, tips, noticias y recursos para dominar la IA como herramienta al servicio del ser humano.

[![Java EE](https://img.shields.io/badge/Java%20EE-JSP-orange?style=flat-square&logo=java)](https://jakarta.ee/)
[![GlassFish](https://img.shields.io/badge/Server-GlassFish-blue?style=flat-square)](https://glassfish.org/)
[![MySQL](https://img.shields.io/badge/DB-MySQL-4479A1?style=flat-square&logo=mysql&logoColor=white)](https://mysql.com/)
[![Status](https://img.shields.io/badge/Estado-En%20desarrollo-purple?style=flat-square)]()

</div>

---

## Sobre el proyecto

**Andrómeda** es una aplicación web desarrollada con Java EE y JSP cuyo propósito es acercar la Inteligencia Artificial a cualquier persona, sin importar su nivel técnico.

La plataforma ofrece:
- 🎓 Cursos estructurados sobre el uso de herramientas de IA
- 📰 Artículos y noticias actualizadas sobre las principales plataformas (Claude, ChatGPT, Gemini y más)
- 💬 Un espacio interactivo para practicar la escritura de prompts efectivos

> La filosofía de Andrómeda es simple: **la IA no es una amenaza, es una herramienta**. Aprender a usarla bien marca la diferencia.

---

## Funcionalidades principales

| Módulo | Descripción |
|--------|-------------|
| 🏠 **Inicio** | Presentación de la plataforma y acceso rápido a contenidos |
| 🔐 **Autenticación** | Registro e inicio de sesión de usuarios |
| 📊 **Dashboard** | Panel personalizado con progreso, cursos activos y recomendaciones |
| 📚 **Cursos** | Aprendizaje por niveles sobre el uso de herramientas de IA |
| 📰 **Artículos** | Noticias y novedades del mundo de la IA |
| 👤 **Perfil** | Gestión de la cuenta y datos personales ||

---

## 🗂️ Estructura del proyecto

```
PROYECTOFINAL/
├── src/
│   ├── conf/                          # Archivos de configuración del proyecto
│   └── java/
│       ├── config/
│       │   └── Conexion.java          # Configuración y conexión a MySQL
│       ├── controlador/
│       │   └── Controlador.java       # Servlet principal (patrón MVC)
│       ├── modelos/
│       │   ├── ArticuloIA.java        # Modelo de artículos/noticias de IA
│       │   ├── Curso.java             # Modelo de cursos
│       │   └── TipIA.java             # Modelo de tips e IA
│       └── rss/
│           └── LectorRSS.java         # Lector de feeds RSS para noticias de IA
├── test/                              # Pruebas unitarias
├── web/
│   ├── WEB-INF/
│   │   ├── web.xml                    # Configuración del servlet (Java EE)
│   │   └── glassfish-web.xml          # Configuración específica de GlassFish
│   ├── articulos.jsp                  # Noticias y artículos sobre IA
│   ├── curso.jsp                      # Vista de un curso individual
│   ├── dashboard.jsp                  # Panel principal del usuario
│   ├── footer.jsp                     # Componente de pie de página compartido
│   ├── header.jsp                     # Componente de encabezado compartido
│   ├── index.jsp                      # Página de inicio
│   ├── login.jsp                      # Autenticación de usuarios
│   ├── normativa.jsp                  # Términos y condiciones / normativa
│   ├── perfil.jsp                     # Gestión del perfil de usuario
│   ├── prompt_maestro.jsp             # Práctica interactiva de prompts
│   ├── recursos.jsp                   # Biblioteca de recursos y guías
│   └── registro.jsp                   # Creación de cuenta nueva
├── .gitignore
└── build.xml                          # Script de construcción Ant
```

---

## 🛠️ Tecnologías utilizadas

- **Java EE** — Backend y lógica de negocio
- **JSP (JavaServer Pages)** — Renderizado de vistas dinámicas
- **MySQL** — Base de datos relacional
- **JDBC** — Conexión y consultas a la base de datos
- **GlassFish Server** — Servidor de aplicaciones Java EE
- **Apache Ant** — Herramienta de construcción (`build.xml`)
- **Patrón MVC** — Separación de capas (Modelos, Controlador, Vistas JSP)
- **Lector RSS** — Obtención automática de noticias de IA desde feeds externos
- **HTML5 / CSS3** — Estructura y estilos de la interfaz
- **JavaScript** — Interactividad del lado del cliente

---

## 🚀 Instalación y despliegue

### Requisitos previos

- JDK 11 o superior
- GlassFish Server 6+
- MySQL 8.0+
- Apache Ant
- NetBeans IDE (recomendado) o cualquier IDE compatible con Java EE

### Pasos

```bash
# 1. Clonar el repositorio
git clone https://github.com/tu-usuario/andromeda.git
cd andromeda
```

```sql
-- 2. Crear la base de datos en MySQL
CREATE DATABASE andromeda;
USE andromeda;
-- Importar el script SQL del proyecto (si existe en /src/conf/)
```

```
-- 3. Configurar la conexión en Conexion.java
src/java/config/Conexion.java
  → Ajusta: host, puerto, usuario y contraseña de tu MySQL

# 4. Abrir el proyecto en NetBeans
File → Open Project → selecciona la carpeta del proyecto

# 5. Configurar GlassFish como servidor
Services → Servers → Add Server → GlassFish Server

# 6. Ejecutar el proyecto
Run Project (F6)
→ Se abrirá automáticamente en: http://localhost:8080/Andromeda
```

---

## 🌐 Páginas disponibles

| Ruta | Descripción |
|------|-------------|
| `/index.jsp` | Página principal |
| `/login.jsp` | Inicio de sesión |
| `/registro.jsp` | Registro de usuarios |
| `/dashboard.jsp` | Panel del usuario |
| `/curso.jsp` | Detalle de un curso |
| `/articulos.jsp` | Noticias sobre IA (vía RSS) |
| `/recursos.jsp` | Recursos y materiales |
| `/perfil.jsp` | Perfil del usuario |
| `/prompt_maestro.jsp` | Práctica de prompts |
| `/normativa.jsp` | Términos, condiciones y normativa |

---

## Contribuciones

¡Las contribuciones son bienvenidas! Si quieres mejorar Andrómeda:

1. Haz un fork del repositorio
2. Crea una rama para tu feature: `git checkout -b feature/nueva-funcionalidad`
3. Realiza tus cambios y haz commit: `git commit -m "Agrega nueva funcionalidad"`
4. Sube tu rama: `git push origin feature/nueva-funcionalidad`
5. Abre un Pull Request

<div align="center">

Hecho con cariño para quienes quieren entender la IA, no temerle.

En desarrollo por Gerardo Villegas, estudiante de Informática.

</div>
