<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Content-Type: application/json");

//  xử lý preflight (Flutter Web)
if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    http_response_code(200);
    exit();
}

include "db.php";

//  tránh undefined
$email = $_POST['email'] ?? '';
$password = $_POST['password'] ?? '';

//  validate
if ($email == '' || $password == '') {
    echo json_encode([
        "success" => false,
        "message" => "Thiếu email hoặc password"
    ]);
    exit();
}

//  query
$sql = "SELECT * FROM users WHERE email='$email' AND password='$password'";
$result = mysqli_query($conn, $sql);

if (!$result) {
    echo json_encode([
        "success" => false,
        "message" => "SQL Error",
        "error" => mysqli_error($conn)
    ]);
    exit();
}

//  nếu có user
if (mysqli_num_rows($result) > 0) {
    $row = mysqli_fetch_assoc($result);

    echo json_encode([
        "success" => true,
        "role" => $row['role'],
        "name" => $row['name'],
        "doctor_id" => $row['doctor_id'] ?? null,
        "user_id" => $row['id']
    ]);
} else {
    echo json_encode([
        "success" => false,
        "message" => "Sai tài khoản hoặc mật khẩu"
    ]);
}
?>