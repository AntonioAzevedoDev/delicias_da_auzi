import 'package:delicias_da_auzi/src/models/user_model.dart';

import '../models/cart_item_model.dart';
import '../models/item_model.dart';
import '../models/order_model.dart';

ItemModel gourmetCake = new ItemModel(
    itemName: "Bolo Gourmet",
    imgUrl: 'assets/cakes/BoloGourmet1.jpeg',
    unit: "un",
    price: 27,
    description: "O melhor bolo gourmet da região");
ItemModel poolCake = new ItemModel(
    itemName: "Bolo Piscininha",
    imgUrl: 'assets/cakes/BoloPiscininha.jpg',
    unit: "un",
    price: 20,
    description: "O melhor bolo gourmet da região");
ItemModel softCake = new ItemModel(
    itemName: "Bolo Mole",
    imgUrl: 'assets/cakes/BoloMole.jpg',
    unit: "un",
    price: 25,
    description: "O melhor bolo gourmet da região");

List<ItemModel> items = [gourmetCake, poolCake, softCake];

List<String> categories = ['Bolos', 'Salgados', 'Kit Festa', 'Doces'];

List<CartItemModel> cartItems = [
  CartItemModel(item: gourmetCake, quantity: 2),
  CartItemModel(item: poolCake, quantity: 1),
  CartItemModel(item: softCake, quantity: 3),
];

UserModel user = UserModel(
    phone: '99 9 9999-9999',
    cpf: '999.999.999-99',
    email: 'lucas@email.com',
    name: 'lucas',
    password: '');

List<OrderModel> orders = [
  OrderModel(
      id: 'adsassda5454s',
      createdDateTime: DateTime.parse('2023-07-29 11:10:00.458'),
      overdueDateTime: DateTime.parse('2023-07-29 12:10:00.458'),
      items: [
        CartItemModel(item: poolCake, quantity: 2),
        CartItemModel(item: softCake, quantity: 1)
      ],
      status: 'pending_payment',
      copyAndPaste: 'asdadsad',
      total: 65
  ),
  OrderModel(
      id: 'adsassda15278s',
      createdDateTime: DateTime.parse('2023-07-29 15:10:00.458'),
      overdueDateTime: DateTime.parse('2023-07-29 16:10:00.458'),
      items: [
        CartItemModel(item: gourmetCake, quantity: 2),
      ],
      status: 'delivered',
      copyAndPaste: 'qweasdqwe',
      total: 54
  ),
];
