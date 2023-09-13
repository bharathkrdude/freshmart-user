

import 'package:fresh_mart/domain/models/cart_model.dart';

abstract class BaseCartRepository {
  Stream<CartModel?> getCartProducts(String email);
  Future<void> updateCartProducts(String cartId,CartModel cart);
  Future<void> deleteCartProducts(String cartId, CartModel cart);
}