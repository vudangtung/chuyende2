import 'package:flutter/material.dart';
import '../models/doctor.dart';
import '../models/booking.dart';
import '../services/booking_service.dart';
import '../widgets/time_slot.dart';

class BookingPage extends StatefulWidget {
  final Doctor doctor;

  const BookingPage({super.key, required this.doctor});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  DateTime selectedDate = DateTime.now();
  String selectedTime = '';

  final times = [
    '08:00', '09:00', '10:00',
    '13:00', '14:00', '15:00'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Đặt lịch')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(widget.doctor.name,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold)),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                );
                if (date != null) {
                  setState(() => selectedDate = date);
                }
              },
              child: Text(
                  'Chọn ngày: ${selectedDate.toString().split(' ')[0]}'),
            ),

            const SizedBox(height: 20),

            Wrap(
              children: times
                  .map((t) => TimeSlot(
                time: t,
                selected: selectedTime == t,
                onTap: () {
                  setState(() => selectedTime = t);
                },
              ))
                  .toList(),
            ),

            const Spacer(),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50)),
              onPressed: () {
                if (selectedTime.isEmpty) return;

                BookingService.addBooking(
                  Booking(
                    doctor: widget.doctor,
                    date: selectedDate.toString().split(' ')[0],
                    time: selectedTime,
                  ),
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Đặt lịch thành công')),
                );

                Navigator.pop(context);
              },
              child: const Text('Xác nhận'),
            )
          ],
        ),
      ),
    );
  }
}