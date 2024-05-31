import 'dart:math';
import 'package:chuonchuonkim_app/database/models/Cart.dart';
import 'package:chuonchuonkim_app/database/models/Notification.dart';
import 'package:chuonchuonkim_app/helper/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import '../controllers/chuonChuonKimController.dart';
import '../database/models/Product.dart';
import '../pages/client/pageCart.dart';
import '../pages/system/notification/pageNotification.dart';
import 'widget.dart';
import '../pages/client/pageDetails.dart';
import '../pages/client/pageProductSearch.dart';
import 'package:badges/badges.dart' as badges;

PreferredSizeWidget buildAppBar({required String info}) {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.white10,
    title: Text(
      info,
      style: const TextStyle(fontSize: 16, color: Color(0xFF3A3737), fontWeight: FontWeight.bold),
    ),
    actions: [
      GestureDetector(
        child: Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: badges.Badge(
            badgeContent: GetBuilder(
              init: ChuonChuonKimController.instance,
              id: "appBar",
              builder: (controller) => StreamBuilder(
                stream: NotificationSnapshot.streamData(),
                builder: (context, snapshot) {
                  List<NotificationSnapshot> list = [];

                  try {
                    list = snapshot.data!;
                  }
                  catch (error) {
                    list = [];
                  }

                  int count = 0;
                  for (var no in list) {
                    if (no.notification.seen == false) count += 1;
                  }

                  return Text("$count", style: const TextStyle(color: Colors.white));
                },
              ),
            ),
            child: const Icon(Icons.notifications_none, color: Color(0xFF3A3737)),
          ),
        ),
        onTap: () {
          var c = ChuonChuonKimController.instance;
          if (c.isLogin == false) {
            c.toLogin();
            return;
          }
          Get.to(const PageNotification());
        },
      ),
      GestureDetector(
        child: Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: badges.Badge(
            badgeContent: GetBuilder(
              init: ChuonChuonKimController.instance,
              id: "appBar",
              builder: (controller) => StreamBuilder(
                stream: CartSnapshot.streamData(),
                builder: (context, snapshot) {
                  var c = ChuonChuonKimController.instance;
                  List<CartSnapshot> list = [];

                  try {
                    list = snapshot.data!;
                    c.listCartSnapshot = list;
                    c.listCartSnapshot.sort((CartSnapshot a, CartSnapshot b) => a.cart.idCart.compareTo(b.cart.idCart));
                  }
                  catch (error) {
                    list = [];
                  }

                  return Text("${list.length}", style: const TextStyle(color: Colors.white));
                },
              ),
            ),
            child: const Icon(Icons.shopping_cart_outlined),
          ),
        ),
        onTap: () {
          var c = ChuonChuonKimController.instance;
          if (c.isLogin == false) {
            c.toLogin();
            return;
          }
          Get.to(const PageCart());
        },
      ),
    ],
  );
}

Widget buildSearch({required BuildContext context}) {
TextEditingController c = TextEditingController();
  void startSearch() {
    String textSearch = c.text;
    if (textSearch.isEmpty) return;
    c.clear;
    ChuonChuonKimController.instance.showProductSearch(search: textSearch);
    Navigator.push(context, MaterialPageRoute(builder: (context) => PageProductSearch(search: textSearch)));
  }

  return SizedBox(
    height: 50,
    child: TextField(
      controller: c,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        suffixIcon: GestureDetector(
          child: const Icon(
            Icons.search,
            color: Colors.redAccent,
          ),
          onTap: () {
            startSearch();
          },
        ),
        hintText: "Tìm kiếm...",
      ),
      onSubmitted: (value) {
        startSearch();
      },
    ),
  );
}

Widget buildFilter() {
  return GetBuilder(
    init: ChuonChuonKimController.instance,
    id: "filter",
    builder: (controller) {
      return SizedBox(
        height: 70,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.listProductTypeSnapshot.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            var item = controller.listProductTypeSnapshot[index].productType;
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 2,
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: GestureDetector(
                  child: Image.network(item.hinhAnhLSP),
                  onTap: () {
                    controller.showProductType(idLSP: item.maLSP);
                  },
                ),
              ),
            );
          },
        ),
    );
    },
  );
}

