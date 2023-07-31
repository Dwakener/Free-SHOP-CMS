<?php
// Check if the request method is POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Get the user ID and product ID from the form data
    $user_id = $_POST['user_id'];
    $product_id = $_POST['product_id'];
    $quantity = $_POST['quantity']; // The quantity to add to the cart
    
    // Replace the following lines with your database connection code
    $config = parse_ini_file('config.ini');
    $pdo = new PDO("pgsql:host=" . $config['host'] . ";dbname=" . $config['dbname'], $config['username'], $config['password']);
    
    // Check if the product is already in the cart for the user
    $stmt = $pdo->prepare("SELECT * FROM shopping_cart WHERE user_id = :user_id AND product_id = :product_id");
    $stmt->bindParam(':user_id', $user_id);
    $stmt->bindParam(':product_id', $product_id);
    $stmt->execute();
    $cart_item = $stmt->fetch(PDO::FETCH_ASSOC);
    
    if ($cart_item) {
        // If the product is already in the cart, update the quantity
        $new_quantity = $cart_item['quantity'] + $quantity;
        $stmt = $pdo->prepare("UPDATE shopping_cart SET quantity = :quantity WHERE user_id = :user_id AND product_id = :product_id");
        $stmt->bindParam(':quantity', $new_quantity);
        $stmt->bindParam(':user_id', $user_id);
        $stmt->bindParam(':product_id', $product_id);
        $stmt->execute();
    } else {
        // If the product is not in the cart, insert a new row
        $stmt = $pdo->prepare("INSERT INTO shopping_cart (user_id, product_id, quantity) VALUES (:user_id, :product_id, :quantity)");
        $stmt->bindParam(':user_id', $user_id);
        $stmt->bindParam(':product_id', $product_id);
        $stmt->bindParam(':quantity', $quantity);
        $stmt->execute();
    }

    // Return the updated quantity in the response (for displaying in the success message)
    $response = array('quantity' => $quantity);
    echo json_encode($response);
}
?>
