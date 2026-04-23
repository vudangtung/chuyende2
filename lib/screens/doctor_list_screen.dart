import 'package:flutter/material.dart';
import '../data/doctor_data.dart';
import '../widgets/rating_stars.dart';
import 'booking_screen.dart';

class DoctorListScreen extends StatelessWidget {
  final String specialty;

  const DoctorListScreen({super.key, required this.specialty});

  @override
  Widget build(BuildContext context) {
    final doctors = DoctorData.doctors
        .where((doc) => doc["specialty"] == specialty)
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text(specialty)),
      body: ListView.builder(
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          final doctor = doctors[index];

          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(doctor["image"]),
              ),
              title: Text(doctor["name"]),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(doctor["hospital"]),
                  RatingStars(rating: doctor["rating"]),
                ],
              ),
              trailing: ElevatedButton(
                child: Text("Đặt"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BookingScreen(
                    
                        doctor: doctor,
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}