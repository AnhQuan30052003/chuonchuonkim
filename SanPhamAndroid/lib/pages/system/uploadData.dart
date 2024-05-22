import 'package:chuonchuonkim_app/database/models/Product.dart';
import 'package:chuonchuonkim_app/database/models/ProductType.dart';
import 'package:chuonchuonkim_app/pages/system/createItem.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../database/connect/firebaseConnect.dart';
import '../../database/connect/setupFirebase.dart';
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
              onPressed: () {
                // Product
                // for (var o in dbProduct) {
                //   ProductSnapshot.add(o);
                // }

                // Product type
                // for (var o in dbProductType) {
                  // ProductTypeSnapshot.add(o);
                // }

                DeleteData(collectionPath: Firebase.colProduct);

                thongBaoThucHienXong(context: context, info: "Delete done.");
                print("Thêm thành công lên Firebase.");
              },
              child: const Text("Delete Collections"),
            ),
          ]
        ),
      )
    );
  }
}
