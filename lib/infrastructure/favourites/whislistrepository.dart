import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fresh_mart/domain/models/whislist_model.dart';
import 'package:fresh_mart/infrastructure/favourites/base_whislist_repository.dart';

class WhislistRepository extends BaseWhislistRepository {
  final FirebaseFirestore _firebaseFirestore;

  WhislistRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance; //

  @override
  Stream<List<WishlistModel>> getProducts() {
    return _firebaseFirestore
        .collection('wishlist')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => WishlistModel.fromSnapshot(doc))
          .toList();
    });
  }

  @override
  Future<void> updateWishlistProducts(
      String wishlistId, WishlistModel newWishlist) async {
    try {
      await _firebaseFirestore
          .collection('wishlist')
          .doc(wishlistId)
          .set(newWishlist.toMap(), SetOptions(merge: true));
      log('wishlist updated successfully');
    } catch (e) {
      log('error updating wishlist: $e');
    }
  }
}
