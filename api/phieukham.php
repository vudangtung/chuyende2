<?php
require_once '/xampp/htdocs/chuyende2/admin/model/database.php';
require_once '/xampp/htdocs/chuyende2/admin/model/phieukham.php';

class PhieukhamController
{
    public $db;
    public $phieukham;

    public function __construct()
    {
        $database = new Database();
        $this->db = $database->ketnoi();
        $this->phieukham = new Phieukham($this->db);
    }
    public function DSPK(){
        $kq = $this->phieukham->layDSPK();
        require_once "/xampp/htdocs/chuyende2/admin/view/phieukham/index.php";
    }

    public function themPK($thoigian,$hoten,$email,$sdt,$chuyenkhoa,$bacsi,$dichvu,$mota){
        $kq = $this->phieukham->themPK($thoigian,$hoten,$email,$sdt,$chuyenkhoa,$bacsi,$dichvu,$mota);
        echo "<script>
        alert('Cảm ơn bạn đã gửi thông tin!');
        window.location.href = '/chuyende2/index.php'; 
        </script>";
    }

    public function xoaPK($maphieu){
        $kq = $this->phieukham->xoaPK($maphieu);
        echo "Xóa phiếu thành công";
    }
}

?>
