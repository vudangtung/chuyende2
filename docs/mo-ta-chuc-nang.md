# 📱 MÔ TẢ CHỨC NĂNG ỨNG DỤNG ĐẶT LỊCH KHÁM BỆNH (FLUTTER)

## 1. Giới thiệu
Ứng dụng đặt lịch khám bệnh được phát triển باستخدام Flutter giúp người dùng tìm kiếm bác sĩ, đặt lịch khám và quản lý thông tin y tế một cách nhanh chóng và tiện lợi trên thiết bị di động.

---

## 2. Công nghệ sử dụng
- Framework: Flutter
- Ngôn ngữ: Dart
- UI: Material Design (Flutter Widgets)
- Backend: Firebase / REST API
- Database: Firebase Firestore / Realtime Database

---

## 3. Các chức năng chính

### 3.1. Splash Screen
- Hiển thị logo ứng dụng
- Tự động chuyển sang màn hình đăng nhập sau vài giây
- Sử dụng: `SplashScreen`, `Future.delayed()`

---

### 3.2. Đăng nhập / Đăng ký

#### 🔐 Đăng nhập
- Nhập email hoặc số điện thoại
- Nhập mật khẩu
- Xử lý xác thực người dùng
- Điều hướng bằng `Navigator.push()`

#### 📝 Đăng ký
- Nhập thông tin cá nhân
- Kiểm tra dữ liệu hợp lệ
- Lưu dữ liệu vào database

---

### 3.3. Trang chủ (Home Screen)
- Hiển thị thông tin người dùng
- Thanh tìm kiếm (`TextField`)
- Danh mục chức năng (`GridView`)
- Danh sách bác sĩ (`ListView.builder`)
- Banner quảng cáo (`Carousel Slider`)

---

### 3.4. Tìm kiếm bác sĩ
- Tìm kiếm theo tên hoặc chuyên khoa
- Lọc dữ liệu theo tiêu chí
- Hiển thị danh sách bằng `ListView`

---

### 3.5. Chi tiết bác sĩ
- Hiển thị thông tin chi tiết
- Đánh giá và kinh nghiệm
- Lịch làm việc (`Calendar`, `Time Slot`)
- Nút đặt lịch

---

### 3.6. Đặt lịch khám
- Nhập thông tin bệnh nhân
- Chọn ngày giờ
- Xác nhận lịch
- Sử dụng `Form`, `TextFormField`

---

### 3.7. Thanh toán
- Hiển thị thông tin lịch khám
- Chọn phương thức thanh toán
- Xử lý thanh toán (mock hoặc API)

---

### 3.8. Lịch hẹn của tôi
- Hiển thị danh sách lịch hẹn
- Phân loại:
  - Sắp tới
  - Đã khám
- Hủy lịch / xem chi tiết

---

### 3.9. Hồ sơ cá nhân
- Hiển thị thông tin người dùng
- Quản lý hồ sơ bệnh án
- Đổi mật khẩu
- Đăng xuất

---

## 4. Cấu trúc thư mục (Flutter)
lib/
│── main.dart
│
├── screens/
│ ├── splash_screen.dart
│ ├── login_screen.dart
│ ├── home_screen.dart
│ ├── search_screen.dart
│ ├── doctor_detail_screen.dart
│ ├── booking_screen.dart
│ ├── payment_screen.dart
│ ├── schedule_screen.dart
│ └── profile_screen.dart
│
├── widgets/
│ ├── doctor_card.dart
│ ├── custom_button.dart
│
├── models/
│ ├── doctor.dart
│ ├── user.dart
│
├── services/
│ ├── api_service.dart
│ ├── auth_service.dart

---

## 5. Luồng hoạt động ứng dụng

1. Splash Screen  
→ 2. Đăng nhập / Đăng ký  
→ 3. Trang chủ  
→ 4. Tìm kiếm bác sĩ  
→ 5. Xem chi tiết  
→ 6. Đặt lịch  
→ 7. Thanh toán  
→ 8. Quản lý lịch hẹn  

---

## 6. Mục tiêu hệ thống
- Đặt lịch khám nhanh chóng
- Tiết kiệm thời gian
- Dễ sử dụng trên mobile
- Giao diện thân thiện

---

## 7. Kết luận
Ứng dụng được xây dựng bằng Flutter giúp tối ưu trải nghiệm người dùng, hỗ trợ đặt lịch khám bệnh một cách hiện đại và hiệu quả.

---
