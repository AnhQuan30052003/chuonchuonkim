// Quân

import '../../controllers/chuonChuonKimController.dart';
import '../../controllers/checkProductController.dart';
import '../../controllers/counterQuantityProductController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
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
      // body: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.end,
      //     children: [
      //       Expanded(
      //         child: GetBuilder(
      //           init: ChuonChuonKimController.instance,
      //           id: "list_cart",
      //           builder: (controller) => ListView.separated(
      //             itemBuilder: (context, index) => Slidable(
      //                 endActionPane: ActionPane(
      //                   motion: const ScrollMotion(),
      //                   children: [
      //                     SlidableAction(
      //                       onPressed: (value) {
      //                         Get.to(PageDetails(product: ChuonChuonKimController.instance.getProductFromCart(index: index)!));
      //                       },
      //                       backgroundColor: Colors.blue,
      //                       foregroundColor: Colors.white,
      //                       icon: Icons.info_outline,
      //                       label: 'Chi tiết',
      //                     ),
      //                     SlidableAction(
      //                       onPressed: (value) {
      //                         listCheck.removeAt(index);
      //                         ChuonChuonKimController.instance.deleteFromCart(index: index);
      //                       },
      //                       backgroundColor: Colors.red,
      //                       foregroundColor: Colors.white,
      //                       icon: Icons.delete,
      //                       label: 'Xoá',
      //                     ),
      //                   ],
      //                 ),
      //                 child: _buildCard(index, listCounter[index], listCheck[index]),
      //               ),
      //             separatorBuilder: (context,index) => const Divider(thickness: 1.5),
      //             itemCount: ChuonChuonKimController.instance.listCart.length
      //           ),
      //         ),
      //       ),
      //       _buildBottomInfo(listCounter, listCheck, context)
      //     ],
      //   ),
      // ),
    );
  }

  Card _buildCard(int index, CounterQuantityProductController counterQuantity, CheckProductController checkProduct) {
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
                child: GestureDetector(
                    onTap: () => Get.to(PageDetails(product: ChuonChuonKimController.instance.getProductFromCart(index: index)!)),
                    child: Image.network("${ChuonChuonKimController.instance.getProductFromCart(index: index)?.hinhAnhSP}")
                )
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${ChuonChuonKimController.instance.getProductFromCart(index: index)?.tenSP}"),
                  Text("${ChuonChuonKimController.instance.getProductFromCart(index: index)?.giaSP}"),
                ],
              ),
              subtitle: Row(
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
                  const SizedBox(width: 10),
                  Obx(() => Text(
                    "Tổng: ${ChuonChuonKimController.instance.sumPirceOfProduct(index: index, quantity: counterQuantity.count.value)} đ",
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