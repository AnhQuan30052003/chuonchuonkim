import 'package:chuonchuonkim_app/controllers/chuonChuonKimController.dart';
import 'package:chuonchuonkim_app/database/models/Notification.dart';
import 'package:flutter/material.dart';

import '../../database/models/Product.dart';
import '../../helper/widget.dart';

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
              child: Column(
                children: [
                  CircleAvatar(),
                ],
              )
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

          print("Lấy dữ liệu. Length: ${list.length}");
          return Text("$count đơn đang chờ", style: const TextStyle(color: Colors.white));

          // return Column(
          // children: [
          //   Text("$count đơn đang chờ", style: const TextStyle(color: Colors.white)),

          // space(0, 10),
          // ListView.separated(
          //   itemBuilder: (context, index) {
          //     var c = ChuonChuonKimController.instance;
          //     NotificationsSnapshot item = list[index];
          //     Product? getP;
          //
          //     for (var ps in c.listProductSnapshot) {
          //       if (ps.product.maSP == item.notification.maSP) {
          //         getP = ps.product;
          //         break;
          //       }
          //     }
          //     Product p = getP!;
          //
          //     return Card(
          //       child: Row(
          //         children: [
          //           Expanded(
          //             flex: 1,
          //             child: Image.network(p.hinhAnhSP),
          //           ),
          //           Expanded(
          //             flex: 2,
          //             child: Padding(
          //               padding: const EdgeInsets.symmetric(horizontal: 10.0),
          //               child: Column(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   Text(p.tenSP),
          //                 ],
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //     );
          //   },
          //   separatorBuilder: (context, index) => const Divider(thickness: 1.5),
          //   itemCount: list.length
          // )
          // ],
          // );
        },
      ),
    );
  }
}
