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
    
    .tip-card {
        background: var(--dark-elevated);
        border: 1px solid var(--border);
        border-radius: 10px;
        padding: 1.25rem;
        height: 100%;
        transition: all 0.2s ease;
    }
    
    .tip-card:hover {
        border-color: var(--primary);
        transform: translateY(-3px);
    }
    
    .tip-card h5 {
        font-family: 'JetBrains Mono', monospace;
        font-weight: 600;
        font-size: 0.95rem;
        color: var(--primary);
        margin-bottom: 0.75rem;
    }
    
    .tip-card p {
        color: var(--text-muted);
        font-size: 0.85rem;
        line-height: 1.5;
    }
    
    .tip-card .badge-category {
        background: var(--dark-surface);
        border: 1px solid var(--border);
        font-size: 0.65rem;
        padding: 0.2rem 0.5rem;
        color: var(--text-muted);
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
    
    .count-badge {
        background: var(--dark-elevated);
        border: 1px solid var(--border);
        padding: 0.3rem 0.8rem;
        border-radius: 20px;
        font-size: 0.8rem;
        color: var(--text-muted);
    }
</style>

<div class="page-section">
    <div class="container">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="page-title">
                <i class="fa-solid fa-code me-2" style="color: var(--primary);"></i>
                Tips de Programacion con IA
            </h2>
            <a href="index.jsp" class="btn btn-back">
                <i class="fa-solid fa-arrow-left me-1"></i>Inicio
            </a>
        </div>
        
        <span class="count-badge mb-4 d-inline-block">
            <i class="fa-solid fa-lightbulb me-1"></i>
            ${misTips.size()} recursos disponibles
        </span>

        <div class="row g-4">
            <c:forEach var="tip" items="${misTips}">
                <div class="col-md-6 col-lg-4">
                    <div class="tip-card">
                        <h5><i class="fa-solid fa-code me-2"></i>${tip.titulo}</h5>
                        <p>${tip.contenido}</p>
                        <span class="badge-category">Programacion</span>
                    </div>
                </div>
            </c:forEach>

            <c:if test="${empty misTips}">
                <div class="col-12 text-center">
                    <div class="empty-state">
                        <i class="fa-solid fa-folder-open"></i>
                        <p>No hay recursos disponibles.</p>
                        <a href="index.jsp" class="btn btn-back mt-3">Volver al inicio</a>
                    </div>
                </div>
            </c:if>
        </div>
    </div>
</div>

<%@include file="footer.jsp" %>