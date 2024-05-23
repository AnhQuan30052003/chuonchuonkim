// * Đạt

import 'dart:math';

import 'package:chuonchuonkim_app/helper/distance.dart';
import 'package:chuonchuonkim_app/helper/instruction.dart';
import 'package:chuonchuonkim_app/helper/shortText.dart';
import 'package:chuonchuonkim_app/pages/client/pageDetails.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/chuonChuonKimController.dart';
import '../../database/connect/firebaseConnect.dart';

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

class PageHomeClient extends StatelessWidget {
  const PageHomeClient({super.key});

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget buildAppBar() {
      return AppBar(
        elevation: 0,
        backgroundColor: Colors.white10,
        title: const Text(
          "Bạn muốn ăn gì?",
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF3A3737),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none,
              color: Color(0xFF3A3737),
            ),
          ),
        ],
      );
    }

    Widget buildSearch() {
      return SizedBox(
        height: 50,
        child: TextField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            prefixIcon: const Icon(
              Icons.search,
              color: Colors.redAccent,
            ),
            suffixIcon: const Icon(Icons.sort, color: Colors.redAccent),
            hintText: "Tìm kiếm",
          ),
          onChanged: (input) {},
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
                    // controller.showProductType(idLSP: list[index].maLSP);
                  },
                ),
              ),
            );
          },
        ),
      );
    }

    Widget buildProductsPopulator() {
      // Lấy toàn bộ product
      var listProduct = ChuonChuonKimController.instance.listProduct;
      var listProductType = ChuonChuonKimController.instance.listProductType;

      // Lấy cái product đàu của từn loại
      int requestQuantity = 1;
      var list = [];
      for (var pt in listProductType) {
        int quantity = 0;
        for (var p in listProduct) {
          if (p.maLSP == pt.maLSP) {
            list.add(p);
            quantity += 1;
            if (quantity == requestQuantity) break;
          }
        }
      }

      double w = 200, h = 230, cir = 130, subSpace = 20;

      return SizedBox(
        height: h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: list.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            var item = list[index];

            return Container(
              width: w,
              height: h,
              margin: const EdgeInsets.only(right: 5.0),
              child: Stack(
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        width: double.infinity,
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.red),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: w,
                        height: h-subSpace,
                        child: Column(
                          children: [
                            distance(double.infinity, (h-subSpace) * 0.55),
                            SizedBox(
                              width: double.infinity,
                              height: (h-subSpace) * 0.4,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(item.tenSP, style: const TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold)),
                                        Text(shortText(text: item.moTaSP, lengthMax: 25), style: const TextStyle(color: Colors.black45, fontSize: 15)),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("${item.giaSP}đ", style: const TextStyle(fontWeight: FontWeight.normal)),
                                        Text("Đã bán: ${Random().nextInt(400)}", style: const TextStyle(fontWeight: FontWeight.normal)),
                                      ]
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    height: h,
                    width: w,
                    top: -50,
                    child: Center(
                      child: Container(
                        width: cir,
                        height: cir,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          borderRadius: BorderRadius.circular(100),
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 4,
                              spreadRadius: 2,
                              color: Colors.black12,
                            )
                          ],
                        ),
                        child: ClipOval(
                          child: Image.network(item.hinhAnhSP, fit: BoxFit.cover)
                        ),
                      ),
                    )
                  )
                ],
              ),
            );
          },
        ),
      );
    }

    Widget buildGridViewProducts() {
      var controller = ChuonChuonKimController.instance;
      return GridView.extent(
          maxCrossAxisExtent: 250,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: controller.listProduct.map(
            (product) {
              return GestureDetector(
                onTap: () {
                  // Get.to(PageDetails(product: product));
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
                        distance(0, 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(product.tenSP, style: const TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold)),
                                Text(shortText(text: product.moTaSP, lengthMax: 25), style: const TextStyle(color: Colors.black45, fontSize: 15)),
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
    
    Widget buildBody() {
      return GetBuilder<ChuonChuonKimController>(
        init: ChuonChuonKimController.instance,
        id: "client_products",
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // * search
                  buildSearch(),

                  // * filter
                  distance(0, 10),
                  buildFilter(),

                  // * Khung phổ biến
                  distance(0, 10),
                  buildInstruction(text: "Phổ biến"),

                  // * card product phổ biến
                  distance(0, 10),
                  buildProductsPopulator(),

                  // * Khung sản phẩm
                  distance(0, 10),
                  buildInstruction(text: "Sản phẩm"),

                  // * card product
                  distance(0, 10),
                  buildGridViewProducts(),
                ]
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }
}
