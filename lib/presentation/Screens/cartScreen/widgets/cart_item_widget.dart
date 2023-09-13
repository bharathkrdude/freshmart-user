

import 'package:flutter/material.dart';
import 'package:fresh_mart/domain/models/product_model.dart';

class CartItemWidget extends StatelessWidget {
  final ProductModel product;
  final int quantity;
  const CartItemWidget({Key? key, required this.product,required this.quantity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Image.asset(
              product.imageUrls[0],
            width: 40,
            height: 40,
          )),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name
                  ,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(product.price.toString(),
                    style: TextStyle(
                        color: Color(0xffFF324B),
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                InkWell(
                  onTap: (() {
                    // setState(() {
                    //   itemCount++;
                    // });
                  }),
                  child: Icon(Icons.add_circle_outline_rounded),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  quantity.toString(),
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(
                  width: 8,
                ),
                InkWell(
                  onTap: () {
                    // setState(() {
                    //   if (widget.quantity > 0) widget.quantity--;
                    // });
                  },
                  child: Icon(Icons.remove_circle_outline)
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
