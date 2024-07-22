import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_mart/application/address/address_bloc.dart';
import 'package:fresh_mart/application/cart/cart_bloc.dart';
import 'package:fresh_mart/application/category/category_bloc.dart';
import 'package:fresh_mart/application/checkout/checkout_bloc.dart';
import 'package:fresh_mart/application/orders/orders_bloc.dart';
import 'package:fresh_mart/application/product/product_bloc.dart';
import 'package:fresh_mart/application/profile/profile_bloc.dart';
import 'package:fresh_mart/application/wishlist/whishlist_bloc.dart';
import 'package:fresh_mart/core/colors.dart';
import 'package:fresh_mart/core/constants.dart';
import 'package:fresh_mart/presentation/screens/category/category_screen.dart';



import 'package:fresh_mart/presentation/screens/home/widgets/category_slide_widget.dart';
import 'package:fresh_mart/presentation/screens/home/widgets/product_horizontal_list_widget.dart';
import 'package:fresh_mart/presentation/screens/search_screen/search_screen.dart';

final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    final String? currentUser = FirebaseAuth.instance.currentUser!.email;
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        BlocProvider.of<CartBloc>(context).add(LoadCart(email: currentUser!));
        BlocProvider.of<WishlistBloc>(context).add(WishListGetLoaded(email: currentUser));
        BlocProvider.of<AddressBloc>(context).add( AddressLoaded(email: currentUser));
        BlocProvider.of<ProfileBloc>(context)
            .add(ProfileGetLoaded(email: currentUser));
        BlocProvider.of<CheckoutBloc>(context).add(const CheckoutUpdated());
       
        BlocProvider.of<OrdersBloc>(context).add(OrdersGetLoaded(email: currentUser));
      },
    );
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
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
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
                       SizedBox(height: 60,)
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
                                          const SearchScreen()));
                            },
                            readOnly: true,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: const InputDecoration(
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
                    child: ClipRRect(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        "assets/Images/freshmart-banner.png",
                        scale: 4.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        SeeAllview(context: context, name: "Categories", onpress: () {
                             Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const CategoryScreen()));
                          }),
                        const SizedBox(
                          height: 24,
                        ),
                        BlocBuilder<CategoryBloc, CategoryState>(
                          key: UniqueKey(),
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
                                category: state.categories,);
                          } else {
                            return const Text('Something went wrong!!!');
                          }
                        }),
                        kWidth30,
                        SeeAllview(context: context, name: "Best Selling", onpress: (){

                          }),
                        kWidth20,
                        ProductSlideWidget(
                            key: UniqueKey(), products: state.products)
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

class SeeAllview extends StatelessWidget {
  const SeeAllview({
    super.key,
    required this.context,
    required this.name,
    required this.onpress,
  });

  final BuildContext context;
  final String name;
  final VoidCallback onpress;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        InkWell(
          onTap: onpress,
          child: const Text(
            "See All",
            style: TextStyle(
                fontSize: 14, color: primaryDark, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}

