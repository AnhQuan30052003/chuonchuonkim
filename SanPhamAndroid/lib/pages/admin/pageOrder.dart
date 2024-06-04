import 'package:chuonchuonkim_app/controllers/chuonChuonKimController.dart';
import 'package:chuonchuonkim_app/database/models/Notification.dart';
import 'package:chuonchuonkim_app/helper/dialog.dart';
import 'package:flutter/material.dart';
import '../../database/models/Product.dart';
import '../../helper/widget.dart';
import '../../helper/widgetClient.dart';

class PageOrder extends StatefulWidget {
  const PageOrder({super.key});

  @override
  State<PageOrder> createState() => _PageOrderState();
}

class _PageOrderState extends State<PageOrder> {
  int countID = 0;


  @override
  void initState() {
    getID();
  }

  void getID() async {
    List<NotificationsSnapshot> listNoti = await NotificationsSnapshot.futureData();
    listNoti.sort((NotificationsSnapshot a, NotificationsSnapshot b) => a.notification.idNoti.compareTo(b.notification.idNoti));

    if (listNoti.isNotEmpty) {
      countID = 1 + int.parse(listNoti.last.notification.idNoti);
    }
  }

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

          if (list.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("Không có đơn hàng nào cần duyêt !")]
              )
            );
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildInstruction(text: "Cần duyệt: ${list.length} đơn"),
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

                        Notifications no = Notifications(
                          idNoti: getIdToString(countID++),
                          idUser: c.userSnapshot!.user.id,
                          maSP: item.notification.maSP,
                          text: "",
                          seen: false,
                          toUser: item.notification.idUser,
                          soLuong: item.notification.soLuong
                        );

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
                                              List<String> thongBao = [
                                                "Đang xác nhận...",
                                                "Đơn hàng ${c.getProductFromID(id:item.notification.maSP)!.tenSP} của bạn đã được xác nhận. Vui lòng chú điện thoại để nhận hàng.",
                                                "Đã xác nhận.",
                                              ];
                                              c.adminConfirm(context: context, thongBaoRaManHinh: thongBao, ns: item, no: no);
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
                                              List<String> thongBao = [
                                                "Đang huỷ...",
                                                "Đơn hàng ${c.getProductFromID(id:item.notification.maSP)!.tenSP} của bạn đã bị huỷ. Vui lòng đặt lại đơn khác !",
                                                "Đã huỷ.",
                                              ];
                                              c.adminConfirm(context: context, thongBaoRaManHinh: thongBao, ns: item, no: no);
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

