// * Đạt

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../controllers/chuonChuonKimController.dart';
import '../../database/connect/firebaseConnect.dart';

void main() {
  return runApp(const ClientConnect());
}

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
          var list = controller.listProduct;
          return Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
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
                      onChanged: (input) {

                      },
                    ),
                  ),
                  // * end search

                  const SizedBox(height: 20),

                  // * filter
                  SizedBox(
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
                  const SizedBox(height: 10),

                  // * card product
                  SizedBox(
                    height: 250,
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
                                        item.tenSP,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        item.moTaSP,
                                        style: const TextStyle(color: Colors.black45, fontSize: 15),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${item.giaSP}đ",
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
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 35,
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
                                child: Image.network(
                                  item.hinhAnhSP,
                                  height: 140,
                                  width: 140,
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                  // * end card product
                  const SizedBox(height: 10),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Sản phẩm",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  GetBuilder<ChuonChuonKimController>(
                    builder: (controller) {
                      return GridView.extent(
                        maxCrossAxisExtent: 250,
                        shrinkWrap: true,
                        children: controller.listProduct
                            .map((product) => GestureDetector(
                                  onTap: () {},
                                  child: ListView(
                                    children: [
                                      Stack(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(top: 8.0),
                                            child: Container(
                                              margin: const EdgeInsets.all(10),
                                              height: 200,
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
                                                      product.tenSP,
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 17,
                                                          fontWeight: FontWeight.bold),
                                                    ),
                                                    Text(
                                                      product.moTaSP,
                                                      style: const TextStyle(
                                                          color: Colors.black45, fontSize: 15),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(
                                                          "${product.giaSP}đ",
                                                          style: const TextStyle(
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.normal),
                                                        ),
                                                        Container(
                                                          height: 30,
                                                          width: 30,
                                                          decoration: BoxDecoration(
                                                            color: Colors.black12,
                                                            borderRadius: BorderRadius.circular(30),
                                                          ),
                                                          child: const Icon(
                                                              Icons.favorite_border_outlined),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 25,
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
                                              child: Image.network(
                                                product.hinhAnhSP,
                                                height: 140,
                                                width: 140,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ))
                            .toList(),
                      );
                    },
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
