<div align="center">

# ⬡ OBLIVION

**Plataforma de aprendizaje especializada en Inteligencia Artificial y Programación**

Cursos, noticias, recursos y Trinity — tu asistente de IA — para dominar las herramientas del futuro.

[![Java EE](https://img.shields.io/badge/Java%20EE-JSP-orange?style=flat-square&logo=java)](https://jakarta.ee/)
[![GlassFish](https://img.shields.io/badge/Server-GlassFish-blue?style=flat-square)](https://glassfish.org/)
[![MySQL](https://img.shields.io/badge/DB-MySQL-4479A1?style=flat-square&logo=mysql&logoColor=white)](https://mysql.com/)
[![Groq API](https://img.shields.io/badge/AI-Groq%20API-00C853?style=flat-square&logo=openai&logoColor=white)](https://groq.com/)
[![Status](https://img.shields.io/badge/Estado-En%20desarrollo-7C3AED?style=flat-square)]()

</div>

---

## Sobre el proyecto

**OBLIVION** es una aplicación web desarrollada con Java EE y JSP, enfocada en el aprendizaje de Inteligencia Artificial y Programación. Ofrece cursos estructurados por niveles, artículos con las últimas noticias del mundo IA, recursos descargables y un espacio de práctica con prompts.

Su característica más destacada es **Trinity**, la mascota interactiva de la plataforma: una asistente impulsada por la API de Groq con quien puedes conversar en tiempo real para resolver dudas, practicar prompts y explorar el mundo de la IA.

> OBLIVION nació con una filosofía clara: **la IA no es el futuro, es el presente.** Aprender a usarla bien marca la diferencia.

---

## Historia — De Andrómeda a OBLIVION

Este proyecto comenzó su vida bajo el nombre de **Andrómeda**, una plataforma dedicada al aprendizaje y divulgación de la Inteligencia Artificial. Con el tiempo, el proyecto creció, evolucionó su identidad visual, incorporó nuevas funcionalidades y sumó a **Trinity** como asistente interactiva.

Con esa evolución llegó un nuevo nombre: **OBLIVION**. El concepto sigue siendo el mismo — acercar la IA a cualquier persona de forma accesible y práctica — pero con una identidad más sólida, una experiencia más completa y una mascota que te acompaña en cada paso del camino.

---

## Trinity — La mascota de OBLIVION

**Trinity** es el asistente inteligente integrado en la plataforma. Vive en la interfaz como un personaje interactivo y está conectada a la **API de Groq** para ofrecer respuestas rápidas e inteligentes.

Con Trinity puedes:
- 💬 Conversar sobre IA, programación y tecnología
- 🧠 Resolver dudas sobre los cursos y contenidos
- ✍️ Practicar la escritura de prompts efectivos
- 🔍 Obtener recomendaciones personalizadas dentro de la plataforma

---

## Funcionalidades principales

| Módulo | Descripción |
|--------|-------------|
| 🏠 **Inicio** | Presentación de la plataforma, cursos destacados y últimas noticias |
| 🔐 **Autenticación** | Registro, inicio de sesión y gestión de sesión de usuario |
| 📊 **Dashboard** | Panel personalizado con progreso y contenidos activos |
| 📚 **Cursos** | Aprendizaje por niveles: Principiante, Intermedio y Avanzado |
| 📖 **Lecciones** | Vista detallada de cada lección dentro de un curso |
| 📰 **Artículos** | Noticias actualizadas via RSS sobre IA y tecnología |
| 📁 **Recursos** | Biblioteca de materiales, guías y referencias descargables |
| 💬 **Prompt Maestro** | Espacio para practicar y perfeccionar prompts de IA |
| 👤 **Perfil** | Gestión de cuenta y datos personales |
| 🛡️ **Admin** | Panel de administración para gestión de contenidos |
| ➕ **Crear Curso** | Herramienta para crear y publicar nuevos cursos (admin) |
| 📋 **Normativa** | Términos, condiciones y políticas de uso |
| 🔒 **Privacidad** | Política de privacidad de la plataforma |
| 🤖 **Trinity** | Asistente IA integrado con Groq API |

---

## Estructura del proyecto

```
PROYECTOFINAL/
├── src/
│   └── java/
│       ├── modelos/
│       │   ├── ArticuloIA.java        # Modelo de artículos y noticias de IA
│       │   ├── Curso.java             # Modelo de cursos
│       │   └── TipIA.java             # Modelo de tips sobre IA
│       └── rss/
│           └── LectorRSS.java         # Lector de feeds RSS para noticias
├── test/                              # Pruebas unitarias
├── web/
│   ├── WEB-INF/
│   │   ├── web.xml                    # Configuración del servlet (Java EE)
│   │   └── glassfish-web.xml          # Configuración específica de GlassFish
│   ├── admin.jsp                      # Panel de administración
│   ├── articulos.jsp                  # Noticias y artículos sobre IA
│   ├── crear_curso.jsp                # Creación de nuevos cursos (admin)
│   ├── curso.jsp                      # Vista de un curso individual
│   ├── dashboard.jsp                  # Panel principal del usuario
│   ├── footer.jsp                     # Componente de pie de página compartido
│   ├── header.jsp                     # Componente de encabezado compartido
│   ├── index.jsp                      # Página de inicio
│   ├── leccion.jsp                    # Vista detallada de una lección
│   ├── login.jsp                      # Autenticación de usuarios
│   ├── normativa.jsp                  # Términos y condiciones
│   ├── perfil.jsp                     # Gestión del perfil de usuario
│   ├── privacidad.jsp                 # Política de privacidad
│   ├── prompt_maestro.jsp             # Práctica interactiva de prompts
│   ├── recursos.jsp                   # Biblioteca de recursos y guías
│   ├── registro.jsp                   # Creación de cuenta nueva
│   └── tip_detalle.jsp                # Vista detallada de un tip de IA
├── .gitignore
└── build.xml                          # Script de construcción Ant
```

---

## Tecnologías utilizadas

- **Java EE** — Backend y lógica de negocio
- **JSP (JavaServer Pages)** — Renderizado de vistas dinámicas
- **MySQL** — Base de datos relacional
- **JDBC** — Conexión y consultas a la base de datos
- **Groq API** — Motor de IA que impulsa a Trinity, la mascota interactiva
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
- NetBeans IDE (recomendado)
- API Key de [Groq](https://console.groq.com/) para activar a Trinity

### Pasos

```bash
# 1. Clonar el repositorio
git clone https://github.com/MisterG2809/Pro_Fin_GEVM
cd oblivion
```

```sql
-- 2. Crear la base de datos en MySQL
CREATE DATABASE oblivion;
USE oblivion;
-- Importar el script SQL del proyecto
```

```
-- 3. Configurar la conexión a MySQL
src/java/config/Conexion.java
  → Ajusta: host, puerto, usuario y contraseña de tu MySQL

-- 4. Configurar la API Key de Groq (para Trinity)
  → Agrega tu API Key en el archivo de configuración correspondiente

# 5. Abrir el proyecto en NetBeans
File → Open Project → selecciona la carpeta del proyecto

# 6. Configurar GlassFish como servidor
Services → Servers → Add Server → GlassFish Server

# 7. Ejecutar el proyecto
Run Project (F6)
→ Se abrirá en: http://localhost:8080/ProyectoFinal/index.jsp
```

---

## Páginas disponibles

| Ruta | Descripción |
|------|-------------|
| `/index.jsp` | Página principal |
| `/login.jsp` | Inicio de sesión |
| `/registro.jsp` | Registro de usuarios |
| `/dashboard.jsp` | Panel del usuario |
| `/curso.jsp` | Detalle de un curso |
| `/leccion.jsp` | Vista de una lección |
| `/articulos.jsp` | Noticias sobre IA (vía RSS) |
| `/recursos.jsp` | Recursos y materiales |
| `/perfil.jsp` | Perfil del usuario |
| `/prompt_maestro.jsp` | Práctica de prompts con Trinity |
| `/tip_detalle.jsp` | Detalle de un tip de IA |
| `/admin.jsp` | Panel de administración |
| `/crear_curso.jsp` | Creación de cursos (admin) |
| `/privacidad.jsp` | Política de privacidad |

---

## Contribuciones

¡Las contribuciones son bienvenidas! Si quieres mejorar OBLIVION:

1. Haz un fork del repositorio
2. Crea una rama para tu feature: `git checkout -b feature/nueva-funcionalidad`
3. Realiza tus cambios y haz commit: `git commit -m "Agrega nueva funcionalidad"`
4. Sube tu rama: `git push origin feature/nueva-funcionalidad`
5. Abre un Pull Request


---

<div align="center">

Hecho con cariño para quienes quieren entender la IA, no temerle.

---

Hecho por **Gerardo Villegas**, estudiante de Informática.

</div>
