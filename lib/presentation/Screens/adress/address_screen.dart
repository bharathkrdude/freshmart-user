

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_mart/application/address/address_bloc.dart';
import 'package:fresh_mart/core/colors.dart';
import 'package:fresh_mart/presentation/Screens/adress/add_adress.dart';
import 'package:fresh_mart/presentation/Screens/adress/widgets/address_card.dart';

import '../checkout/checkout_screen.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});
 static const String routeName = '/address';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const AddressScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 100,
        backgroundColor: backgroundColorWhite,
        iconTheme: const IconThemeData(color: textColor),
        actions: [
          IconButton(
              onPressed: () {
                 Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AddAddressScreen()));
              },
              icon: const Icon(
                Icons.add_circle_outline,
                color: Colors.black,
                size: 28,
              ),
            ),
        ],
        centerTitle: true,
        title: const Text(
          'Adresss',
          style: TextStyle(color: textColor),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
            children: [
              // const CheckoutNavCardWidget(),
              // SizedBox(
              //   height: height * 0.01,
              // ),
              const SectionTitleWidget(title: 'Saved Addresses'),
              BlocBuilder<AddressBloc, AddressState>(
                builder: (context, state) {
                  if (state is AddressLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        backgroundColor: Colors.white,
                        color: Colors.black,
                      ),
                    );
                  }
                  if (state is AddressLoadedSuccess) {
                    return state.addresses.isEmpty
                        ? const Center(
                            child: Text('Empty address list, add new address'),
                          )
                        : Column(
                            children: [
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: state.addresses.length,
                                itemBuilder: (context, index) {
                                  final address = state.addresses[index];
                                  return AddressCardWidget(
                                    index: index,
                                    selectedIndex: state.selectedIndex,
                                    address: address,
                                  );
                                },
                              )
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
            ],
          ),
        ),
    );
  }
}