<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
error_reporting(0);
header("Content-Type: application/json; charset=UTF-8");
include "db.php";

//  lấy tất cả lịch
$sql = "SELECT * FROM appointments ORDER BY id DESC";
$result = mysqli_query($conn, $sql);

$data = [];

if ($result) {
    while ($row = mysqli_fetch_assoc($result)) {
        $data[] = $row;
    }
}

//  trả JSON luôn (KHÔNG warning)
echo json_encode($data);
?>