import 'package:chuonchuonkim_app/controllers/chuonChuonKimController.dart';
import 'package:chuonchuonkim_app/database/models/Notification.dart';
import 'package:chuonchuonkim_app/helper/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../controllers/counterQuantityProductController.dart';
import '../../database/models/Product.dart';
import 'pageOrderSuccess.dart';

class ConfirmOrder extends StatefulWidget {
  final List<Product> listProduct;
  final List<CounterQuantityProductController> listQuantity;
  const ConfirmOrder({required this.listProduct, required this.listQuantity, super.key});

  @override
  State<ConfirmOrder> createState() => _ConfirmOrderState();
}

class _ConfirmOrderState extends State<ConfirmOrder> {
  int phuongThucVanChuyenChon = 1;

  @override
  Widget build(BuildContext context) {
    var c = ChuonChuonKimController.instance;
    var u = c.userSnapshot!;
    String diaChiNhanHang = "${u.user.ten} | ${u.user.sdt}";

    int tongTienDaMua() {
      int tong = 0;
      for (int i = 0; i < widget.listProduct.length; i++) {
        tong += widget.listProduct[i].giaSP * widget.listQuantity[i].count.value;
      }
      return tong;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Xác nhận đặt hàng",
            style: TextStyle(fontSize: 16, color: Color(0xFF3A3737), fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Colors.redAccent,
                  ),
                  space(5, 0),
                  const Text(
                    "Địa chỉ nhận hàng",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              space(0, 20),
              Container(
                height: 70,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white70,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 1,
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(diaChiNhanHang, style: const TextStyle(fontSize: 14)),
                      Text(u.user.diaChi, style: const TextStyle(fontSize: 14)),
                    ],
                  ),
                ),
              ),
              space(0, 20),
              Row(
                children: [
                  const Icon(
                    Icons.delivery_dining_outlined,
                    color: Colors.redAccent,
                  ),
                  space(5, 0),
                  const Text(
                    "Phương thức vận chuyển",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              space(0, 20),
              Row(
                children: [
                  _buildVanChuyen("Nhanh", "2-5 ngày", 1),
                  space(10, 0),
                  _buildVanChuyen("Tiết kiệm", "2-7 ngày", 2),
                ],
              ),
              space(0, 20),
              _buildRow(
                  label: "Phương thức thanh toán",
                  icon: const Icon(Icons.monetization_on_outlined, color: Colors.redAccent),
                  textLeft: "Thanh toán khi nhận hàng"),
              ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var p = widget.listProduct[index];
                  var q = widget.listQuantity[index];
                  return Card(
                    shape: Border.all(width: 0, color: Colors.white),
                    child: ListTile(
                      leading: SizedBox(width: 50, height: 100, child: Image.network(p.hinhAnhSP)),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(p.tenSP),
                        ],
                      ),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Giá: ${p.giaSP} đ"),
                          Text("X${q.count.value}"),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: widget.listProduct.length,
                separatorBuilder: (context, index) => const Divider(thickness: 1.5),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        height: 50,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Tổng thanh toán",
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "${tongTienDaMua()} đ",
                      style: const TextStyle(
                          color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                child: Container(
                  color: Colors.red,
                  child: const Center(
                    child: Text(
                      "Đặt hàng",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                onTap: () async {
                  var c = ChuonChuonKimController.instance;

                  for (int i = 0; i < widget.listProduct.length; i++) {
                    var p = widget.listProduct[i];

                    for (var cs in c.listCartSnapshot) {
                      if (cs.cart.maSP == p.maSP) {
                        await cs.delete();
                        c.listCartSnapshot.remove(cs);
                      }
                    }
                  }

                  List<NotificationsSnapshot> listNoti = await NotificationsSnapshot.futureData();
                  listNoti.sort((NotificationsSnapshot a, NotificationsSnapshot b) => a.notification.idNoti.compareTo(b.notification.idNoti));

                  int number = 1 + int.parse(listNoti.last.notification.idNoti);

                  for (int i = 0; i < widget.listProduct.length; i++) {
                    Notifications no = Notifications(
                      idNoti: getIdToString(number++),
                      idUser: c.userSnapshot!.user.id,
                      maSP: widget.listProduct[i].maSP,
                      text: "Khách hàng ${c.userSnapshot!.user}, đã đặt đơn hàng có mã là ${widget.listProduct[i].maSP}",
                      seen: false,
                      toUser: "0000",
                      soLuong: widget.listQuantity[i].count.value
                    );

                    await NotificationsSnapshot.add(no);
                  }


                  Get.to(const OrderSuccess());
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Row _buildRow({required String label, required Icon icon, required String textLeft}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        icon,
        space(5, 0),
        Text(
          label,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        space(20, 0),
        Expanded(child: Text(textLeft)),
      ],
    );
  }

  Container _buildVanChuyen(String type, String time, int phuongThuc) {
    return Container(
      height: 60,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        border:
            Border.all(color: (phuongThucVanChuyenChon == phuongThuc ? Colors.red : Colors.white)),
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 2,
            spreadRadius: 1,
          )
        ],
      ),
      child: GestureDetector(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              type,
              style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            Text(time),
          ],
        ),
        onTap: () {
          setState(() {
            phuongThucVanChuyenChon = phuongThuc;
          });
        },
      ),
    );
  }
}
