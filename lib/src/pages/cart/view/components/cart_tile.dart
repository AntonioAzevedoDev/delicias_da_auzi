import 'package:delicias_da_auzi/src/models/cart_item_model.dart';
import 'package:delicias_da_auzi/src/pages/cart/controller/cart_controller.dart';
import 'package:delicias_da_auzi/src/pages/commom_widgets/quantity_widget.dart';
import 'package:delicias_da_auzi/src/services/utils_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/custom_colors.dart';

class CartTile extends StatefulWidget {
  final CartItemModel cartItem;

  CartTile({Key? key, required this.cartItem}) : super(key: key);

  @override
  State<CartTile> createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> {
  final UtilsServices utilsServices = UtilsServices();
  final controller = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        //Imagem
        leading: Image.network(
          widget.cartItem.item.imgUrl,
          height: 60,
          width: 60,
        ),
        //Titulo
        title: Text(
          widget.cartItem.item.itemName,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        //Total
        subtitle: Text(
          utilsServices.priceToCurrency(widget.cartItem.totalPrice()),
          style: TextStyle(
              color: CustomColors.customSwatchColor,
              fontWeight: FontWeight.bold),
        ),
        //Quantidade
        trailing: QuantityWidget(
          suffixText: widget.cartItem.item.unit,
          value: widget.cartItem.quantity,
          result: (quantity) {
            controller.changeItemQuantity(
              item: widget.cartItem,
              quantity: quantity,
            );
          },
          isRemovable: true,
        ),
      ),
    );
  }
}
