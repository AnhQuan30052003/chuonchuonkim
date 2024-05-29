import 'package:chuonchuonkim_app/controllers/chuonChuonKimController.dart';
import 'package:chuonchuonkim_app/helper/widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helper/dialog.dart';

class EditPassword extends StatelessWidget {
  const EditPassword({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController txtCu = TextEditingController();
    TextEditingController txtMoi = TextEditingController();
    TextEditingController txtMoiXN = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Đổi mật khẩu"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              space(0, 30),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Mật khẩu cũ", style: TextStyle(fontSize: 15)),
                    const SizedBox(height: 10),
                    _buildTextField(txtCu)
                  ],
                ),
              ),
              space(0, 20),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Mật khẩu mới", style: TextStyle(fontSize: 15)),
                    const SizedBox(height: 10),
                    _buildTextField(txtMoi)
                  ],
                ),
              ),
              space(0, 20),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Xác nhận mật khẩu mới", style: TextStyle(fontSize: 15)),
                    const SizedBox(height: 10),
                    _buildTextField(txtMoiXN)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        margin: const EdgeInsets.all(20),
        // padding: const EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orangeAccent,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            )
          ),
          child: const Text("ĐỔI MẬT KHẨU", style: TextStyle(color: Colors.white, fontSize: 15)),
          onPressed: () async {
            var c = ChuonChuonKimController.instance;
            if (txtCu.text != c.userSnapshot!.user.pass) {
              thongBaoThucHienXong(context: context, info: "Mật khẩu cũ không chính xác !");
              return;
            }

            if (txtMoi.text != txtMoiXN.text) {
              thongBaoThucHienXong(context: context, info: "Mật khẩu mới xác nhận không giống !");
              return;
            }

            thongBaoDangThucHien(context: context, info: "Đang cập nhật...");
            if (txtCu.text.isNotEmpty && txtMoi.text.isNotEmpty && txtMoiXN.text.isNotEmpty) {
              c.userSnapshot!.user.pass = txtMoi.text;
              await c.userSnapshot!.update(c.userSnapshot!.user)
              .then((value) {
                thongBaoThucHienXong(context: context, info: "Đã cập nhật.");
                c.updateNameId(nameId: "account");
                print("Cập nhật thành công.");
                Get.back();
              });
            }
            else {
              thongBaoThucHienXong(context: context, info: "Cập nhật thất bại !");
            }
          },
        ),
      ),
    );
  }

  TextField _buildTextField(TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromRGBO(246, 248, 250, 1),
        contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}