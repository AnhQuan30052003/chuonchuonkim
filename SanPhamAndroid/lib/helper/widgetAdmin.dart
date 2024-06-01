import 'package:badges/badges.dart' as badges;
import 'package:chuonchuonkim_app/database/models/ProductType.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import '../controllers/chuonChuonKimController.dart';
import '../database/connect/setupFirebase.dart';
import '../database/models/Notification.dart';
import '../database/models/Product.dart';
import '../database/models/User.dart';
import 'dialog.dart';
import 'uploadImage.dart';
import '../pages/admin/pageOrder.dart';
import '../pages/admin/product/pageAddProduct.dart';
import '../pages/admin/product/pageUpdateProduct.dart';
import '../pages/admin/product_type/pageAddProductType.dart';
import '../pages/admin/product_type/pageUpdateProductType.dart';
import '../pages/admin/user/updateUser.dart';

PreferredSizeWidget buildAppBarAdmin({required BuildContext context, required String info}) {
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
            badgeContent: StreamBuilder(
              stream: NotificationsSnapshot.streamData(),
              builder: (context, snapshot) {
                List<NotificationsSnapshot> list = [];

                try {
                  list = snapshot.data!;
                } catch (error) {
                  list = [];
                }

                int count = 0;
                for (var no in list) {
                  if (no.notification.seen == false) count += 1;
                }

                return Text("$count", style: const TextStyle(color: Colors.white));
              },
            ),
            child: const Icon(Icons.card_travel, color: Color(0xFF3A3737)),
          ),
        ),
        onTap: () {
          Get.to(() => const PageOrder());
        },
      ),
    ],
  );
}

FloatingActionButton buildFloatButton({required Widget type}) {
  return FloatingActionButton(
    onPressed: () {
      Get.to(() => type);
    },
    child: const Icon(Icons.add),
  );
}

Widget buildProduct(BuildContext context) {
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
        List<ProductSnapshot> data = snapshot.data!;
        data.sort((ProductSnapshot a, ProductSnapshot b) => a.product.maSP.compareTo(b.product.maSP));
        c.listProductSnapshot = data;
        List<ProductSnapshot> list = data;

        void search({required String textSearch}) {
          if (textSearch.isNotEmpty) {
            textSearch = textSearch.toLowerCase();
            list = [];

            for (var object in data) {
              var p = object.product;
              bool searchID = p.maSP.toLowerCase().contains(textSearch);
              bool searchName = p.tenSP.toLowerCase().contains(textSearch);
              bool searchDescription = p.moTaSP.toLowerCase().contains(textSearch);
              bool searchPrice = p.giaSP.toString().toLowerCase().contains(textSearch);

              if (searchID || searchName || searchDescription || searchPrice) {
                list.add(object);
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
                      list = data;
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
                          ProductSnapshot ps = list[index];

                          return ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxHeight: 160,
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
                                        await khungLuaChon(
                                                context: context, listLuaChon: list, cauHoi: cauHoi)
                                            .then((value) async {
                                          if (value == list[0]) {
                                            thongBaoDangThucHien(
                                                context: context, info: "Đang xoá...");

                                            try {
                                              await deleteImage(
                                                  folders: Firebase.pathImageProduct,
                                                  fileName: "${ps.product.maSP}.jpg");
                                              print("Xoá thành công.");
                                            } catch (error) {
                                              print("Lỗi xoá !");
                                            }

                                            await ps.delete().then((value) {
                                              thongBaoThucHienXong(
                                                  context: context, info: "Đã xoá.");
                                              print("Đã xoá.");
                                            }).catchError((error) {
                                              thongBaoThucHienXong(
                                                  context: context, info: "Lỗi xoá !");
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
                                child: Card(
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
                                              Text(
                                                  "Loại sản phẩm: ${c.getTenLSP(product: ps.product)}"),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => const Divider(thickness: 1.5),
                        itemCount: list.length,
                      );
                    }
                  ),
              ),
            ],
          ),
        );
      },
    ),
    floatingActionButton: buildFloatButton(type: const PageAddProduct()),
  );
}

