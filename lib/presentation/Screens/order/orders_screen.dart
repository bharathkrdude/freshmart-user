import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_mart/core/colors.dart';
import 'package:fresh_mart/domain/models/order_model.dart';
import 'package:fresh_mart/presentation/Screens/order/widgets/order_card.dart';

import 'package:intl/intl.dart';

import '../../../application/orders/orders_bloc.dart';


class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  static const String routeName = '/orders';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const OrdersScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        
      ),
      child: Scaffold(
        appBar: AppBar(
        elevation: 1,
        toolbarHeight: 80,
        backgroundColor: backgroundColorWhite,
        iconTheme: const IconThemeData(color: textColor),
        centerTitle: true,
        title: const Text(
          'Orders',
          style: TextStyle(color: textColor),
        ),
      ),
        body: BlocBuilder<OrdersBloc, OrdersState>(
          builder: (context, state) {
            if (state is OrdersLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  backgroundColor: Colors.white,
                  color: Colors.black,
                ),
              );
            }
            if (state is OrdersLoaded) {
              log('<<<<<<<<<<orders screen>>>>>>>>>>');
              List<OrderModel> totalOrders = state.orders;
              totalOrders.sort((a, b) {
                final DateFormat format = DateFormat('MMM d, yyyy');
                final DateTime dateA = format.parse(a.placedAt);
                final DateTime dateB = format.parse(b.placedAt);
                return dateB.compareTo(dateA);
              });
              log(state.orders.toString());
              log(totalOrders.length.toString());
              log(totalOrders.toString());
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: [
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: totalOrders.length,
                        itemBuilder: (context, index) {
                          OrderModel order = totalOrders[index];
                          return OrderProductCardWidget(
                            order: order,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
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
