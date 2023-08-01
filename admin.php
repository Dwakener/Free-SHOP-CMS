<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.2">
    <title>Admin Panel</title>
    <style>
        /* Add your CSS styles here */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        .sidebar {
            background-color: #333;
            color: #fff;
            padding: 20px;
            width: 200px;
            height: 100%;
            position: fixed;
        }

        .sidebar h1 {
            margin-bottom: 20px;
        }

        .sidebar ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .sidebar li {
            margin-bottom: 10px;
        }

        .sidebar a {
            color: #fff;
            text-decoration: none;
            display: block;
            padding: 5px;
            transition: background-color 0.2s;
        }

        .sidebar a:hover {
            background-color: #555;
        }

        .content {
            margin-left: 220px;
            padding: 20px;
        }

        .content h2 {
            margin-bottom: 20px;
        }
    </style>
	<script>
        function loadProductPanel() {
            var xhr = new XMLHttpRequest();
            xhr.open('GET', 'add_product_panel.php', true);
            xhr.onreadystatechange = function() {
                if (xhr.readyState == 4 && xhr.status == 200) {
                    document.getElementById('productPanel').innerHTML = xhr.responseText;
                }
            };
            xhr.send();
        }
    </script>
	<link rel="stylesheet" type="text/css" href="addpoductstyles.css">
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <h1>Admin Panel</h1>
        <ul>
            <li><a href="#dashboard">Dashboard</a></li>
            <li><a href="#" onclick="loadProductPanel()">Products</a></li>
            <li><a href="#orders">Orders</a></li>
            <!-- Add more navigation links here -->
        </ul>
    </div>

	<!-- Content -->
    <div class="content">
        <h2>Welcome, Admin!</h2>
        <!-- Add your admin panel content here -->
        <form action="add_product.php" method="post" style="margin-bottom: 10px;">
            <!-- Форма для добавления продукта -->
        </form>
    </div>

    <!-- Вставляем содержимое add_product_panel.php -->
    <div id="productPanel"></div>

    <!-- Add your JavaScript code here (if needed) -->
    <script>
        // Example JavaScript code (if needed)
    </script>
</body>
</html>
