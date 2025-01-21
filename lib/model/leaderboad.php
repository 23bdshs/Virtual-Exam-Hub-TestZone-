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

// Query to get all users and their scores
$query = "SELECT username, email, scores FROM users";
$result = mysqli_query($db, $query);

$scoresList = [];

// Loop through each user to find their highest score
while ($user = mysqli_fetch_assoc($result)) {
    // Decode scores from JSON format
    $scores = json_decode($user['scores'], true);
    
    // Find the maximum score for the current user
    if (!empty($scores)) {
        $maxScoreForUser = max($scores);
        // Store the username, email, and highest score in an array
        $scoresList[] = [
            'username' => $user['username'],
            'email' => $user['email'],
            'highestScore' => $maxScoreForUser
        ];
    }
}

// Sort scoresList by highestScore in descending order
usort($scoresList, function($a, $b) {
    return $b['highestScore'] <=> $a['highestScore'];
});

// Return the sorted result as JSON
if (!empty($scoresList)) {
    echo json_encode([
        "status" => "success",
        "data" => $scoresList
    ]);
} else {
    echo json_encode([
        "status" => "error",
        "message" => "No scores found"
    ]);
}

// Close the database connection
mysqli_close($db);
