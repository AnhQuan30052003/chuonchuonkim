// * Đạt

import 'dart:math';

import 'package:chuonchuonkim_app/database/models/ProductFavorite.dart';
import 'package:chuonchuonkim_app/helper/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../../controllers/chuonChuonKimController.dart';
import '../../database/connect/firebaseConnect.dart';
import '../../database/models/Product.dart';
import '../../helper/widgetClient.dart';
import '../system/aboutme/account.dart';

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
    List<String> title = ["Bạn muốn ăn gì ?", "Sản phẩm yêu thích", "Tài khoản của tôi"];

    return Scaffold(
      appBar: buildAppBar(info: title[index]),
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
    // Lấy 20 sản phẩm ngẫu nhiên

    var c = ChuonChuonKimController.instance;
    c.listProdutsGridView = [];
    int count = 1;
    do {
      c.listProdutsGridView.add(c.listProduct[Random().nextInt(c.listProduct.length)]);
      count += 1;
    } while (count <= 30);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Column(
          children: [
            StreamBuilder(
              stream: ProductFavoriteSnapshot.streamData(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                List<ProductFavoriteSnapshot> list = [];

                try {
                  list = snapshot.data!;
                }
                catch (error) {
                  list = [];
                }
                list.sort((ProductFavoriteSnapshot a, ProductFavoriteSnapshot b) => (a.productFavorite.maSP.compareTo(b.productFavorite.maSP)));

                List<Product> listProduct = [];
                for (var pf in list) {
                  for (var p in ChuonChuonKimController.instance.listProduct) {
                    if (p.maSP == pf.productFavorite.maSP) {
                      listProduct.add(p);
                    }
                  }
                }
                listProduct.sort((Product a, Product b) => a.maSP.compareTo(b.maSP));
                return buildGridViewProducts(context: context, list: listProduct, showNotFound: false);
              }
            ),
            space(0, 20),
            buildInstruction(text: "Có thể bạn cũng thích"),
            buildGridViewProducts(context: context, list: c.listProdutsGridView, showNotFound: false),
          ],
        ),
      ),
    );
  }
}
