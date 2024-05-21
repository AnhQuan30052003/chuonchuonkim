import 'package:flutter/material.dart';
import 'pages/client/pageHomeClient.dart';
import 'pages/admin/pageHomeAdmin.dart';
import 'pages/system/uploadData.dart';

void main() => runApp(const ChuonChuonKimApp());

class ChuonChuonKimApp extends StatelessWidget {
  const ChuonChuonKimApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Chuonchuonkim App",
      debugShowCheckedModeBanner: false,
      home: ListApp(),
    );
  }
}

// Tạo một danh sách truy cập
class ListApp extends StatelessWidget {
  const ListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Chọn app ?"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              _buildButton(context, label: "Upload Data", type: const AppUploadData()),
              _buildButton(context, label: "App client", type: PageHomeClient()),
              _buildButton(context, label: "App admin", type: const PageHomeAdmin()),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildButton(BuildContext context, {required String label, required Widget type}) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: MediaQuery.of(context).size.width * 0.75,
      child: ElevatedButton(
        child: Text(label),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => type));
        },
      ),
    );
  }
}
