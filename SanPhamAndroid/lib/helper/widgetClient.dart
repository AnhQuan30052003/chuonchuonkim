import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/chuonChuonKimController.dart';
import '../database/models/Product.dart';
import '../pages/client/pageCart.dart';
import '../pages/client/pageNotification.dart';
import 'widget.dart';
import '../pages/client/pageDetails.dart';
import '../pages/client/pageProductSearch.dart';
import 'package:badges/badges.dart' as badges;

PreferredSizeWidget buildAppBar({required String info}) {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.white10,
    title: Text(
      info,
      style: const TextStyle(fontSize: 16, color: Color(0xFF3A3737), fontWeight: FontWeight.bold),
    ),
    actions: [
      GestureDetector(
        child: Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: badges.Badge(
            onTap: () {
              Get.to(const PageNotification());
            },
            badgeContent: GetBuilder(
              init: ChuonChuonKimController.instance,
              id: "badges_noficaton",
              builder: (controller) => Text("${controller.listCart.length}", style: const TextStyle(color: Colors.white)),
            ),
            child: const Icon(Icons.notifications_none, color: Color(0xFF3A3737)),
          ),
        ),
        onTap: () {
          Get.to(const PageNotification());
        },
      ),
      GestureDetector(
        child: Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: badges.Badge(
            onTap: () {
              // Get.to(const PageCart());
            },
            badgeContent: GetBuilder(
              init: ChuonChuonKimController.instance,
              id: "badges_cart",
              builder: (controller) => Text("${controller.listCart.length}", style: const TextStyle(color: Colors.white)),
            ),
            child: const Icon(Icons.shopping_cart_outlined),
          ),
        ),
        onTap: () {
          // Get.to(const PageCart());
        },
      ),
    ],
  );
}

Widget buildSearch({required BuildContext context}) {
  TextEditingController c = TextEditingController();

  void startSearch() {
    String textSearch = c.text;
    c.clear;
    ChuonChuonKimController.instance.showProductSearch(search: textSearch);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PageProductSearch(search: textSearch))
    );
  }

  return SizedBox(
    height: 50,
    child: TextField(
      controller: c,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        suffixIcon: GestureDetector(
          child: const Icon(
            Icons.search,
            color: Colors.redAccent,
          ),
          onTap: () {
            startSearch();
          },
        ),
        hintText: "Tìm kiếm...",
      ),
      onSubmitted: (value) {
        startSearch();
      },
    ),
  );
}

Widget buildFilter() {
  var controller = ChuonChuonKimController.instance;
  return SizedBox(
    height: 70,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: controller.listProductType.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        var item = controller.listProductType[index];
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                spreadRadius: 2,
                blurRadius: 4,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: GestureDetector(
              child: Image.network(item.hinhAnhLSP),
              onTap: () {
                controller.showProductType(idLSP: item.maLSP);
              },
            ),
          ),
        );
      },
    ),
  );
}

Widget buildGridViewProducts({required List<Product> list}) {
  if (list.isEmpty) {
    return const Column(
      children: [
        Text("Rất tiếc...không có kết quả !", style: TextStyle(fontSize: 16)),
      ],
    );
  }

  return GridView.extent(
    maxCrossAxisExtent: 250,
    crossAxisSpacing: 10,
    mainAxisSpacing: 10,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    children: list.map(
      (product) {
        return GestureDetector(
          onTap: () {
            ChuonChuonKimController.instance.showSimilaProducts(product: product);
            Get.to(PageDetails(product: product));
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Expanded(
                    child: Image.network(product.hinhAnhSP)
                  ),
                  space(0, 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(product.tenSP, style: const TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold)),
                          Text(shortText(text: product.moTaSP, lengthMax: 20), style: const TextStyle(color: Colors.black45, fontSize: 15)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${product.giaSP}đ", style: const TextStyle(fontWeight: FontWeight.normal)),
                          Text("Đã bán: ${Random().nextInt(400)}", style: const TextStyle(fontWeight: FontWeight.normal)),
                        ]
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }
    ).toList()
  );
}

Widget buildInstruction({required String text}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        text,
        style: const TextStyle(color: Colors.black87, fontSize: 17, fontWeight: FontWeight.bold),
      ),
    ],
  );
}