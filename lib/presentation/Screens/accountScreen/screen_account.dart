import 'package:flutter/material.dart';
import 'package:fresh_mart/core/colors.dart';

class ScreenAccount extends StatelessWidget {
  const ScreenAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: backgroundColorgrey,
       body:Column(
        children: [
          Stack(
            children: [
              Container(
                height: 140,
                width: double.infinity,
                color: backgroundColorWhite,
              
              ),
              Positioned(
                top: 120,
                child: Center(
                  child: CircleAvatar(
                
                              ),
                ),),

            ],
          )
        ],
       )

       );
  }
}




