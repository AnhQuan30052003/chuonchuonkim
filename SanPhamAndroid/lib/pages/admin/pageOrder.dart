import 'package:chuonchuonkim_app/database/models/Notification.dart';
import 'package:flutter/material.dart';

class PageOrder extends StatelessWidget {
  final Notifications noti;
  const PageOrder({required this.noti, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white10,
        title: const Text(
          "Xác nhận đơn hàng",
          style: TextStyle(fontSize: 16, color: Color(0xFF3A3737), fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
