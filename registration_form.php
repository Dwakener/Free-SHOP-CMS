<!DOCTYPE html>
<html>
<head>
    <title>Online Store - Registration</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .registration-container {
            width: 300px;
            border: 1px solid #ccc;
            padding: 20px;
            text-align: center;
        }

        .registration-container label {
            display: block;
            text-align: left;
            margin-bottom: 5px;
        }

        .registration-container input[type="text"],
        .registration-container input[type="email"],
        .registration-container input[type="password"] {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .registration-container input[type="submit"] {
            width: 100%;
            background-color: #4CAF50;
            color: #fff;
            padding: 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .registration-container p {
            margin-top: 15px;
        }

        .registration-container p a {
            color: #4CAF50;
        }
    </style>
</head>
<body>
    <div class="registration-container">
        <h1>Register as a New Customer</h1>
        <form action="register_customer.php" method="post">
            <label for="first_name">First Name:</label>
            <input type="text" id="first_name" name="first_name" required>

            <label for="last_name">Last Name:</label>
            <input type="text" id="last_name" name="last_name" required>

            <label for="delivery_address">Delivery Address:</label>
            <input type="text" id="delivery_address" name="delivery_address" required>

            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>

            <label for="phone_number">Phone Number:</label>
            <input type="text" id="phone_number" name="phone_number" required>

            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>

            <input type="submit" value="Register">
        </form>
        <p>Already have an account? <a href="login.php">Login here</a></p>
    </div>
</body>
</html>
