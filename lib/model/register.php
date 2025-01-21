<?php
// Database connection
$db = mysqli_connect('localhost', 'root', '', 'peart');
if (!$db) {
    die(json_encode(["status" => "error", "message" => "Database connection failed"]));
}

// Create users table if not exists
$sql = "CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)";
mysqli_query($db, $sql);

// Capture input
$username = mysqli_real_escape_string($db, $_POST['username']);
$email = mysqli_real_escape_string($db, $_POST['email']);
$password = $_POST['password'];

// Check if username or email exists
$query = "SELECT * FROM users WHERE username = '$username' OR email = '$email'";
$result = mysqli_query($db, $query);
if (mysqli_num_rows($result) > 0) {
    echo json_encode(["status" => "error", "message" => "Username or email already exists"]);
    exit();
}

// Hash password and insert user
$hashed_password = password_hash($password, PASSWORD_BCRYPT);
$insert = "INSERT INTO users(username, email, password) VALUES ('$username', '$email', '$hashed_password')";
if (mysqli_query($db, $insert)) {
    // Return user ID for further use in the app
    $userId = mysqli_insert_id($db);
    echo json_encode(["status" => "success", "message" => "User registered successfully", "user_id" => $userId]);
} else {
    echo json_encode(["status" => "error", "message" => "Registration failed: " . mysqli_error($db)]);
}
mysqli_close($db);
?>
