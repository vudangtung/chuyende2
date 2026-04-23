import 'package:flutter/material.dart';
import '../services/api_service.dart';

class BookingScreen extends StatefulWidget {
  final Map<String, dynamic> doctor;

  const BookingScreen({super.key, required this.doctor});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  String? selectedTime;

  List bookedSlots = [];

  bool isLoading = false;

  final List<String> times = [
    "08:00",
    "09:00",
    "10:00",
    "14:00",
    "15:00",
  ];

  @override
  void initState() {
    super.initState();
    loadSlots();
  }

  // 🔥 LOAD SLOT ĐÃ ĐẶT
  loadSlots() async {
    final res = await ApiService.getBookedSlots(
      widget.doctor["id"].toString(),
      selectedDate.toString().split(" ")[0],
    );

    setState(() {
      bookedSlots = res;
    });
  }

  // 🔥 CHECK GIỜ QUA
  bool isPast(String time) {
    DateTime now = DateTime.now();

    final hour = int.parse(time.split(":")[0]);

    DateTime slot = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      hour,
    );

    if (selectedDate.year == now.year &&
        selectedDate.month == now.month &&
        selectedDate.day == now.day) {
      return slot.isBefore(now);
    }

    return false;
  }

  // 🔥 CHECK ĐÃ ĐẶT
  bool isBooked(String time) {
    return bookedSlots.contains(time);
  }

  // 🔥 BOOK
  void book() async {
    if (nameController.text.isEmpty ||
        phoneController.text.isEmpty ||
        selectedTime == null) {
      showMsg("Nhập đủ thông tin");
      return;
    }

    setState(() => isLoading = true);

    final res = await ApiService.addAppointment(
      widget.doctor["id"].toString(),
      widget.doctor["name"],
      nameController.text,
      selectedDate.toString().split(" ")[0],
      selectedTime!,
      phoneController.text,
    );

    setState(() => isLoading = false);

    if (res["success"] == true) {
      showMsg("Đặt lịch thành công");
      Navigator.pop(context,true);
    } else {
      showMsg(res["message"] ?? "Lỗi");
    }
  }

  void showMsg(String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }

  // 🔥 CHỌN NGÀY
  Future pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        selectedTime = null;
      });
      loadSlots(); // 🔥 reload slot
    }
  }

  @override
  Widget build(BuildContext context) {
    final doctor = widget.doctor;

    return Scaffold(
      appBar: AppBar(title: const Text("Đặt lịch khám")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(doctor["name"],
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold)),
            Text(doctor["specialty"] ?? ""),

            const SizedBox(height: 20),

            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Tên bệnh nhân",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: "Số điện thoại",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.calendar_month),
                  onPressed: pickDate,
                ),
                Text("Ngày: ${selectedDate.toString().split(" ")[0]}"),
              ],
            ),

            const SizedBox(height: 10),

            Wrap(
              spacing: 10,
              children: times.map((t) {
                final past = isPast(t);
                final booked = isBooked(t);

                Color color = Colors.grey;

                if (past) color = Colors.grey;
                else if (booked) color = Colors.red;
                else color = Colors.green;

                return ChoiceChip(
                  label: Text(
                    past
                        ? "$t (Qua)"
                        : booked
                            ? "$t (Bận)"
                            : t,
                  ),
                  selected: selectedTime == t,
                  selectedColor: Colors.blue,
                  backgroundColor: color.withOpacity(0.2),
                  onSelected: (past || booked)
                      ? null
                      : (_) {
                          setState(() => selectedTime = t);
                        },
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: isLoading ? null : book,
                child: isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white)
                    : const Text("Xác nhận đặt lịch"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}