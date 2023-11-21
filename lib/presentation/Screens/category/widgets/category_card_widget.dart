import 'package:flutter/material.dart';
import 'package:fresh_mart/core/colors.dart';
import 'package:fresh_mart/domain/models/category_model.dart';
import 'package:fresh_mart/presentation/Screens/category/each_catagory.dart';

class CategoryCard extends StatelessWidget {
 final CategoryModel category;

  const CategoryCard({super.key, 
  required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder:(context) => EachCategoryScreen(category:category ,) ));
        },
      child: Container(
     
        color: backgroundColorWhite,
        width: 120,
        height: 120,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: backgroundColorgrey,
                radius: 34,
                child: Image.network(category.imageUrl,
                  fit: BoxFit.contain,
                  
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(category.name,style: kCategoryText,)
            ],
          ),
        ),
      ),
    );
  }
}
