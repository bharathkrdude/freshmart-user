import 'package:flutter/material.dart';
import 'package:fresh_mart/core/colors.dart';
import 'package:fresh_mart/domain/models/category_model.dart';

class CategoryCircleWidget extends StatelessWidget {
  final CategoryModel category;
  final VoidCallback onTap;
  const CategoryCircleWidget(
      {super.key, required this.category, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: backgroundColorWhite,
              radius: 32,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.network(
                  category.imageUrl,
                  scale: 4.0,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              category.name,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
