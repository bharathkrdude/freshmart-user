import 'package:flutter/material.dart';
import 'package:fresh_mart/core/colors.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColorgrey,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 100,
        backgroundColor: backgroundColorWhite,
        iconTheme: const IconThemeData(color: textColor),
        centerTitle: true,
        title: const Text(
          'Categories',
          style: TextStyle(color: textColor),
        ),
      ),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: EdgeInsets.all(15.0),
            // child: CategoryCard(
             
            //       "https://firebasestorage.googleapis.com/v0/b/fresh-mart-1db2c.appspot.com/o/category_images%2F2417435.png?alt=media&token=accc88a9-0477-4207-bfda-346f424446d0",
            // ),

          ),
        ],
      ),
    );
  }
}
