<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
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
            box-sizing: border-box;
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
            margin-bottom: 10px;
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
        
        #sBox, #eBox {
            display: none;
            padding: 12px;
            border-radius: 15px;
            text-align: center;
            margin-bottom: 15px;
            font-size: 14px;
        }

        #sBox { color: #28a745; background: #e6f4ea; border: 1px solid #badbcc; }
        #eBox { color: #db4437; background: #ffeef0; border: 1px solid #f5c2c7; }
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

        <div id="sBox"></div>
        <div id="eBox"></div>

        <form action="login" method="post">
            <input type="email" name="email" placeholder="Email" required>
            <input type="password" name="password" placeholder="Password" required>

            <div class="forgot">
                <a href="#">Forgot Password?</a>
            </div>

            <button type="submit">Login</button>
        </form>

        <button type="button" class="google-btn">Continue with Google</button>

        <div class="link">
            Don't have an account?
            <a href="javascript:void(0)" onclick="showRegister()">Register</a>
        </div>
    </div>

    <div id="registerForm" class="hidden">
        <h2>Register</h2>

        <form action="register" method="post">
            <input type="email" name="email" placeholder="Email" required>
            <input type="password" name="password" placeholder="Password" required>
            <input type="password" name="confirm" placeholder="Confirm Password" required>

            <button type="submit">Create Account</button>
        </form>

        <button type="button" class="google-btn">Sign up with Google</button>

        <div class="link">
            Already have an account?
            <a href="javascript:void(0)" onclick="showLogin()">Login</a>
        </div>
    </div>
</div>

</body>
</html>
