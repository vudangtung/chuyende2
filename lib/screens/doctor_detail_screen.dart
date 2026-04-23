import 'package:flutter/material.dart';
import '../services/api_service.dart';

class DoctorDetailScreen extends StatelessWidget {
  final Map doctor;
  final String time;
  final DateTime date;

  const DoctorDetailScreen({
    super.key,
    required this.doctor,
    required this.time,
    required this.date,
  });

  // 🔥 ĐẶT LỊCH
  void book(BuildContext context) async {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Nhập thông tin bệnh nhân"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Tên"),
            ),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: "SĐT"),
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () async {
              if (nameController.text.isEmpty ||
                  phoneController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Nhập đầy đủ thông tin")),
                );
                return;
              }

              final res = await ApiService.addAppointment(
                doctor["id"].toString(), // ✅ QUAN TRỌNG
                doctor["name"],
                nameController.text,
                date.toString().split(" ")[0],
                time,
                phoneController.text,
              );

              Navigator.pop(context);

              if (res["success"] == true) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Đặt lịch thành công")),
                );
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content:
                          Text(res["message"] ?? "Đặt lịch thất bại")),
                );
              }
            },
            child: const Text("Xác nhận"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(doctor["name"]),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(doctor["image"] ?? ""),
            ),
            const SizedBox(height: 10),
            Text(
              doctor["name"],
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(doctor["specialty"] ?? ""),
            const SizedBox(height: 20),

            Text("📅 ${date.toString().split(" ")[0]}"),
            Text("⏰ $time"),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () => book(context),
              child: const Text("Đặt lịch"),
            )
          ],
        ),
      ),
    );
  }
}