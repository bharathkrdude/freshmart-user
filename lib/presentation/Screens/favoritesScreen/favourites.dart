import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_mart/application/product/product_bloc.dart';
import 'package:fresh_mart/application/wishlist/whishlist_bloc.dart';
import 'package:fresh_mart/core/colors.dart';
import 'package:fresh_mart/domain/models/product_model.dart';
import 'package:fresh_mart/presentation/Screens/homeScreen/widgets/product_card_widget.dart';

class ScreenFavourites extends StatelessWidget {
  const ScreenFavourites({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 100,
        backgroundColor: backgroundColorWhite,
        iconTheme: const IconThemeData(color: textColor),
        centerTitle: true,
        title: Text(
          'Favourites',
          style: const TextStyle(color: textColor),
        ),
      ),
      backgroundColor: backgroundColorgrey,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: BlocBuilder<WishlistBloc, WishlistState>(
          builder: (context, state) {
            if (state is WishlistLoading) {
              return CircularProgressIndicator();
            } else if (state is WishlistLoaded) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                  mainAxisExtent: 250,
                ),
                itemBuilder: (context, index) {
                  final ProductModel product =
                      (BlocProvider.of<ProductBloc>(context).state
                              as ProductLoaded)
                          .products
                          .firstWhere(
                            (element) =>
                                element.id == state.wishlist.productList[index],
                          );
                  return ProductCardWidget(
                      product: product, onTapCallback: () {});
                },
                itemCount: state.wishlist.productList.length,
              );
            } else {
              return const Text('Something went wrong');
            }
          },
        ),
      ),
    );
  }
}
