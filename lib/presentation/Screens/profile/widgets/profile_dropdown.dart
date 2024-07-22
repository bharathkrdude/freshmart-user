import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fresh_mart/core/colors.dart';

class CustomProfileDropDown extends StatelessWidget {
  CustomProfileDropDown({
    Key? key,
    required this.genderController,
  }) : super(key: key);

  final TextEditingController genderController;

  List<String> genderList = [
    'Select One',
    'Male',
    'Female',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    // Explicitly set the initial value of genderController.text
    genderController.text = genderList.first;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 7,
      ),
      child: DropdownButtonFormField(
        value: genderController.text,
        iconSize: 28,
        icon: const Icon(Icons.arrow_drop_down_circle_outlined),
        iconEnabledColor: Colors.black,
        dropdownColor: backgroundColorgrey,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(5),
          fillColor: backgroundColorgrey,
          hintText: 'Choose Gender',
          labelText: 'Choose Gender',
          filled: true,
          floatingLabelStyle: TextStyle(
            color: Colors.black,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.category_outlined),
          prefixIconColor: Colors.black54,
        ),
        items: genderList.map((gender) {
          return DropdownMenuItem(
            value: gender,
            child: Text(gender),
          );
        }).toList(),
        onChanged: (value) {
          genderController.text = value as String;
          log(value.toString());
        },
      ),
    );
  }
}