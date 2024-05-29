import 'dart:io';
import 'package:chuonchuonkim_app/controllers/chuonChuonKimController.dart';
import 'package:chuonchuonkim_app/database/connect/setupFirebase.dart';
import 'package:chuonchuonkim_app/helper/dialog.dart';
import 'package:chuonchuonkim_app/helper/uploadImage.dart';
import 'package:chuonchuonkim_app/helper/widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../database/models/ProductType.dart';

class PageAddProductType extends StatefulWidget {
  const PageAddProductType({super.key});

  @override
  State<PageAddProductType> createState() => _PageAddProductTypeState();
}

class _PageAddProductTypeState extends State<PageAddProductType> {
  XFile? xFile;
  TextEditingController txtId = TextEditingController();
  TextEditingController txtTen = TextEditingController();

  @override
  void initState() {
    var c = ChuonChuonKimController.instance;
    int number = 1 + int.parse(c.listProductTypeSnapshot.last.productType.maLSP);
    txtId.text = getIdToString(number);
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    var c = ChuonChuonKimController.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cập nhật loại sản phẩm", style: TextStyle(fontSize: 16, color: Color(0xFF3A3737), fontWeight: FontWeight.bold)),
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
                      ? const Icon(Icons.image)
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
                controller: txtTen,
                decoration: const InputDecoration(
                  labelText: "Tên",
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
            if (xFile != null && txtId.text.isNotEmpty && txtTen.text.isNotEmpty) {
              thongBaoDangThucHien(context: context, info: "Đang thêm...");
              await uploadImage(imagePath: xFile!.path, folders: Firebase.pathImageProductType, fileName: "${txtId.text}.jpg")
              .then((url) {
                ProductType pt = ProductType(
                  maLSP: txtId.text,
                  tenLSP: txtTen.text,
                  hinhAnhLSP: url.toString(),
                );

                ProductTypeSnapshot.add(pt);
                thongBaoThucHienXong(context: context, info: "Đã thêm.");
                print("Thêm thành công.");

                txtId.clear();
                txtTen.clear();
                xFile = null;
                setState(() {});
              }).catchError((error) {
                thongBaoThucHienXong(context: context, info: "Thêm thất bại !");
                print("Có lỗi: ${error.toString()}");
              });
            }
            else {
              thongBaoThucHienXong(context: context, info: "Kiểm tra lại thông tin nhập");
              print("Có lỗi khi lưu, hãy kiểm tra lại thông tin nhập");
            }
          },
          child: const Text("Thêm"),
        ),
      ),
    );
  }
}
