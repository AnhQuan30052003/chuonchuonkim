// Quân

import 'package:chuonchuonkim_app/controllers/chuonChuonKimController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
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
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(30),
        ),
        child: GNav(
          activeColor: Colors.white,
          gap: 5,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          padding: const EdgeInsets.all(10),
          style: GnavStyle.google,
          haptic: true,
          color: Colors.white70,
          tabBackgroundColor: Colors.black38,
          tabBorderRadius: 20,
          tabs: const [
            GButton(icon: Icons.fastfood_rounded, text: "Sản phẩm"),
            GButton(icon: Icons.people, text: "Khách hàng"),
            GButton(icon: Icons.shopping_bag_sharp, text: "Đơn hàng"),
            GButton(icon: Icons.person_outline_outlined, text: "Tôi"),
          ],
          onTabChange: (value) async {
            setState(() {
              index = value;
            });
          },
        ),
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
      children: [Text(textString, style: const TextStyle(fontSize: 40))],
    ));
  }

  _buildSMS(BuildContext context, [String textString = "text"]) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text(textString, style: const TextStyle(fontSize: 40))],
    ));
  }
}
