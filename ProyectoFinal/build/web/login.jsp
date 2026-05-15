<%@include file="header.jsp" %>

<div class="container d-flex justify-content-center align-items-center" style="min-height: 80vh;">
    <div class="row w-100 justify-content-center">
        <div class="col-md-5 col-lg-4">
            <div class="card shadow-lg border-0">
                <div class="card-body p-4 p-md-5">
                    <div class="text-center mb-4">
                        <div class="mb-3">
                            <svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" fill="#1a237e" class="bi bi-person-circle" viewBox="0 0 16 16">
                                <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
                                <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
                            </svg>
                        </div>
                        <h2 class="fw-bold text-primary">Maverick AI</h2>
                        <p class="text-muted small">Aprende Responsable IAG</p>
                    </div>
                    
                    <form action="LoginServlet" method="POST">
                        <div class="mb-3">
                            <label class="form-label small fw-bold text-secondary">Correo Electrónico</label>
                            <input type="email" class="form-control form-control-lg fs-6" name="correo" required placeholder="nombre@ejemplo.com">
                        </div>
                        <div class="mb-4">
                            <label class="form-label small fw-bold text-secondary">Contraseña</label>
                            <input type="password" class="form-control form-control-lg fs-6" name="password" required placeholder="********">
                        </div>
                        <button type="submit" class="btn btn-primary btn-lg w-100 shadow-sm mb-3">Iniciar Sesión</button>
                    </form>
                    
                    <div class="text-center">
                        <span class="small text-muted">¿No tienes cuenta? <a href="registro.jsp" class="text-decoration-none fw-bold">Regístrate</a></span>
                    </div>
                </div>
            </div>
            
            <% if(request.getAttribute("error") != null) { %>
                <div class="alert alert-danger mt-3 text-center py-2" role="alert">
                    <small><%= request.getAttribute("error") %></small>
                </div>
            <% } %>
        </div>
    </div>
</div>

<%@include file="footer.jsp" %>