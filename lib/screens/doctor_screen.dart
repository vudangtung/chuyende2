import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'record_screen.dart';
import 'login_screen.dart';

class DoctorScreen extends StatefulWidget {
  final String name;
  final String doctorId;

  const DoctorScreen({
    super.key,
    required this.name,
    required this.doctorId,
  });

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  List data = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future loadData() async {
    final res = await ApiService.getAppointments();

    final filtered = res
        .where((e) => e["doctor_id"].toString() == widget.doctorId)
        .toList();

    setState(() {
      data = filtered;
      isLoading = false;
    });
  }

  void logout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  void showMsg(String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }

  // 🔥 GHI BỆNH ÁN
  void openRecordDialog(dynamic item) {
    final diagnosis = TextEditingController();
    final prescription = TextEditingController();
    final note = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Ghi bệnh án",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

              const SizedBox(height: 10),

              TextField(controller: diagnosis, decoration: const InputDecoration(labelText: "Chẩn đoán")),
              TextField(controller: prescription, decoration: const InputDecoration(labelText: "Đơn thuốc")),
              TextField(controller: note, decoration: const InputDecoration(labelText: "Ghi chú")),

              const SizedBox(height: 10),

              ElevatedButton(
                onPressed: () async {
                  final res = await ApiService.addRecord(
                    item["id"].toString(),
                    widget.doctorId,
                    item["patient_name"],
                    diagnosis.text,
                    prescription.text,
                    note.text,
                  );

                  Navigator.pop(context);

                  showMsg(res["success"] == true
                      ? "Đã lưu bệnh án"
                      : "Lỗi");
                },
                child: const Text("Lưu"),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget statusChip(String s) {
    Color c = s == "pending"
        ? Colors.orange
        : s == "confirmed"
            ? Colors.green
            : Colors.red;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: c,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(s, style: const TextStyle(color: Colors.white)),
    );
  }

  @override
  Widget build(BuildContext context) {
    int total = data.length;

    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        title: Text("👨‍⚕️ ${widget.name}"),
        actions: [
          IconButton(
            icon: const Icon(Icons.folder),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => RecordScreen(doctorId: widget.doctorId),
                ),
              );
            },
          ),
          IconButton(icon: const Icon(Icons.logout), onPressed: logout),
        ],
      ),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () async => loadData(),
              child: ListView(
                children: [

                  // 🔥 DASHBOARD
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.green, Colors.teal],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          const Text("Tổng lịch",
                              style: TextStyle(color: Colors.white)),
                          const SizedBox(height: 5),
                          Text("$total",
                              style: const TextStyle(
                                  fontSize: 26,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),

                  // 🔥 LIST
                  ...data.map((item) {
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: ListTile(
                        title: Text(item["patient_name"]),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${item["date"]} - ${item["time"]}"),
                            Text(item["phone"]),
                          ],
                        ),
                        trailing: Column(
                          children: [
                            statusChip(item["status"]),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [

                                IconButton(
                                  icon: const Icon(Icons.check, color: Colors.green),
                                  onPressed: item["status"] != "pending"
                                      ? null
                                      : () async {
                                          await ApiService.confirmAppointment(item["id"]);
                                          loadData();
                                        },
                                ),

                                IconButton(
                                  icon: const Icon(Icons.close, color: Colors.red),
                                  onPressed: item["status"] != "pending"
                                      ? null
                                      : () async {
                                          await ApiService.cancelAppointment(item["id"]);
                                          loadData();
                                        },
                                ),

                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () => openRecordDialog(item),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }).toList()
                ],
              ),
            ),
    );
  }
}