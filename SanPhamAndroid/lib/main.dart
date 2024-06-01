import 'package:chuonchuonkim_app/controllers/chuonChuonKimController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'database/connect/firebaseConnect.dart';
import 'pages/system/loadPage.dart';
import 'pages/system/uploadData.dart';

void main() => runApp(const ChuonChuonKimApp());

class ChuonChuonKimApp extends StatelessWidget {
  const ChuonChuonKimApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
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
              _buildButton(context, label: "Upload Data", type: const UploadData()),
              _buildButton(context, label: "App", type: const App()),
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
          Get.to(() => type);
        },
      ),
    );
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return FirebaseConnect(
      builder: (context) => GetMaterialApp(
        title: "ChuonoChuonKimApp",
        debugShowCheckedModeBanner: false,
        initialBinding: ChuonChuonKimBindings(),
        home: const PageLoad(),
      ),
    );
  }
}
