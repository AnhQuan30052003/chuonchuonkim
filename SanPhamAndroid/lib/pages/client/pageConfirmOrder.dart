import 'package:chuonchuonkim_app/controllers/chuonChuonKimController.dart';
import 'package:chuonchuonkim_app/helper/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ConfirmOrder(),
    );
  }
}

class ConfirmOrder extends StatelessWidget {
  const ConfirmOrder({super.key});

  @override
  Widget build(BuildContext context) {
    // var c = ChuonChuonKimController.instance.userSnapshot!;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Xác nhận đặt hàng"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              space(0, 20),
              const Row(
                children: [
                  Text(
                    "Địa chỉ nhận hàng",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              space(0, 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(13),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: 3,
                      spreadRadius: 1,
                    )
                  ],
                ),
                height: 60,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Ninh than, Ninh hoa"),
                      TextButton(
                        onPressed: () {},
                        child: const Text("Thay đổi", style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                ),
              ),
              space(0, 20),
              const Row(
                children: [
                  Text(
                    "Phương thức thanh toán",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
