import 'package:chuonchuonkim_app/controllers/chuonChuonKimController.dart';
import 'package:chuonchuonkim_app/database/models/Cart.dart';
import 'package:chuonchuonkim_app/helper/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ConfirmOrder extends StatelessWidget {
  const ConfirmOrder({super.key});

  @override
  Widget build(BuildContext context) {
    var u = ChuonChuonKimController.instance.userSnapshot!;
    var listCardSelected = ChuonChuonKimController.instance.getCart;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Xác nhận đặt hàng"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              ///
              space(0, 20),
              _buildRow(
                  const Icon(
                    Icons.location_on,
                    color: Colors.redAccent,
                  ),
                  u.user.diaChi),

              ///
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
                  _buildVanChuyen("Nhanh", "2-5 ngày"),
                  space(10, 0),
                  _buildVanChuyen("Tiết kiệm", "2-7 ngày"),
                ],
              ),

              ///
              space(0, 20),
              _buildRow(
                  const Icon(
                    Icons.monetization_on_outlined,
                    color: Colors.redAccent,
                  ),
                  "Thanh toán khi nhận hàng"),
              ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(dbCart[index].maSP),
                    trailing: Text(dbCart[index].soLuong.toString()),
                  );
                },
                itemCount: dbCart.length,
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
            const Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.only(right: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Tổng thanh toán",
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "100000",
                      style: TextStyle(
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
              ),
            )
          ],
        ),
      ),
    );
  }

  Row _buildRow(Icon icon, String textLeft) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        icon,
        space(5, 0),
        const Text(
          "Địa chỉ nhận hàng",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        space(20, 0),
        Expanded(child: Text(textLeft)),
      ],
    );
  }

  Container _buildVanChuyen(String type, String time) {
    return Container(
      height: 60,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 4,
            spreadRadius: 1,
          )
        ],
      ),
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
    );
  }
}
