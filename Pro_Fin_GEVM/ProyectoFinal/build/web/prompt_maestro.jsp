<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="header.jsp" %>

<style>
    .page-section {
        background: var(--dark-surface);
        min-height: calc(100vh - 200px);
        padding: 40px 0;
    }
    
    .page-title {
        font-family: 'JetBrains Mono', monospace;
        font-weight: 600;
        font-size: 1.4rem;
        color: var(--text-primary);
    }
    
    .btn-back {
        background: var(--dark-elevated);
        border: 1px solid var(--border);
        color: var(--text-muted);
        padding: 0.4rem 0.9rem;
        border-radius: 6px;
        font-size: 0.8rem;
        transition: all 0.2s ease;
    }
    
    .btn-back:hover {
        border-color: var(--primary);
        color: var(--primary);
    }
    
    .badge-tech {
        background: var(--dark-elevated);
        border: 1px solid var(--border);
        padding: 0.4rem 1rem;
        font-size: 0.8rem;
        color: var(--text-muted);
    }
    
    .content-card {
        background: var(--dark-elevated);
        border: 1px solid var(--border);
        border-radius: 12px;
        padding: 1.5rem;
        margin-bottom: 1.5rem;
    }
    
    .content-card h3 {
        font-family: 'JetBrains Mono', monospace;
        font-weight: 600;
        font-size: 1.1rem;
        color: var(--primary);
        margin-bottom: 1.25rem;
    }
    
    .step-item {
        display: flex;
        align-items: flex-start;
        margin-bottom: 1rem;
        padding: 0.75rem;
        background: var(--dark-surface);
        border-radius: 8px;
    }
    
    .step-badge {
        width: 36px;
        height: 36px;
        min-width: 36px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-family: 'JetBrains Mono', monospace;
        font-weight: 600;
        font-size: 0.9rem;
        background: var(--primary);
        color: var(--dark-bg);
        border-radius: 50%;
        margin-right: 1rem;
    }
    
    .step-item h5 {
        color: var(--text-primary);
        font-weight: 500;
        font-size: 0.95rem;
        margin-bottom: 0.25rem;
    }
    
    .step-item p {
        color: var(--text-muted);
        font-size: 0.8rem;
        margin: 0;
    }
    
    .prompt-box {
        background: var(--dark-bg);
        border: 1px solid var(--border);
        border-left: 3px solid var(--secondary);
        border-radius: 8px;
        padding: 1rem;
        font-family: 'JetBrains Mono', monospace;
        font-size: 0.8rem;
        color: var(--text-muted);
        line-height: 1.6;
    }
    
    .prompt-label {
        color: var(--primary);
        font-weight: 600;
    }
</style>

<div class="page-section">
    <div class="container">
        <a href="index.jsp" class="btn btn-back mb-4 d-inline-block">
            <i class="fa-solid fa-arrow-left me-1"></i>Inicio
        </a>
        
        <div class="text-center mb-5">
            <span class="badge-tech mb-3">
                <i class="fa-solid fa-wand-magic-sparkles me-2"></i>Technique
            </span>
            <h1 class="page-title mb-2">Prompt Engineering</h1>
            <p class="text-muted" style="max-width: 500px; margin: 0 auto;">
                Aprende a estructurar prompts efectivos para obtener el maximo de los modelos de IA.
            </p>
        </div>

        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="content-card">
                    <h3><i class="fa-solid fa-layer-group me-2"></i>Los 4 Pilares</h3>
                    
                    <div class="step-item">
                        <div class="step-badge">1</div>
                        <div>
                            <h5>Rol / Persona</h5>
                            <p>Asigna un rol especifico al modelo. Ej: "Actua como un desarrollador Java senior..."</p>
                        </div>
                    </div>

                    <div class="step-item">
                        <div class="step-badge">2</div>
                        <div>
                            <h5>Contexto</h5>
                            <p>Proporciona el background necesario. Ej: "Estoy migrando una app de GlassFish a Tomcat..."</p>
                        </div>
                    </div>

                    <div class="step-item">
                        <div class="step-badge">3</div>
                        <div>
                            <h5>Tarea</h5>
                            <p>Describe la meta con verbos de accion. Ej: "Genera un Servlet usando namespace jakarta..."</p>
                        </div>
                    </div>

                    <div class="step-item">
                        <div class="step-badge">4</div>
                        <div>
                            <h5>Formato</h5>
                            <p>Especifica la estructura de salida. Ej: "Devuelve solo codigo limpio sin explicaciones..."</p>
                        </div>
                    </div>
                </div>

                <div class="content-card">
                    <h4 style="color: var(--secondary); font-size: 1rem;">
                        <i class="fa-solid fa-terminal me-2"></i>Ejemplo Completo
                    </h4>
                    <div class="prompt-box">
                        <span class="prompt-label">[ROL]:</span> Actua como experto en ciberseguridad.<br>
                        <span class="prompt-label">[CONTEXTO]:</span> Evaluando un formulario de login en JSP y Tomcat 11.<br>
                        <span class="prompt-label">[TAREA]:</span> Analiza vulnerabilidades SQL injection en la conexion JDBC.<br>
                        <span class="prompt-label">[FORMATO]:</span> Lista con recomendaciones de mitigacion.
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@include file="footer.jsp" %>