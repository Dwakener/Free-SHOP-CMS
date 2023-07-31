<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile Page</title>
    <link rel="stylesheet" href="styles.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.18/dist/sweetalert2.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.18/dist/sweetalert2.min.css">
    <style>
        /* Styles for the header */
        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #007bff;
            color: #fff;
            padding: 10px;
        }
        
        .search-bar {
            margin-top: 10px;
        }
        
        .search-bar input[type="text"],
        .search-bar button {
            font-size: 16px;
            padding: 5px 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
    </style>
</head>
<body>
    <header>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <div class="search-bar">
            <input type="text" placeholder="Search...">
            <button>Search</button>
        </div>
        <nav>
            <ul>
			    <li><a href="#"><i class="fas fa-shopping-cart"></i> Cart</a></li>
                <li><a href="#"><i class="fas fa-home"></i> Home</a></li>
				<li><a href="#"><i class="fas fa-box"></i> Products</a></li>
				<li><a href="#"><i class="fas fa-user"></i> Profile</a></li>
                <!-- Add more navigation links here -->
            </ul>
        </nav>
    </header>

	<div class="main-content">
		<div class="product-list">
			<?php
			$config = parse_ini_file('config.ini');
			// Connect to the database and fetch products from the table
			// Modify the connection settings according to your database configuration
			$pdo = new PDO("pgsql:host=" . $config['host'] . ";dbname=" . $config['dbname'], $config['username'], $config['password']);
			$stmt = $pdo->query("SELECT * FROM products");

			// Loop through the products and display them in the product-list
			while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
				echo '<div class="product">';
				// Display the product image using an <img> tag
				echo '<img src="' . $row['image_url'] . '" alt="' . $row['name'] . '">'; // Assuming the image URL is stored in the "image_url" column
				echo '<h3>' . $row['name'] . '</h3>';
				echo '<p>' . $row['description'] . '</p>';
				echo '</div>';
			}
			?>
		</div>

		<div class="buttons-container">
			<!-- Buttons will be dynamically generated here -->
			<button>Button 1</button>
			<!-- Add more buttons here -->
		</div>
	</div>


    <footer>
        <!-- Footer content goes here -->
    </footer>
</body>
</html>
