import 'package:chuonchuonkim_app/controllers/chuonChuonKimController.dart';
import 'package:chuonchuonkim_app/pages/client/pageHomeClient.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'database/connect/firebaseConnect.dart';
import 'pages/admin/pageHomeAdmin.dart';
import 'pages/system/uploadData.dart';

void main() => runApp(const ChuonChuonKimApp());

class ChuonChuonKimApp extends StatelessWidget {
  const ChuonChuonKimApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FirebaseConnect(
      builder: (context) => GetMaterialApp(
        title: "Chuonchuonkim App",
        debugShowCheckedModeBanner: false,
        initialBinding: ChuonChuonKimBindings(),
        home: const ListApp(),
      ),
    );
  }
}

// Tạo một danh sách truy cập
class ListApp extends StatelessWidget {
  const ListApp({super.key});

  @override
  Widget build(BuildContext context) {
    var c = ChuonChuonKimController.instance;

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
              // _buildButton(context, label: "App", type: const App()),
              // _buildButton(context, label: "App", type: (c.isLogin && c.userSnapshot!.user.id == "0000") ? const PageHomeAdmin() : const PageHomeClient()),
              _buildButton(context, label: "App", type: const PageHomeClient()),

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
    var c = ChuonChuonKimController.instance;

    return MaterialApp(
      title: "ChuonChuonKim App",
      debugShowCheckedModeBanner: false,
      home: (c.isLogin && c.userSnapshot!.user.id == "0000") ? const PageHomeAdmin() : const PageHomeClient(),
    );
  }
}