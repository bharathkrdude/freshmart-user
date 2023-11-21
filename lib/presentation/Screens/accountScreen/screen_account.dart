import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_mart/application/profile/profile_bloc.dart';
import 'package:fresh_mart/core/colors.dart';
import 'package:fresh_mart/core/constants.dart';
import 'package:fresh_mart/presentation/Screens/adress/address_screen.dart';
import 'package:fresh_mart/presentation/Screens/auth/auth_welcome_screen.dart';
import 'package:fresh_mart/presentation/Screens/favoritesScreen/favourites.dart';
import 'package:fresh_mart/presentation/Screens/order/orders_screen.dart';
import 'package:fresh_mart/presentation/Screens/profile/profile_screen.dart';
import 'package:fresh_mart/presentation/Screens/profile/widgets/profile_photo.dart';

class ScreenAccount extends StatelessWidget {
  const ScreenAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColorgrey,
        body: ListView(
          children: [
            AccountTop(),
            kHeight,
            const AccountScreenBody(),
          ],
        ));
  }
}

class AccountScreenBody extends StatelessWidget {
  const AccountScreenBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AccountTileWidget(
          leadicon: const Icon(Icons.co_present_rounded),
          title: "About me",
          ontap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => ProfileScreen()));
          },
        ),
        AccountTileWidget(
          leadicon: const Icon(Icons.card_giftcard),
          title: "My orders",
          ontap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const OrdersScreen()));
          },
        ),
        AccountTileWidget(
          leadicon: const Icon(Icons.favorite_outline),
          title: "My favourites",
          ontap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ScreenFavourites()));
          },
        ),
        AccountTileWidget(
          leadicon: const Icon(Icons.location_on_outlined),
          title: "My Address",
          ontap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AddressScreen()));
          },
        ),
        AccountTileWidget(
          leadicon: const Icon(Icons.notifications_active_outlined),
          title: "Notifications",
          ontap: () {},
        ),
        AccountTileWidget(
          leadicon: const Icon(Icons.surfing_outlined),
          title: "Sign out",
          ontap: () {
            FirebaseAuth.instance
                .signOut()
                .then((value) => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WelcomeScreen(),
                    )));
          },
        ),
      ],
    );
  }
}

class AccountTileWidget extends StatelessWidget {
  final Icon leadicon;
  final String title;
  final VoidCallback ontap;
  const AccountTileWidget({
    super.key,
    required this.leadicon,
    required this.title,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: ontap,
      leading: Icon(
        leadicon.icon,
        color: primaryDark,
      ),
      title: Text(
        title,
        style: kCartText2,
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
    );
  }
}


class AccountTop extends StatelessWidget {
  const AccountTop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return Stack(
          alignment:   AlignmentDirectional(0, 20),
          children: [
            Container(
              height: 200,
              width: 400,
              color: backgroundColorWhite,
            ),
            Positioned(
              top: 100,
              child: Container(
                height: 100,
                width: 400,
                color: backgroundColorgrey,
              ),
            ),
            Positioned(
              left: MediaQuery.of(context).size.width/3.8,
              
              top: 50,
              child: Container(
                color: Colors.white.withOpacity(0.1),
                margin: const EdgeInsets.all(5.0),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Center(
                    child: Column(
                      children: [
                        const ProfilePhotoWidget(),
                        kHeight,
                        if (state is ProfileLoaded) ...[
                          Text(
                            state.profile.userName,
                            style: const TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text(
                            state.profile.userEmail,
                            style: const TextStyle(fontSize: 10),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

