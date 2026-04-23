<?php
header("Content-Type: application/json");
include "db.php";

$doctor_id = $_GET['doctor_id'] ?? '';
$date = $_GET['date'] ?? '';

$result = mysqli_query($conn,
"SELECT * FROM appointments 
 WHERE doctor_id='$doctor_id' 
 AND date='$date'"
);

$data = [];

while ($row = mysqli_fetch_assoc($result)) {
    $data[] = $row;
}

echo json_encode($data);
?>