import 'package:chuonchuonkim_app/controllers/chuonChuonKimController.dart';
import 'package:chuonchuonkim_app/helper/dialog.dart';
import 'package:chuonchuonkim_app/helper/widget.dart';
import 'package:chuonchuonkim_app/pages/client/pageHomeClient.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../admin/pageHomeAdmin.dart';
import 'signup.dart';

class PageLogin extends StatefulWidget {
  const PageLogin({super.key});

  @override
  State<PageLogin> createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin> {
  bool hiddenPass = true;
  String messageError = "";

  TextEditingController txtUser = TextEditingController();
  TextEditingController txtPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              space(0, 50),
              Image.asset("assets/freed.png"),

              Text(
                messageError,
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                )
              ),

              space(0, 50),
              TextFormField(
                controller: txtUser,
                decoration: const InputDecoration(
                  labelText: "Tài khoản",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person)),
              ),

              space(0, 15),
              TextFormField(
                controller: txtPass,
                obscureText: hiddenPass,
                decoration: InputDecoration(
                  labelText: "Mật khẩu",
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    onPressed: () {
                      hiddenPass = !hiddenPass;
                      setState(() {});
                    },
                    icon: Icon(hiddenPass ? Icons.visibility_off_rounded : Icons.remove_red_eye),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Quên mật khẩu",
                      style: TextStyle(fontSize: 15, color: Colors.redAccent),
                    ),
                  )
                ],
              ),

              space(0, 50),
              ElevatedButton(
                onPressed: () async {
                  thongBaoDangThucHien(context: context, info: "Đang đăng nhập...");
                  var c = ChuonChuonKimController.instance;
                  await c.login(user: txtUser.text.trim(), password: txtPass.text.trim())
                  .then((value) {
                    if (value == false) {
                      thongBaoThucHienXong(context: context, info: "Đăng nhập thất bại.");
                      messageError = "Tài khoản hoặc mẫu không chính xác !";
                      setState(() {});
                      return;
                    }

                    c.getData();
                    thongBaoThucHienXong(context: context, info: "Đăng nhập thành công.");
                    if (c.userSnapshot!.user.id == "0000") {
                      Get.offAll(const PageHomeAdmin());
                    }
                    else {
                      Get.offAll(const PageHomeClient());
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(55),
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text("Đăng nhập", style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
              space(0, 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Bạn không có Tài khoản?",
                    style: TextStyle(fontSize: 15, color: Colors.black54),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(const PageSignup());
                    },
                    child: const Text(
                      "Đăng kí",
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
    );
  }
}
