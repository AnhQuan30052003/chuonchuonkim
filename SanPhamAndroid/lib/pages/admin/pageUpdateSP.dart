import 'dart:io';
import 'package:chuonchuonkim_app/database/models/Product.dart';
import 'package:chuonchuonkim_app/helper/uploadImage.dart';
import 'package:chuonchuonkim_app/helper/widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PageUpdate extends StatefulWidget {
  ProductSnapshot ps;
  PageUpdate(this.ps, {super.key});

  @override
  State<PageUpdate> createState() => _PageUpdateState();
}

class _PageUpdateState extends State<PageUpdate> {
  XFile? _xFile;
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cập nhật sản phẩm"),
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
                  child: _xFile == null
                      ? Image.network(widget.ps.product.hinhAnhSP)
                      : Image.file(
                          File(_xFile!.path),
                        ),
                ),
              ),
              space(0, 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      _xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                      if (_xFile != null) {
                        setState(() {});
                      }
                    },
                    child: const Text("Chọn ảnh"),
                  )
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                controller: txtId,
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
                controller: txtMaLSP,
                decoration: const InputDecoration(
                  labelText: "Mã LSP",
                ),
              ),
              TextField(
                controller: txtGia,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Giá",
                ),
              ),
              TextField(
                controller: txtMota,
                decoration: const InputDecoration(
                  labelText: "Mô tả",
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
          )),
          onPressed: () async {
            String? imageurl;
            Product product = Product(
              maSP: txtId.text,
              tenSP: txtTen.text,
              maLSP: txtMaLSP.text,
              giaSP: int.parse(txtGia.text),
              moTaSP: txtMota.text,
              hinhAnhSP: widget.ps.product.hinhAnhSP,
            );
            if (_xFile != null) {
              imageurl = await uploadImage(
                imagePath: _xFile!.path,
                folders: ["ChuonChuonKimApp/Products"],
                fileName: "${txtId.text}.jpg",
              );
            } else {
              product.hinhAnhSP = widget.ps.product.hinhAnhSP;
            }
            widget.ps.update(product);
          },
          child: const Text("Cập nhật"),
        ),
      ),
    );
  }
}
