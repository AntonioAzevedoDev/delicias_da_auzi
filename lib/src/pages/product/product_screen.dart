import 'package:delicias_da_auzi/src/config/custom_colors.dart';
import 'package:delicias_da_auzi/src/models/item_model.dart';
import 'package:delicias_da_auzi/src/pages/cart/controller/cart_controller.dart';
import 'package:delicias_da_auzi/src/services/utils_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../base/controller/navigation_controller.dart';
import '../commom_widgets/quantity_widget.dart';
class ProductScreen extends StatefulWidget {
  ProductScreen({Key? key}) : super(key: key);
  final ItemModel item = Get.arguments;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final UtilsServices utilsServices =  UtilsServices();

  int cartItemQuantity = 1;
  final navigationController = Get.find<NavigationController>();

  final cartController = Get.find<CartController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withAlpha(230),
      body: Stack(
        children: [
          //Conteudo
          Column(
            children: [
              Expanded(child: Hero(tag:widget.item.imgUrl,child: Image.network(widget.item.imgUrl))),
              Expanded(child: Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(50)
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade600,
                      offset: Offset(0,2)
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    //Nome - Quantidade
                    Row(
                      children: [
                        Expanded(
                          child: Text(widget.item.itemName,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.bold
                          ),
                          ),
                        ),
                        QuantityWidget(
                         suffixText: widget.item.unit,
                         value: cartItemQuantity,
                          result: (quantity){
                            setState(() {
                              cartItemQuantity = quantity;
                            });
                          },
                       )
                      ],
                    ),
                    //Preço
                    Text(utilsServices.priceToCurrency(widget.item.price),style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: CustomColors.customSwatchColor
                    ),
                    ),
                    //Descrição
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: SingleChildScrollView(
                            child: Text(
                              widget.item.description,
                              style: const TextStyle(height: 1.5),
                            )
                        ),
                      ),
                    ),
                    //Botão
                    SizedBox(
                      height: 55,
                      child: ElevatedButton.icon(

                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)
                          ),
                        ),
                          onPressed: (){
                          //Fechar
                            Get.back();
                            //Adicionar produto
                            cartController.addItemToCart(item: widget.item, quantity: cartItemQuantity);
                            //Abrir carrinho
                            navigationController.navigatePageView(NavigationTabs.cart);
                          },
                          label: const Text('Add no carrinho',style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                          ),),
                          icon: const Icon(Icons.shopping_cart_outlined,color: Colors.white,)
                      ),
                    )
                  ],
                ),
              ))
            ],
          ),
          Positioned(
            left: 10,
            top: 10,
            child: SafeArea(
                child: IconButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back_ios)
                )
            ),
          )
        ],
      ),
    );
  }
}
