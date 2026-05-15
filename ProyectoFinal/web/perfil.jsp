<%@include file="header.jsp" %>
<% 
    // Nota: En la Fase IV, aquí recuperaremos el objeto 'usuario' de la sesión
    // Por ahora, simulamos que el usuario "Estudiante IA" ha iniciado sesión.
    String nombreUsuario = "Estudiante IA"; 
%>

<div class="container my-5">
    <div class="row">
        <div class="col-md-4">
            <div class="card shadow-sm border-0 mb-4">
                <div class="card-body text-center">
                    <img src="https://ui-avatars.com/api/?name=<%=nombreUsuario%>&background=1a237e&color=fff" 
                         class="rounded-circle mb-3" alt="Avatar" width="100">
                    <h4><%= nombreUsuario %></h4>
                    <p class="text-muted">Nivel: Aprendiz de IAG</p>
                    <hr>
                    <div class="d-grid gap-2">
                        <button class="btn btn-outline-primary btn-sm">Editar Perfil</button>
                        <a href="logout.jsp" class="btn btn-danger btn-sm">Cerrar Sesión</a>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-8">
            <h3 class="mb-4">Mis Recursos Favoritos</h3>
            
            <div class="list-group shadow-sm">
                <a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                    <div>
                        <div class="fw-bold">Técnica de la Persona (Prompting)</div>
                        <small class="text-muted">Categoría: Tip de enseñanza</small>
                    </div>
                    <span class="badge bg-primary rounded-pill">Ver de nuevo</span>
                </a>
                
                <a href="#" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                    <div>
                        <div class="fw-bold">Resumen Ley IA (Unión Europea)</div>
                        <small class="text-muted">Categoría: Normatividad</small>
                    </div>
                    <span class="badge bg-primary rounded-pill">Ver de nuevo</span>
                </a>
                
                </div>
            
            <div class="mt-4 p-3 bg-light rounded border">
                <h5>Estatus de Aprendizaje</h5>
                <div class="progress mt-2" style="height: 20px;">
                    <div class="progress-bar bg-success" role="progressbar" style="width: 45%;" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100">45% Completado</div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@include file="footer.jsp" %>