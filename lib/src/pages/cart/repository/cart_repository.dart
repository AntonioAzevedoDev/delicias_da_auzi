import 'package:delicias_da_auzi/src/constants/endpoints.dart';
import 'package:delicias_da_auzi/src/models/cart_item_model.dart';
import 'package:delicias_da_auzi/src/models/order_model.dart';
import 'package:delicias_da_auzi/src/pages/cart/cart_result/cart_result.dart';
import 'package:delicias_da_auzi/src/services/http_manager.dart';

class CartRepository {
  final _httpManager = HttpManager();

  Future<CartResult<List<CartItemModel>>> getCartItems(
      {required String token, required String userId}) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.getCartItems,
      method: HttpMethods.post,
      headers: {'X-Parse-Session-Token': token},
      body: {
        'user': userId,
      },
    );
    if (result['result'] != null) {
      List<CartItemModel> data =
          List<Map<String, dynamic>>.from(result['result'])
              .map(CartItemModel.fromJson)
              .toList();
      return CartResult<List<CartItemModel>>.success(data);
    } else {
      //retornar uma mensagem
      return CartResult.error(
          'Ocorreu um erro ao recuperar os itens do carronho!');
    }
  }

  Future<bool> changeItemQuantity({
    required String cartItemId,
    required String token,
    required int quantity,
  }) async {
    final result = await _httpManager.restRequest(
        url: Endpoints.changeItemQuantity,
        method: HttpMethods.post,
        body: {'cartItemId': cartItemId, 'quantity': quantity},
        headers: {'X-Parse-Session-Token': token});

    return result.isEmpty;
  }

  Future<CartResult<OrderModel>> checkoutCart({
    required String token,
    required double total,
  }) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.checkout,
      method: HttpMethods.post,
      body: {
        'total':total,
      },
      headers: {
        'X-Parse-Session-Token':token
      }
    );
    if(result['result'] != null){
      final order = OrderModel.fromJson(result['result']);
      return CartResult<OrderModel>.success(order);
    }
    else{
      return CartResult.error('Que não foi possível realizar o pedido');
    }
  }

  Future<CartResult<String>> addItemToCart({
    required String userId,
    required String token,
    required String productId,
    required int quantity,
  }) async {
    final result = await _httpManager.restRequest(
        url: Endpoints.addItemToCart,
        method: HttpMethods.post,
        body: {
          'user': userId,
          'quantity': quantity,
          'productId': productId
        },
        headers: {
          'X-Parse-Session-Token': token,
        });
    if (result['result'] != null) {
      //Adicionamos o produto
      return CartResult.success(result['result']['id']);
    } else {
      //Erro
      return CartResult.error('Não foi possível adicionar o item no carrinho');
    }
  }
}
