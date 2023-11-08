import 'package:flutter/material.dart';
import 'package:fresh_mart/core/colors.dart';
import 'package:fresh_mart/presentation/Screens/order/orders_screen.dart';

import '../adress/add_adress.dart';

class OrderConfirmation extends StatelessWidget {
  static const String routeName = '/order-confirmation';

  const OrderConfirmation({super.key});

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const OrderConfirmation(),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        color: backgroundColorgrey
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.asset(
              //   'assets/images/order_confirm.png',
              //   width: size.width * 0.9,
              //   height: size.height * 0.4,
              //   fit: BoxFit.cover,
              // ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Text(
                'Successfully!',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                'Your order has been placed.',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Row(
                children: [
                  MainButtonWidget(
                    buttonText: 'View Orders',
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const OrdersScreen()));
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  MainButtonWidget(
                    buttonText: 'Back To Home',
                    isSubButton: true,
                    onPressed: () {
                      Navigator.pushNamed(context, '/');
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
