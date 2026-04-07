import 'package:flutter/material.dart';
import '../models/doctor.dart';
import 'booking_page.dart';

class DoctorDetailPage extends StatelessWidget {
  final Doctor doctor;

  const DoctorDetailPage({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(doctor.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircleAvatar(radius: 40, child: Icon(Icons.person)),
            const SizedBox(height: 10),
            Text(doctor.name,
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold)),
            Text(doctor.specialty),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BookingPage(doctor: doctor),
                  ),
                );
              },
              child: const Text('Đặt lịch'),
            )
          ],
        ),
      ),
    );
  }
}