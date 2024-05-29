// Quân

import 'package:chuonchuonkim_app/controllers/chuonChuonKimController.dart';
import 'package:chuonchuonkim_app/database/models/ProductType.dart';
import 'package:chuonchuonkim_app/pages/admin/product/pageAddProduct.dart';
import 'package:chuonchuonkim_app/pages/system/aboutme/account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../../database/connect/firebaseConnect.dart';
import 'widget/widgetAdmin.dart';

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
    List<String> title = ["Sản phẩm", "Loại sản phẩm", "Khách hàng", "Tài khoản"];

    return Scaffold(
      appBar: buildAppBarAdmin(info: title[index]),
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
            GButton(icon: Icons.type_specimen, text: "Loại sản phẩm"),
            GButton(icon: Icons.people, text: "Khách hàng"),
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
    if (index == 1) return buildProductType(context);
    if (index == 2) return _buildAboutMe(context);
    if (index == 3) return _buildAboutMe(context);
    return buildProduct(context);
  }

  _buildAboutMe(BuildContext context) {
    return account(context);
  }
}
