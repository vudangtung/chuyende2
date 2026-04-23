<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");
include "db.php";

$doctor_id = $_GET['doctor_id'] ?? '';
$date = $_GET['date'] ?? '';

$result = mysqli_query($conn,
"SELECT time FROM appointments 
 WHERE doctor_id='$doctor_id' 
 AND date='$date'
 AND status != 'cancelled'"
);

$data = [];

while($row = mysqli_fetch_assoc($result)){
    $data[] = $row["time"];
}

echo json_encode($data);
?>