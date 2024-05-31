import 'package:chuonchuonkim_app/helper/widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../main.dart';

class OrderSuccess extends StatelessWidget {
  const OrderSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/success.png"),
              const Text("Thành công!"),
              const Text("Đơn hàng của bạn sẽ sớm được xác nhận"),
              const Text("Cảm ơn đã chọn ứng dụng của chúng tôi"),
              space(0, 20),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13),
                    ),
                    backgroundColor: Colors.redAccent,
                  ),
                  onPressed: () {
                    // Get.to(const UploadData());
                    Get.to(const App());
                  },
                  child: const Text(
                    "Tiếp tục mua hàng",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
