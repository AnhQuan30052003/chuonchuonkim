// Quân

import 'package:chuonchuonkim_app/helper/dialog.dart';
import 'package:flutter/cupertino.dart';

import '../../controllers/chuonChuonKimController.dart';
import '../../controllers/checkProductController.dart';
import '../../controllers/counterQuantityProductController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import '../../database/models/Cart.dart';
import '../../database/models/Product.dart';
import 'pageDetails.dart';

class PageCart extends StatelessWidget {
  const PageCart({super.key});

  @override
  Widget build(BuildContext context) {
    List<CounterQuantityProductController> listCounter = [];
    List<CheckProductController> listCheck = [];
    for (int i = 0; i < ChuonChuonKimController.instance.listCart.length; i++) {
      listCounter.add(CounterQuantityProductController(ChuonChuonKimController.instance.listCart[i].cart.soLuong));
      listCheck.add(CheckProductController());
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white10,
        title: const Text(
          "Giỏ hàng của bạn",
          style: TextStyle(fontSize: 16, color: Color(0xFF3A3737), fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder(
        stream: CartSnapshot.streamData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          var list = [];
          try {
            list = snapshot.data!;
          }
          catch (error) {
            list = [];
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      var item = list[index];
                      return Slidable(
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (value) {
                                var c = ChuonChuonKimController.instance;
                                Product p = c.getProductFromCart(maSP: item.cart.maSP)!;
                                c.showSimilaProducts(product: p);
                                Get.to(PageDetails(product: p));
                              },
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              icon: Icons.info_outline,
                              label: 'Chi tiết',
                            ),
                            SlidableAction(
                              onPressed: (value) async {
                                thongBaoDangThucHien(context: context, info: "Đang xoá khỏi giỏ hàng...");
                                listCheck.removeAt(index);
                                listCounter.removeAt(index);
                                ChuonChuonKimController.instance.deleteFromCart(index: index);
                                await item.delete()
                                .then((value) {
                                  thongBaoThucHienXong(context: context, info: "Đã xoá.");
                                });
                              },
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Xoá',
                            ),
                          ],
                        ),
                        child: _buildCard(item.cart.maSP, listCounter[index], listCheck[index]),
                      );
                    },
                    separatorBuilder: (context,index) => const Divider(thickness: 1.5),
                    itemCount: list.length
                  )
                ),
                _buildBottomInfo(listCounter, listCheck, context)
              ],
            ),
          );
        },
      ),
    );
  }

  Card _buildCard(String maSP, CounterQuantityProductController counterQuantity, CheckProductController checkProduct) {
    Product p = ChuonChuonKimController.instance.getProductFromCart(maSP: maSP)!;
    return Card(
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: Obx(
              () => Checkbox(
                value: checkProduct.isChecked.value,
                onChanged: (bool? newBool) {
                  checkProduct.isChecked.value = newBool!;
                },
              )
            ),
          ),
          Expanded(
            child: ListTile(
              leading: SizedBox(
                width: 50,
                height: 100,
                child: Image.network(p.hinhAnhSP)
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text(p.tenSP)),
                  Text("${p.giaSP}đ"),
                ],
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => counterQuantity.decrement(),
                        icon: const Icon(Icons.remove),
                      ),
                      Obx(() => Text("${counterQuantity.count.value}")),
                      IconButton(
                        onPressed: () => counterQuantity.increment(),
                        icon: const Icon(Icons.add),
                      )
                    ]
                  ),
                  Obx(() => Text(
                    "Tổng: ${ChuonChuonKimController.instance.sumPirceOfProduct(product: p, quantity: counterQuantity.count.value)}đ",
                    style: const TextStyle(color: Colors.red))
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildBottomInfo(List<CounterQuantityProductController> listCounter, List<CheckProductController> listCheck, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Divider(
            height: 1,
            thickness: 1,
            color: Colors.grey,
          ),
          const SizedBox(height: 10),
          Obx(
            () =>
              Text(
              "Tổng tiền: ${ChuonChuonKimController.instance.sumPriceOfList(listCounter: listCounter, listCheck: listCheck)} đ",
              style: const TextStyle(color: Colors.red)
            ),
          ),
          const SizedBox(height: 15),
          ElevatedButton(
              onPressed: () {
                String text = "Hãy thêm sản phẩm vào giỏ hàng !";
                if (ChuonChuonKimController.instance.listCart.isNotEmpty) {
                  text = "Đặt hàng thành công";
                }
                info(context, text);
              },
              child: const Text("Đặt hàng")
          )
        ],
      ),
    );
  }

  void info(BuildContext context, String text) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Center(child: Text("Thông báo", style: TextStyle(fontWeight: FontWeight.bold))),
          content: Text(text),
          actions: [
            ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK")
            )
          ],
        )
    );
  }
}