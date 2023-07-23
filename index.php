<!DOCTYPE html>
<html>
<head>
    <title>Online Store - Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .login-container {
            width: 300px;
            border: 1px solid #ccc;
            padding: 20px;
            text-align: center;
        }

        .login-container img {
            max-width: 150px;
            margin-bottom: 20px;
        }

        .login-container label {
            display: block;
            text-align: left;
            margin-bottom: 5px;
        }

        .login-container input[type="email"],
        .login-container input[type="password"] {
            width: 90%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .login-container input[type="submit"] {
            width: 90%;
            background-color: #4CAF50;
            color: #fff;
            padding: 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .login-container p {
            margin-top: 15px;
        }

        .login-container p a {
            color: #4CAF50;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <img src="path_to_your_logo.png" alt="Company Logo">
        <h1>Login to Your Account</h1>
        <form action="login_process.php" method="post">
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>

            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>

            <input type="submit" value="Login">
        </form>
        <p>Don't have an account? <a href="registration_form.php">Register here</a></p>
    </div>
</body>
</html>
