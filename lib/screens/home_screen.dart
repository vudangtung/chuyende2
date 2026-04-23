import 'package:flutter/material.dart';
import 'doctor_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.name});

  final String name;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final List<Map<String, dynamic>> departments = const [
    {"name": "Tim mạch", "icon": Icons.favorite},
    {"name": "Da liễu", "icon": Icons.spa},
    {"name": "Thần kinh", "icon": Icons.psychology},
    {"name": "Răng hàm mặt", "icon": Icons.medical_services},
    {"name": "Tai mũi họng", "icon": Icons.hearing},
    {"name": "Nhi khoa", "icon": Icons.child_care},
    {"name": "Mắt", "icon": Icons.visibility},
    {"name": "Xương khớp", "icon": Icons.accessibility_new},
    {"name": "Tiêu hóa", "icon": Icons.restaurant},
  ];

  void reload() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade800, Colors.blue.shade400],
              ),
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(30)),
            ),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Đặt lịch khám",
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            ),
          ),

          const SizedBox(height: 20),

          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: departments.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (_, i) {
                final d = departments[i];

                return GestureDetector(
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DoctorListScreen(
                          specialty: d["name"],
                        ),
                      ),
                    );

                    if (result == true) {
                      reload(); // 🔥 reload nếu cần
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 5)
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(d["icon"], color: Colors.blue),
                        const SizedBox(height: 5),
                        Text(
                          d["name"],
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}