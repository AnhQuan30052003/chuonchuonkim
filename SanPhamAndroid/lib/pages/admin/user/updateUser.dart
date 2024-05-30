import 'dart:io';
import 'package:chuonchuonkim_app/controllers/chuonChuonKimController.dart';
import 'package:chuonchuonkim_app/database/connect/setupFirebase.dart';
import 'package:chuonchuonkim_app/helper/dialog.dart';
import 'package:chuonchuonkim_app/helper/uploadImage.dart';
import 'package:chuonchuonkim_app/helper/widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../database/models/User.dart';

class PageUpdateUser extends StatefulWidget {
  final UserSnapshot ps;
  const PageUpdateUser({required this.ps, super.key});

  @override
  State<PageUpdateUser> createState() => _PageUpdateUserState();
}

class _PageUpdateUserState extends State<PageUpdateUser> {
  XFile? xFile;
  TextEditingController txtId = TextEditingController();
  TextEditingController txtTen = TextEditingController();
  TextEditingController txtUser = TextEditingController();
  TextEditingController txtPass = TextEditingController();
  TextEditingController txtSdt = TextEditingController();
  TextEditingController txtDiaChi = TextEditingController();

  @override
  void initState() {
    txtId.text = widget.ps.user.id;
    txtTen.text = widget.ps.user.ten;
    txtUser.text = widget.ps.user.user;
    txtPass.text = widget.ps.user.pass;
    txtSdt.text = widget.ps.user.sdt;
    txtDiaChi.text = widget.ps.user.diaChi;
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    var c = ChuonChuonKimController.instance;
    var list = c.listUserSnapshot;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cập nhật sản phẩm", style: TextStyle(fontSize: 16, color: Color(0xFF3A3737), fontWeight: FontWeight.bold)),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Center(
                child: SizedBox(
                  width: w * 0.8,
                  height: w * 0.8 * 2 / 3,
                  child: xFile == null
                      ? Image.network(widget.ps.user.hinhAnhUser)
                      : Image.file(
                    File(xFile!.path),
                  ),
                ),
              ),
              space(0, 10),
              ElevatedButton(
                onPressed: () async {
                  xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                  if (xFile != null) {
                    setState(() {});
                  }
                },
                child: const Text("Chọn ảnh"),
              ),

              space(0, 10),
              TextField(
                controller: txtId,
                enabled: false,
                decoration: const InputDecoration(
                  labelText: "id",
                ),
              ),
              TextField(
                controller: txtUser,
                enabled: false,
                decoration: const InputDecoration(
                  labelText: "Tên đăng nhập",
                ),
              ),
              TextField(
                controller: txtPass,
                decoration: const InputDecoration(
                  labelText: "Mật khẩu",
                ),
              ),
              TextField(
                controller: txtTen,
                decoration: const InputDecoration(
                  labelText: "Tên",
                ),
              ),
              TextField(
                controller: txtSdt,
                decoration: const InputDecoration(
                  labelText: "Số điện thoai",
                ),
              ),
              TextField(
                controller: txtDiaChi,
                decoration: const InputDecoration(
                  labelText: "Địa chỉ",
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(15),
        height: 50,
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              )
          ),
          onPressed: () async {
            thongBaoDangThucHien(context: context, info: "Đang cập nhật...");
            if (txtId.text.isNotEmpty && txtUser.text.isNotEmpty && txtPass.text.isNotEmpty && txtTen.text.isNotEmpty && txtSdt.text.isNotEmpty && txtDiaChi.text.isNotEmpty ) {
              String? imagePath;
              if (xFile != null) {
                imagePath = await uploadImage(imagePath: xFile!.path, folders: Firebase.pathImageProduct, fileName: "${txtId.text}.jpg");
              }
              imagePath??= widget.ps.user.hinhAnhUser;

              User p = User(
                id: txtId.text,
                user: txtUser.text,
                pass: txtPass.text,
                ten: txtTen.text,
                sdt: txtSdt.text,
                diaChi: txtDiaChi.text,
                hinhAnhUser: imagePath,
              );

              await widget.ps.update(p)
              .then((value) {
                thongBaoThucHienXong(context: context, info: "Đã cập nhật.");
                print("Cập nhật thành công.");
                Get.back();
              });
            }
            else {
              thongBaoThucHienXong(context: context, info: "Cập nhật thất bại !");
            }
          },
          child: const Text("Cập nhật"),
        ),
      ),
    );
  }
}
