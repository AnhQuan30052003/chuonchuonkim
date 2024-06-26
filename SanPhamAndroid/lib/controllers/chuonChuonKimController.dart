import 'package:chuonchuonkim_app/database/models/ProductFavorite.dart';
import 'package:chuonchuonkim_app/pages/admin/pageHomeAdmin.dart';
import 'package:chuonchuonkim_app/pages/client/pageHomeClient.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../database/connect/setupFirebase.dart';
import '../database/models/Notification.dart';
import '../database/models/Product.dart';
import '../database/models/Cart.dart';
import '../database/models/ProductType.dart';
import '../database/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper/dialog.dart';
import '../pages/system/createItem.dart';

class ChuonChuonKimController extends GetxController {
  static ChuonChuonKimController get instance => Get.find<ChuonChuonKimController>();

  bool isLogin = false;
  UserSnapshot? userSnapshot;

  List<ProductSnapshot> listProductSnapshot = [];
  List<ProductTypeSnapshot> listProductTypeSnapshot = [];
  List<CartSnapshot> listCartSnapshot = [];
  List<UserSnapshot> listUserSnapshot = [];
  List<ProductFavoriteSnapshot> listProductFavoriteSnapshot = [];

  List<Product> listProductsPopulator = [];
  List<Product> listProductsGridView = [];
  List<Product> listProductSearch = [];
  List<Product> listSimilarProducts = [];

  @override
  void onReady() {
    super.onReady();
    getData();
  }

