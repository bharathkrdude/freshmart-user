import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_mart/application/cart/cart_bloc.dart';
import 'package:fresh_mart/core/colors.dart';
import 'package:fresh_mart/presentation/Screens/cartScreen/widgets/cart_bill_widget.dart';
import 'package:lottie/lottie.dart';
import 'widgets/cart_item_widget.dart';

class ScreenCart extends StatelessWidget {
  const ScreenCart({super.key,  });

  @override
  Widget build(BuildContext context) {
        final String? userEmail = FirebaseAuth.instance.currentUser!.email;

    return Scaffold(
      backgroundColor: backgroundColorgrey,
      appBar: AppBar(
        elevation: 1,
        toolbarHeight: 100,
        backgroundColor: backgroundColorWhite,
        iconTheme: const IconThemeData(color: textColor),
        centerTitle: true,
        title: const Text(
          'Cart',
          style: TextStyle(color: textColor),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                if (state is CartLoading) {
                  return const CircularProgressIndicator();
                } else if (state is CartLoaded 
                
                
          ) {
                  return ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: state.cart.productsMap.length,
                    itemBuilder: (context, index) {
                      final product = state.cart.productsMap.keys.elementAt(index);
                      final quantity = state.cart.productsMap.values.elementAt(index);

                      return Column(
                        children: [
                          Dismissible(
                            key: UniqueKey(),
                            onDismissed: (direction) {
                              // Remove the item from the cart here
                              BlocProvider.of<CartBloc>(context).add(CartProductDeleted(userEmail!, product));
                            },
                            background: Container(
                              
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                            child: CartItemWidget(
                              product: product,
                              quantity: quantity,
                            ),
                          ),
                          const Divider(),
                        ],
                      );
                    },
                  );
                }
                 else {
                  return const Text("Something went wrong");
                }
              },
            ),
          ),
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartLoaded && state.cart.productsMap.isNotEmpty) {
                return CartBillWidget(
                  subTotal: state.cart.subTotal,
                  deliveryFee: state.cart.deliveryFee,
                  totalAmount: state.cart.grandTotal,
                );
              } else {
                return  
                     Expanded(
                       child: Lottie.asset('assets/lottie/cartAnimation.json', width: double.infinity,
                       height: double.infinity,
                       fit: BoxFit.fill,),
                     );
                }
              
            },
          ),
        ],
      ),
    );
  }
}






