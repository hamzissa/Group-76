<!DOCTYPE html>
<html>
<head>
    <title>Login & Register</title>
    <style>
        body {
            margin: 0;
            font-family: "Nunito", sans-serif;
            background: #eef2f7;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .container {
            width: 380px;
            padding: 40px;
            background: white;
            border-radius: 30px;
            box-shadow: 0 15px 40px rgba(0,0,0,0.1);
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
            font-weight: 800;
            color: #333;
        }

        input {
            width: 100%;
            padding: 16px;
            margin: 12px 0;
            border-radius: 20px;
            border: 1px solid #ddd;
            background: #f7f9fc;
        }

        input:focus {
            border-color: #4e73df;
            outline: none;
        }

        button {
            width: 100%;
            padding: 16px;
            margin-top: 15px;
            border: none;
            border-radius: 20px;
            background: #4e73df;
            color: white;
            font-weight: bold;
            cursor: pointer;
        }

        button:hover {
            background: #2e59d9;
        }

        .google-btn {
            background: #db4437;
        }

        .google-btn:hover {
            background: #c23321;
        }

        .link {
            text-align: center;
            margin-top: 15px;
        }

        .link a {
            color: #4e73df;
            cursor: pointer;
            font-weight: 700;
            text-decoration: none;
        }

        .forgot {
            text-align: right;
            font-size: 12px;
        }

        .forgot a {
            color: #4e73df;
            text-decoration: none;
        }

        .hidden {
            display: none;
        }
    </style>

    <script>
        function showRegister() {
            document.getElementById("loginForm").classList.add("hidden");
            document.getElementById("registerForm").classList.remove("hidden");
        }

        function showLogin() {
            document.getElementById("registerForm").classList.add("hidden");
            document.getElementById("loginForm").classList.remove("hidden");
        }
    </script>
</head>
<body>

<div class="container">

    <div id="loginForm">
        <h2>Login</h2>

        <input type="email" placeholder="Email" required>
        <input type="password" placeholder="Password" required>

        <div class="forgot">
            <a href="#">Forgot Password?</a>
        </div>

        <button>Login</button>
        <button class="google-btn">Continue with Google</button>

        <div class="link">
            Don't have an account?
            <a href="#" onclick="showRegister()">Register</a>
        </div>
    </div>

    <div id="registerForm" class="hidden">
        <h2>Register</h2>

        <input type="email" placeholder="Email" required>
        <input type="password" placeholder="Password" required>
        <input type="password" placeholder="Confirm Password" required>

        <button>Create Account</button>
        <button class="google-btn">Sign up with Google</button>

        <div class="link">
            Already have an account?
            <a href="#" onclick="showLogin()">Login</a>
        </div>
    </div>

</div>

</body>
</html>
