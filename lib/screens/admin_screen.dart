import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'login_screen.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  List data = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    setState(() => isLoading = true);

    final res = await ApiService.getAppointments();

    setState(() {
      data = res;
      isLoading = false;
    });
  }

  // 🔥 LOGOUT
  void logout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    int total = data.length;
    int pending = data.where((e) => e["status"] == "pending").length;
    int confirmed = data.where((e) => e["status"] == "confirmed").length;
    int cancelled = data.where((e) => e["status"] == "cancelled").length;

    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        title: const Text("Admin Dashboard"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: loadData,
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: logout,
          ),
        ],
      ),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [

                // 🔥 DASHBOARD
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _card("Tổng", total, Colors.blue),
                      _card("Chờ", pending, Colors.orange),
                      _card("OK", confirmed, Colors.green),
                      _card("Huỷ", cancelled, Colors.red),
                    ],
                  ),
                ),

                const SizedBox(height: 5),

                Expanded(
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (_, i) {
                      final item = data[i];
                      String status = item["status"];

                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5,
                            )
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [

                            // 🔥 DOCTOR
                            Text(
                              item["doctor_name"],
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),

                            const SizedBox(height: 5),

                            Text("👤 ${item["patient_name"]}"),
                            Text("📅 ${item["date"]} ${item["time"]}"),
                            Text("📞 ${item["phone"]}"),

                            const SizedBox(height: 8),

                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                _status(status),

                                Row(
                                  children: [
                                    // ✅ DUYỆT
                                    IconButton(
                                      icon: const Icon(Icons.check,
                                          color: Colors.green),
                                      onPressed: status != "pending"
                                          ? null
                                          : () async {
                                              await ApiService
                                                  .confirmAppointment(
                                                      item["id"]);
                                              showMsg("Đã duyệt");
                                              loadData();
                                            },
                                    ),

                                    // ❌ HUỶ
                                    IconButton(
                                      icon: const Icon(Icons.close,
                                          color: Colors.red),
                                      onPressed: status != "pending"
                                          ? null
                                          : () async {
                                              await ApiService
                                                  .cancelAppointment(
                                                      item["id"]);
                                              showMsg("Đã huỷ");
                                              loadData();
                                            },
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
    );
  }

  // 🔥 CARD
  Widget _card(String t, int c, Color color) {
    return Container(
      width: 80,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(t, style: const TextStyle(color: Colors.white)),
          const SizedBox(height: 5),
          Text("$c",
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // 🔥 STATUS
  Widget _status(String s) {
    Color c = s == "pending"
        ? Colors.orange
        : s == "confirmed"
            ? Colors.green
            : Colors.red;

    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: c,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        s,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  // 🔥 MESSAGE
  void showMsg(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }
}