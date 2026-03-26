<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>IBM SkillsBuild Login</title>
<link rel="stylesheet" href="/css/styles.css">

<style>
    body {
        background: linear-gradient(135deg, #001141 0%, #1a3a6b 60%, #2d5a9c 100%);
        min-height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
        position: relative;
        overflow: hidden;
        padding: 2rem;
    }

    body::before {
        content: '';
        position: absolute;
        top: -50%;
        right: -20%;
        width: 600px;
        height: 600px;
        background: radial-gradient(circle, rgba(15, 98, 254, 0.15) 0%, transparent 70%);
        border-radius: 50%;
        animation: float 20s infinite ease-in-out;
    }

    body::after {
        content: '';
        position: absolute;
        bottom: -30%;
        left: -15%;
        width: 500px;
        height: 500px;
        background: radial-gradient(circle, rgba(15, 98, 254, 0.1) 0%, transparent 70%);
        border-radius: 50%;
        animation: float 15s infinite ease-in-out reverse;
    }

    @keyframes float {
        0%, 100% { transform: translate(0, 0); }
        50% { transform: translate(-30px, 30px); }
    }

    .login-container {
        display: flex;
        gap: 4rem;
        max-width: 1100px;
        width: 100%;
        align-items: center;
        position: relative;
        z-index: 10;
    }

    .hero-section {
        flex: 1;
        color: white;
    }

    .ibm-badge {
        display: inline-block;
        background-color: var(--ibm-blue);
        color: white;
        padding: 0.4rem 1rem;
        border-radius: 4px;
        font-size: 0.75rem;
        font-weight: 600;
        margin-bottom: 1.5rem;
        letter-spacing: 0.05em;
        text-transform: uppercase;
    }

    .hero-section h1 {
        font-size: 2.5rem;
        margin-bottom: 1rem;
        line-height: 1.2;
        font-weight: 600;
    }

    .hero-section p {
        color: rgba(255, 255, 255, 0.8);
        font-size: 1rem;
        line-height: 1.6;
        max-width: 400px;
    }

    .login-card {
        flex: 0 0 460px;
        background: var(--ibm-white);
        border-radius: var(--radius-lg);
        box-shadow: 0 30px 60px rgba(0, 0, 0, 0.4);
        padding: 2.5rem;
    }

    .login-card h2 {
        text-align: left;
        margin-bottom: 1.5rem;
        color: var(--ibm-navy);
        font-size: 1.75rem;
        font-weight: 600;
    }

    .input-group {
        position: relative;
        margin-bottom: 1.25rem;
    }

    .input-group input {
        width: 100%;
        padding: 0.875rem 1rem;
        border-radius: var(--radius-sm);
        border: 1px solid var(--ibm-gray-20);
        background: var(--ibm-white);
        font-family: 'IBM Plex Sans', sans-serif;
        font-size: 0.95rem;
        color: var(--ibm-gray-80);
        transition: border-color 0.15s, box-shadow 0.15s;
    }

    .input-group input:focus {
        outline: none;
        border-color: var(--ibm-blue);
        box-shadow: 0 0 0 3px rgba(15, 98, 254, 0.15);
    }

    .toggle {
        position: absolute;
        right: 15px;
        top: 50%;
        transform: translateY(-50%);
        cursor: pointer;
        color: var(--ibm-blue);
    }

    .toggle svg {
        width: 20px;
        height: 20px;
        fill: currentColor;
    }

    .login-card button {
        width: 100%;
        padding: 0.875rem;
        border-radius: var(--radius-sm);
        border: none;
        background: var(--ibm-blue);
        color: white;
        font-family: 'IBM Plex Sans', sans-serif;
        font-size: 0.95rem;
        font-weight: 600;
        margin-top: 0.5rem;
        cursor: pointer;
        transition: background 0.15s, transform 0.1s;
    }

    .login-card button:hover {
        background: var(--ibm-blue-dark);
    }

    .login-card button:active {
        transform: scale(0.98);
    }

    .switch-container {
        display: flex;
        justify-content: center;
        margin-top: 1.5rem;
        font-size: 0.875rem;
        color: var(--ibm-gray-60);
    }

    .switch-container a {
        color: var(--ibm-blue);
        text-decoration: none;
        cursor: pointer;
        font-weight: 600;
        margin-left: 0.25rem;
    }

    .switch-container a:hover {
        text-decoration: underline;
    }

    #strengthLabel {
        display: none;
        font-size: 0.875rem;
        font-weight: 600;
        margin-bottom: 0.5rem;
        margin-top: -0.5rem;
        opacity: 0;
        transition: opacity 0.3s ease;
    }

    .hidden { 
        display: none; 
    }

    @media (max-width: 900px) {
        .login-container {
            flex-direction: column;
            gap: 2rem;
        }
        .hero-section {
            text-align: center;
        }
        .hero-section p {
            max-width: 100%;
        }
        .login-card {
            flex: 1;
            width: 100%;
            max-width: 460px;
        }
    }
