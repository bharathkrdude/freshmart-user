import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fresh_mart/core/colors.dart';
import 'package:fresh_mart/core/constants.dart';
import 'package:fresh_mart/presentation/Screens/adress/address_screen.dart';
import 'package:fresh_mart/presentation/Screens/auth/auth_welcome_screen.dart';
import 'package:fresh_mart/presentation/Screens/favoritesScreen/favourites.dart';
import 'package:fresh_mart/presentation/Screens/order/orders_screen.dart';


class ScreenAccount extends StatelessWidget {
  const ScreenAccount({super.key,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColorgrey,
      body: ListView(
        children: [
          accountTop(),
          kHeight,
          AccountScreenBody(),
        ],
      )
    );
  }
}

class AccountScreenBody extends StatelessWidget {
  const AccountScreenBody({
    super.key,
    
  });

  

  @override
  Widget build(BuildContext context) {
    return  Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AccountTileWidget(
                  leadicon: Icon(Icons.co_present_rounded),
                  title: "About me", ontap: () {  },
                ),
                AccountTileWidget(
                  leadicon: Icon(Icons.card_giftcard),
                  title: "My orders", ontap: () { Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => OrdersScreen())); },
                ),
                AccountTileWidget(
                  leadicon: Icon(Icons.favorite_outline),
                  title: "My favourites", ontap: () { Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ScreenFavourites())); },
                ),
                AccountTileWidget(
                  leadicon: Icon(Icons.location_on_outlined),
                  title: "My Address", ontap: () { Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AddressScreen())); },
                ),
                AccountTileWidget(
                  leadicon: Icon(Icons.notifications_active_outlined),
                  title: "Notifications", ontap: () {  },
                ),
                AccountTileWidget(
                  leadicon: Icon(Icons.surfing_outlined),
                  title: "Sign out", ontap: () {
                     FirebaseAuth.instance
                                    .signOut()
                                    .then((value) => Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const WelcomeScreen(),
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
  final  VoidCallback ontap;
  const AccountTileWidget({
    Key? key,
    
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
  accountTop() {
    return Stack(
      alignment: AlignmentDirectional(0, 30),
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
          left: 110,
          top: 50,
          child: Container(
            color: Colors.white.withOpacity(0.1),
            margin: EdgeInsets.all(5.0),
            child: const Padding(
              padding:  EdgeInsets.all(4.0),
              child: Center(
                child: Column(
                  children: [
                    
                   CircleAvatar(
  radius: 50,
  backgroundImage: AssetImage('assets/Images/bharath.png'),
)
,
                    Text(
                      '''Bharath KR''',
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.w900),
                    ),
                    Text(
                      '''bharathkr122@.com''',
                      style: TextStyle(fontSize: 10),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }