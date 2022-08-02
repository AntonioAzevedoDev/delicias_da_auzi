import 'package:delicias_da_auzi/src/models/cart_item_model.dart';
import 'package:delicias_da_auzi/src/models/order_model.dart';
import 'package:delicias_da_auzi/src/pages/auth/controller/auth_controller.dart';
import 'package:delicias_da_auzi/src/pages/orders/orders_result/orders_result.dart';
import 'package:delicias_da_auzi/src/pages/orders/repository/orders_repository.dart';
import 'package:delicias_da_auzi/src/services/utils_services.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  final ordersRepository = OrdersRepository();
  final authController = Get.find<AuthController>();
  final utilsServices = UtilsServices();
  bool isLoading = false;
  OrderModel order;

  void setLoading(bool value){
    isLoading = value;
    update();
  }
  OrderController(this.order);

  Future<void> getOrderItems() async {
    setLoading(true);

    final OrdersResult<List<CartItemModel>> result =
        await ordersRepository.getOrdersItems(
      orderId: order.id,
      token: authController.user.token!,
    );
    setLoading(false);
    result.when(
      success: (items) {
        order.items = items;
        update();
      },
      error: (message) {
        utilsServices.showToast(
          message: message,
          isError: true,
        );
      },
    );
  }
}
