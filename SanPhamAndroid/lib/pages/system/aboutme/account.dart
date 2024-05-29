import 'package:chuonchuonkim_app/controllers/chuonChuonKimController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../helper/widget.dart';
import 'address/address.dart';
import 'infor/personalInfo.dart';

class WidgetTest extends StatelessWidget {
  const WidgetTest({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

Widget account(BuildContext context) {
  List<GestureDetector> above = [
    _buildGestureDetector(icon: const Icon(Icons.person_2_outlined, color: Colors.orangeAccent), label: "Thông tin cá nhân", widget: const PersonalInfo()),
    _buildGestureDetector(icon: const Icon(CupertinoIcons.location_solid, color: Colors.lightBlue), label: "Địa chỉ nhận hàng", widget: const MyAddress()),
  ];

  List<GestureDetector> bellow = [
    _buildGestureDetector(icon: const Icon(Icons.key_sharp, color: Colors.purpleAccent), label: "Đổi mật khẩu", widget: const WidgetTest()),
    _buildGestureDetector(icon: const Icon(Icons.logout_rounded, color: Colors.redAccent), label: "Đăng xuất", widget: const WidgetTest()),
  ];

  var c = ChuonChuonKimController.instance;

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
                    child: Image.network(c.userSnapshot == null ? "https://i.pinimg.com/474x/df/ce/a7/dfcea7989195d3273c2bcb367fca0a83.jpg" : c.userSnapshot!.user.hinhAnhUser, fit: BoxFit.cover),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(c.userSnapshot == null ? "Tên khách hàng" : c.userSnapshot!.user.ten, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                        Text("Tài khoản: ${c.userSnapshot!.user}", style: const TextStyle(color: Color.fromARGB(96, 27, 10, 10))),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          space(0, 20),
          _buildContainerFrame(context, above),

          space(0, 20),
          _buildContainerFrame(context, bellow),
        ],
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

GestureDetector _buildGestureDetector({required Icon icon, required String label, required Widget widget}) {
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
        // child: Icon(Icons.logout_rounded, color: Colors.redAccent),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.arrow_forward_ios_outlined, size: 17),
        onPressed: () => Get.to(widget),
      ),
    ),
    onTap: () => Get.to(widget),
  );
}