import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_mart/application/checkout/checkout_bloc.dart';
import 'package:fresh_mart/core/colors.dart';
import 'package:fresh_mart/presentation/Screens/adress/address_screen.dart';
import 'package:fresh_mart/presentation/Screens/checkout/widgets/checkout_payment.dart';
import 'package:fresh_mart/presentation/Screens/checkout/widgets/new_address_card.dart';
import 'package:fresh_mart/presentation/Screens/order/order_confirm.dart';


import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:status_alert/status_alert.dart';

import '../../../application/payment/payment_bloc.dart';
import '../adress/add_adress.dart';
import 'widgets/checkout_address.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  static const String routeName = '/checkout';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const CheckoutScreen(),
    );
  }

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _razorpay = Razorpay();
  final currentUser = FirebaseAuth.instance.currentUser!.email;

  @override
  void initState() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    
    super.initState();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    // Do something when payment succeeds
    BlocProvider.of<CheckoutBloc>(context)
        .add(CheckoutConfirmed(email: currentUser!));
    StatusAlert.show(
      context,
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.white,
      title: 'Order Placed',
      subtitle: 'Your order has been successfully placed!',
      configuration: const IconConfiguration(
        icon: Icons.done,
        color: Colors.green,
      ),
      maxWidth: 260,
    );
    await Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushNamed(context, '/order-confirmation');
    });
    log('Payment successful');
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    StatusAlert.show(
      context,
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.white,
      title: 'Oops!',
      subtitle: 'Something  went wrong, try again!',
      configuration: const IconConfiguration(
        icon: Icons.clear,
        color: Colors.red,
      ),
      maxWidth: 260,
    );
    log('Payment failure');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
    log('Payment from external wallet');
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    return Container(
      decoration: const BoxDecoration(
        color: backgroundColorgrey
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
        elevation: 0,
        toolbarHeight: 100,
        backgroundColor: backgroundColorWhite,
        iconTheme: const IconThemeData(color: textColor),
        centerTitle: true,
        title: const Text(
          'Checkout',
          style: TextStyle(color: textColor),
        ),
      ),
        body: BlocBuilder<CheckoutBloc, CheckoutState>(
          builder: (context, state) {
            if (state is CheckoutLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  backgroundColor: Colors.white,
                  color: Colors.black,
                ),
              );
            }
            if (state is CheckoutLoaded) {
              log('<<<<<<<<<<<checxkout screen>>>>>>>>>>>');
              log(state.cart.grandTotal.toString());
              log(state.address.toString());
              //log(state.address!.name);
              log(state.paymentMethod.toString());
              log('<<<<<<<<<<//////////>>>>>>>>>>');
              return ListView(
                children: [
                  (state.address == null)

                      ? 
                      const Center(
                        child: SectionTitleWidget(
                            title: 'Delivery Address',
                          ),
                      )
                      : Center(
                        child: SectionTitleWidget(
                            title: 'Delivery Address',
                            button: true,
                            buttonText: 'Change',
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const AddressScreen()));
                            },
                          ),
                      ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  (state.address == null)
                      ? const NewAddressCard()
                      : CheckoutAddressCard(
                          address: state.address!,
                        ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  const CheckoutPaymentWidget(),
                ],
              );
            } else {
              return const Icon(
                Icons.error,
                color: Colors.red,
              );
            }
          },
        ),
        bottomNavigationBar: BlocBuilder<CheckoutBloc, CheckoutState>(
          builder: (context, state) {
            if (state is CheckoutLoaded) {
              if (state.paymentMethod == PaymentMethod.cash_on_delivery) {
                return BottomAppBar(
                  child: MainButtonWidget(
                    buttonText: 'PAY WITH COD',
                    onPressed: () async {
                      BlocProvider.of<CheckoutBloc>(context)
                          .add(CheckoutConfirmed(
                        email: currentUser!,
                      ));
                      StatusAlert.show(
                        context,
                        duration: const Duration(seconds: 2),
                        backgroundColor: Colors.white,
                        title: 'Order Placed',
                        subtitle: 'Your order has been successfully placed!',
                        configuration: const IconConfiguration(
                          icon: Icons.done,
                          color: primary,
                        ),
                        maxWidth: 260,
                      );
                      await Future.delayed(const Duration(seconds: 2), () {
                       Navigator.of(context).push(MaterialPageRoute(builder:(context) =>const OrderConfirmation()));
                      });
                    },
                  ),
                );
              } else if (state.paymentMethod == PaymentMethod.razor_pay) {
                return BottomAppBar(
                  child: MainButtonWidget(
                    buttonText: 'PAY WITH RAZOR PAY',
                    onPressed: () {
                      var options = {
                        'key': "rzp_test_AUj1P3eYGR7a70",
                        //amount must be multiple of 100
                        'amount': state.cart.grandTotal * 100,
                        'name': 'FreshMart',
                        'description': 'Sample Payment',
                        'timeout': 300, // in seconds
                        'prefill': {
                          'contact': '9746411339',
                          'email': 'fresh@razorpay.com'
                        }
                      };
                      _razorpay.open(options);
                      
                      // BlocProvider.of<CheckoutBloc>(context)
                      //     .add(CheckoutConfirmed(
                      //   email: currentUser!,
                      //));
                    },
                  ),
                );
              } else {
                return BottomAppBar(
                  child: MainButtonWidget(
                    buttonText: 'CHOOSE PAYMENT',
                    onPressed: () {},
                  ),
                );
              }
            } else {
              return const Icon(
                Icons.error,
                color: Colors.red,
              );
            }
          },
        ),
      ),
    );
  }
}



class SectionTitleWidget extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final bool button;
  final String buttonText;
  final double size;
  const SectionTitleWidget({
    super.key,
    required this.title,
    this.onPressed,
    this.button = false,
    this.buttonText = 'Clear All',
    this.size = 10.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          (button)
              ? ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 173, 172, 164).withAlpha(100)),
                    overlayColor: MaterialStateProperty.all<Color>(
                        Colors.white60.withOpacity(0.1)),
                  ),
                  onPressed: onPressed,
                  child: Row(
                    children: [
                      Text(
                        buttonText,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                )
              : const SizedBox(
                  width: 10,
                ),
        ],
      ),
    );
  }
}
