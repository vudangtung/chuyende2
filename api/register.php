<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");
header("Access-Control-Allow-Headers: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
include "db.php";

$name = $_POST['name'] ?? '';
$email = $_POST['email'] ?? '';
$password = $_POST['password'] ?? '';
$role = $_POST['role'] ?? 'user';
$doctor_id = $_POST['doctor_id'] ?? null;

// check trống
if($name == '' || $email == '' || $password == ''){
  echo json_encode([
    "success"=>false,
    "message"=>"Thiếu dữ liệu"
  ]);
  exit();
}

// check email tồn tại
$check = mysqli_query($conn, "SELECT * FROM users WHERE email='$email'");
if(mysqli_num_rows($check) > 0){
  echo json_encode([
    "success"=>false,
    "message"=>"Email đã tồn tại"
  ]);
  exit();
}

// insert
mysqli_query($conn,
"INSERT INTO users(name,email,password,role,doctor_id)
VALUES('$name','$email','$password','$role','$doctor_id')");

echo json_encode([
  "success"=>true
]);
?>