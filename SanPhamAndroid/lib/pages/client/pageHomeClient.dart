// * Đạt

import 'package:chuonchuonkim_app/helper/widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/chuonChuonKimController.dart';
import '../../database/connect/firebaseConnect.dart';
import '../../helper/widgetClient.dart';

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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        items: const [
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.home, color: Colors.blue),
            icon: Icon(Icons.home, color: Colors.grey),
            label: "Trang chủ",
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.favorite, color: Colors.blue),
            icon: Icon(Icons.favorite, color: Colors.grey),
            label: "Yêu thích",
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
    if (index == 0) {
      ChuonChuonKimController.instance.showProductType(idLSP: "");
      return home();
    }
    if (index == 1) return favorite();
    return me();
  }

  Widget home() {
    return GetBuilder(
      init: ChuonChuonKimController.instance,
      id: "client_products",
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
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
                    return buildGridViewProducts(list: controller.listProdutsGridView, showNotFound: false);
                  }
                )
              ]
            ),
          ),
        );
      },
    );
  }

  Widget favorite() {
    return Container();
  }

  Widget me() {
    return Container();
  }
}
