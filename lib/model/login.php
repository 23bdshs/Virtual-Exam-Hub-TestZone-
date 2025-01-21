<?php
// Database connection
$db = mysqli_connect('localhost', 'root', '', 'peart');

if (!$db) {
    echo json_encode(["status" => "error", "message" => "Database connection failed"]);
    exit();
}


$username = isset($_POST['username']) ? $_POST['username'] : null;
$password = isset($_POST['password']) ? $_POST['password'] : null;


$sql = "SELECT * FROM users WHERE username = ?";
$stmt = mysqli_prepare($db, $sql);
mysqli_stmt_bind_param($stmt, "s", $username);
mysqli_stmt_execute($stmt);
$result = mysqli_stmt_get_result($stmt);


if ($row = mysqli_fetch_assoc($result)) {

    if (password_verify($password, $row['password'])) {
        echo json_encode(["status" => "success", "message" => "Login successful"]);
    } else {
        echo json_encode(["status" => "error", "message" => "Invalid password"]);
    }
} else {
    echo json_encode(["status" => "error", "message" => "Username not found"]);
}

mysqli_stmt_close($stmt);
mysqli_close($db);
?>