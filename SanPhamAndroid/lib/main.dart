import 'package:chuonchuonkim_app/controllers/chuonChuonKimController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'database/connect/firebaseConnect.dart';
import 'pages/system/loadPage.dart';

void main() => runApp(const ChuonChuonKimApp());

class ChuonChuonKimApp extends StatelessWidget {
  const ChuonChuonKimApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FirebaseConnect(
      builder: (context) => GetMaterialApp(
        title: "Chuonchuonkim App",
        debugShowCheckedModeBanner: false,
        initialBinding: ChuonChuonKimBindings(),
        home: const PageLoad(),
      ),
    );
  }
}

// Tạo một danh sách truy cập
// class ListApp extends StatelessWidget {
//   const ListApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: const Text("Chọn app ?"),
//       ),
//       body: SingleChildScrollView(
//         child: Center(
//           child: Column(
//             children: [
//               _buildButton(context, label: "Upload Data", type: const UploadData(), notBack: false),
//               _buildButton(context, label: "App", type: const PageLoad(), notBack: true),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Container _buildButton(BuildContext context, {required String label, required Widget type, required bool notBack}) {
//     return Container(
//       margin: const EdgeInsets.only(top: 10),
//       width: MediaQuery.of(context).size.width * 0.75,
//       child: ElevatedButton(
//         child: Text(label),
//         onPressed: () {
//           notBack ? Get.offAll(() => type) : Get.to(() => type);
//         },
//       ),
//     );
//   }
// }