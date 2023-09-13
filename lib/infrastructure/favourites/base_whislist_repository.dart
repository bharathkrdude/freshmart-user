

import 'package:fresh_mart/domain/models/whislist_model.dart';

abstract class BaseWhislistRepository {
  Stream<List<WishlistModel>>  getProducts();
  Future<void> updateWishlistProducts(String wishlistId,WishlistModel newWishlist);
}