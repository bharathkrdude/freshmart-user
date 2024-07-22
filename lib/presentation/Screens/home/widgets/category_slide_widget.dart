
import 'package:flutter/material.dart';
import 'package:fresh_mart/domain/models/category_model.dart';
import 'package:fresh_mart/presentation/screens/category/each_catagory.dart';
import 'package:fresh_mart/presentation/screens/home/widgets/category_circle_widget.dart';

class CategorySlideWidget extends StatelessWidget {
  final List<CategoryModel> category;
  const CategorySlideWidget({
    super.key,
  required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height/7.2,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: category.length,
        itemBuilder: (context,index){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: CategoryCircleWidget(category: category[index],onTap: () {
               Navigator.push(context, MaterialPageRoute(builder:(context) => EachCategoryScreen(category:category[index] ,) ));
            },),
          );
      }),
    );
  }
}