Widget buildProductType(BuildContext context) {
  return Scaffold(
    body: StreamBuilder(
      stream: ProductTypeSnapshot.streamData(),
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
        List<ProductTypeSnapshot> data = snapshot.data!;
        data.sort((ProductTypeSnapshot a, ProductTypeSnapshot b) =>
            a.productType.maLSP.compareTo(b.productType.maLSP));
        c.listProductTypeSnapshot = data;
        List<ProductTypeSnapshot> list = data;

        void search({required String textSearch}) {
          if (textSearch.isNotEmpty) {
            textSearch = textSearch.toLowerCase();
            list = [];

            for (var object in data) {
              var p = object.productType;
              bool searchID = p.maLSP.toLowerCase().contains(textSearch);
              bool searchName = p.tenLSP.toLowerCase().contains(textSearch);

              if (searchID || searchName) {
                list.add(object);
              }
            }
            c.updateNameId(nameId: "productTypeAllAdmin");
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
                      list = data;
                      ChuonChuonKimController.instance.updateNameId(nameId: "productTypeAllAdmin");
                    }
                  },
                ),
              ),

              // * show products
              Expanded(
                child: GetBuilder(
                    init: ChuonChuonKimController.instance,
                    id: "productTypeAllAdmin",
                    builder: (controller) {
                      return ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          ProductTypeSnapshot pts = list[index];

                          return ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxHeight: 80,
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
                                        Get.to(PageUpdateProductType(pts: pts));
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
                                        await khungLuaChon(
                                                context: context, listLuaChon: list, cauHoi: cauHoi)
                                            .then((value) async {
                                          if (value == list[0]) {
                                            thongBaoDangThucHien(
                                                context: context, info: "Đang xoá...");

                                            try {
                                              await deleteImage(
                                                  folders: Firebase.pathImageProductType,
                                                  fileName: "${pts.productType.maLSP}.jpg");
                                              print("Xoá thành công.");
                                            } catch (error) {
                                              print("Xoá lỗi !");
                                            }

                                            await pts.delete().then((value) {
                                              thongBaoThucHienXong(
                                                  context: context, info: "Đã xoá.");
                                              print("Đã xoá.");
                                            }).catchError((error) {
                                              thongBaoThucHienXong(
                                                  context: context, info: "Lỗi xoá !");
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
                                child: Card(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Image.network(pts.productType.hinhAnhLSP),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 10),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text("ID: ${pts.productType.maLSP}"),
                                              Text("Tên: ${pts.productType.tenLSP}"),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => const Divider(thickness: 1.5),
                        itemCount: list.length,
                      );
                    }),
              ),
            ],
          ),
        );
      },
    ),
    floatingActionButton: buildFloatButton(type: const PageAddProductType()),
  );
}

Widget buildUser(BuildContext context) {
  return Scaffold(
    body: StreamBuilder(
      stream: UserSnapshot.streamData(),
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
        List<UserSnapshot> data = snapshot.data!;
        for (var o in data) {
          if (o.user.id == "0000") {
            data.remove(o);
            break;
          }
        }

        data.sort((UserSnapshot a, UserSnapshot b) => a.user.id.compareTo(b.user.id));
        c.listUserSnapshot = data;
        List<UserSnapshot> list = data;

        void search({required String textSearch}) {
          if (textSearch.isNotEmpty) {
            textSearch = textSearch.toLowerCase();
            list = [];

            for (var object in data) {
              var p = object.user;
              bool searchID = p.id.toLowerCase().contains(textSearch);
              bool searchName = p.ten.toLowerCase().contains(textSearch);
              bool searchPhoneNumber = p.sdt.toLowerCase().contains(textSearch);
              bool searchAddress = p.diaChi.toLowerCase().contains(textSearch);

              if (searchID || searchName || searchPhoneNumber || searchAddress) {
                list.add(object);
              }
            }
            c.updateNameId(nameId: "userAllAdmin");
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
                      list = data;
                      ChuonChuonKimController.instance.updateNameId(nameId: "userAllAdmin");
                    }
                  },
                ),
              ),

              // * show products
              Expanded(
                child: GetBuilder(
                    init: ChuonChuonKimController.instance,
                    id: "userAllAdmin",
                    builder: (controller) {
                      return ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          UserSnapshot pts = list[index];

                          return ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxHeight: 150,
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
                                        Get.to(PageUpdateUser(ps: pts));
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
                                        await khungLuaChon(
                                                context: context, listLuaChon: list, cauHoi: cauHoi)
                                            .then((value) async {
                                          if (value == list[0]) {
                                            thongBaoDangThucHien(
                                                context: context, info: "Đang xoá...");
                                            try {
                                              await deleteImage(
                                                  folders: Firebase.pathAvatarUser,
                                                  fileName: "${pts.user.id}.jpg");
                                              print("Xoá thành công.");
                                            } catch (error) {
                                              print("Không tìm thấy ảnh !");
                                            }
                                            await pts.delete().then((value) {
                                              thongBaoThucHienXong(
                                                  context: context, info: "Đã xoá.");
                                              print("Đã xoá.");
                                            }).catchError((error) {
                                              thongBaoThucHienXong(
                                                  context: context, info: "Lỗi xoá !");
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
                                child: Card(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Image.network(pts.user.hinhAnhUser),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 10),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text("ID: ${pts.user.id}"),
                                              Text("Tên: ${pts.user.ten}"),
                                              Text("SDT: ${pts.user.sdt}"),
                                              Text("Địa chỉ: ${pts.user.diaChi}"),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => const Divider(thickness: 1.5),
                        itemCount: list.length,
                      );
                    }),
              ),
            ],
          ),
        );
      },
    ),
  );
}
