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
    $email = $_POST["email"];
    $password = $_POST["password"];

    // Получаем хеш пароля из базы данных на основе переданного email
    $stmt = $pdo->prepare("SELECT password_hash FROM customers WHERE email = :email");
    $stmt->bindParam(':email', $email);
    $stmt->execute();
    $result = $stmt->fetch(PDO::FETCH_ASSOC);

    // Проверяем, есть ли пользователь с указанным email и сравниваем хеш пароля
    if ($result && password_verify($password, $result['password_hash'])) {
        // Если пароль совпадает, значит пользователь авторизован
        // Здесь вы можете выполнить дополнительные действия для авторизованного пользователя
        // Например, установить сессию или перенаправить на другую страницу
        header("Location: welcome.php");
        exit;
    } else {
        // Если пароль не совпадает или пользователя с таким email не существует
        // Вы можете перенаправить обратно на страницу входа с сообщением об ошибке
        header("Location: index.php?error=" . urlencode('Authentication error')); // Здесь мы отправляем просто текст ошибки "Authentication error"
        exit;
    }
}
?>
