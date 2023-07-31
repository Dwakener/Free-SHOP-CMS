<?php
if (isset($_GET['registration']) && $_GET['registration'] === 'success') {
    // JavaScript-код для показа SweetAlert2 всплывающего окна с сообщением об успешной регистрации
    echo "<script>
        Swal.fire({
            icon: 'success',
            title: 'Registration successful!',
            text: 'Your registration was successful.',
            confirmButtonText: 'OK'
        }).then(() => {
            window.location.href = 'index.php';
        });
    </script>";
}

if (isset($_GET['error'])) {
    // JavaScript-код для показа SweetAlert2 всплывающего окна с сообщением об ошибке
    echo "<script>
        Swal.fire({
            icon: 'error',
            title: 'Error:',
            text: '".addslashes($_GET['error'])."', // Используем addslashes для экранирования текста ошибки
            confirmButtonText: 'OK'
        }).then(() => {
            window.location.href = 'index.php';
        });
    </script>";
}
?>


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
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.18/dist/sweetalert2.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.18/dist/sweetalert2.min.css">
	<style>
        /* Стили для разворачивающегося виджета */
        #feedback-widget {
            position: fixed;
            bottom: 20px;
            right: 20px;
            width: 60px;
            height: 60px;
            background-color: #007bff;
            border-radius: 50%;
            color: #fff;
            text-align: center;
            line-height: 60px;
            cursor: pointer;
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
	<div id="feedback-widget">✉️</div>
	
	<script>
    // Открыть форму обратной связи при нажатии на виджет
    document.getElementById('feedback-widget').addEventListener('click', function() {
        Swal.fire({
            title: 'Feedback',
            html:
                '<input id="swal-input1" class="swal2-input" placeholder="Name">' +
                '<input id="swal-input2" class="swal2-input" placeholder="Email">' +
                '<textarea id="swal-input3" class="swal2-textarea" placeholder="Message"></textarea>',
            confirmButtonText: 'Send',
            preConfirm: function () {
                return new Promise(function (resolve) {
                    var name = document.getElementById('swal-input1').value;
                    var email = document.getElementById('swal-input2').value;
                    var message = document.getElementById('swal-input3').value;
                    resolve({ name: name, email: email, message: message });
                });
            }
        }).then(function (result) {
            // Отправка данных обратной связи на сервер (здесь вызовите PHP-скрипт для добавления данных в базу)
            // Пример отправки данных через fetch API
            if (result.value) {
                fetch('feedback.php', {
                    method: 'POST',
                    body: JSON.stringify(result.value),
                    headers: {
                        'Content-Type': 'application/json'
                    }
                })
                .then(function(response) {
                    if (response.ok) {
                        Swal.fire('Thank you!', 'Your feedback has been submitted.', 'success');
                    } else {
                        Swal.fire('Error!', 'An error occurred while submitting feedback.', 'error');
                    }
                })
                .catch(function(error) {
                    Swal.fire('Error!', 'An error occurred while submitting feedback.', 'error');
                });
            }
        });

        // Предотвращение отправки формы при нажатии на кнопку "Send"
        // (предотвращение действия по умолчанию)
        event.preventDefault();
    });
	</script>
</body>
</html>
