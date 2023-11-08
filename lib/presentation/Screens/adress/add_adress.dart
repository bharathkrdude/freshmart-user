


import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_mart/application/address/address_bloc.dart';
import 'package:fresh_mart/core/colors.dart';
import 'package:fresh_mart/domain/models/adress_model.dart';
import 'package:fresh_mart/presentation/Screens/adress/widgets/custom_textfield.dart';


class AddAddressScreen extends StatelessWidget {
  AddAddressScreen({super.key});

  static const String routeName = '/add_address';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => AddAddressScreen(),
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

  @override
  Widget build(BuildContext context) {
    String addressType = BlocProvider.of<AddressBloc>(context).addressType;
    return Container(
      decoration: const BoxDecoration(
        color: backgroundColorgrey
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
          'Add adress',
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
                    addressType: addressType),
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
                final AddressModel newAddress = AddressModel(
                  name: nameController.text.trim(),
                  phone: phoneController.text.trim(),
                  house: houseController.text.trim(),
                  street: streetController.text.trim(),
                  city: cityController.text.trim(),
                  state: stateController.text.trim(),
                  pincode: pinController.text.trim(),
                  type: addressType,
                );
                BlocProvider.of<AddressBloc>(context)
                    .add(AddressAdded(newAddress));
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




class MainButtonWidget extends StatelessWidget {
  final String buttonText;
  final bool isSubButton;
  final double heightFactor;
  final VoidCallback onPressed;
  const MainButtonWidget({
    super.key,
    required this.buttonText,
    this.isSubButton = false,
    this.heightFactor = 0.07,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    
    // Define the gradient colors
    List<Color> gradientColors = [Color(0xFFAEDC81), Color(0xFF6CC51D)];

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GestureDetector(
          onTap: onPressed,
          child: Container(
            height: size.height * heightFactor,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              gradient: LinearGradient(
                colors: isSubButton ? gradientColors : gradientColors, // Use the same gradient for both cases
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Center(
              child: Text(
                buttonText,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: isSubButton ? Colors.black : Colors.white, // Text color based on the button type
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}






class AddressDetailsWidget extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController houseController;
  final TextEditingController streetController;
  final TextEditingController cityController;
  final TextEditingController stateController;
  final TextEditingController pinController;
  final bool editPage;
  String addressType;
  AddressDetailsWidget({
    super.key,
    required this.nameController,
    required this.phoneController,
    required this.houseController,
    required this.streetController,
    required this.cityController,
    required this.stateController,
    required this.pinController,
    required this.addressType,
    this.editPage=false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomTextFormField(
          controller: nameController,
          labelText: (editPage) ? nameController.text : 'Full Name',
          iconData: Icons.person,
          validator: (name) => name != '' ? null : 'Name is required!!',
        ),
        CustomTextFormField(
          controller: phoneController,
          labelText: (editPage) ? phoneController.text : 'Phone Number',
          iconData: Icons.phone_android,
          keyboardType: TextInputType.number,
          validator: (phone) => (phone != null &&
                  phone.length != 10 &&
                  !RegExp(r'^[0-9]{10}$').hasMatch(phone))
              ? 'Phone number should be 10 digits'
              : null,
        ),
        CustomTextFormField(
          controller: houseController,
          labelText: (editPage) ? houseController.text : 'House / Building Name',
          iconData: Icons.home,
          validator: (house) => house != '' ? null : 'House Name is required!!',
        ),
        CustomTextFormField(
          controller: streetController,
          labelText: (editPage) ? streetController.text : 'Street Name',
          iconData: Icons.location_pin,
          validator: (street) =>
              street != '' ? null : 'Street Name is required!!',
        ),
        CustomTextFormField(
          controller: cityController,
          labelText: (editPage) ? cityController.text : 'City Name',
          iconData: Icons.location_city,
          validator: (city) => city != '' ? null : 'City Name is required!!',
        ),
        Row(
          children: [
            Expanded(
              child: CustomTextFormField(
                controller: stateController,
                labelText: (editPage) ? stateController.text : 'State Name',
                iconData: Icons.flag,
                validator: (state) =>
                    state != '' ? null : 'State name is required!!',
              ),
            ),
            CustomTextFormField(
              controller: pinController,
              labelText: (editPage) ? pinController.text : 'Pin Code',
              iconData: Icons.pin,
              keyboardType: TextInputType.number,
              widthFactor: 0.37,
              validator: (pin) => (pin != null &&
                      pin.length != 6 &&
                      !RegExp(r'^[0-9]{10}$').hasMatch(pin))
                  ? 'Pin must be 6 digits'
                  : null,
            ),
          ],
        ),
        BlocBuilder<AddressBloc, AddressState>(
          builder: (context, state) {
            if (state is AddressLoadedSuccess) {
              log('<<<<<<<<<<<details pa>>>>>>>>>>>');
              log(addressType);
              addressType = state.addressType;
              log('<<<<<<<after>>>>>>>');
              log(addressType);
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    AddressRadioButtonWidget(
                      addressType: addressType,
                      buttonValue: 'Home',
                    ),
                    AddressRadioButtonWidget(
                      addressType: addressType,
                      buttonValue: 'Work',
                    ),
                    AddressRadioButtonWidget(
                      addressType: addressType,
                      buttonValue: 'Other',
                    ),
                  ],
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
      ],
    );
  }
}


class AddressRadioButtonWidget extends StatelessWidget {
  const AddressRadioButtonWidget({
    super.key,
    required this.addressType,
    required this.buttonValue,
  });

  final String addressType;
  final String buttonValue;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        radioTheme: RadioThemeData(
          fillColor: MaterialStateColor.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return const Color(0xff388E3C);
            }
            return Colors.black54;
          }),
        ),
      ),
      child: RadioMenuButton(
        value: buttonValue,
        groupValue: addressType,
        onChanged: (value) {
          BlocProvider.of<AddressBloc>(context)
              .add(AddressTypeButtonClicked(value!));
          log('<<<<<<<<<<<<after event call>>>>>>>>>>>>');
          log(value);
          log(addressType);
        },
        child: Text(
          buttonValue,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
