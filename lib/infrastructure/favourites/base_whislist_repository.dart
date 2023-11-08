import 'package:fresh_mart/domain/models/whislist_model.dart';

abstract class BaseWishlistRepository {
  Future<WishlistModel>  getProducts(String email);
  Future<void> updateWishlistProducts(String email,String wishlistId,WishlistModel newWishlist);
  
}