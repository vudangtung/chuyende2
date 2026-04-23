<?php
error_reporting(0);
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
include "db.php";

//  nhận dữ liệu từ Flutter
$doctor_id   = $_POST['doctor_id'] ?? '';
$doctor_name = $_POST['doctor_name'] ?? '';
$patient     = $_POST['patient_name'] ?? '';
$date        = $_POST['date'] ?? '';
$time        = $_POST['time'] ?? '';
$phone       = $_POST['phone'] ?? '';

//  check rỗng
if ($doctor_id == '' || $patient == '' || $date == '' || $time == '') {
    echo json_encode([
        "success" => false,
        "message" => "Thiếu dữ liệu"
    ]);
    exit();
}

//  chống trùng lịch
$sqlCheck = "SELECT id FROM appointments 
WHERE doctor_id='$doctor_id' 
AND date='$date' 
AND time='$time'";

$check = mysqli_query($conn, $sqlCheck);

if (!$check) {
    echo json_encode([
        "success" => false,
        "message" => mysqli_error($conn)
    ]);
    exit();
}

if (mysqli_num_rows($check) > 0) {
    echo json_encode([
        "success" => false,
        "message" => "Bác sĩ đã có lịch giờ này"
    ]);
    exit();
}

//  insert
$sql = "INSERT INTO appointments 
(doctor_id, doctor_name, patient_name, date, time, phone, status)
VALUES 
('$doctor_id', '$doctor_name', '$patient', '$date', '$time', '$phone', 'pending')";

if (mysqli_query($conn, $sql)) {
    echo json_encode([
        "success" => true,
        "message" => "Đặt lịch thành công"
    ]);
} else {
    echo json_encode([
        "success" => false,
        "message" => mysqli_error($conn)
    ]);
}
?>