import 'package:flutter/material.dart';

class TimeSlot extends StatelessWidget {
  final String time;
  final bool selected;
  final VoidCallback onTap;

  const TimeSlot({
    super.key,
    required this.time,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(6),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.blue),
        ),
        child: Text(
          time,
          style: TextStyle(
              color: selected ? Colors.white : Colors.blue),
        ),
      ),
    );
  }
}