// Đạt

import 'dart:math';
import 'package:chuonchuonkim_app/controllers/chuonChuonKimController.dart';
import 'package:chuonchuonkim_app/helper/widget.dart';
import 'package:flutter/material.dart';
import '../../database/models/Product.dart';
import '../../helper/widgetClient.dart';

class PageDetails extends StatelessWidget {
  final Product product;
  const PageDetails({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    Widget buildBody() {
      String randomStar() {
        List<int> soNguyen = [2, 3, 4];
        double soLe = (Random().nextInt(8) + 1) / 10;
        double tong = soNguyen[Random().nextInt(soNguyen.length)] + soLe;

        return "$tong";
      }

      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Column(
            children: [
              SizedBox(
                height: 350,
                width: MediaQuery.of(context).size.width,
                child: Image.network(product.hinhAnhSP),
              ),
              
              space(0, 20),
              Row(
                children: [
                  Text(
                    "${product.giaSP}đ",
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                    )
                  ),
                  space(10, 0),
                  Text(
                    "${product.giaSP * 1.25}đ",
                    style: const TextStyle(
                      fontSize: 15,
                      decoration: TextDecoration.lineThrough
                    )
                  ),
                ],
              ),

              Row(
                children: [
                  Text(product.moTaSP, style: const TextStyle(fontSize: 20)),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.yellow),
                          Text("${randomStar()} / 5"),
                        ],
                      ),
                      Text("  |  Đã bán ${Random().nextInt(400)}"),
                    ]
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.favorite, color: Colors.black26),
                        onPressed: () {

                        },
                      ),
                    ],
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {

                    },
                    child: Row(
                      children: [
                        const Icon(Icons.shopping_cart_outlined),
                        space(5, 0),
                        const Text("Thêm vào giỏ hàng"),
                      ],
                    )
                  ),
                  ElevatedButton(
                    onPressed: () {

                    },
                    child: const Text("Mua ngay")
                  ),
                ],
              ),

              space(0, 10),
              buildInstruction(text: "Sản phẩm tương tự"),
              space(0, 10),
              buildGridViewProducts(list: ChuonChuonKimController.instance.listSimilarProducts, showNotFound: false),
            ],
          ),
        ),
      );
    }



    return Scaffold(
      appBar: buildAppBar(info: "Chi tiết"),
      body: buildBody(),
    );
  }
}