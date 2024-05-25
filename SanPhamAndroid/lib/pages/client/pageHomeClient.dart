// * Đạt

import 'package:chuonchuonkim_app/helper/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../../controllers/chuonChuonKimController.dart';
import '../../database/connect/firebaseConnect.dart';
import '../../helper/widgetClient.dart';
import '../system/account.dart';

class ClientConnect extends StatelessWidget {
  const ClientConnect({super.key});

  @override
  Widget build(BuildContext context) {
    return FirebaseConnect(
      builder: (context) => GetMaterialApp(
        title: "Client connect",
        debugShowCheckedModeBanner: false,
        initialBinding: ChuonChuonKimBindings(),
        home: const PageHomeClient(),
      ),
    );
  }
}

class PageHomeClient extends StatefulWidget {
  const PageHomeClient({super.key});

  @override
  State<PageHomeClient> createState() => _PageHomeClientState();
}

class _PageHomeClientState extends State<PageHomeClient> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(info: "Bạn muốn ăn gì?"),
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
            GButton(icon: CupertinoIcons.home, text: "Trang chủ"),
            GButton(icon: Icons.favorite_border, text: "Yêu thích"),
            GButton(icon: Icons.person_outline_outlined, text: "Tôi"),
          ],
          onTabChange: (value) {
            setState(() {
              index = value;
            });
          },
        ),
      ),
    );
  }

  _buildBody(BuildContext context, int index) {
    if (index == 0) {
      ChuonChuonKimController.instance.showProductType(idLSP: "");
      return home();
    }
    if (index == 1) return favorite();
    return account(context);
  }

  Widget home() {
    return GetBuilder(
      init: ChuonChuonKimController.instance,
      id: "client_products",
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: SingleChildScrollView(
            child: Column(children: [
              // * search
              buildSearch(context: context),

              // * filter
              space(0, 10),
              buildFilter(),

              // * Khung phổ biến
              space(0, 10),
              buildInstruction(text: "Phổ biến"),

              // * card product phổ biến
              space(0, 10),
              buildProductsPopulator(),

              // * Khung sản phẩm
              space(0, 10),
              buildInstruction(text: "Sản phẩm"),

              // * card product
              space(0, 10),
              GetBuilder(
                init: ChuonChuonKimController.instance,
                id: "gridview_products",
                builder: (controller) {
                  return buildGridViewProducts(
                    context: context,
                    list: controller.listProdutsGridView,
                    showNotFound: false
                  );
                }
              )
            ]),
          ),
        );
      },
    );
  }

  Widget favorite() {
    return Container(
      child: const Text("favorite"),
    );
  }

  Widget account(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text("title of account"),
    //   ),
    // );
    return const MaterialApp(
      title: "My Account",
      debugShowCheckedModeBanner: false,
      home: MyAccount(),
    );
  }
}
