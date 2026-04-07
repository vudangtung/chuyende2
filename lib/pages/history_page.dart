import 'package:flutter/material.dart';
import '../services/booking_service.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: BookingService.bookings.length,
      itemBuilder: (_, i) {
        final b = BookingService.bookings[i];
        return ListTile(
          title: Text(b.doctor.name),
          subtitle: Text('${b.date} - ${b.time}'),
        );
      },
    );
  }
}