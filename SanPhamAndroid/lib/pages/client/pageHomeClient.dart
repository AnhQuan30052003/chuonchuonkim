// * Đạt

import 'package:chuonchuonkim_app/database/models/Product.dart';
import 'package:chuonchuonkim_app/pages/client/pageDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../controllers/chuonChuonKimController.dart';
import '../../database/connect/firebaseConnect.dart';

class ClientConnect extends StatelessWidget {
  const ClientConnect({super.key});

  @override
  Widget build(BuildContext context) {
    return FirebaseConnect(
      builder: (context) => GetMaterialApp(
        title: "Client connect",
        debugShowCheckedModeBanner: false,
        initialBinding: ChuonChuonKimBindings(),
        home: const PageHomeClient(),
      ),
    );
  }
}

class PageHomeClient extends StatelessWidget {
  const PageHomeClient({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white10,
        title: const Text(
          "Bạn muốn ăn gì?",
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF3A3737),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none,
              color: Color(0xFF3A3737),
            ),
          ),
        ],
      ),
      body: GetBuilder<ChuonChuonKimController>(
        init: ChuonChuonKimController.instance,
        id: "client_products",
        builder: (controller) {
          var list = controller.listProduct;
          print("Đã load page home client");
          return Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // * search
                  SizedBox(
                    height: 50,
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.redAccent,
                        ),
                        suffixIcon: const Icon(Icons.sort, color: Colors.redAccent),
                        hintText: "Tìm kiếm",
                      ),
                      onChanged: (input) {

                      },
                    ),
                  ),
                  // * end search
                ]
              ),
            ),
          );
        },
      ),
    );
  }
}
