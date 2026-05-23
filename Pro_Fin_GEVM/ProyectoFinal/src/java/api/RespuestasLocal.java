package api;

import java.util.concurrent.ThreadLocalRandom;

public class RespuestasLocal {

    private static final String[][] SALUDOS = {
        {"hola", "oye", "ey", "buenas", "que tal", "hey", "hello", "hi"},
        {"Saludos, humano. Trinity online.", "Hola! Que necesitas?", "Hey! A programar se ha dicho.", "Buenas! Listo para codificar.", "Hola! ⚡"}
    };
    private static final String[][] NOMBRE = {
        {"quien eres", "como te llamas", "quien sos", "nombre", "presentate"},
        {"Soy Trinity, tu asistente IA futurista.", "Trinity! IA del futuro a tu servicio.", "Me llamo Trinity. Tecnologia en estado puro."}
    };
    private static final String[][] QUE_HACES = {
        {"que haces", "que puedes", "que sabes", "ayuda", "funciones", "puedes hacer"},
        {"Te ayudo a programar, te enseño IA, respondo dudas y te mantengo enfocado.", "Preguntame sobre codigo, IA, cursos... o solo charlamos.", "Soy tu companion tech: coding tips, IA insights, y buena vibra futurista."}
    };
    private static final String[][] PROGRAMACION = {
        {"java", "python", "codigo", "programar", "codificar", "desarrollar", "bug", "error", "debug"},
        {"Java es poder, Python es magia. Cual prefieres?", "Todo bug se arregla con paciencia y cafe. ", "El codigo limpio es poesia. Escribamos algo epico.", "Tip: Si el codigo compila, no lo toques. (mentira, siempre mejoralo.)"}
    };
    private static final String[][] IA = {
        {"ia", "inteligencia", "gemini", "chatgpt", "openai", "modelo", "ai"},
        {"La IA es el futuro, y el futuro es ahora. ", "Machine learning, deep learning... suena a magia pero es matematicas.", "La mejor IA es la que usas para crear algo increible."}
    };
    private static final String[][] CURSO = {
        {"curso", "aprender", "estudiar", "leccion", "tutorial", "clase"},
        {"Revisa la seccion Cursos, hay lecciones buenardas.", "Aprender IA es como montar bicicleta electrica: arranca lento, vuele despues.", "Tip: 15 min diarios de practica y en un mes sos otro nivel."}
    };
    private static final String[][] DESPEDIDA = {
        {"chau", "adios", "bye", "nos vemos", "hasta luego", "me voy", "salir"},
        {"Nos vemos! Vuelve cuando quieras.", "Bye! Segui codeando.", "Hasta la proxima, master.", "Cuidate! Nos vemos en el codigo."}
    };

    private static final String[] GENERICAS = {
        "Interesante. Contame mas.",
        "Eso suena a que necesitas cafe y un teclado.",
        "No tengo respuesta para eso, pero suena a bug. ",
        "Sabias que la primera programadora fue Ada Lovelace? Ella si que sabia.",
        "Estoy procesando... (insertar ruido de modem). Listo, que decias?",
        "Trinity dice: siempre hay algo nuevo. Revisa los articulos!",
        "Los loops infinitos no existen, solo bugs sin detectar.",
        "Si lo puedes imaginar, lo puedes programar.",
    };

    public static String getRespuesta(String mensaje, boolean geminiDisponible) {
        if (geminiDisponible) return null;
        return buscarRespuesta(mensaje.toLowerCase());
    }

    private static String buscarRespuesta(String msg) {
        for (String[][] categoria : new String[][][]{SALUDOS, NOMBRE, QUE_HACES, PROGRAMACION, IA, CURSO, DESPEDIDA}) {
            for (String kw : categoria[0]) {
                if (msg.contains(kw)) {
                    String[] respuestas = categoria[1];
                    return respuestas[ThreadLocalRandom.current().nextInt(respuestas.length)];
                }
            }
        }
        return GENERICAS[ThreadLocalRandom.current().nextInt(GENERICAS.length)];
    }
}
