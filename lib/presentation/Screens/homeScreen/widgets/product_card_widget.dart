import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_mart/application/wishlist/whishlist_bloc.dart';
import 'package:fresh_mart/core/colors.dart';
import 'package:fresh_mart/core/constants.dart';
import 'package:fresh_mart/domain/models/product_model.dart';

class ProductCardWidget extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onTapCallback;

  const ProductCardWidget(
      {Key? key, required this.product, required this.onTapCallback})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTapCallback(),
      child: Card(
          color: backgroundColorWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(.0),
          ),
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //  Row(
                //   mainAxisAlignment: MainAxisAlignment.end,

                //   children: [
                //     IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border,color: hintTextColor,))
                //   ],
                //  ),
                BlocBuilder<WishlistBloc, WishlistState>(
                  builder: (context, state) {
                    if (state is WishlistLoading) {
                      return const CircularProgressIndicator();
                    }
                    else if(state is WishlistLoaded){
                      return Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: (state.wishlist.productList.contains(product.id))?() {
                            BlocProvider.of<WishlistBloc>(context).add(RemoveWishlist(wishlistId: state.wishlist.id, productId: product.id));
                          }
                          :() {
                            BlocProvider.of<WishlistBloc>(context).add(AddToWishlist(wishlistId: state.wishlist.id, productId: product.id));
                          },
                          icon:  Icon(
                            Icons.favorite,
                            color: (state.wishlist.productList.contains(product.id))?Colors.red: hintTextColor,
                          ),
                        ),
                      ],
                    ); 
                    }
                    else{
                      return const Text('something went wrong');
                    }
                  },
                ),
                kHeight,
                Image.network(
                  product.imageUrls[0],
                  width: 120,
                  height: 120,
                ),
                kHeight16,
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    product.name,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                Text(
                  "₹${product.price.toString()}/${product.unit}",
                  style: const TextStyle(
                      color: primaryDark,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )),
    );
  }
}
