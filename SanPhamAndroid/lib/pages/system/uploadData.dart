import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/chuonChuonKimController.dart';
import '../../database/connect/firebaseConnect.dart';
import '../../helper/dialog.dart';

class AppUploadData extends StatelessWidget {
  const AppUploadData({super.key});

  @override
  Widget build(BuildContext context) {
    return FirebaseConnect(
      builder: (context) => const GetMaterialApp(
        title: "Connect To Upload",
        debugShowCheckedModeBanner: false,
        home: UploadData(),
      ),
    );
  }
}

class UploadData extends StatelessWidget {
  const UploadData({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Đẩy dữ liệu lên Firebase")
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                thongBaoDangThucHien(context: context, info: "Uploading...");
                var c = ChuonChuonKimController.instance;
                c.removeAndUploadData();
                thongBaoThucHienXong(context: context, info: "Upload done.");
              },
              child: const Text("Add data to firebase"),
            ),
          ]
        ),
      )
    );
  }
}
