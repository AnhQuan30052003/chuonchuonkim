// Quân

import 'package:chuonchuonkim_app/helper/widgetClient.dart';
import 'package:flutter/material.dart';

class PageNotification extends StatelessWidget {
  const PageNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white10,
        title: const Text(
          "Thông báo",
          style: TextStyle(fontSize: 16, color: Color(0xFF3A3737), fontWeight: FontWeight.bold),
        ),
      ),
      body: buildStreamBuilderNotification(),
    );
  }
}
