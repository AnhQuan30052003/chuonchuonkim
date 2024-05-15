// * Đạt

import 'package:chuonchuonkim_app/controllers/chuonChuonKimController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class PageHome extends StatelessWidget {
  final List iconTypeProduct = [
    "assets/images/icons/icon1.png",
    "assets/images/icons/icon2.png",
    "assets/images/icons/icon3.png",
    "assets/images/icons/icon1.png",
    "assets/images/icons/icon2.png",
    "assets/images/icons/icon3.png",
    "assets/images/icons/icon1.png",
  ];
  PageHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      ),
      body: GetBuilder<ChuonChuonKimController>(
        init: ChuonChuonKimController.instance,
        id: "client_products",
        builder: (controller) {
          var products = controller.listProduct;
          return Padding(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // * search
                SizedBox(
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
                  ),
                ),
                // * end search
                const SizedBox(height: 20),
                // * filter
                SizedBox(
                  height: 70,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: iconTypeProduct.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
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
                            child: Image.asset(iconTypeProduct[index]),
                            onTap: () {
                              controller.showProductType(idLSP: products[index].maLSP);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // * end filter
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Phổ biến",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        "Tất cả",
                        style: TextStyle(color: Colors.redAccent, fontSize: 15),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // * card product
                SizedBox(
                  height: 250,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: products.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              height: 250,
                              width: 190,
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
                                      products[index].tenSP,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Text(
                                      products[index].moTaSP,
                                      style: const TextStyle(color: Colors.black45, fontSize: 15),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${products[index].giaSP}đ",
                                          style: const TextStyle(fontWeight: FontWeight.normal),
                                        ),
                                        Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                            color: Colors.black12,
                                            borderRadius: BorderRadius.circular(30),
                                          ),
                                          child: const Icon(Icons.favorite_border_outlined),
                                        ),
                                      ],
                                    )
                                    // Image.asset(products[index].hinhAnhSP)
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 35,
                            // top: -10,
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
                              child: Image.asset(
                                products[index].hinhAnhSP,
                                height: 140,
                                width: 140,
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        );
        },
      ),
    );
  }
}
