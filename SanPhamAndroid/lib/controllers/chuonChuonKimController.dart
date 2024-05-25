import 'package:get/get.dart';
import '../database/models/Product.dart';
import '../database/models/Cart.dart';
import '../database/models/ProductFavorite.dart';
import '../database/models/ProductType.dart';
import 'checkProductController.dart';
import 'counterQuantityProductController.dart';

class ChuonChuonKimController extends GetxController {
  static ChuonChuonKimController get instance => Get.find<ChuonChuonKimController>();

  String idUser = "";
  List<Product> listProduct = [];
  List<CartSnapshot> listCart = [];
  List<ProductFavoriteSnapshot> listProductFavorite = [];
  List<ProductType> listProductType = [];

  List<Product> listProductsPopulator = [];
  List<Product> listProdutsGridView = [];

  List<Product> listProductSeach= [];
  List<Product> listSimilarProducts= [];

  @override
  void onReady() {
    super.onReady();
    getProductTypes();
    getProducts();
    getCarts();
    getFavorites();
  }



  // * -------------------------------------
  // Lấy product populator
  void getProductsPopulator({required int requestQuantity}) {
    listProductsPopulator = [];
    for (var pt in listProductType) {
      int quantity = 0;
      for (var p in listProduct) {
        if (p.maLSP == pt.maLSP) {
          listProductsPopulator.add(p);
          quantity += 1;
          if (quantity == requestQuantity) break;
        }
      }
    }
  }

  // Lấy dữ liệu ListCart
  void getCarts() {

  }

  // Lấy dữ liệu Favorite
  void getFavorites() {

  }

  // Lấy dữ liệu Product
  void getProducts() async {
    var data = await ProductSnapshot.futureData();
    listProduct = data.map((e) => e.product).toList();
    listProduct.sort((Product a, Product b) => a.maSP.compareTo(b.maSP));

    getProductsPopulator(requestQuantity: 1);
    listProdutsGridView = listProduct;

    updatePageHome();
    print("Đã cập nhật Product. Số lượng: ${listProduct.length}");
  }

  // Lấy dữ liệu ProductType
  void getProductTypes() async {
    var data = await ProductTypeSnapshot.futureData();
    listProductType = data.map((e) => e.productType).toList();
    listProductType.sort((ProductType a, ProductType b) => a.maLSP.compareTo(b.maLSP));
    updatePageHome();
    print("Đã cập nhật Product Type. Số lượng: ${listProductType.length}");
  }

  void updatePageHome() {
    update(["client_products"]);
  }

  void updateProductsPopulattor() {
    update(["products_populator"]);
  }

  void updateGridView() {
    update(["gridview_products"]);
  }

  // Thêm sản phẩm vào giỏ hàng
  void addToCart({required Product product}) {
    // for (var cart in listCart) {
    //   if (cart.maSP == product.maSP) {
    //     cart.soLuong += 1;
    //     return;
    //   }
    // }

    // listCart.add(Cart(idUser: idUser, maSP: product.maSP, soLuong: 1));
  }

  // Xoá sản phẩm khỏi giỏ hàng
  void deleteFromCart({required int index}) {
    listCart.removeAt(index);
  }

  // Lấy sản phẩm từ giỏ hàng
  Product? getProductFromCart({required int index}) {
    // for (var product in listProduct) {
    //   if (product.maSP == listCart[index].maSP) {
    //     return product;
    //   }
    // }
    return null;
  }

  // Tổng giá của sản phẩm
  int sumPirceOfProduct({required int index, required int quantity}) {
    return getProductFromCart(index: index)!.giaSP * quantity;
  }

  // Tổng tiền cả giỏ hàng
  int sumPriceOfList({required List<CounterQuantityProductController> listCounter, required List<CheckProductController> listCheck}) {
    int sum = 0;
    for (int i = 0; i < listCart.length; i++) {
      if (listCheck[i].isChecked.value) {
        sum += sumPirceOfProduct(index: i, quantity: listCounter[i].count.value);
      }
    }
    return sum;
  }



  // * -------------------------------------
  // Hiển thị sản phẩm theo loại sản phẩm click vào !
  void showProductType({required String idLSP}) {
    for (var p in listProductsPopulator) {
      if (p.maLSP == idLSP) {
        Product temp = p;
        listProductsPopulator.remove(p);
        listProductsPopulator.insert(0, temp);
      }
    }

    listProdutsGridView = [];
    for (var p in listProduct) {
      if (p.maLSP == idLSP) {
        listProdutsGridView.add(p);
      }
    }
    updateProductsPopulattor();
    updateGridView();
  }

  void showProductSearch({required String search}) {
    listProductSeach = [];
    for (var p in listProduct) {
      if ((p.tenSP.toLowerCase().contains(search.toLowerCase())) || (p.moTaSP.toLowerCase().contains(search.toLowerCase()))) {
        listProductSeach.add(p);
      }
    }
  }

  void showSimilaProducts({required Product product}) {
    listSimilarProducts = [];
    for (var p in listProduct) {
      if (p.maLSP == product.maLSP) {
        listSimilarProducts.add(p);
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
