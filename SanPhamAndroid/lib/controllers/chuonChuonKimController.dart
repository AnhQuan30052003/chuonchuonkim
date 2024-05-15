import 'package:get/get.dart';
import '../database_test/Cart.dart';
import '../database_test/Product.dart';
import 'checkProductController.dart';
import 'counterQuantityProductController.dart';

class ChuonChuonKimController extends GetxController {
  static ChuonChuonKimController get instance => Get.find<ChuonChuonKimController>();

  List<Product> listProduct = [];
  List<Product> listProductSave = [];
  final listCart = <Cart>[
    Cart(maSP: "SP001", soLuong: 1),
  ].obs;

  @override
  void onReady() {
    super.onReady();
    getData();
  }

  void getData() {
    listProduct = listProductSave = dbProduct;
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

    listCart.add(Cart(maSP: product.maSP, soLuong: 1));
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

  /// Hàm xủ lỷ
  // Hiển thị sản phẩm theo loại sản phẩm click vào !
  void showProductType({required String idLSP}) {
    listProduct = [];
    for (var p in listProductSave) {
      if (p.maLSP == idLSP) {
        listProduct.add(p);
      }
    }

    update(["client_products"]);
  }
}



// Bindings..
class ChuonChuonKimBindings extends Bindings {

  @override
  void dependencies() {
    Get.put(ChuonChuonKimController());
  }
}


