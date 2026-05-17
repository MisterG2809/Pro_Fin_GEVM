<%@include file="header.jsp" %>
<div class="container my-5">
    <h2 class="mb-4">Catálogo de Tips y Consejos</h2>
    <div class="row">
        <div class="col-md-4 mb-4">
            <div class="card h-100 shadow-sm">
                <div class="card-body">
                    <span class="badge bg-info text-dark mb-2">Tip de Prompting</span>
                    <h5 class="card-title">Estructura de un Prompt Maestro</h5>
                    <p class="card-text">Aprende a usar la técnica de 'Persona' para obtener mejores respuestas.</p>
                    <a href="prompt_maestro.jsp" class="btn btn-primary btn-sm">Ver más</a>
                </div>
            </div>
        </div>
        <div class="col-md-4 mb-4">
            <div class="card h-100 shadow-sm">
                <div class="card-body">
                    <span class="badge bg-success text-white mb-2">Todos los Recursos</span>
                    <h5 class="card-title">Dashboard de Recursos</h5>
                    <p class="card-text">Explora todos los tips, consejos y normativas disponibles.</p>
                    <a href="Controlador?accion=listar" class="btn btn-success btn-sm">Ir al Dashboard</a>
                </div>
            </div>
        </div>
    </div>
</div>
<%@include file="footer.jsp" %>
