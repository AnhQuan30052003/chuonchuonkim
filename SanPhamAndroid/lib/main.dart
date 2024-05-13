import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'pages/pageTrangChu.dart';

void main() => runApp(const ChuonChuonKimApp());

class ChuonChuonKimApp extends StatelessWidget {
  const ChuonChuonKimApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: "Chuonchuonkim App",
      debugShowCheckedModeBanner: false,
      home: PageTrangChu(),
    );
  }
}


