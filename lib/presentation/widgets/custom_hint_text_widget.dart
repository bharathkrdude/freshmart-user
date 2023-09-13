
import 'package:flutter/material.dart';
import 'package:fresh_mart/core/colors.dart';

class CustomHintTextWidget extends StatelessWidget {
   final String text;
  final double fontSize;
  
  const CustomHintTextWidget({super.key,
    required this.text,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
   return Text(
      text,
      style: TextStyle(
        decoration: TextDecoration.none,
        color:hintTextColor,
        fontSize: fontSize,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w500,
        letterSpacing: 0.45,
      ),
    );
  }
}