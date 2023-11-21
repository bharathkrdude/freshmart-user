import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_mart/Presentation/screens/splashscreens/splash_screen.dart';
import 'package:fresh_mart/application/BottomNavBloc/bottom_nav_bloc.dart';
import 'package:fresh_mart/application/cart/cart_bloc.dart';

import 'package:fresh_mart/application/category/category_bloc.dart';
import 'package:fresh_mart/application/orders/orders_bloc.dart';
import 'package:fresh_mart/application/payment/payment_bloc.dart';
import 'package:fresh_mart/application/product/product_bloc.dart';
import 'package:fresh_mart/application/profile/profile_bloc.dart';
import 'package:fresh_mart/application/search/search_bloc.dart';
import 'package:fresh_mart/application/wishlist/whishlist_bloc.dart';
import 'package:fresh_mart/firebase_options.dart';
import 'package:fresh_mart/infrastructure/cart/cart_repository.dart';
import 'package:fresh_mart/infrastructure/catagories/category_repository.dart';
import 'package:fresh_mart/infrastructure/favourites/whislistrepository.dart';
import 'package:fresh_mart/infrastructure/products/product_repository.dart';
import 'package:fresh_mart/infrastructure/profile/profile_repository.dart';

import 'application/address/address_bloc.dart';
import 'application/checkout/checkout_bloc.dart';
import 'infrastructure/address/address_repository.dart';
import 'infrastructure/order/order_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final String? userEmail = FirebaseAuth.instance.currentUser?.email;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BottomNavBloc()),
        BlocProvider(
          create: (_) => CategoryBloc(
            categoryRepository: CategoryRepository(),
          )..add(LoadCategories()),
        ),
        BlocProvider(
          create: (_) => ProductBloc(
            productRepository: ProductRepository(),
          )..add(LoadProducts()),
        ),
        BlocProvider(
            create: (_) =>
                WishlistBloc(wishlistRepository: WishlistRepository())),
        BlocProvider(
            create: (_) => CartBloc(
                  cartRepository: CartRepository(),
                )..add(LoadCart(email: userEmail!))),
        BlocProvider(
          create: (context) => SearchBloc(
            productRepository: ProductRepository(),
            categoryRepository: CategoryRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => AddressBloc(
            addressRepository: AddressRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => PaymentBloc()..add(PaymentMethodLoaded()),
        ),
        BlocProvider(
          create: (_) => ProfileBloc(
            profileRepository: ProfileRepository(),
          ),
        ),
        BlocProvider(
          create: (context) => CheckoutBloc(
            orderRepository: OrderRepository(),
            cartRepository: CartRepository(),
            cartBloc: BlocProvider.of<CartBloc>(context),
            addressBloc: BlocProvider.of<AddressBloc>(context),
            paymentBloc: BlocProvider.of<PaymentBloc>(context),
          )..add(const CheckoutUpdated()),
        ),
        BlocProvider(create: (context) => OrdersBloc(orderRepository: OrderRepository()))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          iconTheme: const IconThemeData(color: Colors.white),
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: Colors.black,
              ),
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
