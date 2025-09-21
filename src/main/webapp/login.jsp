<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Parrot Keep</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link rel="icon" href="https://img.icons8.com/ios-filled/50/4CAF50/feather.png" type="image/png">
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #121212; /* black background */
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            color: #fff;
        }
        .login-box {
            background: #1e1e1e; /* dark card */
            padding: 2rem;
            border-radius: 12px;
            width: 100%;
            max-width: 380px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.6);
            text-align: center;
        }
        .logo {
            font-size: 1.6rem;
            font-weight: bold;
            margin-bottom: 1.8rem;
            display: flex;
            justify-content: center;
            align-items: center;
            gap: .6rem;
            color: #4CAF50; /* parrot green */
        }
        .logo i {
            color: #4CAF50;
        }
        input {
            width: 100%;
            padding: .9rem;
            margin: .7rem 0;
            border: 1px solid #333;
            border-radius: 6px;
            font-size: 1rem;
            background: #121212;
            color: #fff;
            outline: none;
            transition: border .3s;
        }
        input:focus {
            border: 1px solid #4CAF50;
        }
        button {
            width: 100%;
            padding: .9rem;
            margin-top: 1rem;
            background: #4CAF50;
            border: none;
            color: #fff;
            font-size: 1rem;
            font-weight: bold;
            border-radius: 6px;
            cursor: pointer;
            transition: background .3s;
        }
        button:hover {
            background: #2E7D32; /* darker green */
        }
        .extra {
            margin-top: 1rem;
            font-size: 0.9rem;
            color: #ccc;
        }
        .extra a {
            color: #4CAF50;
            text-decoration: none;
            font-weight: bold;
        }
        .extra a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="login-box">
    <div class="logo"><i class="fas fa-feather-alt"></i> Parrot Keep</div>
    <form action="LoginServlet" method="post">
        <input type="text" name="username" placeholder="Username" required>
        <input type="password" name="password" placeholder="Password" required>
        <button type="submit"><i class="fas fa-sign-in-alt"></i> Sign In</button>
    </form>
    <div class="extra">
        Don't have an account? <a href="register.jsp">Register</a>
    </div>
</div>

</body>
</html>
