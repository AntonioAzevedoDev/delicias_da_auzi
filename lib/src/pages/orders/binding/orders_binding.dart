

import 'package:delicias_da_auzi/src/pages/orders/controller/all_orders_controller.dart';
import 'package:get/get.dart';

class OrdersBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(AllOrdersController());
  }

}