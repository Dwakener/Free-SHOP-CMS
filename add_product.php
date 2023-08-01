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

    // Подготавливаем SQL-запрос для добавления нового товара
    $stmt = $pdo->prepare("INSERT INTO products (name, description, price, image_url) VALUES (:name, :description, :price, :image_url)");
    $stmt->bindParam(':name', $productName);
    $stmt->bindParam(':description', $productDescription);
    $stmt->bindParam(':price', $productPrice);
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
