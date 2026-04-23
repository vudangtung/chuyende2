import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      "http://localhost/medical_app/api";

  // ================= LOGIN =================
  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    try {
      final res = await http.post(
        Uri.parse("$baseUrl/login.php"),
        body: {"email": email, "password": password},
      );

      print("LOGIN: ${res.body}");
      return jsonDecode(res.body);
    } catch (e) {
      return {"success": false};
    }
  }

  // ================= DOCTORS =================
  static Future<List> getDoctors() async {
    final res = await http.get(
      Uri.parse("$baseUrl/get_doctors.php"),
    );

    print("DOCTORS: ${res.body}");
    return jsonDecode(res.body);
  }

  // ================= GET APPOINTMENTS =================
  static Future<List> getAppointments() async {
    try {
      final res = await http.get(
        Uri.parse("$baseUrl/get_appointments.php"),
      );

      print("APPOINTMENTS: ${res.body}");

      final data = jsonDecode(res.body);
      return data is List ? data : [];
    } catch (e) {
      print("GET ERROR: $e");
      return [];
    }
  }

  // ================= ADD =================
  static Future<Map<String, dynamic>> addAppointment(
    String doctorId,
    String doctorName,
    String patientName,
    String date,
    String time,
    String phone,
  ) async {
    try {
      final res = await http.post(
        Uri.parse("$baseUrl/add_appointment.php"),
        body: {
          "doctor_id": doctorId,
          "doctor_name": doctorName,
          "patient_name": patientName,
          "date": date,
          "time": time,
          "phone": phone,
        },
      );

      print("SEND:");
      print({
        "doctor_id": doctorId,
        "doctor_name": doctorName,
        "patient_name": patientName,
        "date": date,
        "time": time,
        "phone": phone,
      });

      print("ADD: ${res.body}");

      return jsonDecode(res.body);
    } catch (e) {
      print("ADD ERROR: $e");
      return {
        "success": false,
        "message": "Lỗi kết nối server"
      };
    }
  }

  // ================= CONFIRM =================
  static Future<bool> confirmAppointment(String id) async {
    try {
      final res = await http.post(
        Uri.parse("$baseUrl/confirm_appointment.php"),
        body: {"id": id},
      );

      print("CONFIRM: ${res.body}");
      return true;
    } catch (e) {
      print("CONFIRM ERROR: $e");
      return false;
    }
  }

  // ================= CANCEL =================
  static Future<bool> cancelAppointment(String id) async {
    try {
      final res = await http.post(
        Uri.parse("$baseUrl/cancel_appointment.php"),
        body: {"id": id},
      );

      print("CANCEL: ${res.body}");
      return true;
    } catch (e) {
      print("CANCEL ERROR: $e");
      return false;
    }
  }

  // ================= DELETE =================
  static Future<bool> deleteAppointment(String id) async {
    try {
      final res = await http.post(
        Uri.parse("$baseUrl/delete_appointment.php"),
        body: {"id": id},
      );

      print("DELETE: ${res.body}");
      return true;
    } catch (e) {
      print("DELETE ERROR: $e");
      return false;
    }
  }
    // ================= REQUEST LEAVE =================
  static Future<Map<String, dynamic>> requestLeave(
    String doctorName,
    String date,
    String reason,
  ) async {
    try {
      final res = await http.post(
        Uri.parse("$baseUrl/request_leave.php"),
        body: {
          "doctor_name": doctorName,
          "date": date,
          "reason": reason,
        },
      );

      print("LEAVE: ${res.body}");

      return jsonDecode(res.body);
    } catch (e) {
      print("LEAVE ERROR: $e");
      return {
        "success": false,
        "message": "Lỗi kết nối server"
      };
    }
  }
  // ================= REGISTER =================
  static Future<Map<String, dynamic>> register(
    String name,
    String email,
    String password,
    String role, {
    String? doctorId,
  }) async {
    try {
      final res = await http.post(
        Uri.parse("$baseUrl/register.php"),
        body: {
          "name": name,
          "email": email,
          "password": password,
          "role": role,
          "doctor_id": doctorId ?? "",
        },
      );

      print("REGISTER: ${res.body}");
      return jsonDecode(res.body);
    } catch (e) {
      return {"success": false};
    }
  }

  static Future<List> getDoctorAppointments(
    String doctorId, String date) async {
  final res = await http.get(
    Uri.parse(
        "$baseUrl/get_doctor_appointments.php?doctor_id=$doctorId&date=$date"),
  );

  return jsonDecode(res.body);
}
static Future<List> getBookedSlots(
    String doctorId, String date) async {
  try {
    final res = await http.get(
      Uri.parse("$baseUrl/get_booked_slots.php?doctor_id=$doctorId&date=$date"),
    );

    return jsonDecode(res.body);
  } catch (e) {
    print("SLOTS ERROR: $e");
    return [];
  }
}
// 🔥 ADD RECORD
static Future addRecord(
  String appointmentId,
  String doctorId,
  String patient,
  String diagnosis,
  String prescription,
  String note,
) async {
  final res = await http.post(
    Uri.parse("$baseUrl/add_record.php"),
    body: {
      "appointment_id": appointmentId,
      "doctor_id": doctorId,
      "patient_name": patient,
      "diagnosis": diagnosis,
      "prescription": prescription,
      "note": note,
    },
  );

  return jsonDecode(res.body);
}

// 🔥 GET RECORD
static Future<List> getRecords(String doctorId) async {
  final res = await http.get(
    Uri.parse("$baseUrl/get_records.php?doctor_id=$doctorId"),
  );

  return jsonDecode(res.body);
}
}