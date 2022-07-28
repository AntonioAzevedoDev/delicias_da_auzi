import 'package:delicias_da_auzi/src/pages/product/product_screen.dart';
import 'package:delicias_da_auzi/src/services/utils_services.dart';
import 'package:flutter/material.dart';

import '../../../config/custom_colors.dart';
import '../../../models/item_model.dart';

class ItemTile extends StatelessWidget {
  ItemTile({Key? key, required this.item}) : super(key: key);
  final ItemModel item;
  
  final UtilsServices utilsServices = UtilsServices();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //Conteudo
        GestureDetector(
          onTap: (){
            Navigator.of(context).push(
              MaterialPageRoute(builder: (c){
                return ProductScreen(item: item,);
              })
            );
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
                      tag: item.imgUrl,
                      child: Image.asset(item.imgUrl)
                  )
                  ),
                  //Nome
                  Text(item.itemName, style:const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold
                    ),
                  ),
                  //Preço - Unidade
                  Row(
                    children: [

                      Text(utilsServices.priceToCurrency(item.price),style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: CustomColors.customSwatchColor
                      ),),
                      Text('/${item.unit}',style: TextStyle(
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
            child: GestureDetector(
              onTap: (){

              },
              child: Container(
                height: 40,
                width: 35,
                decoration: BoxDecoration(
                  color: CustomColors.customSwatchColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    topRight: Radius.circular(20)
                  )
                ),
                child: const Icon(
                    Icons.add_shopping_cart_outlined,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ))
      ],
    );
  }
}
