// Quân

import 'package:chuonchuonkim_app/helper/dialog.dart';
import 'package:chuonchuonkim_app/pages/client/pageConfirmOrder.dart';
import 'package:flutter/widgets.dart';
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
    CheckProductController selectAll = CheckProductController();

    for (int i = 0; i < ChuonChuonKimController.instance.listCartSnapshot.length; i++) {
      listCounter.add(CounterQuantityProductController(ChuonChuonKimController.instance.listCartSnapshot[i].cart.soLuong));
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

          List<CartSnapshot> list = [];

          try {
            list = snapshot.data!;
            var c = ChuonChuonKimController.instance;
            c.listCartSnapshot = list;
            c.listCartSnapshot
                .sort((CartSnapshot a, CartSnapshot b) => a.cart.idCart.compareTo(b.cart.idCart));
          } catch (error) {
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
                                    c.showSimilarProducts(product: p);
                                    Get.to(() => PageDetails(product: p));
                                  },
                                  backgroundColor: Colors.blue,
                                  foregroundColor: Colors.white,
                                  icon: Icons.info_outline,
                                  label: 'Chi tiết',
                                ),
                                SlidableAction(
                                  onPressed: (value) async {
                                    thongBaoDangThucHien(
                                        context: context, info: "Đang xoá khỏi giỏ hàng...");
                                    listCheck.removeAt(index);
                                    listCounter.removeAt(index);
                                    var c = ChuonChuonKimController.instance;
                                    c.deleteFromCart(index: index);

                                    await item.delete().then((value) {
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
                        separatorBuilder: (context, index) => const Divider(thickness: 1.5),
                        itemCount: list.length)),
                _buildBottomInfo(listCounter, listCheck, selectAll, context)
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      color: Colors.white,
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: Obx(() => Checkbox(
                value: checkProduct.isChecked.value,
                onChanged: (bool? newBool) {
                  checkProduct.check();
                  ChuonChuonKimController.instance.updateNameId(nameId: "sumMoney");
                },
              )
            ),
          ),
          Expanded(
            child: ListTile(
              leading: SizedBox(width: 50, height: 100, child: Image.network(p.hinhAnhSP)),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text(p.tenSP)),
                  Text("${p.giaSP} đ"),
                ],
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    IconButton(
                      onPressed: () {
                        counterQuantity.decrement();
                        ChuonChuonKimController.instance.updateNameId(nameId: "sumMoney");
                      },
                      icon: const Icon(Icons.remove),
                    ),
                    Obx(() => Text("${counterQuantity.count.value}")),
                    IconButton(
                      onPressed: () {
                        counterQuantity.increment();
                        ChuonChuonKimController.instance.updateNameId(nameId: "sumMoney");
                      },
                      icon: const Icon(Icons.add),
                    )
                  ]),
                  Obx(() => Text(
                      "Tổng: ${sumPirceOfProduct(product: p, quantity: counterQuantity.count.value)} đ",
                      style: const TextStyle(color: Colors.red))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildBottomInfo(List<CounterQuantityProductController> listCounter, List<CheckProductController> listCheck, CheckProductController selectAll, BuildContext context) {
    void checkAll(bool check) {
      for (var o in listCheck) {
        if (selectAll.isChecked.value = true) {
          o.isChecked.value = true;
        }
      }
    }

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Obx(() => SizedBox(
                  child: Checkbox(
                    value: selectAll.isChecked.value,
                    onChanged: (bool? newBool) {
                      selectAll.check();
                      print("Click tất cả: ${selectAll.isChecked.value}");
                      ChuonChuonKimController.instance.updateNameId(nameId: "sumMoney");
                    },
                  ),
                )),
                const Text("Tất cả", style: TextStyle(color: Colors.black, fontSize: 16))
              ],
            ),
          ),
          GetBuilder(
            init: ChuonChuonKimController.instance,
            id: "sumMoney",
            builder: (controller) => Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.grey,
                ),
                const SizedBox(height: 10),
                Text(
                    "Tổng tiền: ${sumPriceOfList(listCounter: listCounter, listCheck: listCheck)} đ",
                    style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () {
                      var c = ChuonChuonKimController.instance;
                      String text;

                      if (c.listCartSnapshot.isEmpty) {
                        text = "Hãy thêm sản phẩm vào giỏ hàng !";
                        info(context, text);
                        return;
                      }

                      int sumChecked = 0;
                      for (var check in listCheck) {
                        if (check.isChecked.value) {
                          sumChecked += 1;
                        }
                      }
                      if (sumChecked == 0) {
                        text = "Click chọn sản phẩm để đặt hàng !";
                        info(context, text);
                        return;
                      }

                      List<Product> getListProduct = [];
                      List<int> getListQuantity = [];
                      for (int i = 0; i < listCheck.length; i++) {
                        if (listCheck[i].isChecked.value) {
                          getListQuantity.add(listCounter[i].count.value);
                          getListProduct.add(c.getProductFromID(id: c.listCartSnapshot[i].cart.maSP)!);
                        }
                      }

                      Get.to(() => ConfirmOrder(listProduct: getListProduct, listQuantity: getListQuantity));
                    },
                    child: Text("Mua hàng (${numberOfItemSelected(listCheck)})", style: const TextStyle(color: Colors.white)))
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Hiên thị thông báo
  void info(BuildContext context, String text) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Center(
                  child: Text("Thông báo", style: TextStyle(fontWeight: FontWeight.bold))),
              content: Text(text),
              actions: [
                ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text("OK"))
              ],
            ));
  }

  // Tổng giá của sản phẩm
  int sumPirceOfProduct({required Product product, required int quantity}) {
    return product.giaSP * quantity;
  }

  // Tính số lượng sản phẩm đã chọn
  int numberOfItemSelected(List<CheckProductController> listCheck) {
    int cnt = 0;
    for (var o in listCheck) {
      if (o.isChecked.value) {
        cnt++;
      }
    }
    return cnt;
  }

  // Tổng tiền cả giỏ hàng
  int sumPriceOfList(
      {required List<CounterQuantityProductController> listCounter,
      required List<CheckProductController> listCheck}) {
    int sum = 0;
    var c = ChuonChuonKimController.instance;
    for (int i = 0; i < c.listCartSnapshot.length; i++) {
      if (listCheck[i].isChecked.value) {
        sum += sumPirceOfProduct(
            product: c.getProductFromCart(maSP: c.listCartSnapshot[i].cart.maSP)!,
            quantity: listCounter[i].count.value);
      }
    }
    return sum;
  }
}
