import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppointmentData {
  static ValueNotifier<List<Map<String, String>>> appointments =
      ValueNotifier([]);

  // 🔥 LOAD DATA
  static Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString("appointments");

    if (data != null) {
      List list = jsonDecode(data);
      appointments.value =
          list.map((e) => Map<String, String>.from(e)).toList();
    }
  }

  // 🔥 SAVE DATA
  static Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(
      "appointments",
      jsonEncode(appointments.value),
    );
  }

  static void add(String doctor, String time, String phone) {
    final list = List<Map<String, String>>.from(appointments.value);

    list.add({
      "doctor": doctor,
      "time": time,
      "phone": phone,
      "created": DateTime.now().toString(), // 🔥 dùng phân loại
    });

    appointments.value = list;
    save();
  }

  static void remove(Map<String, String> item) {
    final list = List<Map<String, String>>.from(appointments.value);
    list.remove(item);
    appointments.value = list;
    save();
  }

  static bool isBusy(String doctor, String time) {
    return appointments.value.any(
      (a) => a["doctor"] == doctor && a["time"] == time,
    );
  }
}