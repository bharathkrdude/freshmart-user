

import 'package:fresh_mart/domain/models/cart_model.dart';

abstract class BaseCartRepository {
  //Stream<List<ProductModel>> getCartProducts();
  Stream<CartModel?> getCartProducts(String email);
  Future<void> updateCartProducts(String email,String cartId,CartModel cart);
  Future<void> deleteCartProducts(String email,String cartId, CartModel cart);
}