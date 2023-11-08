
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fresh_mart/domain/models/cart_model.dart';
import 'package:fresh_mart/infrastructure/cart/base_cart_repository.dart';

class CartRepository extends BaseCartRepository {
  final FirebaseFirestore _firebaseFirestore;

  CartRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<CartModel?> getCartProducts(String email) async* {
    //_firebaseFirestore.collection('users').doc(email).collection('cart').doc().get();
    Stream<List<CartModel?>> cartList =
        _firebaseFirestore.collection('users').doc(email).collection('cart').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return CartModel.fromSnapshot(doc);
      }).toList();
    });
    List<CartModel?> cartListData = await cartList.first;
    if (cartListData.isEmpty) {
      yield null;
    } else {
      yield* cartList.map((list) {
        return list.firstWhere(
          (cartModel) => cartModel!.userEmail == email,
        );
      });
    }
  }

  @override
  Future<void> updateCartProducts(String email,String cartId, CartModel cart) async {
    try {
      await _firebaseFirestore.collection('users').doc(email).collection('cart').doc(cartId).set(
            cart.toMap(),
            SetOptions(merge: true),
          );
      log('cart updated successfully.');
    } catch (error) {
      log('Error updating cart: $error');
    }
  }

  @override
  Future<void> deleteCartProducts(String email,String cartId, CartModel cart) async {
    try {
      await _firebaseFirestore.collection('users').doc(email).collection('cart').doc(cartId).set(
            cart.toMap(),
            SetOptions(merge: false),
          );
      log('cart updated successfully.');
    } catch (error) {
      log('Error updating cart: $error');
    }
  }
}













// import 'dart:developer';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fresh_mart/domain/models/cart_model.dart';
// import 'package:fresh_mart/infrastructure/cart/base_cart_repository.dart';

// class CartRepository extends BaseCartRepository {
//   final FirebaseFirestore _firebaseFirestore;

//   CartRepository({FirebaseFirestore? firebaseFirestore})
//       : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

//   @override
//   Stream<CartModel?> getCartProducts(String email) async* {
//     Stream<List<CartModel?>> cartList =
//         _firebaseFirestore.collection('carts').snapshots().map((snapshot) {
//       return snapshot.docs.map((doc) {
//         return CartModel.fromSnapshot(doc);
//       }).toList();
//     });
//     List<CartModel?> cartListData = await cartList.first;
//     if (cartListData.isEmpty) {
//       yield null;
//     } else {
//       yield* cartList.map((list) {
//         return list.firstWhere(
//           (cartModel) => cartModel!.userEmail == email,
//         );
//       });
//     }
//   }

//   @override
//   Future<void> updateCartProducts(String cartId, CartModel cart) async {
//     try {
//       await _firebaseFirestore.collection('carts').doc(cartId).set(
//             cart.toMap(),
//             SetOptions(merge: true),
//           );
//       log('cart updated successfully.');
//     } catch (error) {
//       log('Error updating cart: $error');
//     }
//   }

//   @override
//   Future<void> deleteCartProducts(String cartId, CartModel cart) async {
//     try {
//       await _firebaseFirestore.collection('carts').doc(cartId).set(
//             cart.toMap(),
//             SetOptions(merge: false),
//           );
//       log('cart updated successfully.');
//     } catch (error) {
//       log('Error updating cart: $error');
//     }
//   }
// }