<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Content-Type: application/json");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

include "db.php";

$id = $_POST['id'];

mysqli_query($conn,
"UPDATE appointments SET status='cancelled' WHERE id='$id'");

echo json_encode(["success"=>true]);
?>