</div>
<footer class="footer-tech">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-md-6 text-center text-md-start">
                <span class="brand" style="font-family:'Orbitron',sans-serif;letter-spacing:2px;">OBLIVION</span>
                <span class="tagline">AI · Futuro · Codigo</span>
            </div>
            <div class="col-md-6 text-center text-md-end mt-3 mt-md-0">
                <span class="version">v2.0</span>
                <span class="separator">·</span>
                <span class="tech-stack">Java · GlassFish</span>
            </div>
        </div>
        <div class="divider"></div>
        <p class="copyright">&copy; 2026 OBLIVION · desarrollado por <strong style="color:var(--primary);">MaverickTec</strong></p>
    </div>
</footer>

<style>
    .footer-tech {
        background: var(--dark-surface);
        border-top: 1px solid var(--border);
        padding: 1.5rem 0;
        margin-top: 3rem;
    }
    
    .footer-tech .brand {
        font-family: 'JetBrains Mono', monospace;
        font-weight: 600;
        font-size: 1rem;
        color: var(--primary);
    }
    
    .footer-tech .tagline {
        color: var(--text-muted);
        margin-left: 0.75rem;
        font-size: 0.85rem;
    }
    
    .footer-tech .version {
        color: var(--primary);
        font-family: 'JetBrains Mono', monospace;
        font-size: 0.75rem;
    }
    
    .footer-tech .separator {
        color: var(--text-muted);
        margin: 0 0.5rem;
    }
    
    .footer-tech .tech-stack {
        color: var(--text-muted);
        font-size: 0.8rem;
    }
    
    .footer-tech .divider {
        height: 1px;
        background: var(--border);
        margin: 1rem 0;
    }
    
    .footer-tech .copyright {
        color: var(--text-muted);
        font-size: 0.8rem;
        text-align: center;
    }
</style>

<script>
const orb = document.getElementById('orb');
const iris = document.getElementById('iris');
const eyelid = document.getElementById('eyelid');
const speech = document.getElementById('orb-speech');
const container = document.getElementById('ai-orb');
const chatPanel = document.getElementById('chat-panel');
const chatBody = document.getElementById('chat-body');
const chatInput = document.getElementById('chat-input');
const chatSend = document.getElementById('chat-send');
const chatClose = document.getElementById('chat-close');

let chatOpen = false;
let isLoading = false;
let blinkInterval = setInterval(blink, 3000);
let isBlinking = false;

function blink() {
    if (isBlinking) return;
    isBlinking = true;
    eyelid.classList.add('closed');
    setTimeout(() => {
        eyelid.classList.remove('closed');
        isBlinking = false;
    }, 150);
}

function fastBlink() {
    eyelid.classList.add('closed');
    setTimeout(() => {
        eyelid.classList.remove('closed');
        isBlinking = false;
    }, 80);
}

function lookAt(x, y) {
    const rect = orb.getBoundingClientRect();
    const cx = rect.left + rect.width / 2;
    const cy = rect.top + rect.height / 2;
    let dx = (x - cx) / 20;
    let dy = (y - cy) / 20;
    dx = Math.max(-8, Math.min(8, dx));
    dy = Math.max(-8, Math.min(8, dy));
    iris.style.transform = 'translate(' + dx + 'px, ' + dy + 'px)';
}

function setSpeech(text) {
    speech.textContent = text;
    speech.style.opacity = '0';
    speech.style.transform = 'translateY(10px)';
    setTimeout(() => {
        speech.style.opacity = '1';
        speech.style.transform = 'translateY(0)';
    }, 50);
}

function addMessage(text, role) {
    const div = document.createElement('div');
    div.className = 'chat-msg ' + role;
    const content = document.createElement('div');
    content.className = 'msg-content';
    content.textContent = text;
    div.appendChild(content);
    chatBody.appendChild(div);
    chatBody.scrollTop = chatBody.scrollHeight;
    return div;
}

function setLoading(loading) {
    isLoading = loading;
    chatInput.disabled = loading;
    chatSend.disabled = loading;
    if (loading) {
        const div = document.createElement('div');
        div.className = 'chat-msg ai loading';
        div.id = 'chat-loading';
        const content = document.createElement('div');
        content.className = 'msg-content';
        content.textContent = 'Pensando...';
        div.appendChild(content);
        chatBody.appendChild(div);
        chatBody.scrollTop = chatBody.scrollHeight;
    } else {
        const el = document.getElementById('chat-loading');
        if (el) el.remove();
    }
}

function askTrinity(message) {
    if (isLoading || !message.trim()) return;
    setSpeech('Pensando...');
    addMessage(message, 'user');
    setLoading(true);
    
    var url = window.location.origin + '/ProyectoFinal/api/gemini';
    
    fetch(url, {method:'POST', headers:{'Content-Type':'application/x-www-form-urlencoded'}, body:'message=' + encodeURIComponent(message)})
        .then(function(r) {
            if (!r.ok) throw new Error('HTTP ' + r.status);
            return r.json();
        })
        .then(function(data) {
            var text = data && data.candidates && data.candidates[0] && data.candidates[0].content && data.candidates[0].content.parts && data.candidates[0].content.parts[0] && data.candidates[0].content.parts[0].text;
            if (text) {
                addMessage(text, 'ai');
                setSpeech(text.length > 100 ? text.substring(0, 100) + '...' : text);
            } else {
                addMessage('No entendi eso 🤔', 'ai');
                setSpeech('No entendi eso 🤔');
            }
        })
        .catch(function(err) {
            addMessage('Error: ' + err.message + ' 💥', 'ai');
            setSpeech('Error: ' + err.message + ' 💥');
        })
        .finally(function() {
            setLoading(false);
        });
}

function openChat() {
    if (chatOpen) return;
    chatPanel.style.display = 'flex';
    chatOpen = true;
    chatBody.scrollTop = chatBody.scrollHeight;
    setTimeout(() => chatInput.focus(), 150);
}

function closeChat() {
    chatPanel.style.display = 'none';
    chatOpen = false;
}

container.addEventListener('click', function(e) {
    var target = e.target;
    if (target.classList.contains('chat-close') || target.closest('.chat-close')) {
        e.preventDefault();
        e.stopPropagation();
        closeChat();
        return;
    }
    if (target.classList.contains('chat-send') || target.closest('.chat-send')) {
        e.preventDefault();
        e.stopPropagation();
        var msg = chatInput.value.trim();
        if (msg) {
            chatInput.value = '';
            askTrinity(msg);
        }
        return;
    }
    if (target === orb || target.closest('.orb')) {
        e.stopPropagation();
        fastBlink();
        openChat();
        orb.style.transform = 'scale(1.3)';
        setTimeout(function() { orb.style.transform = 'scale(1)'; }, 300);
    }
});

chatInput.addEventListener('keydown', function(e) {
    if (e.key === 'Enter') {
        e.preventDefault();
        var msg = chatInput.value.trim();
        if (msg) {
            chatInput.value = '';
            askTrinity(msg);
        }
    }
    if (e.key === 'Escape') {
        closeChat();
    }
});

document.addEventListener('mousemove', function(e) {
    if (!isBlinking) lookAt(e.clientX, e.clientY);
});

document.addEventListener('click', function(e) {
    if (chatOpen && !container.contains(e.target)) {
        closeChat();
    }
});

document.addEventListener('scroll', () => {
    blink();
}, { passive: true });

</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>