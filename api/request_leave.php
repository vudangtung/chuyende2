<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");

include "db.php";

$name = $_POST['doctor_name'];
$date = $_POST['date'];
$reason = $_POST['reason'];

mysqli_query($conn,
"INSERT INTO doctor_leaves(doctor_name, date, reason)
VALUES('$name','$date','$reason')");

echo json_encode(["success"=>true]);
?>