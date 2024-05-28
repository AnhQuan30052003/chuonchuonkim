import 'package:chuonchuonkim_app/database/models/ProductFavorite.dart';
import 'package:get/get.dart';
import '../database/models/Product.dart';
import '../database/models/Cart.dart';
import '../database/models/ProductType.dart';

class ChuonChuonKimController extends GetxController {
  static ChuonChuonKimController get instance => Get.find<ChuonChuonKimController>();

  List<ProductSnapshot> listProductSnapshot = [];
  List<ProductTypeSnapshot> listProductTypeSnapshot = [];
  List<CartSnapshot> listCartSnapshot = [];
  List<ProductFavoriteSnapshot> listProductFavoriteSnapshot = [];

  List<Product> listProductsPopulator = [];
  List<Product> listProdutsGridView = [];
  List<Product> listProductSeach= [];
  List<Product> listSimilarProducts= [];

  String idUser = "0001";

  @override
  void onReady() {
    super.onReady();

    getProductType();
    getProduct();
    getProductFavorite();
    getCart();
    getUser();
    // getNotification();
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
    listProdutsGridView = listProductSnapshot.map((e) => e.product).toList();
  }

  // Lấy dữ liệu product Type
  Future<void> getProductType() async {
    listProductTypeSnapshot = await ProductTypeSnapshot.futureData();
    listProductTypeSnapshot.sort((ProductTypeSnapshot a, ProductTypeSnapshot b) => a.productType.maLSP.compareTo(b.productType.maLSP));
  }

  // Lấy dữ liệu user
  Future<void> getUser() async {

  }

  // Lấy dữ liệu notification
  Future<void> getNotification() async {

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










  // * -------------------------------------
  // Hiển thị sản phẩm theo loại sản phẩm click vào !
  void showProductType({required String idLSP}) {
    if (idLSP.isEmpty) {
      listProdutsGridView = listProductSnapshot.map((e) => e.product).toList();
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

      listProdutsGridView = [];
      for (var ps in listProductSnapshot) {
        if (ps.product.maLSP == idLSP) {
          listProdutsGridView.add(ps.product);
        }
      }
    }

    // updateProductsPopulattor();
    // updateGridView();
  }

  void showProductSearch({required String search}) {
    listProductSeach = [];
    search = search.toLowerCase();

    for (var ps in listProductSnapshot) {
      bool searchMaSP = ps.product.maSP.toLowerCase().contains(search);
      bool searchName = ps.product.tenSP.toLowerCase().contains(search);
      bool searchMota= ps.product.moTaSP.toLowerCase().contains(search);

      if (searchMaSP || searchName || searchMota) {
        listProductSeach.add(ps.product);
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
