<?php
// Подключение к базе данных PostgreSQL с использованием PDO
$config = parse_ini_file('config.ini');
try {
    $pdo = new PDO("pgsql:host=" . $config['host'] . ";dbname=" . $config['dbname'], $config['username'], $config['password']);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die("Error connecting to the database: " . $e->getMessage());
}

// Получение данных обратной связи из POST-запроса
$data = json_decode(file_get_contents('php://input'), true);

// Вставка данных в таблицу "feedback"
try {
    $stmt = $pdo->prepare("INSERT INTO feedback (name, email, message) VALUES (:name, :email, :message)");
    $stmt->bindParam(':name', $data['name']);
    $stmt->bindParam(':email', $data['email']);
    $stmt->bindParam(':message', $data['message']);
    $stmt->execute();

    // Ответ клиенту об успешной вставке данных
    http_response_code(200);
} catch (PDOException $e) {
    // Ответ клиенту об ошибке
    http_response_code(500);
}
?>
