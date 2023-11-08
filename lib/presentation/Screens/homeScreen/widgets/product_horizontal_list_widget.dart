

import 'package:flutter/material.dart';
import 'package:fresh_mart/domain/models/product_model.dart';
import 'package:fresh_mart/presentation/Screens/productsScreen/product_details_screen.dart';

import 'product_card_widget.dart';

class ProductSlideWidget extends StatelessWidget {
  final List<ProductModel> products;
  const ProductSlideWidget({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 4.2,
      width: MediaQuery.of(context).size.width/0.5
      ,
      child: ListView.builder(
         
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: products.length,
          itemBuilder: (context, index) {
            return ProductCardWidget(
              key: UniqueKey(),
              product: products[index],
              onTapCallback: () {
                Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
              ProductDetailsScreen(product: products[index],)));
              },
            );
          }),
    );
  }
}