  Future<void> removeAndUploadData() async {
    print("Đang thêm dữ liệu lên firebase...");
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
      for (var o in dbNotifications) {
        NotificationsSnapshot.add(o);
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

    print("Thêm dữ liệu thành công lên Firebase.");
  }

  void getData() async {
    await getUser();
    await getProductType();
    await getProduct();
    await getProductFavorite();
    await getCart();
    await testLogin();
  }

  Future<void> testLogin() async {
    SharedPreferences spf = await SharedPreferences.getInstance();
    String? idLogin = spf.getString("idLogin");

    if (idLogin == null) {
      Get.offAll(() => const PageHomeClient());
      return;
    }

    for (var us in listUserSnapshot) {
      if (us.user.id == idLogin) {
        userSnapshot = us;
        isLogin = true;

        if (idLogin == "0000") {
          Get.offAll(() => const PageHomeAdmin());
        } else {
          Get.offAll(() => const PageHomeClient());
        }
      }
    }
  }

  Future<bool> login({required String user, required String password}) async {
    for (var us in listUserSnapshot) {
      var u = us.user;
      if ((u.user == user || u.sdt == user) && u.pass == password) {
        userSnapshot = us;
        isLogin = true;
        SharedPreferences spf = await SharedPreferences.getInstance();
        spf.setString("idLogin", userSnapshot!.user.id);
        return true;
      }
    }
    return false;
  }

  // * -------------------------------------
  // Lấy dữ liệu cart
  Future<void> getCart() async {
    listCartSnapshot = await CartSnapshot.futureData();
  }

  // Lấy dữ liệu product favorite
  Future<void> getProductFavorite() async {
    listProductFavoriteSnapshot = await ProductFavoriteSnapshot.futureData();
  }

  // Lấy dữ liệu product
  Future<void> getProduct() async {
    listProductSnapshot = await ProductSnapshot.futureData();

    getProductsPopulator(requestQuantity: 1);
    listProductsGridView = listProductSnapshot.map((e) => e.product).toList();
    updateNameId(nameId: "gridview_products");
  }

  // Lấy dữ liệu product Type
  Future<void> getProductType() async {
    listProductTypeSnapshot = await ProductTypeSnapshot.futureData();
    updateNameId(nameId: "filter");
    updateNameId(nameId: "productAllAdmin");
  }

  // Lấy dữ liệu user
  Future<void> getUser() async {
    listUserSnapshot = await UserSnapshot.futureData();
  }

  String getId() {
    return isLogin == false ? "" : userSnapshot!.user.id;
  }

  void getProductsPopulator({required int requestQuantity}) {
    listProductsPopulator = [];
    for (var pts in listProductTypeSnapshot) {
      int quantity = 0;
      for (var ps in listProductSnapshot) {
        if (ps.product.maLSP == pts.productType.maLSP) {
          listProductsPopulator.add(ps.product);
          quantity += 1;
          if (quantity == requestQuantity) break;
        }
      }
    }

    updateNameId(nameId: "products_populator");
  }

  void updateNameId({required String nameId}) {
    print("Chuẩn bị update id: $nameId");
    update([nameId]);
  }

  // * -------------------------------------
  // Thêm sản phẩm vào giỏ hàng
  Future<void> addToCart({required Cart cartNew}) async {
    for (var cn in listCartSnapshot) {
      if (cn.cart.maSP == cartNew.maSP) {
        cn.cart.soLuong += 1;
        cn.update(cn.cart);
        return;
      }
    }

    await CartSnapshot.add(cartNew);
    // getCartSnapshot();
  }

  // Xoá sản phẩm khỏi giỏ hàng
  void deleteFromCart({required int index}) {
    listCartSnapshot.removeAt(index);
  }

  // Lấy sản phẩm từ giỏ hàng
  Product? getProductFromCart({required String maSP}) {
    for (var ps in listProductSnapshot) {
      if (ps.product.maSP == maSP) {
        return ps.product;
      }
    }
    return null;
  }

  // Lấy tên loại sản phẩm từ mã
  String getTenLSP({required Product product}) {
    String text = "";
    for (var pts in listProductTypeSnapshot) {
      if (pts.productType.maLSP == product.maLSP) {
        text = pts.productType.tenLSP;
        break;
      }
    }

    return text;
  }

  // * -------------------------------------
  // Hiển thị sản phẩm theo loại sản phẩm click vào !
  void showProductType({required String idLSP}) {
    if (idLSP.isEmpty) {
      listProductsGridView = listProductSnapshot.map((e) => e.product).toList();
      listProductsPopulator.sort((Product a, Product b) => a.maSP.compareTo(b.maSP));
    } else {
      for (var p in listProductsPopulator) {
        if (p.maLSP == idLSP) {
          Product temp = p;
          listProductsPopulator.remove(p);
          listProductsPopulator.insert(0, temp);
        }
      }

      listProductsGridView = [];
      for (var ps in listProductSnapshot) {
        if (ps.product.maLSP == idLSP) {
          listProductsGridView.add(ps.product);
        }
      }
    }

    updateNameId(nameId: "products_populator");
    updateNameId(nameId: "gridview_products");
  }

  void showProductSearch({required String search}) {
    listProductSearch = [];
    search = search.toLowerCase();

    for (var ps in listProductSnapshot) {
      bool searchMaSP = ps.product.maSP.toLowerCase().contains(search);
      bool searchName = ps.product.tenSP.toLowerCase().contains(search);
      bool searchMota = ps.product.moTaSP.toLowerCase().contains(search);

      if (searchMaSP || searchName || searchMota) {
        listProductSearch.add(ps.product);
      }
    }
  }

  void showSimilarProducts({required Product product}) {
    listSimilarProducts = [];
    for (var ps in listProductSnapshot) {
      if (ps.product.maLSP == product.maLSP) {
        listSimilarProducts.add(ps.product);
      }
    }
  }

  Product? getProductFromID({required String id}) {
    for (var ps in listProductSnapshot) {
      if (ps.product.maSP == id) {
        return ps.product;
      }
    }
    return null;
  }

  Future<void> adminConfirm({
    required BuildContext context,
    required List<String> thongBaoRaManHinh,
    required NotificationsSnapshot ns,
    required Notifications no
    }) async {

    int i = 0;
    thongBaoDangThucHien(context: context, info: thongBaoRaManHinh[i++]);
    no.text = thongBaoRaManHinh[i++];

    await NotificationsSnapshot.add(no).then((value) {
      thongBaoThucHienXong(context: context, info: thongBaoRaManHinh[i++]);
      ns.delete();
    });
  }
}

// Bindings..
class ChuonChuonKimBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ChuonChuonKimController());
    print("Đã tạo xong controller");
  }
}
