import 'package:delicias_da_auzi/src/pages/cart/controller/cart_controller.dart';
import 'package:delicias_da_auzi/src/pages/product/product_screen.dart';
import 'package:delicias_da_auzi/src/pages_routes/app_pages.dart';
import 'package:delicias_da_auzi/src/services/utils_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/custom_colors.dart';
import '../../../../models/item_model.dart';

class ItemTile extends StatefulWidget {
  const ItemTile({Key? key, required this.item, required this.cartAnimationMethod}) : super(key: key);
  final ItemModel item;

  final void Function(GlobalKey) cartAnimationMethod;


  @override
  State<ItemTile> createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  final GlobalKey imageGk = GlobalKey();
  final cartController = Get.find<CartController>();
  final UtilsServices utilsServices = UtilsServices();

  IconData tileIcon = Icons.add_shopping_cart_outlined;

  Future<void> switchIcon() async{
    setState(() => tileIcon = Icons.check);

    await Future.delayed(const Duration(milliseconds: 2000));

    setState(() => tileIcon = Icons.add_shopping_cart_outlined);
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //Conteudo
        GestureDetector(
          onTap: (){
            Get.toNamed(PagesRoutes.productRoute, arguments: widget.item);
          },
          child: Card(
            elevation: 1,
            shadowColor: Colors.grey.shade300,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Imagem
                  Expanded(child: Hero(
                      tag: widget.item.imgUrl,
                      child: Image.network(widget.item.imgUrl,key: imageGk,)
                  )
                  ),
                  //Nome
                  Text(widget.item.itemName, style:const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold
                    ),
                  ),
                  //Preço - Unidade
                  Row(
                    children: [

                      Text(utilsServices.priceToCurrency(widget.item.price),style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: CustomColors.customSwatchColor
                      ),),
                      Text('/${widget.item.unit}',style: TextStyle(
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.bold,
                          fontSize: 12
                      ),)
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 4,
            right: 4,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  topRight: Radius.circular(20)
              ),
              child: Material(
                child: InkWell(
                  onTap: (){
                    switchIcon();
                    cartController.addItemToCart(item: widget.item);

                    widget.cartAnimationMethod(imageGk);
                  },
                  child: Ink(
                    height: 40,
                    width: 35,
                    decoration: BoxDecoration(
                      color: CustomColors.customSwatchColor,

                    ),
                    child: Icon(
                        tileIcon,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ))
      ],
    );
  }
}
