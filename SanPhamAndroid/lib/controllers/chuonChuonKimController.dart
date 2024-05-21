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
  List<Cart> listCart = [];
  List<ProductFavorite> listProductFavorite = [];
  List<ProductType> listProductType = [];

  @override
  void onReady() {
    super.onReady();
    getProducts();
    getProductTypes();
  }


  // Lấy dữ liệu Product
  void getProducts() async {
    var data = await ProductSnapshot.futureData();
    listProduct = data.map((e) => e.product).toList();
    listProduct.sort((Product a, Product b) => a.maSP.compareTo(b.maSP));
    updatePageHome();
    print("Đã cập nhật Product. Số lượng: ${listProduct.length}");
  }

  // Lấy dữ liệu ProductType
  void getProductTypes() async {
    var data = await ProductTypeSnapshot.futureData();
    listProductType = data.map((e) => e.productType).toList();
    listProductType.sort((ProductType a, ProductType b) => a.maLSP.compareTo(b.maLSP));
    updatePageHome();
    print("Đã cập nhật Product Type. ${listProductType.length}");
  }

  void updatePageHome() {
    update(["client_products"]);
  }




  // Thêm sản phẩm vào giỏ hàng
  void addToCart({required Product product}) {
    for (var cart in listCart) {
      if (cart.maSP == product.maSP) {
        cart.soLuong += 1;
        return;
      }
    }

    listCart.add(Cart(idUser: idUser, maSP: product.maSP, soLuong: 1));
  }

  // Xoá sản phẩm khỏi giỏ hàng
  void deleteFromCart({required int index}) {
    listCart.removeAt(index);
  }

  // Lấy sản phẩm từ giỏ hàng
  Product? getProductFromCart({required int index}) {
    for (var product in listProduct) {
      if (product.maSP == listCart[index].maSP) {
        return product;
      }
    }
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


  // Hiển thị sản phẩm theo loại sản phẩm click vào !
  void showProductType({required String idLSP}) {
    getProducts();
    var listProductSave = listProduct;
    listProduct = [];
    for (var p in listProductSave) {
      if (p.maLSP == idLSP) {
        listProduct.add(p);
      }
    }
    updatePageHome();
  }
}



// Bindings..
class ChuonChuonKimBindings extends Bindings {

  @override
  void dependencies() {
    Get.put(ChuonChuonKimController());
  }
}


