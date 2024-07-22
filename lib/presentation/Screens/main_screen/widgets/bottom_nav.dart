import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_mart/application/BottomNavBloc/bottom_nav_bloc.dart';
import 'package:fresh_mart/core/colors.dart';
import 'package:fresh_mart/presentation/screens/account_screen/screen_account.dart';
import 'package:fresh_mart/presentation/screens/cart/screen_cart.dart';
import 'package:fresh_mart/presentation/screens/favorites/favourites.dart';
import 'package:fresh_mart/presentation/screens/home/screen_home.dart';




class BottomNavigationWidget extends StatelessWidget {
  const BottomNavigationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screens = [
       const ScreenHome(),
       const ScreenAccount(),
       const ScreenFavourites(),
      const ScreenCart(),
    ];
    return BlocBuilder<BottomNavBloc, BottomNavState>(
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(
            index: state.index,
            children: screens,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state.index,
            onTap: (index){
              BlocProvider.of<BottomNavBloc>(context).add(indexChanger(index: index));
            },
             unselectedItemColor: hintTextColor,
            unselectedIconTheme: const IconThemeData(color: hintTextColor),
            backgroundColor: backgroundColorWhite,
            type: BottomNavigationBarType.fixed,
            fixedColor: textColor,
            // Set unselected label color
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_outlined),
                label: 'Account',
              ), 
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border_outlined),
                label: 'favourites',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.work_outline),
                label: 'Cart',
              ),
            ],
          ),
        );
      },
    );
  }
}
