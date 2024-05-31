import 'package:chuonchuonkim_app/controllers/chuonChuonKimController.dart';
import 'package:chuonchuonkim_app/database/connect/setupFirebase.dart';
import 'package:chuonchuonkim_app/helper/dialog.dart';
import 'package:chuonchuonkim_app/helper/widget.dart';
import 'package:chuonchuonkim_app/pages/system/sign/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../database/models/User.dart';

class PageSignup extends StatefulWidget {
  const PageSignup({super.key});

  @override
  State<PageSignup> createState() => _PageSignupState();
}

class _PageSignupState extends State<PageSignup> {
  bool hiddenPass = true;
  String messageError = "";

  TextEditingController txtUser = TextEditingController();
  TextEditingController txtPass = TextEditingController();
  TextEditingController txtPassConfirm = TextEditingController();
  TextEditingController txtTen = TextEditingController();
  TextEditingController txtSdt = TextEditingController();
  TextEditingController txtDiaChi = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Image.asset("assets/freed.png"),
              Text(messageError, style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),

              space(0, 50),
              _buildTextField(controller: txtUser, text: "Tài khoản", icon: const Icon(Icons.person)),

              space(0, 15),
              _buildTextField(controller: txtTen, text: "Tên", icon: const Icon(Icons.drive_file_rename_outline)),

              space(0, 15),
              TextField(
                controller: txtSdt,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: "Số điện thoại",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(CupertinoIcons.phone)
                ),
              ),

              space(0, 15),
              _buildTextField(controller: txtDiaChi, text: "Địa chỉ", icon: const Icon(Icons.location_on_outlined)),

              space(0, 15),
              _buildTextFieldPass(controller: txtPass, text: "Mật khẩu"),
              space(0, 15),
              _buildTextFieldPass(controller: txtPassConfirm, text: "Nhập lại mật khẩu"),

              space(0, 50),
              ElevatedButton(
                onPressed: () async {
                  if (txtUser.text.isNotEmpty && txtPass.text.isNotEmpty && txtTen.text.isNotEmpty && txtSdt.text.isNotEmpty && txtDiaChi.text.isNotEmpty) {
                    if (txtPass.text != txtPassConfirm.text) {
                      messageError = "Mật khẩu xác nhận không chích xác !";
                      setState(() {});
                      return;
                    }

                    thongBaoDangThucHien(context: context, info: "Đang tạo...");
                    var c = ChuonChuonKimController.instance;
                    c.listUserSnapshot = await UserSnapshot.futureData();
                    c.listUserSnapshot.sort((UserSnapshot a,UserSnapshot b) => a.user.id.compareTo(b.user.id));

                    int number = 1 + int.parse(c.listUserSnapshot.last.user.id);

                    User u = User(
                      id: getIdToString(number),
                      user: txtUser.text,
                      pass: txtPass.text,
                      ten: txtTen.text,
                      sdt: txtSdt.text,
                      diaChi: txtDiaChi.text,
                      hinhAnhUser: Firebase.avtDefault,
                    );

                    await UserSnapshot.add(u);
                    await c.login(user: u.user, password: u.pass)
                    .then((value) {
                      thongBaoThucHienXong(context: context, info: "Tạo thành công. Đăng nhập thành công");
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(55),
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text("Tạo tài khoản", style: TextStyle(fontSize: 18, color: Colors.white)),
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
    );
  }

  TextFormField _buildTextFieldPass({required TextEditingController controller, required String text}) {
    return TextFormField(
      controller: controller,
      obscureText: hiddenPass,
      decoration: InputDecoration(
        labelText: text,
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.lock),
        suffixIcon:
          IconButton(
            onPressed: () {
              hiddenPass = !hiddenPass;
              setState(() {});
            },
            icon: Icon(hiddenPass ? Icons.visibility_off_outlined : Icons.remove_red_eye)
          ),
      ),
    );
  }

  TextField _buildTextField({required TextEditingController controller, required String text, required Icon icon}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: text,
        border: const OutlineInputBorder(),
        prefixIcon: icon
      ),
    );
  }
}