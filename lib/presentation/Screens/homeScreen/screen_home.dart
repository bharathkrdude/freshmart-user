import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_mart/Presentation/screens/Auth/auth_welcome_screen.dart';
import 'package:fresh_mart/application/category/category_bloc.dart';
import 'package:fresh_mart/application/product/product_bloc.dart';
import 'package:fresh_mart/application/wishlist/whishlist_bloc.dart';
import 'package:fresh_mart/core/colors.dart';
import 'package:fresh_mart/core/constants.dart';
import 'package:fresh_mart/domain/models/category_model.dart';
import 'package:fresh_mart/presentation/Screens/category/category_screen.dart';
import 'package:fresh_mart/presentation/Screens/homeScreen/widgets/category_slide_widget.dart';

import 'package:fresh_mart/presentation/Screens/homeScreen/widgets/product_horizontal_list_widget.dart';
import 'package:fresh_mart/presentation/Screens/search_screen/search_screen.dart';

final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    final String? userEmail = FirebaseAuth.instance.currentUser!.email;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<WishlistBloc>(context).add(LoadWishList(email: userEmail!));
    },);
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColorgrey,
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  backgroundColor: Colors.white,
                  color: Colors.black,
                ),
              );
            }
            if (state is ProductLoaded) {
              return SingleChildScrollView(
                child: Column(children: [
                  kWidth30,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        // Expanded(
                        //   child: Image.asset(
                        //     "assets/Images/user.png",
                        //     scale: 3.6,
                        //   ),
                        // ),
                        // Expanded(
                        //     flex: 2,
                        //     child: Container(
                        //       margin: const EdgeInsets.symmetric(horizontal: 8),
                        //       child: const Column(
                        //         mainAxisAlignment: MainAxisAlignment.start,
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: [
                        //           Text(
                        //             "Welcome back",
                        //             style: TextStyle(
                        //                 color: hintTextColor,
                        //                 fontSize: 12,
                        //                 fontWeight: FontWeight.w500),
                        //           ),
                        //           SizedBox(
                        //             height: 4,
                        //           ),
                        //           Text(
                        //             "Bharath Kr",
                        //             style: TextStyle(
                        //                 color: Colors.black,
                        //                 fontSize: 16,
                        //                 fontWeight: FontWeight.w600),
                        //           ),
                        //         ],
                        //       ),
                        //     )),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextButton(
                              onPressed: () {
                                FirebaseAuth.instance
                                    .signOut()
                                    .then((value) => Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const WelcomeScreen(),
                                        )));
                              },
                              child: const Text('Log Out')),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        decoration: const BoxDecoration(
                            color: backgroundColorWhite,
                            borderRadius:
                                BorderRadius.all(Radius.circular(24))),
                        child: GestureDetector(
                          // onTap:  () {
                          //   Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) =>
                          //               ()));
                          // },
                          child: TextField(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ScreenSearch()));
                            },
                            readOnly: true,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search Category",
                              hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: hintTextColor,
                                  fontWeight: FontWeight.w500),
                              contentPadding: EdgeInsets.all(16),
                              prefixIcon: Icon(
                                CupertinoIcons.search,
                                color: textColor,
                              ),
                            ),
                          ),
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.asset(
                      "assets/Images/banner.png",
                      scale: 4.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const CategoryScreen()));
                          },
                          child: _seeAllView(
                            context,
                            "Categories",
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),

                        BlocBuilder<CategoryBloc, CategoryState>(
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
                            return CategorySlideWidget(
                                category: state.categories);
                          } else {
                            return const Text('Something went wrong!!!');
                          }
                        }),
                        kWidth30,
                        _seeAllView(
                          context,
                          "Best Selling",
                        ),

                        kWidth20,
                        ProductSlideWidget(products: state.products)
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: ProductCardWidget(
                        //         imagePath: "assets/Images/bell_pepper_red.png",
                        //         name: "Red Chilly",
                        //         price: "1kg, 4\$",
                        //         onTapCallback: () {},
                        //       ),
                        //     ),
                        //     Expanded(
                        //       child: ProductCardWidget(
                        //           imagePath: "assets/Images/lamb_meat.png",
                        //           name: "Lamb meat",
                        //           price: "1kg, 4\$",
                        //           onTapCallback: () {}),
                        //     ),

                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ]),
              );
            } else {
              return const Text('Something went wrong!!!');
            }
          },
        ),
      ),
    );
  }

  Widget _seeAllView(
    BuildContext context,
    String name,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        InkWell(
          onTap: () {},
          child: const Text(
            "See All",
            style: TextStyle(
                fontSize: 14, color: primaryDark, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
// final ProductModel product;
//   _buildAllProducts() => GridView.builder(

//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         childAspectRatio: (100 / 140),
//         crossAxisSpacing: 12,
//         mainAxisSpacing: 12,
//       ),
//       scrollDirection: Axis.vertical,
//       itemBuilder: (context, index) {

//   return ProductCardWidget(imagePath: product.imageUrls[index], name:product.name , price:product., onTapCallback: );
//       });
}

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
