import 'doctor.dart';

class Booking {
  final Doctor doctor;
  final String date;
  final String time;

  Booking({
    required this.doctor,
    required this.date,
    required this.time,
  });
}