import '../models/item_model.dart';

ItemModel gourmetCake = new ItemModel(
    itemName: "Bolo Gourmet",
    imgUrl: 'assets/cakes/BoloGourmet1.jpeg',
    unit: "und",
    price: 27,
    description: "O melhor bolo gourmet da região");
ItemModel poolCake = new ItemModel(
    itemName: "Bolo Piscininha",
    imgUrl: 'assets/cakes/BoloPiscininha.jpg',
    unit: "und",
    price: 20,
    description: "O melhor bolo gourmet da região");
ItemModel softCake = new ItemModel(
    itemName: "Bolo Mole",
    imgUrl: 'assets/cakes/BoloMole.jpg',
    unit: "und",
    price: 25,
    description: "O melhor bolo gourmet da região");

List<ItemModel> items = [gourmetCake, poolCake, softCake];

List<String> categories = ['Bolos', 'Salgados', 'Kit Festa', 'Doces'];
