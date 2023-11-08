import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_mart/core/colors.dart';
import 'package:fresh_mart/presentation/Screens/adress/add_adress.dart';

import '../../../application/address/address_bloc.dart';
import '../../../domain/models/adress_model.dart';


class EditAddressScreen extends StatelessWidget {
  final AddressModel address;
  EditAddressScreen({
    super.key,
    required this.address,
  });

  static const String routeName = '/edit_address';

  static Route route({required AddressModel address}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => EditAddressScreen(
        address: address,
      ),
    );
  }

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final houseController = TextEditingController();
  final streetController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final pinController = TextEditingController();
  String? addressType;

  @override
  Widget build(BuildContext context) {
    nameController.text = address.name;
    phoneController.text = address.phone;
    houseController.text = address.house;
    streetController.text = address.street;
    cityController.text = address.city;
    stateController.text = address.state;
    pinController.text = address.pincode;
    addressType = address.type;
    return Container(
      decoration: const BoxDecoration(
        color: backgroundColorWhite
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
        elevation: 1,
        toolbarHeight: 100,
        backgroundColor: backgroundColorWhite,
        iconTheme: const IconThemeData(color: textColor),
        centerTitle: true,
        title: const Text(
          'Edit Adress',
          style: TextStyle(color: textColor),
        ),
      ),
        body: ListView(
          padding: EdgeInsets.all(10),
          children: [
            Form(
              key: formKey,
              child: BlocListener<AddressBloc, AddressState>(
                listener: (context, state) {
                  if (state is AddressLoadedSuccess) {
                    addressType = state.addressType;
                  }
                },
                child: AddressDetailsWidget(
                  nameController: nameController,
                  phoneController: phoneController,
                  houseController: houseController,
                  streetController: streetController,
                  cityController: cityController,
                  stateController: stateController,
                  pinController: pinController,
                  addressType: addressType!,
                  editPage: true,
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: MainButtonWidget(
            buttonText: 'SAVE ADDRESS',
            onPressed: () {
              final isValid = formKey.currentState!.validate();
              if (isValid) {
                log('navigate to previous');
                final AddressModel updatedAddress = AddressModel(
                  id: address.id,
                  name: nameController.text.trim(),
                  phone: phoneController.text.trim(),
                  house: houseController.text.trim(),
                  street: streetController.text.trim(),
                  city: cityController.text.trim(),
                  state: stateController.text.trim(),
                  pincode: pinController.text.trim(),
                  type: addressType!,
                );
                BlocProvider.of<AddressBloc>(context)
                    .add(AddressEdited(updatedAddress));
                Navigator.pop(context);
              } else {
                log('not valid');
                log(addressType.toString());
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    behavior: SnackBarBehavior.floating,
                    margin: const EdgeInsets.all(5),
                    backgroundColor: const Color(0xff4CAF50),
                    content: Text(
                      'All the fields are required.',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    duration: const Duration(seconds: 1),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}