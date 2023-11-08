
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_mart/Presentation/screens/Auth/widgets/snackbar.dart';
import 'package:fresh_mart/application/cart/cart_bloc.dart';
import 'package:fresh_mart/application/wishlist/whishlist_bloc.dart';
import 'package:fresh_mart/core/colors.dart';
import 'package:fresh_mart/core/constants.dart';
import 'package:fresh_mart/domain/models/product_model.dart';
import 'package:fresh_mart/presentation/Screens/homeScreen/widgets/product_card_widget.dart';
import 'package:fresh_mart/presentation/widgets/primary_button_widget.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductModel product;
  const ProductDetailsScreen({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
        final String? userEmail = FirebaseAuth.instance.currentUser!.email;

    final wishlistBloc = BlocProvider.of<WishlistBloc>(context);
    
    return Scaffold(
      backgroundColor: backgroundColorWhite,
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
                color: backgroundColorgrey,
                ),
            child: Column(children: [
              kHeight36,
              
             kHeight24,
              Container(
                height: MediaQuery.of(context).size.height/2.5,
                width: MediaQuery.of(context).size.width,
                color: backgroundColorgrey,
                child: Image.network(
                  product.imageUrls[0],
                  fit: BoxFit.contain,
                ),
              ),
              kHeight45
            ]),
          ),
         kHeight16,
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        product.name,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                      
                    ),
                    WishlistLikeButton(product: product, wishlistBloc: wishlistBloc)
                    
                   
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Text("₹${product.price} ",
                    style: const TextStyle(
                        color: primaryDark,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                kHeight,
                 Text(
                  product.unit,
                  style: const TextStyle(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                        kHeight,
                
                Text(
                  product.description,
                  style: const TextStyle(
                      color:hintTextColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
               
                
              ],
            ),
          )
        ],
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PrimaryButtonWidget(title: 'Add to cart', onPressed: (){BlocProvider.of<CartBloc>(context).add(CartProductAdded(userEmail!, product)); alertSnackbar(context, "item added to cart");}),
      ),
    );
  }
}