</style>

<script>
const eyeIcon = '<svg viewBox="0 0 24 24"><path d="M12 4.5C7 4.5 2.73 7.61 1 12c1.73 4.39 6 7.5 11 7.5s9.27-3.11 11-7.5c-1.73-4.39-6-7.5-11-7.5zM12 17c-2.76 0-5-2.24-5-5s2.24-5 5-5 5 2.24 5 5-2.24 5-5 5zm0-8c-1.66 0-3 1.34-3 3s1.34 3 3 3 3-1.34 3-3-1.34-3-3-3z"/></svg>';
const eyeSlashIcon = '<svg viewBox="0 0 24 24"><path d="M12 7c2.76 0 5 2.24 5 5 0 .65-.13 1.26-.36 1.82l2.92 2.92c1.51-1.26 2.7-2.89 3.44-4.74-1.73-4.39-6-7.5-11-7.5-1.4 0-2.74.25-3.98.7l2.16 2.16C10.74 7.13 11.35 7 12 7zM2 4.27l2.28 2.28.46.46C3.08 8.3 1.78 10.02 1 12c1.73 4.39 6 7.5 11 7.5 1.55 0 3.03-.3 4.38-.84l.42.42L19.73 22 21 20.73 3.27 3 2 4.27zM7.53 9.8l1.55 1.55c-.05.21-.08.43-.08.65 0 1.66 1.34 3 3 3 .22 0 .44-.03.65-.08l1.55 1.55c-.67.33-1.41.53-2.2.53-2.76 0-5-2.24-5-5 0-.79.2-1.53.53-2.2zm4.31-.78l3.15 3.15.02-.16c0-1.66-1.34-3-3-3l-.17.01z"/></svg>';

function showRegister() {
    document.getElementById("loginForm").classList.add("hidden");
    document.getElementById("registerForm").classList.remove("hidden");
}

function showLogin() {
    document.getElementById("registerForm").classList.add("hidden");
    document.getElementById("loginForm").classList.remove("hidden");
    const label = document.getElementById("strengthLabel");
    label.style.display = "none";
    label.style.opacity = "0";
}

function toggleIcon(id, element) {
    const input = document.getElementById(id);
    input.type = (input.type === "password") ? "text" : "password";
    element.innerHTML = (input.type === "password") ? eyeIcon : eyeSlashIcon;
}

function checkPasswordStrength() {
    const password = document.getElementById("regPassword").value;
    const label = document.getElementById("strengthLabel");

    if (password.length === 0) {
        label.style.display = "none";
        label.style.opacity = "0";
        return;
    }

    label.style.display = "block";
    setTimeout(() => label.style.opacity = "1", 10);

    if (password.length < 6) {
        label.innerText = "Weak";
        label.style.color = "#0062ff";
    } else if (password.length < 10) {
        label.innerText = "Medium";
        label.style.color = "#ff4d4d";
    } else {
        label.innerText = "Strong";
        label.style.color = "#24a148";
    }
}
</script>
</head>

<body>

    <div class="login-container">
        <div class="hero-section">
            <div class="ibm-badge">IBM SkillsBuild</div>
            <h1>Welcome to SkillsBuild</h1>
            <p>Design is a layer to improve the high-end experience for the user. Explore your potential with world-class digital skills.</p>
        </div>

        <div class="login-card">
            <div id="loginForm">
                <h2>Login</h2>
                <form action="/login" method="POST">
                    <div class="input-group">
                        <input type="email" name="email" placeholder="Email address" required>
                    </div>
                    <div class="input-group">
                        <input type="password" id="loginPassword" name="password" placeholder="Password" required>
                        <span class="toggle" onclick="toggleIcon('loginPassword', this)">
                            <script>document.write(eyeIcon);</script>
                        </span>
                    </div>
                    <button type="submit">Sign in</button>
                </form>
                <div class="switch-container">
                    <span>New here?<a onclick="showRegister()">Register</a></span>
                </div>
            </div>

            <div id="registerForm" class="hidden">
                <h2>Register</h2>
                <form action="/register" method="POST">
                    <div class="input-group">
                        <input type="email" name="email" placeholder="Email address" required>
                    </div>

                    <span id="strengthLabel"></span>

                    <div class="input-group">
                        <input type="password" id="regPassword" name="password" placeholder="Password" oninput="checkPasswordStrength()" required>
                        <span class="toggle" onclick="toggleIcon('regPassword', this)">
                            <script>document.write(eyeIcon);</script>
                        </span>
                    </div>
                    <div class="input-group">
                        <input type="password" id="confirmPassword" name="confirm" placeholder="Confirm password" required>
                        <span class="toggle" onclick="toggleIcon('confirmPassword', this)">
                            <script>document.write(eyeIcon);</script>
                        </span>
                    </div>
                    <button type="submit">Create account</button>
                </form>
                <div class="switch-container">
                    <span>Already a member?<a onclick="showLogin()">Login</a></span>
                </div>
            </div>
        </div>
    </div>

</body>