import '../controllers/chuonChuonKimController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'pages/pageHome.dart';
import 'pages/pageCart.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: ChuonChuonKimApp(),
    );
  }
}

// Chạy thử chương trình đơn giản
class PageDemo extends StatelessWidget {
  const PageDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Title demo"),
      ),
      body: const Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text("Run file demo successful")],
      )),
    );
  }
}

// App chính, sau này code FirebaseConnect cho class này, thay MyApp()
class ChuonChuonKimApp extends StatelessWidget {
  const ChuonChuonKimApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Chuonchuonkim App",
      debugShowCheckedModeBanner: false,
      initialBinding: ChuonChuonKimBindings(),
      home: PageHome(),
    );
  }
}
