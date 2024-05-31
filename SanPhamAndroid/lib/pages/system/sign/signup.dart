import 'package:chuonchuonkim_app/helper/widget.dart';
import 'package:chuonchuonkim_app/pages/system/sign/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageSignup extends StatefulWidget {
  const PageSignup({super.key});

  @override
  State<PageSignup> createState() => _PageSignupState();
}

class _PageSignupState extends State<PageSignup> {
  bool showPass = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Image.asset("assets/freed.png"),
                space(0, 50),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Họ và tên",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person)),
                ),
                space(0, 15),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                      labelText: "Số điện thoại (tài khoản)",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.phone_android)),
                ),
                space(0, 15),
                TextFormField(
                  obscureText: showPass,
                  decoration: InputDecoration(
                    labelText: "Mật khẩu",
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon:
                        IconButton(onPressed: () {}, icon: const Icon(Icons.remove_red_eye)),
                  ),
                ),
                space(0, 15),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Nhập lại mật khẩu",
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon:
                        IconButton(onPressed: () {}, icon: const Icon(Icons.remove_red_eye)),
                  ),
                ),
                space(0, 50),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(55),
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text("Tạo tài khoản",
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
                space(0, 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Bạn đã có Tài khoản?",
                      style: TextStyle(fontSize: 15, color: Colors.black54),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(const PageLogin());
                      },
                      child: const Text(
                        "Đăng nhập",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
