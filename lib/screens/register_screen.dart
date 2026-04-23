import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String role = "user";
  String? doctorId;

  List doctors = [];

  final String baseUrl = "http://127.0.0.1/medical_app/api";

  @override
  void initState() {
    super.initState();
    loadDoctors();
  }

  void loadDoctors() async {
    try {
      final res = await http.get(
        Uri.parse("$baseUrl/get_doctors.php"),
      );

      final data = jsonDecode(res.body);

      setState(() {
        doctors = data;
      });
    } catch (e) {
      print("Load doctor error: $e");
    }
  }

  void register() async {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      showMsg("Nhập đầy đủ thông tin");
      return;
    }

    if (role == "doctor" && doctorId == null) {
      showMsg("Chọn bác sĩ");
      return;
    }

    try {
      final res = await http.post(
        Uri.parse("$baseUrl/register.php"),
        body: {
          "name": nameController.text,
          "email": emailController.text,
          "password": passwordController.text,
          "role": role,
          "doctor_id": doctorId ?? "",
        },
      );

      final data = jsonDecode(res.body);

      if (data["success"] == true) {
        showMsg("Đăng ký thành công");
        Navigator.pop(context);
      } else {
        showMsg(data["message"]);
      }
    } catch (e) {
      showMsg("Lỗi server");
    }
  }

  void showMsg(String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // 🔥 QUAN TRỌNG
      appBar: AppBar(title: const Text("Đăng ký")),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [

              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Tên"),
              ),

              const SizedBox(height: 10),

              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email"),
              ),

              const SizedBox(height: 10),

              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Mật khẩu"),
              ),

              const SizedBox(height: 15),

              DropdownButtonFormField(
                value: role,
                decoration: const InputDecoration(labelText: "Vai trò"),
                items: ["user", "doctor"]
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    role = val!;
                  });
                },
              ),

              const SizedBox(height: 15),

              if (role == "doctor")
                DropdownButtonFormField(
                  decoration:
                      const InputDecoration(labelText: "Chọn bác sĩ"),
                  value: doctorId,
                  items: doctors.map<DropdownMenuItem>((d) {
                    return DropdownMenuItem(
                      value: d["id"].toString(),
                      child: Text(d["name"]),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      doctorId = val.toString();
                    });
                  },
                ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: register,
                  child: const Text("Đăng ký"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}