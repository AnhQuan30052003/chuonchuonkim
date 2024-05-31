import 'package:chuonchuonkim_app/controllers/chuonChuonKimController.dart';
import 'package:chuonchuonkim_app/database/models/Notification.dart';
import 'package:flutter/material.dart';
import '../../database/models/Product.dart';
import '../../helper/widget.dart';

class PageOrder extends StatelessWidget {
  const PageOrder({super.key});

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
      body: StreamBuilder(
        stream: NotificationsSnapshot.streamData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator()
            );
          }

          List<NotificationsSnapshot> list = [];

          try {
            list = snapshot.data!;
          } catch (error) {
            list = [];
          }

          int count = 0;
          for (var no in list) {
            if (no.notification.seen == false) count += 1;
          }

          return Text("33");
        },
      ),
    );
  }
}
