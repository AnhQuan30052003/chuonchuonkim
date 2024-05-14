import 'package:get/get.dart';
import '../database_test/SanPham.dart';

class ChuonChuonKimController extends GetxController {
  static ChuonChuonKimController get instance => Get.find<ChuonChuonKimController>();

  List<SanPham> listSP = [];

  @override
  void onReady() {
    super.onReady();
    getData();
  }

  void getData() {
    listSP = dbSanPham;
  }
}

class ChuonChuonKimBindings extends Bindings {

  @override
  void dependencies() {
    Get.put(ChuonChuonKimController());
  }
}


