import 'package:chuonchuonkim_app/controllers/chuonChuonKimController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'pages/pageTrangChu.dart';

void main() => runApp(const ChuonChuonKimApp());

class ChuonChuonKimApp extends StatelessWidget {
  const ChuonChuonKimApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Chuonchuonkim App",
      debugShowCheckedModeBanner: false,
      initialBinding: ChuonChuonKimBindings(),
      home: const PageTrangChu(),
    );
  }
}


