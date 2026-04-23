class DoctorData {
  static List<Map<String, dynamic>> doctors = [
    // ❤️ TIM MẠCH
    {
      "name": "BS Nguyễn Văn A",
      "specialty": "Tim mạch",
      "hospital": "BV Bạch Mai",
      "phone": "0123",
      "address": "Hà Nội",
      "rating": 4.5,
      "experience": "10 năm kinh nghiệm",
      "description":
          "Chuyên điều trị bệnh tim mạch, tăng huyết áp, suy tim.",
      "image": "https://randomuser.me/api/portraits/men/1.jpg"
    },
    {
      "name": "BS Lê Văn C",
      "specialty": "Tim mạch",
      "hospital": "BV 108",
      "phone": "0124",
      "address": "Hà Nội",
      "rating": 4.2,
      "experience": "8 năm kinh nghiệm",
      "description":
          "Chuyên khám và điều trị bệnh tim, tư vấn phòng ngừa đột quỵ.",
      "image": "https://randomuser.me/api/portraits/men/3.jpg"
    },

    // 🌿 DA LIỄU
    {
      "name": "BS Trần Thị B",
      "specialty": "Da liễu",
      "hospital": "BV Da Liễu TW",
      "phone": "0456",
      "address": "TP.HCM",
      "rating": 4.6,
      "experience": "9 năm kinh nghiệm",
      "description":
          "Chuyên điều trị mụn, nám, viêm da và các bệnh da liễu.",
      "image": "https://randomuser.me/api/portraits/women/2.jpg"
    },
    {
      "name": "BS Phạm Thị D",
      "specialty": "Da liễu",
      "hospital": "BV Da Liễu TP.HCM",
      "phone": "0457",
      "address": "TP.HCM",
      "rating": 4.3,
      "experience": "7 năm kinh nghiệm",
      "description":
          "Chuyên chăm sóc da, điều trị dị ứng và bệnh da mãn tính.",
      "image": "https://randomuser.me/api/portraits/women/5.jpg"
    },

    // 🧠 THẦN KINH
    {
      "name": "BS Hoàng Văn E",
      "specialty": "Thần kinh",
      "hospital": "BV Việt Đức",
      "phone": "0789",
      "address": "Hà Nội",
      "rating": 4.7,
      "experience": "12 năm kinh nghiệm",
      "description":
          "Chuyên điều trị đau đầu, đột quỵ và các bệnh thần kinh.",
      "image": "https://randomuser.me/api/portraits/men/6.jpg"
    },
    {
      "name": "BS Nguyễn Thị F",
      "specialty": "Thần kinh",
      "hospital": "BV Chợ Rẫy",
      "phone": "0790",
      "address": "TP.HCM",
      "rating": 4.4,
      "experience": "10 năm kinh nghiệm",
      "description":
          "Chuyên khám và điều trị các rối loạn thần kinh.",
      "image": "https://randomuser.me/api/portraits/women/7.jpg"
    },

    // 🦷 RĂNG HÀM MẶT
    {
      "name": "BS Đỗ Văn G",
      "specialty": "Răng hàm mặt",
      "hospital": "BV Răng Hàm Mặt",
      "phone": "0888",
      "address": "Đà Nẵng",
      "rating": 4.1,
      "experience": "6 năm kinh nghiệm",
      "description":
          "Chuyên nhổ răng, trồng răng và điều trị nha khoa.",
      "image": "https://randomuser.me/api/portraits/men/8.jpg"
    },

    // 👂 TAI MŨI HỌNG
    {
      "name": "BS Lý Thị H",
      "specialty": "Tai mũi họng",
      "hospital": "BV Tai Mũi Họng",
      "phone": "0999",
      "address": "Hà Nội",
      "rating": 4.3,
      "experience": "8 năm kinh nghiệm",
      "description":
          "Chuyên điều trị viêm xoang, viêm họng và bệnh tai.",
      "image": "https://randomuser.me/api/portraits/women/9.jpg"
    },

    // 👶 NHI KHOA
    {
      "name": "BS Trần Văn I",
      "specialty": "Nhi khoa",
      "hospital": "BV Nhi Đồng",
      "phone": "0111",
      "address": "TP.HCM",
      "rating": 4.8,
      "experience": "11 năm kinh nghiệm",
      "description":
          "Chuyên khám và điều trị bệnh cho trẻ em.",
      "image": "https://randomuser.me/api/portraits/men/10.jpg"
    },

    // 👁️ MẮT
    {
      "name": "BS Nguyễn Thị K",
      "specialty": "Mắt",
      "hospital": "BV Mắt TW",
      "phone": "0222",
      "address": "Hà Nội",
      "rating": 4.6,
      "experience": "9 năm kinh nghiệm",
      "description":
          "Chuyên điều trị cận thị, viễn thị và các bệnh về mắt.",
      "image": "https://randomuser.me/api/portraits/women/11.jpg"
    },

    // 🦴 XƯƠNG KHỚP
    {
      "name": "BS Phạm Văn L",
      "specialty": "Xương khớp",
      "hospital": "BV Chấn Thương Chỉnh Hình",
      "phone": "0333",
      "address": "Đà Nẵng",
      "rating": 4.2,
      "experience": "10 năm kinh nghiệm",
      "description":
          "Chuyên điều trị đau khớp, thoái hóa xương.",
      "image": "https://randomuser.me/api/portraits/men/12.jpg"
    },

    // 🍽️ TIÊU HÓA
    {
      "name": "BS Đặng Thị M",
      "specialty": "Tiêu hóa",
      "hospital": "BV Đại học Y",
      "phone": "0444",
      "address": "TP.HCM",
      "rating": 4.5,
      "experience": "8 năm kinh nghiệm",
      "description":
          "Chuyên điều trị bệnh dạ dày, gan và tiêu hóa.",
      "image": "https://randomuser.me/api/portraits/women/13.jpg"
    },
  ];
}