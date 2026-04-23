import 'package:flutter/material.dart';
import '../screens/booking_screen.dart';

class DoctorCard extends StatelessWidget {
  final Map<String, dynamic> doctor;

  const DoctorCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    print("DOCTOR CARD DATA: $doctor"); // 🔥 DEBUG

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BookingScreen(
              doctor: doctor, // 🔥 TRUYỀN NGUYÊN OBJECT
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Text(doctor["name"] ?? ""),
            Text(doctor["specialty"] ?? ""),
          ],
        ),
      ),
    );
  }
}