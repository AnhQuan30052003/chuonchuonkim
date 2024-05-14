import 'package:get/get.dart';

class CheckProductController extends GetxController {
  final Rx<bool> isChecked = Rx<bool>(false);

  void check() {
    isChecked.value ? false : true;
  }
}