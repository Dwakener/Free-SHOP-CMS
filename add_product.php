<?php
// Чтение настроек подключения из config.ini
$config = parse_ini_file('config.ini');
// Подключение к базе данных PostgreSQL с использованием PDO
try {
    $pdo = new PDO("pgsql:host=" . $config['host'] . ";dbname=" . $config['dbname'], $config['username'], $config['password']);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die("Error connecting to the database: " . $e->getMessage());
}

// Проверяем, что форма была отправлена методом POST
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Получаем данные из формы
    $productName = $_POST["product_name"];
    $productDescription = $_POST["product_description"];
    $productPrice = $_POST["product_price"];
    $imageUrl = $_POST["image_url"];
    $categoryID = $_POST["category_id"];
    $brand = $_POST["brand"];
    $weight = $_POST["weight"];
    $color = $_POST["color"];
    $material = $_POST["material"];
    $stockQuantity = $_POST["stock_quantity"];
    $isAvailable = isset($_POST["is_available"]) ? 1 : 0; // Преобразуем чекбокс в 0 или 1
    $createdAt = $_POST["created_at"];

    // Подготавливаем SQL-запрос для добавления нового товара
    $stmt = $pdo->prepare("INSERT INTO products (name, description, price, category_id, brand, weight, color, material, stock_quantity, is_available, created_at, image_url) VALUES (:name, :description, :price, :category_id, :brand, :weight, :color, :material, :stock_quantity, :is_available, :created_at, :image_url)");
    $stmt->bindParam(':name', $productName);
    $stmt->bindParam(':description', $productDescription);
    $stmt->bindParam(':price', $productPrice);
    $stmt->bindParam(':category_id', $categoryID);
    $stmt->bindParam(':brand', $brand);
    $stmt->bindParam(':weight', $weight);
    $stmt->bindParam(':color', $color);
    $stmt->bindParam(':material', $material);
    $stmt->bindParam(':stock_quantity', $stockQuantity);
    $stmt->bindParam(':is_available', $isAvailable, PDO::PARAM_INT);
    $stmt->bindParam(':created_at', $createdAt);
    $stmt->bindParam(':image_url', $imageUrl);

    // Выполняем запрос
    try {
        $stmt->execute();
        // Если товар успешно добавлен, перенаправляем обратно на страницу админ-панели
        header("Location: admin.php");
        exit;
    } catch (PDOException $e) {
        // Если возникла ошибка при добавлении товара, перенаправляем с сообщением об ошибке
        header("Location: admin.php?error=" . urlencode('Error adding product'));
        exit;
    }
}
?>
