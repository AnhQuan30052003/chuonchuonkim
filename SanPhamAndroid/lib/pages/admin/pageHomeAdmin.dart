// Quân

import 'package:chuonchuonkim_app/controllers/chuonChuonKimController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../database/connect/firebaseConnect.dart';

class AdminConnect extends StatelessWidget {
  const AdminConnect({super.key});

  @override
  Widget build(BuildContext context) {
    return FirebaseConnect(
      builder: (context) => GetMaterialApp(
        title: "Admin connect",
        debugShowCheckedModeBanner: false,
        initialBinding: ChuonChuonKimBindings(),
        home: const PageHomeAdmin(),
      ),
    );
  }
}

class PageHomeAdmin extends StatefulWidget {
  const PageHomeAdmin({super.key});

  @override
  State<PageHomeAdmin> createState() => _PageHomeAdminState();
}

class _PageHomeAdminState extends State<PageHomeAdmin> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quản lý"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none,
              color: Color(0xFF3A3737),
            ),
          ),
        ],
      ),
      body: _buildBody(context, index),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        items: const [
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.food_bank_outlined, color: Colors.blue),
            icon: Icon(Icons.food_bank_outlined, color: Colors.grey),
            label: "Đồ ăn",
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.people, color: Colors.blue),
            icon: Icon(Icons.people, color: Colors.grey),
            label: "Người dùng",
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.event_busy, color: Colors.blue),
            icon: Icon(Icons.event_busy, color: Colors.grey),
            label: "Đơn hàng",
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.person, color: Colors.blue),
            icon: Icon(Icons.person, color: Colors.grey),
            label: "Tôi",
          ),
        ],
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
      ),
    );
  }

  _buildBody(BuildContext context, int index) {
    if (index == 1) return _buildSMS(context, "Người dùng");
    if (index == 2) return _buildSMS(context, "Đơn hàng");
    if (index == 3) return _buildSMS(context, "Tôi");
    return _buildHome(context, "Đồ ăn");
  }

  _buildHome(BuildContext context, [String textString = "text"]) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(textString, style: const TextStyle(fontSize: 40))
        ],
      )
    );
  }

  _buildSMS(BuildContext context, [String textString = "text"]) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(textString, style: const TextStyle(fontSize: 40))
        ],
      )
    );
  }
}
