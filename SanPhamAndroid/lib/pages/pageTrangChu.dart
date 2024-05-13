// Đạt

import 'package:flutter/material.dart';

import '../database_test/ImageDemo.dart';

class PageTrangChu extends StatefulWidget {
  const PageTrangChu({super.key});

  @override
  State<PageTrangChu> createState() => _PageTrangChuState();
}

class _PageTrangChuState extends State<PageTrangChu> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Trang chủ"),
      ),
      body: Container(
        child: Image.asset(ImageDemo.path),
      ),
    );
  }
}
