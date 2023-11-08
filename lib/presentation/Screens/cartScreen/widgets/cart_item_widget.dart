import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_mart/application/cart/cart_bloc.dart';
import 'package:fresh_mart/core/colors.dart';
import 'package:fresh_mart/core/constants.dart';
import 'package:fresh_mart/domain/models/product_model.dart';

class CartItemWidget extends StatelessWidget {
  final ProductModel product;
  final int quantity;
  const CartItemWidget({Key? key, required this.product,required this.quantity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
            final String? userEmail = FirebaseAuth.instance.currentUser!.email;

    return Container(
      color: backgroundColorWhite,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Image.network(
              product.imageUrls[0],
            width: 60,
            height: 60,
          )),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "₹ ${product.price.toString()}",
                  
                  style: const TextStyle(
                      color:  primaryDark,
                      fontSize: 12,
                      ),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(product.name,
                    style: const TextStyle(
                        color: textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                        const SizedBox(
                  height: 2,
                ),
                        Text(product.unit,
                    style: const TextStyle(
                        color: hintTextColor,
                        fontSize: 12,
                       )),
                        
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: (() {
                     BlocProvider.of<CartBloc>(context)
                                    .add(CartProductAdded(userEmail!, product));
                  }),
                  child: const Icon(Icons.add,color: primary,),
                ),
                kWidth,
                Text(
                  quantity.toString(),
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                kWidth,
                InkWell(
                  onTap: (quantity >1)?(){
                     BlocProvider.of<CartBloc>(context)
                                    .add(CartProductRemoved(userEmail!, product));
                  }:() =>ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    margin: const EdgeInsets.all(5),
                                    backgroundColor: const Color(0xff4CAF50),
                                    content: Text(
                                      'Minimum quantity of 1 is allowed.',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                              fontWeight: FontWeight.w600),
                                    ),
                                    duration: const Duration(seconds: 2),
                                  ),
                                ) ,
                  child: Icon(Icons.remove,color:(quantity >1)? primary:primary.withOpacity(0.4),)
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
