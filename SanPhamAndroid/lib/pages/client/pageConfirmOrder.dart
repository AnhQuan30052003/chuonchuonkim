import 'package:flutter/material.dart';

class ConfirmOrder extends StatelessWidget {
  const ConfirmOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Xác nhận đặt hàng"),
      ),
      body: const SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Text("Địa chỉ nhận hàng"),
            SizedBox(
              height: 40,
              width: double.infinity,
              child: Row(
                children: [],
              ),
            )
          ],
        ),
      )),
    );
  }
}
