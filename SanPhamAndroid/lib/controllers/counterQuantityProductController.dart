import 'package:get/get.dart';

class CounterQuantityProductController extends GetxController {
  final Rx<int> count;
  CounterQuantityProductController(int i) : count = Rx<int>(i);

  void increment() {
    count.value += 1;
  }

  void decrement() {
    if (count.value > 0) {
      count.value -= 1;
    }
  }
}