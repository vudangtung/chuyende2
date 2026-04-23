<?php
header("Content-Type: application/json");
include "db.php";

$doctor_id = $_GET['doctor_id'] ?? '';

$result = mysqli_query($conn,
"SELECT * FROM medical_records WHERE doctor_id='$doctor_id' ORDER BY id DESC"
);

$data = [];

while($row = mysqli_fetch_assoc($result)){
    $data[] = $row;
}

echo json_encode($data);
?>