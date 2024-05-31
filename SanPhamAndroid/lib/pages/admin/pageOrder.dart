import 'package:chuonchuonkim_app/controllers/chuonChuonKimController.dart';
import 'package:chuonchuonkim_app/database/models/Notification.dart';
import 'package:chuonchuonkim_app/helper/dialog.dart';
import 'package:flutter/material.dart';
import '../../database/models/Product.dart';
import '../../helper/widget.dart';
import '../../helper/widgetClient.dart';

class PageOrder extends StatelessWidget {
  const PageOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white10,
        title: const Text(
          "Xác nhận đơn hàng",
          style: TextStyle(fontSize: 16, color: Color(0xFF3A3737), fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder(
        stream: NotificationsSnapshot.streamData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator()
            );
          }

          List<NotificationsSnapshot> list = [];

          try {
            list = snapshot.data!;
          } catch (error) {
            list = [];
          }

          int count = 0;
          for (var no in list) {
            if (no.notification.seen == false) count += 1;
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildInstruction(text: "Cần duyệt: $count đơn"),
                space(0, 10),
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      var c = ChuonChuonKimController.instance;
                      NotificationsSnapshot item = list[index];
                      Product? getP;

                      for (var ps in c.listProductSnapshot) {
                        if (ps.product.maSP == item.notification.maSP) {
                          getP = ps.product;
                          break;
                        }
                      }
                      Product p = getP!;

                      return Card(
                        color: Colors.white,
                        shape: Border.all(width: 1, color: Colors.black),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Image.network(p.hinhAnhSP),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(p.tenSP, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                                            space(0, 5),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text("${p.giaSP}"),
                                                Text("x${item.notification.soLuong}"),
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    space(0, 20),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () async {
                                            item.notification.seen = true;
                                            thongBaoDangThucHien(context: context, info: "Đang xác nhận...");
                                            await item.update(item.notification)
                                            .then((value) {
                                              thongBaoThucHienXong(context: context, info: "Đã xác nhận.");
                                            });
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.green,
                                            minimumSize: const Size(100, 45),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                          ),
                                          child: const Text("Xác nhận", style: TextStyle(color: Colors.white)),
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            item.notification.seen = true;
                                            thongBaoDangThucHien(context: context, info: "Đang huỷ...");
                                            await item.update(item.notification)
                                            .then((value) {
                                              thongBaoThucHienXong(context: context, info: "Đã huỷ.");
                                            });
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red,
                                            minimumSize: const Size(100, 45),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                          ),
                                          child: const Text("Huỷ", style: TextStyle(color: Colors.white))
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(thickness: 1.5),
                    itemCount: list.length
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
