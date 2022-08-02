import 'package:delicias_da_auzi/src/pages/orders/controller/all_orders_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/order_tile.dart';

class OrdersTab extends StatelessWidget {
  const OrdersTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Pedidos'),
        ),
        body: GetBuilder<AllOrdersController>(builder: (controller) {
          return RefreshIndicator(
            onRefresh: () => controller.getAllOrders(),
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              physics: const BouncingScrollPhysics(),
              itemBuilder: (_, index) => OrderTile(
                order: controller.allOrders[index],
              ),
              separatorBuilder: (_, index) => const SizedBox(
                height: 10,
              ),
              itemCount: controller.allOrders.length,
            ),
          );
        }));
  }
}
