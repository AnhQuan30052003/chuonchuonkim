import 'package:chuonchuonkim_app/controllers/chuonChuonKimController.dart';
import 'package:flutter/material.dart';

class PageLoad extends StatefulWidget {
  const PageLoad({super.key});

  @override
  State<PageLoad> createState() => _PageLoadState();
}

class _PageLoadState extends State<PageLoad> {
  @override
  void initState() {
    var c = ChuonChuonKimController.instance;
    c.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Image.asset("assets/logo.png", height: 85),
            ),
          ],
        ),
      ),
    );
  }
}
