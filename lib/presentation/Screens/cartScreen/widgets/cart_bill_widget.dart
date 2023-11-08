

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_mart/application/checkout/checkout_bloc.dart';
import 'package:fresh_mart/core/colors.dart';
import 'package:fresh_mart/core/constants.dart';
import 'package:fresh_mart/domain/models/adress_model.dart';
import 'package:fresh_mart/presentation/Screens/checkout/checkout_screen.dart';
import 'package:fresh_mart/presentation/widgets/primary_button_widget.dart';

class CartBillWidget extends StatelessWidget {
  final double subTotal;
  final double deliveryFee;
  final double totalAmount;
  
  const 
  
  CartBillWidget({
    required this.subTotal,
    required this.deliveryFee,
    required this.totalAmount,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: MediaQuery.of(context).size.height / 5,
        width: MediaQuery.of(context).size.width,
        color: backgroundColorWhite,
        child: Column(
          
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  
                  Text("Subtotal",style:kCartText1 ,),
                  Text('₹ $subTotal',style: kCartText1,),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  
                  Text("Shipping charges",style:kCartText1 ,),
                  Text('₹ $deliveryFee',style: kCartText1,),
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total",style: kCartText2,),
                  Text( '₹ $totalAmount',style: kCartText2,),
                ],
              ),
              kHeight,
              PrimaryButtonWidget(title: "checkout", onPressed: () {
              
                 Navigator.push(context, MaterialPageRoute(builder:(context) => const CheckoutScreen() ));}),
            ]),
      ),
    );
  }
}
