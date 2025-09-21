<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Parrot Keep</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link rel="icon" href="https://img.icons8.com/ios-filled/50/4CAF50/feather.png" type="image/png">
    <style>
        :root {
            --parrot-green: #4CAF50;
            --dark-bg: #121212;
            --dark-card: #1e1e1e;
            --white: #ffffff;
            --radius: 10px;
            --shadow: 0 6px 20px rgba(0,0,0,0.6);
        }

        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background: var(--dark-bg); /* black background */
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            color: var(--white);
        }

        .register-box {
            background: var(--dark-card);
            padding: 2.5rem 2rem;
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            width: 100%;
            max-width: 420px;
            text-align: center;
        }

        .logo {
            font-size: 1.6rem;
            font-weight: bold;
            margin-bottom: 1.5rem;
            color: var(--parrot-green);
            display: flex;
            justify-content: center;
            align-items: center;
            gap: .5rem;
        }
        .logo i {
            color: var(--parrot-green);
        }

        h2 {
            margin: 0 0 .5rem;
            font-size: 1.4rem;
            font-weight: 600;
            color: var(--white);
        }

        p.subtitle {
            margin: 0 0 1.5rem;
            font-size: .9rem;
            color: #bbb;
        }

        .form-group {
            text-align: left;
            margin-bottom: 1rem;
        }
        .form-group label {
            font-size: .85rem;
            font-weight: 600;
            margin-bottom: .3rem;
            display: block;
            color: #ddd;
        }
        .form-group input {
            width: 100%;
            padding: .8rem;
            border: 1px solid #333;
            border-radius: var(--radius);
            font-size: 1rem;
            background: #121212;
            color: var(--white);
        }
        .form-group input:focus {
            border-color: var(--parrot-green);
            outline: none;
            box-shadow: 0 0 0 2px rgba(76,175,80,0.3);
        }

        .password-strength {
            margin-top: .4rem;
            height: 4px;
            border-radius: 2px;
            background: #333;
        }
        .strength-bar {
            height: 100%;
            width: 0;
            border-radius: 2px;
            transition: width .3s;
        }
        .weak { background: #F44336; width: 33%; }
        .medium { background: #FFC107; width: 66%; }
        .strong { background: #4CAF50; width: 100%; }

        .btn {
            width: 100%;
            padding: .9rem;
            margin-top: 1rem;
            background: var(--parrot-green);
            border: none;
            border-radius: var(--radius);
            color: var(--white);
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: .3s;
        }
        .btn:hover {
            background: #2E7D32;
        }

        .extra {
            margin-top: 1rem;
            font-size: .9rem;
            color: #bbb;
        }
        .extra a {
            color: var(--parrot-green);
            text-decoration: none;
            font-weight: 600;
        }
        .extra a:hover {
            text-decoration: underline;
        }

        /* Snackbar */
        #snackbar {
            visibility: hidden;
            min-width: 250px;
            margin-left: -125px;
            background-color: #F44336;
            color: var(--white);
            text-align: center;
            border-radius: var(--radius);
            padding: 1rem;
            position: fixed;
            z-index: 1;
            left: 50%;
            bottom: 30px;
            font-size: .9rem;
            box-shadow: var(--shadow);
        }

        #snackbar.show {
            visibility: visible;
            animation: fadeIn 0.5s, fadeOut 0.5s 2.5s;
        }

        @keyframes fadeIn {
            from {bottom: 0; opacity: 0;}
            to {bottom: 30px; opacity: 1;}
        }
        @keyframes fadeOut {
            from {bottom: 30px; opacity: 1;}
            to {bottom: 0; opacity: 0;}
        }
    </style>
</head>
<body>

<div class="register-box">
    <div class="logo"><i class="fas fa-feather-alt"></i> Parrot Keep</div>
    <h2>Create Account</h2>
    <p class="subtitle">Join us and start organizing your notes</p>

    <form action="RegisterServlet" method="post">
        <div class="form-group">
            <label for="username">Username</label>
            <input type="text" id="username" name="username" required placeholder="Enter your username (must be unique)">
        </div>
        <div class="form-group">
            <label for="email">Email Address</label>
            <input type="email" id="email" name="email" required placeholder="Enter your email">
        </div>
        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" required placeholder="Create password">
            <div class="password-strength"><div class="strength-bar" id="strengthBar"></div></div>
        </div>
        <div class="form-group">
            <label for="confirmPassword">Confirm Password</label>
            <input type="password" id="confirmPassword" name="confirmPassword" required placeholder="Confirm password">
        </div>
        <button type="submit" class="btn"><i class="fas fa-user-plus"></i> Create Account</button>
    </form>

    <div class="extra">
        Already have an account? <a href="login.jsp">Sign In</a>
    </div>
</div>

<div id="snackbar"></div>

<script>
const pwd = document.getElementById("password");
const bar = document.getElementById("strengthBar");
const snackbar = document.getElementById("snackbar");

pwd.addEventListener("input", () => {
    const val = pwd.value;
    let strength = 0;
    if (val.length >= 8) strength++;
    if (/[A-Z]/.test(val)) strength++;
    if (/[0-9]/.test(val)) strength++;
    if (/[^A-Za-z0-9]/.test(val)) strength++;

    bar.className = "strength-bar";
    if (strength <= 1) bar.classList.add("weak");
    else if (strength === 2) bar.classList.add("medium");
    else bar.classList.add("strong");
});

function showSnackbar(message) {
    snackbar.textContent = message;
    snackbar.className = "show";
    setTimeout(function(){ snackbar.className = snackbar.className.replace("show", ""); }, 3000);
}

// Show error if passed as parameter
<% String error = request.getParameter("error"); if(error != null){ %>
    window.onload = function() {
        showSnackbar('<%= error %>');
    };
<% } %>
</script>

</body>
</html>
