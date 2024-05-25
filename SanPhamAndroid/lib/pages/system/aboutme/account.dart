import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'personalInfo.dart';

Widget account(BuildContext context) {
  return SingleChildScrollView(
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
                    child: Image.network("https://i.pinimg.com/474x/df/ce/a7/dfcea7989195d3273c2bcb367fca0a83.jpg", fit: BoxFit.cover),
                  ),
                ),
                const Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Tên khách hàng",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                      Text("Tài khoản",
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
                GestureDetector(
                  child: ListTile(
                    horizontalTitleGap: 10,
                    title: const Text("Thông tin cá nhân"),
                    leading: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                      child: const Icon(Icons.person_2_outlined, color: Colors.orangeAccent),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.arrow_forward_ios_outlined, size: 17),
                      onPressed: () {
                        Get.to(const PersonalInfo());
                      },
                    ),
                  ),
                  onTap: () => Get.to(const PersonalInfo()),
                ),
                GestureDetector(
                  child: ListTile(
                    horizontalTitleGap: 10,
                    title: const Text("Địa chỉ nhận hàng"),
                    leading: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                      child: const Icon(CupertinoIcons.location_solid, color: Colors.lightBlue),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.arrow_forward_ios_outlined, size: 17),
                      onPressed: () {},
                    ),
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            color: const Color.fromRGBO(246, 248, 250, 1),
            width: MediaQuery.of(context).size.width,
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                GestureDetector(
                  child: ListTile(
                    horizontalTitleGap: 10,
                    title: const Text("Đăng xuất"),
                    leading: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                      child: const Icon(Icons.logout_rounded, color: Colors.redAccent),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.arrow_forward_ios_outlined, size: 17),
                      onPressed: () {},
                    ),
                  ),
                  onTap: () {},
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}