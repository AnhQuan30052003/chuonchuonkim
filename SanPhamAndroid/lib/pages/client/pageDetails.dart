// Đạt

import 'dart:math';
import 'package:chuonchuonkim_app/controllers/chuonChuonKimController.dart';
import 'package:chuonchuonkim_app/controllers/counterQuantityProductController.dart';
import 'package:chuonchuonkim_app/database/models/Cart.dart';
import 'package:chuonchuonkim_app/database/models/ProductFavorite.dart';
import 'package:chuonchuonkim_app/helper/dialog.dart';
import 'package:chuonchuonkim_app/helper/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../database/models/Product.dart';
import '../../helper/widgetClient.dart';
import '../system/sign/login.dart';
import 'pageConfirmOrder.dart';


class PageDetails extends StatefulWidget {
  final Product product ;
  PageDetails({required this.product, super.key});

  @override
  State<PageDetails> createState() => _PageDetailsState();
}

class _PageDetailsState extends State<PageDetails> {
  bool tym = false;

  @override
  void initState() {
    var c = ChuonChuonKimController.instance;
    List<ProductFavoriteSnapshot> list = c.listProductFavoriteSnapshot;
    for (var pfs in list) {
      if (pfs.productFavorite.maSP == widget.product.maSP) {
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
                        icon: GetBuilder(
                          init: ChuonChuonKimController.instance,
                          id: widget.product.maSP,
                          builder: (controller) {
                            return tym ? const Icon(Icons.favorite, color: Colors.red) : const Icon(Icons.favorite, color: Colors.black26);
                          },
                        ),
                        onPressed: () async {
                          var c = ChuonChuonKimController.instance;

                          if (c.isLogin == false) {
                            Get.to(() => const PageLogin());
                            return;
                          }

                          tym = !tym;
                          c.updateNameId(nameId: widget.product.maSP);

                          if (tym) {
                            String id = "0";
                            var lastProductFavoriteSnapshot = c.listProductFavoriteSnapshot.lastOrNull;
                            if (lastProductFavoriteSnapshot != null) {
                              id = lastProductFavoriteSnapshot.productFavorite.maSP;
                            }

                            int number = int.parse(id) + 1;
                            ProductFavorite pf = ProductFavorite(idPF: getIdToString(number), idUser: c.userSnapshot!.user.id, maSP: widget.product.maSP);
                            await ProductFavoriteSnapshot.add(pf)
                            .then((value) {
                              thongBaoThucHienXong(context: context, info: "Đã thêm vào yêu thích.");
                            });
                          }
                          else {
                            for (var pfn in c.listProductFavoriteSnapshot) {
                              if (pfn.productFavorite.maSP == widget.product.maSP) {
                                await pfn.delete();
                                c.listProductFavoriteSnapshot.remove(pfn);
                                break;
                              }
                            }
                            thongBaoThucHienXong(context: context, info: "Đã xoá khỏi yêu thích.");
                          }
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
                    onPressed: () async {
                      var c = ChuonChuonKimController.instance;
                      if (c.isLogin == false) {
                        Get.to(() => const PageLogin());
                        return;
                      }

                      String id = "0";
                      var lastCartSnapshot = c.listCartSnapshot.lastOrNull;
                      if (lastCartSnapshot != null) {
                        id = lastCartSnapshot.cart.idCart;
                      }

                      int number = int.parse(id) + 1;
                      Cart cart = Cart(idCart: getIdToString(number), idUser: c.userSnapshot!.user.id, maSP: widget.product.maSP, soLuong: 1);
                      await c.addToCart(cartNew: cart)
                      .then((value) {
                        thongBaoThucHienXong(context: context, info: "Đã thêm vào giỏ hàng.");
                      });
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
                      var c = ChuonChuonKimController.instance;
                      if (c.isLogin == false) {
                        Get.to(() => const PageLogin());
                        return;
                      }

                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          CounterQuantityProductController quantity = CounterQuantityProductController(0);

                          return SizedBox(
                            height: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        quantity.decrement();
                                      },
                                      icon: const Icon(Icons.remove),
                                    ),
                                    Obx(() => Text("${quantity.count.value}")),
                                    IconButton(
                                      onPressed: () {
                                        quantity.increment();
                                      },
                                      icon: const Icon(Icons.add),
                                    ),
                                  ],
                                ),

                                Container(
                                  height: 50,
                                  width: 40,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        side: const BorderSide(
                                          color: Colors.redAccent
                                        )
                                      )
                                    ),
                                    onPressed: () {
                                      List<Product> getListProduct = [];
                                      List<int> getListQuantity = [];
                                      getListProduct.add(widget.product);
                                      getListQuantity.add(quantity.count.value);
                                  
                                      Navigator.of(context).pop();
                                      Get.to(() => ConfirmOrder(listProduct: getListProduct, listQuantity: getListQuantity));
                                    },
                                    child: const Text("Mua", style: TextStyle(color: Colors.redAccent),),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      );
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
