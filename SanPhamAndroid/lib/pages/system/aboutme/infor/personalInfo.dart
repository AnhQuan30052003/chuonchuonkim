import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'editProfile.dart';

class PersonalInfo extends StatelessWidget {
  const PersonalInfo({super.key});

  @override
  Widget build(BuildContext context) {
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
                "Sửa",
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 15,
                    color: Colors.redAccent,
                    decorationColor: Colors.redAccent),
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
                        child: Image.network(
                            "https://i.pinimg.com/474x/df/ce/a7/dfcea7989195d3273c2bcb367fca0a83.jpg",
                            fit: BoxFit.cover),
                      ),
                    ),
                    const Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Tên khách hàng",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                          Text("Chữ ký...",
                              style: TextStyle(color: Color.fromARGB(96, 27, 10, 10))),
                        ],
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
                      subtitle: const Text(
                        "Tui tên là",
                        style: TextStyle(color: Colors.black54),
                      ),
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
                      subtitle: const Text("0123456789"),
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
