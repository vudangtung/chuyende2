import 'package:flutter/material.dart';
import '../services/api_service.dart';

class ScheduleScreen extends StatefulWidget {
  final String name;

  const ScheduleScreen({super.key, required this.name});
  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {

  String getStatusText(String status) {
    switch (status) {
      case "pending":
        return "Chờ xác nhận";
      case "confirmed":
        return "Đã xác nhận";
      case "completed":
        return "Đã khám";
      case "cancelled":
        return "Đã hủy";
      default:
        return status;
    }
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "pending":
        return Colors.orange;
      case "confirmed":
        return Colors.green;
      case "completed":
        return Colors.blue;
      case "cancelled":
        return Colors.red;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lịch đã đặt")),
      body: FutureBuilder(
        future: ApiService.getAppointments(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data as List;

          if (data.isEmpty) {
            return Center(child: Text("Chưa có lịch"));
          }

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (_, i) {
              final item = data[i];

              return Card(
                margin: EdgeInsets.all(10),
                child: ListTile(
                  title: Text(item["doctor_name"]),
                  subtitle: Text(
                      "${item["date"]} - ${item["time"]}\n${getStatusText(item["status"])}"),
                  trailing: item["status"] == "pending"
                      ? ElevatedButton(
                          onPressed: () async {
                            await ApiService.cancelAppointment(item["id"]);
                            setState(() {});
                          },
                          child: Text("Hủy"),
                        )
                      : Text(
                          getStatusText(item["status"]),
                          style: TextStyle(
                            color: getStatusColor(item["status"]),
                          ),
                        ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}