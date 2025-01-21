<?php
// Database connection
$db = mysqli_connect('localhost', 'root', '', 'peart');
if (!$db) {
    die(json_encode(["status" => "error", "message" => "Database connection failed"]));
}

// Capture input and sanitize
$username = mysqli_real_escape_string($db, $_POST['username']);
$newScore = intval($_POST['new_score']); // Ensure the score is an integer

// Check if the user exists
$query = "SELECT * FROM users WHERE username = '$username'";
$result = mysqli_query($db, $query);

if (mysqli_num_rows($result) > 0) {
    // User exists, get current scores
    $user = mysqli_fetch_assoc($result);
    
    // Deserialize the current scores
    $currentScores = isset($user['scores']) && !empty($user['scores']) 
        ? json_decode($user['scores'], true) 
        : [];

    // Append the new score to the scores array
    $currentScores[] = $newScore;

    // Serialize the updated scores back to JSON format
    $updatedScores = json_encode($currentScores);

    // Update the scores back to the database
    $updateQuery = "UPDATE users SET scores = '$updatedScores' WHERE username = '$username'";
    
    if (mysqli_query($db, $updateQuery)) {
        echo json_encode(["status" => "success", "message" => "Scores updated successfully"]);
    } else {
        echo json_encode(["status" => "error", "message" => "Failed to update scores: " . mysqli_error($db)]);
    }
} else {
    echo json_encode(["status" => "error", "message" => "User not found"]);
}

// Close the database connection
mysqli_close($db);
?>
