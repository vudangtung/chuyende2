<?php

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
include "db.php";

$name = $_GET['name'];

$result = mysqli_query($conn,
"SELECT * FROM appointments WHERE patient_name='$name'");

$data = [];

while($row = mysqli_fetch_assoc($result)){
  $data[] = $row;
}

echo json_encode($data);
?>