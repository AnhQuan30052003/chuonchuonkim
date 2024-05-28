import 'dart:io';
import 'package:chuonchuonkim_app/controllers/chuonChuonKimController.dart';
import 'package:chuonchuonkim_app/database/connect/setupFirebase.dart';
import 'package:chuonchuonkim_app/database/models/Product.dart';
import 'package:chuonchuonkim_app/helper/dialog.dart';
import 'package:chuonchuonkim_app/helper/uploadImage.dart';
import 'package:chuonchuonkim_app/helper/widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PageUpdateProduct extends StatefulWidget {
  final ProductSnapshot ps;
  const PageUpdateProduct({required this.ps, super.key});

  @override
  State<PageUpdateProduct> createState() => _PageUpdateProductState();
}

class _PageUpdateProductState extends State<PageUpdateProduct> {
  XFile? xFile;
  TextEditingController txtId = TextEditingController();
  TextEditingController txtTen = TextEditingController();
  TextEditingController txtMaLSP = TextEditingController();
  TextEditingController txtGia = TextEditingController();
  TextEditingController txtMota = TextEditingController();

  @override
  void initState() {
    txtId.text = widget.ps.product.maSP;
    txtTen.text = widget.ps.product.tenSP;
    txtMaLSP.text = widget.ps.product.maLSP;
    txtGia.text = widget.ps.product.giaSP.toString();
    txtMota.text = widget.ps.product.moTaSP;
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    var c = ChuonChuonKimController.instance;
    var list = c.listProductTypeSnapshot;

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
                      ? Image.network(widget.ps.product.hinhAnhSP)
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
              TextField(
                controller: txtMota,
                decoration: const InputDecoration(
                  labelText: "Mô tả",
                ),
              ),
              TextField(
                controller: txtGia,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Giá",
                ),
              ),

              space(0, 10),
              DropdownButton(
                isExpanded: true,
                value: txtMaLSP.text,
                items: list.map(
                  (e) => DropdownMenuItem(
                    value: e.productType.maLSP,
                    child: Text(e.productType.tenLSP),
                  )
                ).toList(),
                onChanged: (value) {
                  txtMaLSP.text = value!;
                  setState(() {});
                }
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
            if (txtId.text.isNotEmpty && txtTen.text.isNotEmpty && txtGia.text.isNotEmpty && txtMota.text.isNotEmpty ) {
              String? imagePath;
              if (xFile != null) {
                imagePath = await uploadImage(imagePath: xFile!.path, folders: Firebase.pathImageProduct, fileName: "${txtId.text}.jpg");
              }
              imagePath??= widget.ps.product.hinhAnhSP;

              Product p = Product(
                maSP: txtId.text,
                tenSP: txtTen.text,
                giaSP: int.parse(txtGia.text),
                maLSP: txtMaLSP.text,
                hinhAnhSP: imagePath,
                moTaSP: txtMota.text,
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
