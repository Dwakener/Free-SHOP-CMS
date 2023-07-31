<?php
// Check if the user_id is set in the session
if (isset($_SESSION['user_id'])) {
    // Get the user_id from the session and store it in a PHP variable
    $currentUserId = $_SESSION['user_id'];
} else {
    // If user_id is not set in the session, you can handle this case accordingly (e.g., redirect to login page)
    // For now, let's assume a default value of 0 if the user is not logged in
    $currentUserId = 0;
}
?>

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
        
        .search-bar input[type="text"] {
		/* Add your desired styles here */
		width: 500px;
		height: 25px;
		padding: 5px;
		border: 1px solid #ccc;
		border-radius: 5px;
		font-size: 14px;
		left: 500px; 
		}
		.search-bar, .product-list {
		margin-left: 20px; /* Adjust the value as needed */
		}
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
		session_start(); // Добавляем эту строку, чтобы инициализировать сессию

		$currentUserId = $_SESSION['user_id'];

		$config = parse_ini_file('config.ini');
		$pdo = new PDO("pgsql:host=" . $config['host'] . ";dbname=" . $config['dbname'], $config['username'], $config['password']);
		$stmt = $pdo->query("SELECT * FROM products");

		while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
			echo '<div class="product">';
			echo '<img src="' . $row['image_url'] . '" alt="' . $row['name'] . '">';
			echo '<h3>' . $row['name'] . '</h3>';
			echo '<p>' . $row['description'] . '</p>';
			echo '<button class="add-to-cart-btn" data-product-id="' . $row['id'] . '">Add to Cart</button>';
    
			// Display the current quantity of the product in the shopping cart (if any)
			$cartItemStmt = $pdo->prepare("SELECT quantity FROM shopping_cart WHERE user_id = :user_id AND product_id = :product_id");
			$cartItemStmt->bindParam(':user_id', $currentUserId);
			$cartItemStmt->bindParam(':product_id', $row['id']);
			$cartItemStmt->execute();
			$cartItem = $cartItemStmt->fetch(PDO::FETCH_ASSOC);
    
			if ($cartItem) {
				echo '<span>Quantity in Cart: ' . $cartItem['quantity'] . '</span>';
			}
    
			echo '</div>';
		}
	?>

    </div>
	</div>

	<!-- SweetAlert2 library -->
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.18/dist/sweetalert2.all.min.js"></script>

	<script>
    // JavaScript for handling the "Add to Cart" button click
    const addToCartButtons = document.querySelectorAll('.add-to-cart-btn');

    addToCartButtons.forEach(button => {
        button.addEventListener('click', function() {
            const productId = button.dataset.productId;
            // Assuming you have the current user ID stored in a variable called "currentUserId"
            const userId = <?php echo json_encode($currentUserId); ?>;
            const quantity = 1; // For demonstration purposes, we add 1 quantity to the cart
            
            // Insert the cart item into the shopping_cart table
            const formData = new FormData();
            formData.append('user_id', userId);
            formData.append('product_id', productId);
            formData.append('quantity', quantity);
            
            fetch('add_to_cart.php', {
                method: 'POST',
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                // Handle the response using SweetAlert2
                Swal.fire({
                    icon: 'success',
                    title: 'Product added to cart!',
                    text: 'Quantity: ' + data.quantity,
                    confirmButtonText: 'OK'
                }).then(() => {
                    // Optionally, you can redirect the user to the cart page or update the cart icon
                    // window.location.href = 'cart.php';
                });
            })
            .catch(error => {
                // Handle the error using SweetAlert2
                Swal.fire({
                    icon: 'error',
                    title: 'Error adding product to cart',
                    text: 'An error occurred while adding the product to the cart.',
                    confirmButtonText: 'OK'
                });
                console.error('Error adding product to cart:', error);
            });
        });
    });
	</script>

</body>
</html>
