<?php
header("Content-Type: application/json");
include "db.php";

$appointment_id = $_POST['appointment_id'] ?? '';
$doctor_id = $_POST['doctor_id'] ?? '';
$patient = $_POST['patient_name'] ?? '';
$diagnosis = $_POST['diagnosis'] ?? '';
$prescription = $_POST['prescription'] ?? '';
$note = $_POST['note'] ?? '';

if ($appointment_id == '') {
    echo json_encode(["success"=>false]);
    exit();
}

$sql = "INSERT INTO medical_records
(appointment_id, doctor_id, patient_name, diagnosis, prescription, note)
VALUES
('$appointment_id','$doctor_id','$patient','$diagnosis','$prescription','$note')";

if (mysqli_query($conn,$sql)) {
    echo json_encode(["success"=>true]);
} else {
    echo json_encode(["success"=>false]);
}
?>