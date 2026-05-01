<?php
require_once '/xampp/htdocs/chuyende2/admin/model/database.php';
require_once '/xampp/htdocs/chuyende2/admin/model/lichtrinh.php';

class LichtrinhController
{
    public $db;
    public $lichtrinh;

    public function __construct()
    {
        $database = new Database();
        $this->db = $database->ketnoi();
        $this->lichtrinh = new Lichtrinh($this->db);
    }
    public function DSLT(){
        $kq = $this->lichtrinh->layDSLT();
        require_once "/xampp/htdocs/chuyende2/admin/view/lichtrinh/index.php";
    }
}

?>
