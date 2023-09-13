import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_mart/application/product/product_bloc.dart';
import 'package:fresh_mart/core/colors.dart';
import 'package:fresh_mart/domain/models/category_model.dart';
import 'package:fresh_mart/domain/models/product_model.dart';
import 'package:fresh_mart/presentation/Screens/homeScreen/widgets/product_card_widget.dart';
import 'package:fresh_mart/presentation/Screens/productsScreen/product_details_screen.dart';

class EachCategoryScreen extends StatelessWidget {
  final CategoryModel category;
  const EachCategoryScreen({
    super.key,
    required this.category,
  });
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
        title: Text(
          category.name,
          style: const TextStyle(color: textColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ProductLoaded) {
              final List<ProductModel> eachCategoryProducts = state.products
                  .where((product) => product.category == category.name)
                  .toList();
              return GridView.builder(
                
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  
                  crossAxisCount: 2,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                  mainAxisExtent: 250,
                ),
                itemBuilder: (context, index) {
                  return ProductCardWidget(
                      product: eachCategoryProducts[index],
                      onTapCallback: () {
                        Navigator.of(context).push(MaterialPageRoute(builder:(context) =>
                                         ProductDetailsScreen(product: eachCategoryProducts[index],) ));
                      });
                },
                itemCount: eachCategoryProducts.length,
              );
            } else {
              return const Text('Something went wrong!!!');
            }
          },
        ),
      ),
    );
  }
}
