// * Đạt

import 'dart:math';
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

class PageHomeClient extends StatelessWidget {
  const PageHomeClient({super.key});

  @override
  Widget build(BuildContext context) {
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

    Widget buildProductsPopulator() {
      double w = 190, h = 230;

      return GetBuilder(
        init: ChuonChuonKimController.instance,
        id: "products_populator",
        builder: (controller) {
          var list = controller.listProductsPopulator;
          return SizedBox(
            height: h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: list.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var item = list[index];

                return Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        height: h,
                        width: w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 4,
                              spreadRadius: 2,
                              color: Colors.black12,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const SizedBox(height: 7),
                              Text(
                                item.tenSP,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                              ),
                              Text(shortText(text: item.moTaSP, lengthMax: 20), style: const TextStyle(color: Colors.black45, fontSize: 15)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("${item.giaSP}đ", style: const TextStyle(fontWeight: FontWeight.normal),),
                                  Text("Đã bán: ${Random().nextInt(400)}", style: const TextStyle(fontWeight: FontWeight.normal)),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 45,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80),
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 4,
                              spreadRadius: 2,
                              color: Colors.black12,
                            )
                          ],
                        ),
                        child: ClipOval(
                          child: SizedBox.fromSize(
                            size: const Size.fromRadius(60), // Image radius
                            child: Image.network(item.hinhAnhSP, fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          );
        },
      );
    }
    
    Widget buildBody() {
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
                  buildSearch(context: context, search: ""),

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
                      return buildGridViewProducts();
                    }
                  )
                ]
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: buildAppBar(info: "Bạn muốn ăn gì?"),
      body: buildBody(),
    );
  }
}
