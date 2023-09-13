import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_mart/Presentation/widgets/primary_button_widget.dart';
import 'package:fresh_mart/application/cart/cart_bloc.dart';


import 'widgets/cart_item_widget.dart';

class ScreenCart extends StatelessWidget {
  const ScreenCart({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Cart",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Image.asset(
            "assets/images/back_icon.png",
            scale: 2.2,
          ),
        ),
      ),
      body: Stack(
        children: [
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartLoading) {
                return CircularProgressIndicator();
              } else if (state is CartLoaded) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                    itemCount: state.cart.productsMap.length,
                    itemBuilder: (context, index) {
                      return CartItemWidget(
                          product: state.cart.productsMap.keys.elementAt(index),
                          quantity:
                              state.cart.productsMap.values.elementAt(index));
                    },
                  ),
                );
              } else {
                return Text("something went wrong");
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              FractionallySizedBox(
                widthFactor: 1,
                child: PrimaryButtonWidget(title: "checkout", onPressed: (){})
              )
            ]),
          )
        ],
      ),
    );
  }
}
