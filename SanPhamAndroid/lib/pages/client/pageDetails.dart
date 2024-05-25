// Đạt

import 'dart:math';
import 'package:chuonchuonkim_app/controllers/chuonChuonKimController.dart';
import 'package:chuonchuonkim_app/database/models/Cart.dart';
import 'package:chuonchuonkim_app/database/models/ProductFavorite.dart';
import 'package:chuonchuonkim_app/helper/dialog.dart';
import 'package:chuonchuonkim_app/helper/widget.dart';
import 'package:flutter/material.dart';
import '../../database/models/Product.dart';
import '../../helper/widgetClient.dart';

class PageDetails extends StatefulWidget {
  final Product product;
  const PageDetails({required this.product, super.key});

  @override
  State<PageDetails> createState() => _PageDetailsState();
}

class _PageDetailsState extends State<PageDetails> {
  bool tym = false;

  @override
  void initState() {
    List<ProductFavoriteSnapshot> list = ChuonChuonKimController.instance.listProductFavoriteSnapshot;
    for (var pfn in list) {
      if (pfn.productFavorite.maSP == widget.product.maSP) {
        tym = true;
        return;
      }
    }
  }

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
                child: Image.network(widget.product.hinhAnhSP),
              ),

              space(0, 20),
              Row(
                children: [
                  Text(
                      "${widget.product.giaSP}đ",
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.red,
                      )
                  ),
                  space(10, 0),
                  Text(
                      "${widget.product.giaSP * 1.25}đ",
                      style: const TextStyle(
                          fontSize: 15,
                          decoration: TextDecoration.lineThrough
                      )
                  ),
                ],
              ),

              Row(
                children: [
                  Text(widget.product.moTaSP, style: const TextStyle(fontSize: 20)),
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
                        icon: tym ? const Icon(Icons.favorite, color: Colors.red) : const Icon(Icons.favorite, color: Colors.black26),
                        onPressed: () {
                          tym = !tym;
                          setState(() {});

                          var c = ChuonChuonKimController.instance;
                          if (tym) {
                            String id = "0";
                            var lastProductFavoriteSnapshot = c.listProductFavoriteSnapshot.lastOrNull;
                            if (lastProductFavoriteSnapshot != null) {
                              id = lastProductFavoriteSnapshot.productFavorite.maSP;
                            }

                            int number = int.parse(id) + 1;
                            ProductFavorite pf = ProductFavorite(idPF: getIdToString(number), idUser: c.idUser, maSP: widget.product.maSP);
                            ProductFavoriteSnapshot.add(pf);
                            thongBaoThucHienXong(context: context, info: "Đã thêm vào yêu thích.");
                          }
                          else {
                            for (var pfn in c.listProductFavoriteSnapshot) {
                              if (pfn.productFavorite.maSP == widget.product.maSP) {
                                pfn.delete();
                                break;
                              }
                            }
                            thongBaoThucHienXong(context: context, info: "Đã xoá khỏi yêu thích.");
                          }

                          c.getProductFavoriteSnapshot();
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
                      var c = ChuonChuonKimController.instance;

                      String id = "0";
                      var lastCartSnapshot = c.listCartSnapshot.lastOrNull;
                      if (lastCartSnapshot != null) {
                        id = lastCartSnapshot.cart.idCart;
                      }

                      int number = int.parse(id) + 1;
                      Cart cart = Cart(idCart: getIdToString(number), idUser: c.idUser, maSP: widget.product.maSP, soLuong: 1);
                      c.addToCart(cartNew: cart);
                      thongBaoThucHienXong(context: context, info: "Đã thêm vào giỏ hàng.");
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
              buildGridViewProducts(context: context, list: ChuonChuonKimController.instance.listSimilarProducts, showNotFound: false),
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
