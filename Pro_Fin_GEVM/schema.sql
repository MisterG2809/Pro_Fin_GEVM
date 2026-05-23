-- ============================================================
-- OBLIVION - Database Schema + Seed Data
-- Plataforma educativa con IA
-- ============================================================
-- Para inicializar: mysql -u root < schema.sql
-- ============================================================

CREATE DATABASE IF NOT EXISTS db_plataforma_ia CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci;
USE db_plataforma_ia;

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `articulos`
--

DROP TABLE IF EXISTS `articulos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `articulos` (
  `id_articulo` int NOT NULL AUTO_INCREMENT,
  `titulo` varchar(200) COLLATE utf8mb4_spanish_ci NOT NULL,
  `url` varchar(500) COLLATE utf8mb4_spanish_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_spanish_ci,
  `imagen_url` varchar(255) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `fuente` varchar(100) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `fecha_publicacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_articulo`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categorias`
--

DROP TABLE IF EXISTS `categorias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categorias` (
  `id_categoria` int NOT NULL AUTO_INCREMENT,
  `nombre_categoria` varchar(50) COLLATE utf8mb4_spanish_ci NOT NULL,
  PRIMARY KEY (`id_categoria`),
  UNIQUE KEY `nombre_categoria` (`nombre_categoria`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contenidos`
--

DROP TABLE IF EXISTS `contenidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contenidos` (
  `id_contenido` int NOT NULL AUTO_INCREMENT,
  `id_curso` int NOT NULL,
  `titulo` varchar(200) COLLATE utf8mb4_spanish_ci NOT NULL,
  `contenido` text COLLATE utf8mb4_spanish_ci,
  `orden` int DEFAULT '0',
  PRIMARY KEY (`id_contenido`),
  KEY `id_curso` (`id_curso`),
  CONSTRAINT `contenidos_ibfk_1` FOREIGN KEY (`id_curso`) REFERENCES `cursos` (`id_curso`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cursos`
--

DROP TABLE IF EXISTS `cursos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cursos` (
  `id_curso` int NOT NULL AUTO_INCREMENT,
  `titulo_curso` varchar(100) COLLATE utf8mb4_spanish_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_spanish_ci NOT NULL,
  `nivel` enum('Principiante','Intermedio','Avanzado') COLLATE utf8mb4_spanish_ci DEFAULT 'Principiante',
  `id_autor` int DEFAULT NULL,
  `estado` varchar(20) COLLATE utf8mb4_spanish_ci DEFAULT 'activo',
  `imagen_url` varchar(255) COLLATE utf8mb4_spanish_ci DEFAULT 'default.png',
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_curso`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `progreso_usuario`
--

DROP TABLE IF EXISTS `progreso_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `progreso_usuario` (
  `id_progreso` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `id_contenido` int NOT NULL,
  `fecha_completado` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_progreso`),
  UNIQUE KEY `uk_progreso` (`id_usuario`,`id_contenido`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tips_ia`
--

DROP TABLE IF EXISTS `tips_ia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tips_ia` (
  `id_tip` int NOT NULL AUTO_INCREMENT,
  `titulo` varchar(100) COLLATE utf8mb4_spanish_ci NOT NULL,
  `contenido` text COLLATE utf8mb4_spanish_ci NOT NULL,
  `id_categoria` int NOT NULL,
  `id_curso` int DEFAULT NULL,
  `fecha_publicacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_tip`),
  KEY `id_categoria` (`id_categoria`),
  KEY `id_curso` (`id_curso`),
  CONSTRAINT `tips_ia_ibfk_1` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id_categoria`) ON UPDATE CASCADE,
  CONSTRAINT `tips_ia_ibfk_2` FOREIGN KEY (`id_curso`) REFERENCES `cursos` (`id_curso`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `nombre_usuario` varchar(50) COLLATE utf8mb4_spanish_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_spanish_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_spanish_ci NOT NULL,
  `foto_perfil` varchar(500) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `rol` enum('estudiante','administrador','desarrollador') COLLATE utf8mb4_spanish_ci DEFAULT 'estudiante',
  `estado` varchar(20) COLLATE utf8mb4_spanish_ci DEFAULT 'activo',
  `especialidad` varchar(100) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `fecha_registro` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

--
-- Seed Data
-- ============================================================

INSERT INTO `categorias` (`nombre_categoria`) VALUES
('Programación'),
('Inteligencia Artificial'),
('Normativa Legal');

INSERT INTO `cursos` (`titulo_curso`, `descripcion`, `nivel`, `id_autor`, `estado`) VALUES
('Fundamentos de IA', 'Aprende los conceptos básicos de inteligencia artificial, machine learning y deep learning.', 'Principiante', NULL, 'activo'),
('Python para Data Science', 'Domina Python con librerías como NumPy, Pandas y Matplotlib para análisis de datos.', 'Intermedio', NULL, 'activo'),
('Prompt Engineering Avanzado', 'Técnicas avanzadas para crear prompts efectivos en modelos de lenguaje.', 'Avanzado', NULL, 'activo');

INSERT INTO `contenidos` (`id_curso`, `titulo`, `contenido`, `orden`) VALUES
(1, '¿Qué es la IA?', 'La inteligencia artificial (IA) es una rama de la informática que busca crear sistemas capaces de realizar tareas que requieren inteligencia humana. Esto incluye aprendizaje, razonamiento, percepción y procesamiento de lenguaje natural.\n\nTipos de IA:\n- IA Débil: diseñada para una tarea específica (ej. asistentes virtuales)\n- IA Fuerte: capaz de realizar cualquier tarea intelectual humana (aún en desarrollo)\n\nMachine Learning (ML): subcampo de la IA donde las máquinas aprenden de datos sin ser programadas explícitamente.', 1),
(1, 'Machine Learning', 'El Machine Learning se divide en tres categorías principales:\n\n1. Aprendizaje Supervisado: el modelo aprende de datos etiquetados (ej. clasificación, regresión).\n2. Aprendizaje No Supervisado: el modelo encuentra patrones en datos no etiquetados (ej. clustering).\n3. Aprendizaje por Refuerzo: el modelo aprende mediante prueba y error con recompensas.\n\nAlgoritmos populares: regresión lineal, árboles de decisión, SVM, redes neuronales.', 2),
(1, 'Redes Neuronales', 'Las redes neuronales artificiales están inspiradas en el cerebro humano. Están compuestas por capas de neuronas interconectadas.\n\nComponentes:\n- Capa de entrada: recibe los datos\n- Capas ocultas: procesan la información\n- Capa de salida: produce el resultado\n\nCada conexión tiene un peso que se ajusta durante el entrenamiento mediante backpropagation.', 3),
(2, 'Introducción a Python', 'Python es un lenguaje de programación interpretado, de alto nivel y multiparadigma. Es ampliamente utilizado en ciencia de datos por su sintaxis clara y su ecosistema de librerías.\n\nPara empezar:\n```python\nprint(\"¡Hola, Data Science!\")\n# Tipos básicos\nnumero = 42\ntexto = \"IA\"\nlista = [1, 2, 3]\n```', 1),
(2, 'NumPy y Álgebra Lineal', 'NumPy es la librería fundamental para cómputo numérico en Python.\n\n```python\nimport numpy as np\narr = np.array([1, 2, 3, 4, 5])\nprint(arr.mean())  # 3.0\nprint(arr.std())   # 1.414\n\n# Matrices\nmatriz = np.array([[1, 2], [3, 4]])\nprint(matriz.T)  # transpuesta\n```\n\nOperaciones vectorizadas: evita loops, mucho más rápido.', 2),
(2, 'Pandas para DataFrames', 'Pandas es la herramienta esencial para manipulación y análisis de datos.\n\n```python\nimport pandas as pd\ndf = pd.read_csv(\"datos.csv\")\nprint(df.head())\nprint(df.describe())\nprint(df.isnull().sum())\n```\n\nOperaciones clave: groupby, merge, pivot_table, apply.', 3),
(3, 'Fundamentos del Prompt', 'Un prompt es la instrucción que le das a un modelo de lenguaje. La calidad del output depende directamente de la calidad del input.\n\nRegla de oro: sé específico y proporciona contexto.\n\nEjemplo:\n❌ \"Escribe sobre Python\"\n✅ \"Escribe un artículo de 300 palabras explicando por qué Python es ideal para machine learning, dirigido a principiantes.\"', 1),
(3, 'Técnicas Avanzadas', 'Técnicas para mejorar tus prompts:\n\n1. Chain-of-Thought: pide al modelo que razone paso a paso.\n2. Few-Shot: proporciona ejemplos en el prompt.\n3. Role Prompting: asigna un rol al modelo.\n\"Actúa como un tutor de programación...\"\n4. Structured Output: especifica el formato de salida.\n\"Devuelve la respuesta en JSON con campos: titulo, descripcion, ejemplos\"', 2),
(3, 'Optimización de Resultados', 'Consejos para refinar outputs:\n\n- Temperatura: controla la creatividad (0 = determinista, 1 = creativo)\n- Max Tokens: limita la longitud de la respuesta\n- Stop Sequences: define cuándo detener la generación\n- System Prompt: define el comportamiento base del modelo\n\nItera y experimenta: el prompt perfecto rara vez se logra al primer intento.', 3);

INSERT INTO `tips_ia` (`titulo`, `contenido`, `id_categoria`, `id_curso`) VALUES
('Tip: Depura con IA', 'Usa ChatGPT para depurar tu código. Copia el error exacto y pide: \"Explica este error y cómo solucionarlo\".', 1, NULL),
('Tip: Código más limpio', 'Pide a la IA: \"Refactoriza este código siguiendo principios SOLID\" o \"Sugiere mejoras de rendimiento\".', 1, NULL),
('Tip: Explicación de Conceptos', 'Si no entiendes un concepto, pide: \"Explícame [concepto] como si tuviera 10 años\".', 2, NULL),
('Tip: Generación de Datos', 'Usa IA para generar datos de prueba sintéticos: \"Genera 10 registros JSON de usuarios con nombre, email y edad\".', 2, NULL),
('Tip: Prompt System', 'Define un system prompt fuerte: \"Eres un experto en Python con 10 años de experiencia. Respondes con ejemplos de código y explicaciones claras.\"', 2, 3);

INSERT INTO `usuarios` (`nombre_usuario`, `email`, `password`, `rol`, `estado`) VALUES
('admin', 'admin@maverick.com', 'admin123', 'administrador', 'activo');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

