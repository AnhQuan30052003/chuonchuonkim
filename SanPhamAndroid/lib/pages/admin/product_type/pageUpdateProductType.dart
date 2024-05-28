import 'dart:io';
import 'package:chuonchuonkim_app/controllers/chuonChuonKimController.dart';
import 'package:chuonchuonkim_app/database/connect/setupFirebase.dart';
import 'package:chuonchuonkim_app/helper/dialog.dart';
import 'package:chuonchuonkim_app/helper/uploadImage.dart';
import 'package:chuonchuonkim_app/helper/widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../database/models/ProductType.dart';

class PageUpdateProductType extends StatefulWidget {
  final ProductTypeSnapshot pts;
  const PageUpdateProductType({required this.pts, super.key});

  @override
  State<PageUpdateProductType> createState() => _PageUpdateProductTypeState();
}

class _PageUpdateProductTypeState extends State<PageUpdateProductType> {
  XFile? xFile;
  TextEditingController txtId = TextEditingController();
  TextEditingController txtTen = TextEditingController();

  @override
  void initState() {
    txtId.text = widget.pts.productType.maLSP;
    txtTen.text = widget.pts.productType.tenLSP;
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
                      ? Image.network(widget.pts.productType.hinhAnhLSP)
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
            thongBaoDangThucHien(context: context, info: "Đang cập nhật...");
            if (txtId.text.isNotEmpty && txtTen.text.isNotEmpty) {
              String? imagePath;
              if (xFile != null) {
                imagePath = await uploadImage(imagePath: xFile!.path, folders: Firebase.pathImageProductType, fileName: "${txtId.text}.jpg");
              }
              imagePath??= widget.pts.productType.hinhAnhLSP;

              ProductType pt = ProductType(
                maLSP: txtId.text,
                tenLSP: txtTen.text,
                hinhAnhLSP: imagePath,
              );

              await widget.pts.update(pt)
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
