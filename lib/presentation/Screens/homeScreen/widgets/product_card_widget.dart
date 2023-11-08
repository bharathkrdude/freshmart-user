import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_mart/application/wishlist/whishlist_bloc.dart';
import 'package:fresh_mart/core/colors.dart';
import 'package:fresh_mart/domain/models/product_model.dart';
import 'package:fresh_mart/presentation/Screens/auth/widgets/snackbar.dart';
 
class ProductCardWidget extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onTapCallback;

  const ProductCardWidget({
    Key? key,
    required this.product,
    required this.onTapCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
    Size size = MediaQuery.of(context).size;
    final wishlistBloc = BlocProvider.of<WishlistBloc>(context);

    return InkWell(
      onTap: () => onTapCallback(),
      child: Stack(
        children: [
          Card(
            color: backgroundColorWhite,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Image.network(
                    product.imageUrls[0],
                    width: size.width / 4,
                    height: size.width / 4,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Text(
                    "₹${product.price.toString()}/${product.unit}",
                    style: const TextStyle(
                      color: hintTextColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: WishlistLikeButton(product: product, wishlistBloc: wishlistBloc,),
          ),
        ],
      ),
    );
  }
}

class WishlistLikeButton extends StatelessWidget {
  final ProductModel product;
  final WishlistBloc wishlistBloc;
   
  const WishlistLikeButton({
    Key? key,
    required this.product,
    required this.wishlistBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String? userEmail = FirebaseAuth.instance.currentUser!.email;
    return BlocBuilder<WishlistBloc, WishlistState>(
      bloc: wishlistBloc,
      builder: (context, state) {
        final isProductInWishlist = state is WishlistLoaded &&
            state.wishlist.productList.contains(product.id);

        return IconButton(
          onPressed: () {
            
            if (isProductInWishlist) {
              wishlistBloc.add(
                RemoveFromWishlist(email: userEmail!, productId: product.id),
               
              );alertSnackbar(context, "item removed from fav");

            } else {
              wishlistBloc.add(
               AddToWishlist(email: userEmail!, productId: product.id)
              );
              alertSnackbar(context, "Item added to wishlist");
            }
          },
          icon: isProductInWishlist ?
           const Icon(
            Icons.favorite,
            color:  Colors.red ,
          ):const Icon(
            Icons.favorite_border_outlined,
            color:textColor,
          ) 
        );
      },
    );
  }
}

// class ProductCardWidget extends StatelessWidget {
//   final ProductModel product;
//   final VoidCallback onTapCallback;

//   const ProductCardWidget({
//     Key? key,
//     required this.product,
//     required this.onTapCallback,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return InkWell(
//       onTap: () => onTapCallback(),
//       child: Stack(
//         children: [
//           Card(
//             color: backgroundColorWhite,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(5.0),
//             ),
//             elevation: 2,
//             child: Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   kHeight,
//                   Image.network(
//                     product.imageUrls[0],
//                     width: size.width / 4,
//                     height: size.width / 4,
//                   ),
//                   kHeight,
//                   Container(
//                     alignment: Alignment.center,
//                     child: Text(
//                       product.name,
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                   Text(
//                     "₹${product.price.toString()}/${product.unit}",
//                     style: const TextStyle(
//                       color: hintTextColor,
//                       fontSize: 14,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           BlocBuilder<WishlistBloc, WishlistState>(
//             builder: (context, state) {
//               final isProductInWishlist = state is WishlistLoaded &&
//                   state.wishlist.productList.contains(product.id);

//               return Positioned(
//                 top: 10, // Adjust the position as needed
//                 right: 10, // Adjust the position as needed
//                 child: IconButton(
//                   onPressed: () {
//                     if (isProductInWishlist) {
//                       BlocProvider.of<WishlistBloc>(context).add(
//                         RemoveWishlist(
//                           wishlistId: (state).wishlist.id,
//                           productId: product.id,
//                         ),
//                       );
//                     } else {
//                       BlocProvider.of<WishlistBloc>(context).add(
//                         AddToWishlist(
//                           wishlistId: (state as WishlistLoaded).wishlist.id,
//                           productId: product.id,
//                         ),
//                       );
//                     }
//                   },
//                   icon: Icon(
//                     Icons.favorite,
//                     color: isProductInWishlist ? Colors.red : hintTextColor,
//                   ),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }