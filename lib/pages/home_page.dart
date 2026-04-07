import 'package:dat_lich_kham_benh/widgets/doctor_card.dart';
import 'package:flutter/material.dart';
import '../models/doctor.dart';
import '../widgets/doctor_card.dart';
import 'doctor_detail_page.dart';
import 'history_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  List<Doctor> doctors = [
    Doctor(name: 'BS. Nguyễn Văn A', specialty: 'Tim mạch', rating: 4.8),
    Doctor(name: 'BS. Trần Thị B', specialty: 'Nhi', rating: 4.7),
    Doctor(name: 'BS. Lê Văn C', specialty: 'Da liễu', rating: 4.9),
  ];

  @override
  Widget build(BuildContext context) {
    final pages = [
      Column(
        children: [
          // HEADER
          Container(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF4A90E2), Color(0xFF6FB1FC)],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Xin chào 👋',
                    style: TextStyle(color: Colors.white70)),

                const SizedBox(height: 5),

                const Text('Đặt lịch khám',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold)),

                const SizedBox(height: 15),

                // SEARCH
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Tìm bác sĩ...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // CATEGORY
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              children: [
                _chip('Tim mạch'),
                _chip('Nhi'),
                _chip('Da liễu'),
                _chip('Tai mũi họng'),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // LIST
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: doctors
                  .map((doc) => DoctorCard(
                doctor: doc,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          DoctorDetailPage(doctor: doc),
                    ),
                  );
                },
              ))
                  .toList(),
            ),
          ),
        ],
      ),
      const HistoryPage()
    ];

    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Colors.blue,
        onTap: (i) => setState(() => currentIndex = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Lịch sử'),
        ],
      ),
    );
  }

  Widget _chip(String text) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.blue),
      ),
      child: Center(
        child: Text(text, style: const TextStyle(color: Colors.blue)),
      ),
    );
  }
}