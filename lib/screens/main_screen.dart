import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'schedule_screen.dart';
import 'profile_screen.dart';

class MainScreen extends StatefulWidget {
  final String name;

  const MainScreen({super.key, required this.name});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 0;

  late final List<Widget> screens;

  @override
  void initState() {
    super.initState();

    screens = [
      HomeScreen(name: widget.name),
      ScheduleScreen(name: widget.name),
      const ProfileScreen(), // 🔥 FIX: không truyền name nữa
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      // 🔥 APPBAR ĐẸP HƠN
      appBar: AppBar(
        elevation: 0,
        title: Row(
          children: [
            const Icon(Icons.local_hospital),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                "Xin chào ${widget.name}",
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.blue,
      ),

      // 🔥 BODY (GIỮ TRẠNG THÁI)
      body: IndexedStack(
        index: index,
        children: screens,
      ),

      // 🔥 NAVBAR ĐẸP HƠN
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 5),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: index,
          onTap: (i) => setState(() => index = i),
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Trang chủ",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: "Lịch",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Cá nhân",
            ),
          ],
        ),
      ),
    );
  }
}