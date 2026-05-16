<%@taglib prefix="c" uri="jakarta.tags.core" %>
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
    
    .norm-card {
        background: var(--dark-elevated);
        border: 1px solid var(--border);
        border-radius: 10px;
        padding: 1.25rem;
        margin-bottom: 1rem;
        transition: all 0.2s ease;
    }
    
    .norm-card:hover {
        border-color: var(--secondary);
    }
    
    .norm-card h4 {
        font-family: 'JetBrains Mono', monospace;
        font-weight: 600;
        font-size: 1rem;
        color: var(--primary);
        margin-bottom: 0.5rem;
    }
    
    .norm-card p {
        color: var(--text-muted);
        font-size: 0.85rem;
        line-height: 1.6;
    }
    
    .norm-card .badge-legal {
        background: rgba(248, 81, 73, 0.1);
        border: 1px solid rgba(248, 81, 73, 0.3);
        font-size: 0.7rem;
        padding: 0.25rem 0.5rem;
        color: #f85149;
    }
    
    .norm-card .date {
        color: var(--text-muted);
        font-size: 0.75rem;
    }
    
    .empty-state {
        text-align: center;
        padding: 4rem 0;
    }
    
    .empty-state i {
        font-size: 3rem;
        color: var(--text-muted);
        opacity: 0.4;
    }
    
    .empty-state p {
        color: var(--text-muted);
        margin-top: 1rem;
    }
</style>

<div class="page-section">
    <div class="container">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="page-title">
                <i class="fa-solid fa-gavel me-2" style="color: var(--secondary);"></i>
                Legal y Normativa IA
            </h2>
            <a href="index.jsp" class="btn btn-back">
                <i class="fa-solid fa-arrow-left me-1"></i>Inicio
            </a>
        </div>

        <div class="row">
            <div class="col-12">
                <c:forEach var="norma" items="${misNormas}">
                    <div class="norm-card">
                        <div class="d-flex justify-content-between align-items-start mb-2">
                            <h4>${norma.titulo}</h4>
                            <span class="badge-legal">Legal</span>
                        </div>
                        <p>${norma.contenido}</p>
                        <span class="date"><i class="fa-regular fa-calendar me-1"></i>2026</span>
                    </div>
                </c:forEach>
                
                <c:if test="${empty misNormas}">
                    <div class="empty-state">
                        <i class="fa-solid fa-scale-balanced"></i>
                        <p>No hay normativas disponibles.</p>
                        <a href="index.jsp" class="btn btn-back mt-3">Volver al inicio</a>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</div>

<%@include file="footer.jsp" %>