<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <h1>Admin Panel</h1>
        <ul>
            <li><a href="#dashboard">Dashboard</a></li>
            <li><a href="#products">Products</a></li>
            <li><a href="#orders">Orders</a></li>
            <!-- Add more navigation links here -->
        </ul>
    </div>

    <!-- Content Area -->
    <div class="content">
        <h2>Welcome, Admin!</h2>
        <!-- Add your admin panel content here -->
        <form action="add_product.php" method="post">
            <label for="product_name">Product Name:</label>
            <input type="text" id="product_name" name="product_name" required><br>

            <label for="product_description">Product Description:</label>
            <textarea id="product_description" name="product_description" required></textarea><br>

            <label for="product_price">Product Price:</label>
            <input type="number" id="product_price" name="product_price" min="0.01" step="0.01" required><br>

            <label for="image_url">Image URL:</label>
            <input type="text" id="image_url" name="image_url" required><br>

            <input type="submit" value="Add Product">
        </form>
    </div>

    <!-- Add your JavaScript code here (if needed) -->
    <script>
        // Example JavaScript code (if needed)
    </script>
</body>
</html>
