<?php
$conn = mysqli_connect("localhost", "root", "", "medical_app");

if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}

//  FIX JSON tiếng Việt
mysqli_set_charset($conn, "utf8");
?>