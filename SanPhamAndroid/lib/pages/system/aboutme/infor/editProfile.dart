import 'package:chuonchuonkim_app/controllers/chuonChuonKimController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../database/connect/setupFirebase.dart';
import '../../../../database/models/User.dart';
import '../../../../helper/dialog.dart';
import '../../../../helper/uploadImage.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  XFile? xFile;
  TextEditingController txtTen = TextEditingController();
  TextEditingController txtSdt = TextEditingController();
  TextEditingController txtDiaChi = TextEditingController();
  var c = ChuonChuonKimController.instance.userSnapshot!.user;

  @override
  void initState() {
    txtTen.text = c.ten;
    txtSdt.text = c.sdt;
    txtDiaChi.text = c.diaChi;
  }

  @override
  Widget build(BuildContext context) {
    var c = ChuonChuonKimController.instance;
    return Scaffold(
      appBar: AppBar(title: const Text("Chỉnh sửa thông tin")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Center(
                child: Stack(
                  children: [
                    ClipOval(
                      child: SizedBox.fromSize(
                        size: const Size.fromRadius(50), // Image radius
                        child: Image.network(c.userSnapshot!.user.hinhAnhUser, fit: BoxFit.cover),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          color: Colors.orangeAccent,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.edit_sharp,
                            color: Colors.white,
                            size: 20,
                          ),
                          onPressed: () async {
                            xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                            if (xFile != null) {
                              setState(() {});
                            }
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("HỌ VÀ TÊN"),
                    const SizedBox(height: 10),
                    _buildTextField(txtTen),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("SỐ ĐIỆN THOẠI"),
                    const SizedBox(height: 10),
                    _buildTextField(txtSdt),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("ĐỊA CHỈ"),
                    const SizedBox(height: 10),
                    _buildTextField(txtDiaChi),
                  ],
                ),
              ),
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
            )),
          child: const Text("LƯU THÔNG TIN", style: TextStyle(color: Colors.white, fontSize: 15)),
          onPressed: () async {
            thongBaoDangThucHien(context: context, info: "Đang cập nhật...");
            if (txtTen.text.isNotEmpty && txtSdt.text.isNotEmpty && txtDiaChi.text.isNotEmpty) {
              String? imagePath;
              if (xFile != null) {
                imagePath = await uploadImage(imagePath: xFile!.path, folders: Firebase.pathAvatarUser, fileName: "${c.userSnapshot!.user.id}.jpg");
              }
              imagePath??= c.userSnapshot!.user.hinhAnhUser;

              User temp = c.userSnapshot!.user;
              temp.ten = txtTen.text;
              temp.sdt = txtSdt.text;
              temp.diaChi = txtDiaChi.text;
              temp.hinhAnhUser = imagePath;

              await c.userSnapshot!.update(temp)
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

