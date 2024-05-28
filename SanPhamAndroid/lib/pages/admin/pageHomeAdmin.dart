// Quân

import 'package:chuonchuonkim_app/controllers/chuonChuonKimController.dart';
import 'package:chuonchuonkim_app/helper/widgetClient.dart';
import 'package:chuonchuonkim_app/pages/admin/product/pageAddProduct.dart';
import 'package:chuonchuonkim_app/pages/system/aboutme/account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../../database/connect/firebaseConnect.dart';
import '../../database/connect/setupFirebase.dart';
import '../../database/models/Product.dart';
import '../../helper/dialog.dart';
import '../../helper/uploadImage.dart';
import 'product/pageUpdateProduct.dart';

class AdminConnect extends StatelessWidget {
  const AdminConnect({super.key});

  @override
  Widget build(BuildContext context) {
    return FirebaseConnect(
      builder: (context) => GetMaterialApp(
        title: "Admin connect",
        debugShowCheckedModeBanner: false,
        initialBinding: ChuonChuonKimBindings(),
        home: const PageHomeAdmin(),
      ),
    );
  }
}

class PageHomeAdmin extends StatefulWidget {
  const PageHomeAdmin({super.key});

  @override
  State<PageHomeAdmin> createState() => _PageHomeAdminState();
}

class _PageHomeAdminState extends State<PageHomeAdmin> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    List<String> title = ["Sản phẩm", "Loại sản phẩm", "Khách hàng", "Tài khoản"];

    return Scaffold(
      appBar: buildAppBarAdmin(info: title[index]),
      body: _buildBody(context, index),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(30),
        ),
        child: GNav(
          activeColor: Colors.white,
          gap: 5,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          padding: const EdgeInsets.all(10),
          style: GnavStyle.google,
          haptic: true,
          color: Colors.white70,
          tabBackgroundColor: Colors.black38,
          tabBorderRadius: 20,
          tabs: const [
            GButton(icon: Icons.fastfood_rounded, text: "Sản phẩm"),
            GButton(icon: Icons.people, text: "Khách hàng"),
            GButton(icon: Icons.shopping_bag_sharp, text: "Đơn hàng"),
            GButton(icon: Icons.person_outline_outlined, text: "Tôi"),
          ],
          onTabChange: (value) async {
            setState(() {
              index = value;
            });
          },
        ),
      ),
    );
  }

  _buildBody(BuildContext context, int index) {
    if (index == 1) return _buildAboutMe(context);
    if (index == 2) return _buildAboutMe(context);
    if (index == 3) return _buildAboutMe(context);
    return _buildHome(context);
  }

  _buildHome(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: ProductSnapshot.streamData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          
          var c = ChuonChuonKimController.instance;
          TextEditingController txt = TextEditingController();
          List<ProductSnapshot> list = snapshot.data!;
          list.sort((ProductSnapshot a, ProductSnapshot b) => a.product.maSP.compareTo(b.product.maSP));
          c.listProductSnapshot = list;
          List<ProductSnapshot> products = list;

          void search({required String textSearch}) {
            if (textSearch.isNotEmpty) {
              textSearch = textSearch.toLowerCase();
              products = [];

              for (ProductSnapshot psn in list) {
                Product p = psn.product;
                bool searchID = p.maSP.toLowerCase().contains(textSearch);
                bool searchName = p.tenSP.toLowerCase().contains(textSearch);
                bool searchDescription = p.moTaSP.toLowerCase().contains(textSearch);
                bool searchPrice = p.giaSP.toString().toLowerCase().contains(textSearch);

                if (searchID || searchName || searchDescription || searchPrice) {
                  products.add(psn);
                }
              }
              c.updateNameId(nameId: "productAllAdmin");
            }
          }

          return Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              children: [
                // * search
                SizedBox(
                  height: 50,
                  child: TextField(
                    controller: txt,
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
                          search(textSearch: txt.text);
                        },
                      ),
                      hintText: "Tìm kiếm...",
                    ),
                    onSubmitted: (value) {
                      search(textSearch: value);
                    },
                    onChanged: (value) {
                      if (value.isEmpty) {
                        products = list;
                        ChuonChuonKimController.instance.updateNameId(nameId: "productAllAdmin");
                      }
                    },
                  ),
                ),
          
                // * show products
                Expanded(
                  child: GetBuilder(
                    init: ChuonChuonKimController.instance,
                    id: "productAllAdmin",
                    builder: (controller) {
                      return ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          ProductSnapshot ps = products[index];

                          return ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxHeight: 120,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Slidable(
                                key: const ValueKey(0),
                                endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (value) {
                                        Get.to(PageUpdateProduct(ps: ps));
                                      },
                                      backgroundColor: const Color(0xFF7BC043),
                                      foregroundColor: Colors.white,
                                      icon: Icons.archive,
                                      label: 'Cập nhật',
                                    ),
                                    SlidableAction(
                                      onPressed: (value) async {
                                        List<String> list = ["Xoá", "Huỷ"];
                                        String cauHoi = "Bạn chắc chắc muốn xoá ?";
                                        await khungLuaChon(context: context, listLuaChon: list, cauHoi: cauHoi)
                                        .then((value) async {
                                          if (value == list[0]) {
                                            thongBaoDangThucHien(context: context, info: "Đang xoá...");
                                            await deleteImage(folders: Firebase.pathImageProduct, fileName: "${ps.product.maSP}.jpg");
                                            await ps.delete()
                                            .then((value) {
                                              thongBaoThucHienXong(context: context, info: "Đã xoá.");
                                              print("Đã xoá.");
                                            })
                                            .catchError((error) {
                                              thongBaoThucHienXong(context: context, info: "Lỗi xoá !");
                                              print("Có lỗi khi xoá !.");
                                            });
                                          }
                                        });
                                      },
                                      backgroundColor: const Color.fromARGB(255, 207, 3, 3),
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                      label: 'Xóa',
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Image.network(ps.product.hinhAnhSP),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text("ID: ${ps.product.maSP}"),
                                            Text("Tên: ${ps.product.tenSP}"),
                                            Text("Giá: ${ps.product.giaSP}"),
                                            Text("Mô tả: ${ps.product.moTaSP}"),
                                            Text("Loại sản phẩm: ${c.getTenLSP(product: ps.product)}"),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => const Divider(thickness: 1.5),
                        itemCount: products.length,
                      );
                    }
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const PageAddProduct());
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  _buildAboutMe(BuildContext context) {
    return account(context);
  }
}
