import 'package:flutter/material.dart';
import '../services/api_service.dart';

class RecordScreen extends StatefulWidget {
  final String doctorId;

  const RecordScreen({super.key, required this.doctorId});

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  List data = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    load();
  }

  load() async {
    final res = await ApiService.getRecords(widget.doctorId);
    setState(() {
      data = res;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hồ sơ bệnh án"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: data.length,
              itemBuilder: (_, i) {
                final item = data[i];
                return ListTile(
                  title: Text(item["patient_name"] ?? ""),
                  subtitle: Text(item["diagnosis"] ?? ""),
                );
              },
            ),
    );
  }
}