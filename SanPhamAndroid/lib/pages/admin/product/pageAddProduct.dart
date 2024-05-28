import 'dart:io';
import 'package:chuonchuonkim_app/controllers/chuonChuonKimController.dart';
import 'package:chuonchuonkim_app/database/connect/setupFirebase.dart';
import 'package:chuonchuonkim_app/database/models/Product.dart';
import 'package:chuonchuonkim_app/helper/dialog.dart';
import 'package:chuonchuonkim_app/helper/uploadImage.dart';
import 'package:chuonchuonkim_app/helper/widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PageAddProduct extends StatefulWidget {
  const PageAddProduct({super.key});

  @override
  State<PageAddProduct> createState() => _PageAddProductState();
}

class _PageAddProductState extends State<PageAddProduct> {
  XFile? xFile;
  TextEditingController txtId = TextEditingController();
  TextEditingController txtTen = TextEditingController();
  TextEditingController txtMaLSP = TextEditingController();
  TextEditingController txtGia = TextEditingController();
  TextEditingController txtMota = TextEditingController();

  @override
  void initState() {
    var c = ChuonChuonKimController.instance;
    txtMaLSP.text = c.listProductTypeSnapshot[0].productType.maLSP;

    int number = 1 + int.parse(c.listProductSnapshot.last.product.maSP);
    txtId.text = getIdToString(number);
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    var c = ChuonChuonKimController.instance;

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
                items: c.listProductTypeSnapshot.map(
                  (pts) => DropdownMenuItem(
                    value: pts.productType.maLSP,
                    child: Text(pts.productType.tenLSP),
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
            if (xFile != null && txtId.text.isNotEmpty && txtTen.text.isNotEmpty && txtGia.text.isNotEmpty && txtMota.text.isNotEmpty ) {
              thongBaoDangThucHien(context: context, info: "Đang thêm...");
              await uploadImage(imagePath: xFile!.path, folders: Firebase.pathImageProduct, fileName: "${txtId.text}.jpg")
              .then((url) {
                Product p = Product(
                  maSP: txtId.text,
                  tenSP: txtTen.text,
                  giaSP: int.parse(txtGia.text),
                  maLSP: txtMaLSP.text,
                  hinhAnhSP: url.toString(),
                  moTaSP: txtMota.text,
                );

                ProductSnapshot.add(p);
                thongBaoThucHienXong(context: context, info: "Đã thêm.");
                print("Thêm thành công.");

                txtId.clear();
                txtTen.clear();
                txtGia.clear();
                txtMota.clear();
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
          child: const Text("Lưu"),
        ),
      ),
    );
  }
}