Widget buildGridViewProducts({required BuildContext context, required List<Product> list, required bool showNotFound}) {
  if (list.isEmpty && showNotFound) {
    return const Column(
      children: [
        Text("Rất tiếc...không có kết quả !", style: TextStyle(fontSize: 16)),
      ],
    );
  }

  return GridView.extent(
    maxCrossAxisExtent: 300,
    crossAxisSpacing: 12,
    mainAxisSpacing: 10,
    shrinkWrap: true,
    childAspectRatio: 0.8,
    physics: const NeverScrollableScrollPhysics(),
    children: list.map(
      (product) {
        return GestureDetector(
          onTap: () {
            ChuonChuonKimController.instance.showSimilarProducts(product: product);
            Navigator.push(context, MaterialPageRoute(builder: (context) => PageDetails(product: product)));
          },
          child: PhysicalModel(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            elevation: 4,
            shadowColor: Colors.black,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Expanded(child: Image.network(product.hinhAnhSP)),
                  space(0, 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            product.tenSP,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            // shortText(text: product.moTaSP, lengthMax: 20),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            product.moTaSP,
                            style: const TextStyle(color: Colors.black45, fontSize: 15),
                          ),
                        ],
                      ),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Text(
                          "${product.giaSP}đ",
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, color: Colors.redAccent),
                        ),
                        Text("Đã bán: ${Random().nextInt(400)}",
                            style: const TextStyle(fontWeight: FontWeight.normal)),
                      ]),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }
    ).toList()
  );
}

Widget buildInstruction({required String text}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        text,
        style: const TextStyle(color: Colors.black87, fontSize: 17, fontWeight: FontWeight.bold),
      ),
    ],
  );
}

Widget buildProductsPopulator() {
  double w = 190, h = 230;

  return GetBuilder(
    init: ChuonChuonKimController.instance,
    id: "products_populator",
    builder: (controller) {
      var list = controller.listProductsPopulator;
      return SizedBox(
        height: h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: list.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            var item = list[index];

            return GestureDetector(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0, bottom: 10),
                    child: Container(
                      margin: const EdgeInsets.only(right: 5, left: 5),
                      height: h,
                      width: w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 4,
                            spreadRadius: 2,
                            color: Colors.black12,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const SizedBox(height: 7),
                            Text(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              item.tenSP,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              item.moTaSP,
                              style: const TextStyle(color: Colors.black45, fontSize: 15),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${item.giaSP}đ",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500, color: Colors.redAccent),
                                ),
                                Text("Đã bán: ${Random().nextInt(400)}",
                                    style: const TextStyle(fontWeight: FontWeight.normal)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 40,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(80),
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 4,
                            spreadRadius: 2,
                            color: Colors.black12,
                          )
                        ],
                      ),
                      child: ClipOval(
                        child: SizedBox.fromSize(
                          size: const Size.fromRadius(60), // Image radius
                          child: Image.network(item.hinhAnhSP, fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              onTap: () {
                controller.showSimilarProducts(product: item);
                Get.to(PageDetails(product: item));
              },
            );
          },
        ),
      );
    },
  );
}

Padding _buildTinTucThongBao(double spacePading, String text) {
  return Padding(
    padding: EdgeInsets.only(left: spacePading),
    child: buildInstruction(text: text),
  );
}

Widget buildStreamBuilderNotification() {
  return StreamBuilder(
    stream: NotificationSnapshot.streamData(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      List<NotificationSnapshot> list = [], listNew = [], listOld = [];

      try {
        list = snapshot.data!;

        for (NotificationSnapshot l in list) {
          if (l.notification.seen) {
            listOld.add(l);
          } else {
            listNew.add(l);
          }
        }

        listNew.sort((NotificationSnapshot a, NotificationSnapshot b) => (b.notification.idNoti.compareTo(a.notification.idNoti)));
        listOld.sort((NotificationSnapshot a, NotificationSnapshot b) => (b.notification.idNoti.compareTo(a.notification.idNoti)));
      } catch (error) {
        list = [];
      }

      double spacePading = 5.0;
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: spacePading, right: spacePading),
          child: Column(
            children: [
              _buildTinTucThongBao(spacePading, "Mới(${listNew.length})"),
              Column(
                children: listNew.map(
                  (ns) {
                    return GestureDetector(
                      child: Card(
                        color: Colors.white,
                        child: SizedBox(
                          height: 50,
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 35,
                                child: Icon(Icons.mark_as_unread, color: Colors.grey, size: 40),
                              ),
                              space(10, 0),
                              SizedBox(
                                  height: 50,
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: Text(ns.notification.text, style: const TextStyle(color: Colors.black))
                                  )
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: () async {
                        // Chuyển page..
                        ns.notification.seen = true;
                        await ns.update(ns.notification);
                      },
                    );
                  }
                ).toList(),
              ),

              _buildTinTucThongBao(spacePading, "Trước đó(${listOld.length})"),
              Column(
                children: listOld.map(
                  (ns) {
                    return GestureDetector(
                      child: Card(
                        color: Colors.black12,
                        child: SizedBox(
                          height: 50,
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 35,
                                child: Icon(Icons.mark_as_unread, color: Colors.white, size: 40),
                              ),
                              space(10, 0),
                              SizedBox(
                                  height: 50,
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: Text(ns.notification.text, style: const TextStyle(color: Colors.white))
                                  )
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        // Chuyển page..
                        // Get.to();
                      },
                    );
                  }
                ).toList(),
              ),
            ],
          ),
        ),
      );
    },
  );
}