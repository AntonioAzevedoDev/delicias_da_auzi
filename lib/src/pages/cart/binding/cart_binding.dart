import 'package:delicias_da_auzi/src/pages/cart/controller/cart_controller.dart';
import 'package:get/get.dart';
class CartBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(CartController());

  }

}