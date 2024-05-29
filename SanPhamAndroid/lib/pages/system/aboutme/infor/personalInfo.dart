import 'package:chuonchuonkim_app/controllers/chuonChuonKimController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'editProfile.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({super.key});

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  @override
  Widget build(BuildContext context) {
    var c = ChuonChuonKimController.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Thông tin cá nhân"),
        actions: [
          InkWell(
            onTap: () {
              Get.to(const EditProfile());
            },
            child: Container(
              margin: const EdgeInsets.only(right: 20),
              child: const Text(
                "Cập nhật",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                  decorationColor: Colors.redAccent
                ),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 100,
                width: 272,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ClipOval(
                      child: SizedBox.fromSize(
                        size: const Size.fromRadius(50), // Image radius
                        child: Image.network(c.userSnapshot!.user.hinhAnhUser, fit: BoxFit.cover),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(c.userSnapshot!.user.ten, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                            Text(c.userSnapshot!.user.user, style: const TextStyle(color: Color.fromARGB(96, 27, 10, 10))),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: const Color.fromRGBO(246, 248, 250, 1),
                ),
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    ListTile(
                      horizontalTitleGap: 20,
                      title: const Text("Họ và tên"),
                      subtitle: Text(c.userSnapshot!.user.ten, style: const TextStyle(color: Colors.black54),),
                      leading: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                        ),
                        child: const Icon(Icons.person_2_outlined, color: Colors.orangeAccent),
                      ),
                    ),
                    ListTile(
                      horizontalTitleGap: 20,
                      title: const Text("Số điện thoại"),
                      subtitle: Text(c.userSnapshot!.user.sdt),
                      leading: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                        ),
                        child: const Icon(
                          CupertinoIcons.phone,
                          color: Color.fromRGBO(54, 155, 255, 1),
                        ),
                      ),
                    ),
                    ListTile(
                      horizontalTitleGap: 20,
                      title: const Text("Địa chỉ"),
                      subtitle: Text(c.userSnapshot!.user.diaChi),
                      leading: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                        ),
                        child: const Icon(
                          CupertinoIcons.phone,
                          color: Color.fromRGBO(54, 155, 255, 1),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
