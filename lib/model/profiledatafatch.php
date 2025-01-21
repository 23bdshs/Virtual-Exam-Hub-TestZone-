<?php
// Turn off error reporting
error_reporting(0);
ini_set('display_errors', 0);

// Set the content type to JSON
header('Content-Type: application/json');

// Database connection
$db = mysqli_connect('localhost', 'root', '', 'peart');
if (!$db) {
    die(json_encode(["status" => "error", "message" => "Database connection failed"]));
}

// Capture the username from the GET request
$username = mysqli_real_escape_string($db, $_GET['username']);

// Check if the user exists
$query = "SELECT * FROM users WHERE username = '$username'";
$result = mysqli_query($db, $query);

if (mysqli_num_rows($result) > 0) {
    // User exists, fetch the user data
    $user = mysqli_fetch_assoc($result);

    // Fetch the scores list
    $scores = isset($user['scores']) && !empty($user['scores']) 
        ? json_decode($user['scores'], true) 
        : [];

    // Return the user data (including the scores) as JSON
    echo json_encode(["status" => "success", "username" => $user['username'], "email" => $user['email'], "scores" => $scores]);
} else {
    echo json_encode(["status" => "error", "message" => "User not found"]);
}

// Close the database connection
mysqli_close($db);
