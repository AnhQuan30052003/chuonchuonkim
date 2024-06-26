import 'package:shared_preferences/shared_preferences.dart';
import 'package:chuonchuonkim_app/controllers/chuonChuonKimController.dart';
import 'package:chuonchuonkim_app/pages/system/aboutme/editPassword.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../helper/dialog.dart';
import '../../../helper/widget.dart';
import '../loadPage.dart';
import '../sign/login.dart';
import '../sign/signup.dart';
import 'infor/personalInfo.dart';

Widget account(BuildContext context) {
  List<GestureDetector> above = [
    _buildGestureDetector(
      context: context,
      icon: const Icon(Icons.person_2_outlined, color: Colors.orangeAccent),
      label: "Thông tin cá nhân",
      widget: const PersonalInfo(),
      logout: false,
    ),
  ];

  List<GestureDetector> bellow = [
    _buildGestureDetector(
      context: context,
      icon: const Icon(Icons.key_sharp, color: Colors.purpleAccent),
      label: "Đổi mật khẩu",
      widget: const EditPassword(),
      logout: false,
    ),
    _buildGestureDetector(
      context: context,
      icon: const Icon(Icons.logout_rounded, color: Colors.redAccent),
      label: "Đăng xuất",
      widget: const PageLoad(),
      logout: true,
    ),
  ];

  var c = ChuonChuonKimController.instance;

  var rowNotLogin = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      ElevatedButton(
        onPressed: () {
          Get.to(() => const PageLogin());
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5), side: const BorderSide(color: Colors.redAccent)),
          backgroundColor: Colors.white,
        ),
        child: const Text(
          "Đăng nhập",
          style: TextStyle(color: Colors.redAccent),
        ),
      ),
      space(20, 0),
      ElevatedButton(
        onPressed: () {
          Get.to(() => const PageSignup());
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5)),
          backgroundColor: Colors.redAccent,
        ),
        child: const Text(
          "Đăng ký",
          style: TextStyle(color: Colors.white),
        ),
      ),
    ],
  );

  var columnLogined = Column(
    children: [
      space(0, 20),
      _buildContainerFrame(context, above),
      space(0, 20),
      _buildContainerFrame(context, bellow),
    ],
  );

  return SingleChildScrollView(
    child: GetBuilder(
      init: ChuonChuonKimController.instance,
      id: "account",
      builder: (controller) => Padding(
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
                          c.isLogin == false
                              ? "https://cdn.icon-icons.com/icons2/1378/PNG/512/avatardefault_92824.png"
                              : c.userSnapshot!.user.hinhAnhUser,
                          fit: BoxFit.cover),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(c.isLogin == false ? "Tên khách hàng" : c.userSnapshot!.user.ten,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                          Text(
                              c.isLogin == false ? "Chưa đăng nhập" : "Tài khoản ${c.userSnapshot!.user.user}",
                              style: const TextStyle(color: Color.fromARGB(96, 27, 10, 10))),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            (c.isLogin ? columnLogined : rowNotLogin)
          ],
        ),
      ),
    ),
  );
}

Container _buildContainerFrame(BuildContext context, List<GestureDetector> list) {
  return Container(
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      color: const Color.fromRGBO(246, 248, 250, 1),
    ),
    child: ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: list.toList(),
    ),
  );
}

GestureDetector _buildGestureDetector(
    {required BuildContext context,
    required Icon icon,
    required String label,
    required Widget widget,
    required logout}) {
  return GestureDetector(
    child: ListTile(
      horizontalTitleGap: 10,
      title: Text(label),
      leading: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
        ),
        child: icon,
      ),
      trailing: const Icon(Icons.arrow_forward_ios_outlined, size: 17),
    ),
    onTap: () async {
      if (logout == false) {
        Get.to(() => widget);
        return;
      }

      List<String> list = ["Xác nhận", "Huỷ"];
      String cauHoi = "Bạn chắc chắc muốn đăng xuất ?";
      SharedPreferences spf = await SharedPreferences.getInstance();
      await khungLuaChon(context: context, listLuaChon: list, cauHoi: cauHoi).then((value) {
        if (value == list.first) {
          spf.remove("idLogin").then((value) {
            var c = ChuonChuonKimController.instance;
            c.userSnapshot = null;
            c.isLogin = false;
            Get.offAll(() => widget);
          });
        }
      });
    },
  );
}
