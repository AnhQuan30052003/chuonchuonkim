import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'addNewAddress.dart';

class MyAddress extends StatelessWidget {
  const MyAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Địa chỉ của tôi"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Stack(
                children: [
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
                          title: const Text("NHÀ"),
                          subtitle: const Text(
                            "34 Nguyễn Đình Chiểu, Nha Trang",
                            style: TextStyle(color: Colors.black54),
                          ),
                          leading: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white,
                            ),
                            child: const Icon(Icons.home, color: Colors.orangeAccent),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: -5,
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.edit, color: Colors.orangeAccent)),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.delete, color: Colors.orangeAccent)),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Stack(
                children: [
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
                          title: const Text("CÔNG TY"),
                          subtitle: const Text(
                            "312 KĐT Vĩnh Điềm Trung, Nha Trang",
                            style: TextStyle(color: Colors.black54),
                          ),
                          leading: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white,
                            ),
                            child: const Icon(Icons.work, color: Colors.blueAccent),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: -5,
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.edit, color: Colors.orangeAccent)),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.delete, color: Colors.orangeAccent)),
                      ],
                    ),
                  )
                ],
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
          onPressed: () {
            Get.to(const NewAddress());
          },
          child: const Text("THÊM ĐỊA CHỈ", style: TextStyle(color: Colors.white, fontSize: 15)),
        ),
      ),
    );
  }
}
