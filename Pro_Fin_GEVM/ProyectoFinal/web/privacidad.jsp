<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="header.jsp" %>
<style>
    .privacy-section { background: var(--dark-surface); min-height: calc(100vh - 200px); padding: 40px 0; }
    .privacy-card { background: var(--dark-elevated); border: 1px solid var(--border); border-radius: 14px; padding: 2rem; max-width: 800px; margin: 0 auto; }
    .privacy-card h1 { font-family: 'Orbitron', sans-serif; font-weight: 600; font-size: 1.3rem; color: var(--text-primary); letter-spacing: 1px; }
    .privacy-card h2 { font-family: 'JetBrains Mono', monospace; font-weight: 600; font-size: 0.95rem; color: var(--primary); margin-top: 1.5rem; }
    .privacy-card p, .privacy-card li { color: var(--text-muted); font-size: 0.85rem; line-height: 1.6; }
    .privacy-card ul { padding-left: 1.25rem; }
    .privacy-card li { margin-bottom: 0.4rem; }
    .privacy-card .updated { color: var(--text-muted); font-size: 0.8rem; margin-top: 2rem; border-top: 1px solid var(--border); padding-top: 1rem; }
</style>
<div class="privacy-section">
    <div class="container">
        <div class="privacy-card">
            <h1><i class="fa-solid fa-shield-halved me-2" style="color:var(--primary);"></i>Aviso de Privacidad</h1>
            <p style="margin-top:0.75rem;">En <strong>OBLIVION</strong>, nos comprometemos a proteger tu privacidad. Este aviso explica que datos recopilamos, como los usamos y tus derechos.</p>

            <h2>1. Datos que recopilamos</h2>
            <ul>
                <li><strong>Registro:</strong> nombre de usuario, correo electronico y contraseña (almacenada de forma segura).</li>
                <li><strong>Progreso:</strong> lecciones vistas y cursos completados para llevar tu seguimiento academico.</li>
                <li><strong>Foto de perfil:</strong> solo si decides subir una imagen.</li>
            </ul>

            <h2>2. Uso de los datos</h2>
            <ul>
                <li>Autenticarte y personalizar tu experiencia en la plataforma.</li>
                <li>Mostrar tu progreso en los cursos.</li>
                <li>Mejorar nuestros servicios y contenidos.</li>
                <li>Comunicarte sobre cambios en la plataforma (unicamente si es necesario).</li>
            </ul>

            <h2>3. Comparticion de datos</h2>
            <p>No compartimos, vendemos ni alquilamos tus datos personales a terceros. La informacion de progreso y perfil es visible unicamente para ti y los administradores de la plataforma.</p>

            <h2>4. Seguridad</h2>
            <p>Implementamos medidas tecnicas y organizativas para proteger tus datos contra acceso no autorizado, alteracion o perdida.</p>

            <h2>5. Tus derechos</h2>
            <ul>
                <li><strong>Acceso:</strong> puedes ver tus datos en cualquier momento desde tu perfil.</li>
                <li><strong>Rectificacion:</strong> puedes actualizar tu nombre de usuario e informacion de perfil.</li>
                <li><strong>Cancelacion:</strong> puedes solicitar la eliminacion de tu cuenta contactando al administrador.</li>
            </ul>

            <h2>6. Cookies</h2>
            <p>Esta plataforma utiliza cookies de sesion (tecnicas) necesarias para el funcionamiento del inicio de sesion. No utilizamos cookies de rastreo ni publicitarias.</p>

            <h2>7. Contacto</h2>
            <p>Si tienes dudas sobre este aviso, contacta al administrador a traves de los canales disponibles en la plataforma.</p>

            <div class="updated">Ultima actualización: Mayo 2026 · OBLIVION by <span style="color:var(--primary);">MaverickTec</span></div>
        </div>
    </div>
</div>
<%@include file="footer.jsp" %>