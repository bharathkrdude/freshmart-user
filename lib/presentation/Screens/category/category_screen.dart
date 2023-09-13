
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_mart/application/category/category_bloc.dart';
import 'package:fresh_mart/core/colors.dart';

import 'widgets/category_card_widget.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

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
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
             if (state is CategoryLoading) {
              return const Center(
                child: CircularProgressIndicator(
                      strokeWidth: 3,
                      backgroundColor: Colors.white,
                      color: Colors.black,
                    ),
              );
            }
            if (state is CategoryLoaded) {
              return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                    mainAxisExtent: 225,
                  ),
                  itemBuilder: (context, index) {
                    return CategoryCard(category: state.categories[index]);
                  },
                  itemCount: state.categories.length,);
            } else{
              return const Text('Something went wrong!!!');
            }
            
            
          },
        ),
      ),
    );
  }
}