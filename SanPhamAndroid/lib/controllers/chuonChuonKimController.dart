import 'package:chuonchuonkim_app/database/models/ProductFavorite.dart';
import 'package:get/get.dart';
import '../database/models/Product.dart';
import '../database/models/Cart.dart';
import '../database/models/ProductType.dart';
import '../database/models/User.dart';

class ChuonChuonKimController extends GetxController {
  static ChuonChuonKimController get instance => Get.find<ChuonChuonKimController>();

  List<ProductSnapshot> listProductSnapshot = [];
  List<ProductTypeSnapshot> listProductTypeSnapshot = [];
  List<CartSnapshot> listCartSnapshot = [];
  List<UserSnapshot> listUserSnapshot = [];
  List<ProductFavoriteSnapshot> listProductFavoriteSnapshot = [];

  List<Product> listProductsPopulator = [];
  List<Product> listProductsGridView = [];
  List<Product> listProductSearch= [];
  List<Product> listSimilarProducts= [];
  List<Product> productYouCanLike= [];

  UserSnapshot? userSnapshot;

  @override
  void onReady() {
    super.onReady();

    getUser();
    getProductType();
    getProduct();
    getProductFavorite();
    getCart();
  }

  // * -------------------------------------
  // Lấy dữ liệu cart
  Future<void> getCart() async {
    listCartSnapshot = await CartSnapshot.futureData();
    listCartSnapshot.sort((CartSnapshot a, CartSnapshot b) => a.cart.idCart.compareTo(b.cart.idCart));
  }

  // Lấy dữ liệu product favorite
  Future<void> getProductFavorite() async {
    listProductFavoriteSnapshot = await ProductFavoriteSnapshot.futureData();
    listProductFavoriteSnapshot.sort((ProductFavoriteSnapshot a, ProductFavoriteSnapshot b) => a.productFavorite.idPF.compareTo(b.productFavorite.idPF));
  }

  // Lấy dữ liệu product
  Future<void> getProduct() async {
    listProductSnapshot = await ProductSnapshot.futureData();
    listProductSnapshot.sort((ProductSnapshot a, ProductSnapshot b) => a.product.maSP.compareTo(b.product.maSP));

    getProductsPopulator(requestQuantity: 1);
    listProductsGridView = listProductSnapshot.map((e) => e.product).toList();
    updateNameId(nameId: "gridview_products");
  }

  // Lấy dữ liệu product Type
  Future<void> getProductType() async {
    listProductTypeSnapshot = await ProductTypeSnapshot.futureData();
    listProductTypeSnapshot.sort((ProductTypeSnapshot a, ProductTypeSnapshot b) => a.productType.maLSP.compareTo(b.productType.maLSP));
    updateNameId(nameId: "filter");
    updateNameId(nameId: "productAllAdmin");
  }

  // Lấy dữ liệu user
  Future<void> getUser() async {
    listUserSnapshot = await UserSnapshot.futureData();
    listUserSnapshot.sort((UserSnapshot a, UserSnapshot b) => a.user.id.compareTo(b.user.id));

    // lấy tạm để code
    for (var o in listUserSnapshot) {
      if (o.user.id == "0001") {
        userSnapshot = o;
        break;
      }
    }
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
    }
    else {
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
      bool searchMota= ps.product.moTaSP.toLowerCase().contains(search);

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
}










// Bindings..
class ChuonChuonKimBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ChuonChuonKimController());
  }
}
