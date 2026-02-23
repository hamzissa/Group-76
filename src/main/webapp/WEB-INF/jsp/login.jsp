<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>IBM SkillsBuild Login</title>

<style>
    * {
        box-sizing: border-box;
        margin: 0;
        padding: 0;
    }

    body {
        background-color: #333c4d; 
        font-family: "Segoe UI", Arial, sans-serif;
        height: 100vh;
        width: 100vw;
        display: flex;
        justify-content: center;
        align-items: center;
        position: relative;
        overflow: hidden;
    }

    .hero-text {
        position: absolute;
        top: 40px;
        left: 40px;
        text-align: left;
        max-width: 400px;
    }

    .ibm-badge {
        display: inline-block;
        background-color: #0062ff;
        color: white;
        padding: 4px 12px;
        border-radius: 4px;
        font-size: 14px;
        font-weight: bold;
        margin-bottom: 15px;
    }

    .hero-text h1 {
        font-size: 32px;
        color: #ffffff;
        margin-bottom: 10px;
        line-height: 1.2;
        font-weight: 600;
    }

    .hero-text p {
        color: #cccccc;
        font-size: 14px;
        line-height: 1.6;
    }

    .card {
        width: 560px;
        padding: 60px;
        border-radius: 25px;
        background: #ffffff;
        box-shadow: 0 30px 60px rgba(0, 0, 0, 0.4);
        z-index: 10;
        position: relative;
    }

    h2 {
        text-align: left;
        margin-bottom: 30px;
        color: #0062ff; 
        font-size: 24px;
        font-weight: 600;
    }

    .input-group {
        position: relative;
        margin-bottom: 20px;
    }

    input {
        width: 100%;
        padding: 14px 20px;
        border-radius: 10px; 
        border: 1px solid #dddddd;
        background: #ffffff;
        font-size: 16px;
        color: #333;
        transition: border-color 0.2s;
    }

    input:focus {
        outline: none;
        border-color: #0062ff;
    }

    .toggle {
        position: absolute;
        right: 15px;
        top: 50%;
        transform: translateY(-50%);
        cursor: pointer;
        display: flex;
        color: #0062ff;
    }

    .toggle svg {
        width: 22px;
        height: 22px;
        fill: currentColor;
    }

    button {
        width: 100%;
        padding: 16px;
        border-radius: 10px; 
        border: none;
        background: #0070d2; 
        color: #ffffff;
        font-size: 16px;
        font-weight: bold;
        margin-top: 10px;
        cursor: pointer;
        transition: background 0.2s;
    }

    button:hover {
        background: #005fb2;
    }

    .switch-container {
        display: flex;
        justify-content: flex-end;
        margin-top: 25px;
        font-size: 14px;
        color: #666;
    }

    .switch-container a {
        color: #0062ff; 
        text-decoration: none;
        cursor: pointer;
        font-weight: bold;
        margin-left: 5px;
    }

    #strengthLabel {
        display: none;
        font-size: 14px;
        font-weight: bold;
        margin-bottom: 8px;
        margin-top: -10px;
        opacity: 0;
        transition: opacity 0.3s ease;
    }

    .hidden { display: none; }
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

    <div class="hero-text">
        <div class="ibm-badge">IBM SkillsBuild</div>
        <h1>Welcome to SkillsBuild</h1>
        <p>Design is a layer to improve the high-end experience for the user. Explore your potential with world-class digital skills.</p>
    </div>

    <div class="card">
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
                <span>New here? <a onclick="showRegister()">Register</a></span>
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
                <span>Already a member? <a onclick="showLogin()">Login</a></span>
            </div>
        </div>
    </div>

</body>