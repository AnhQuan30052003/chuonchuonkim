import 'package:chuonchuonkim_app/database/models/Cart.dart';
import 'package:chuonchuonkim_app/database/models/Notification.dart';
import 'package:chuonchuonkim_app/database/models/Product.dart';
import 'package:chuonchuonkim_app/database/models/ProductFavorite.dart';
import 'package:chuonchuonkim_app/database/models/ProductType.dart';
import 'package:chuonchuonkim_app/pages/system/createItem.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../database/connect/firebaseConnect.dart';
import '../../database/connect/setupFirebase.dart';
import '../../database/models/User.dart';
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
                // Product type
                await deleteData(collectionPath: Firebase.colProductType)
                .then((value) {
                  for (var o in dbProductType) {
                    ProductTypeSnapshot.add(o);
                  }
                });

                // Carts
                await deleteData(collectionPath: Firebase.colCart)
                .then((value) {
                  for (var o in dbCart) {
                    CartSnapshot.add(o);
                  }
                });

                // Product favorite
                await deleteData(collectionPath: Firebase.colProductFavorite)
                .then((value) {
                  for (var o in dbProductFavorite) {
                    ProductFavoriteSnapshot.add(o);
                  }
                });

                // Notifications
                await deleteData(collectionPath: Firebase.colNotification)
                .then((value) {
                  for (var o in dbNotification) {
                    NotificationSnapshot.add(o);
                  }
                });

                // Users
                await deleteData(collectionPath: Firebase.colUser)
                .then((value) {
                  for (var o in dbUser) {
                    UserSnapshot.add(o);
                  }
                });

                // Product
                await deleteData(collectionPath: Firebase.colProduct)
                .then((value) {
                  int soLuongTao = 20, indexLSP = 0;
                  buildProduct(soLuongTao: soLuongTao, tenSPTao: "Cơm sườn", hinhAnhSPTao: hinhAnhComSuon, giaSPTao: List.of([20000, 25000]), maLSPTao: dbProductType[indexLSP++].maLSP);
                  buildProduct(soLuongTao: soLuongTao, tenSPTao: "Hamburger", hinhAnhSPTao: hinhAnhHamburger, giaSPTao: List.of([25000, 30000, 40000]), maLSPTao: dbProductType[indexLSP++].maLSP);
                  buildProduct(soLuongTao: soLuongTao, tenSPTao: "Bún", hinhAnhSPTao: hinhAnhBun, giaSPTao: List.of([15000, 20000, 25000, 30000]), maLSPTao: dbProductType[indexLSP++].maLSP);
                  buildProduct(soLuongTao: soLuongTao, tenSPTao: "Phở", hinhAnhSPTao: hinhAnhPho, giaSPTao: List.of([20000, 25000, 30000]), maLSPTao: dbProductType[indexLSP++].maLSP);
                  buildProduct(soLuongTao: soLuongTao, tenSPTao: "Nước", hinhAnhSPTao: hinhAnhNuoc, giaSPTao: List.of([10000, 15000, 20000]), maLSPTao: dbProductType[indexLSP++].maLSP);
                  buildProduct(soLuongTao: soLuongTao, tenSPTao: "Sald", hinhAnhSPTao: hinhAnhSalad, giaSPTao: List.of([10000, 15000]), maLSPTao: dbProductType[indexLSP++].maLSP);
                  for (var o in dbProduct) {
                    ProductSnapshot.add(o);
                  }
                });

                thongBaoThucHienXong(context: context, info: "Upload done.");
                print("Thêm dữ liệu thành công lên Firebase.");
              },
              child: const Text("Add data to firebase"),
            ),
          ]
        ),
      )
    );
  }
}
