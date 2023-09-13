import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fresh_mart/Presentation/screens/Auth/auth_signup_screen.dart';
import 'package:fresh_mart/Presentation/screens/Auth/login_screen.dart';
import 'package:fresh_mart/Presentation/screens/Auth/widgets/snackbar.dart';
import 'package:fresh_mart/Presentation/screens/main_screen/screen_main.dart';
import 'package:fresh_mart/core/colors.dart';
import '../../../services/signin_signout_services.dart';
import '../../widgets/custom_hint_text_widget.dart';
import '../../widgets/custom_text_widget.dart';
import '../../widgets/primary_button_widget.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
   
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: backgroundColorlightgrey,
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: size.height - size.height * 0.45,
              child: Image.asset(
                "assets/Images/welcome-bg.png",
                fit: BoxFit.cover,
              ),
            ),
            Container(
                height: size.height * 0.4,
                width: double.infinity,
                color: backgroundColorlightgrey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          child: const CustomTextWidget(
                            text: 'Welcome',
                            fontSize: 25,
                          )),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      Container(
                         margin: const EdgeInsets.symmetric(horizontal: 8),
                        child: const CustomHintTextWidget(
                            text:
                                "The best delivery app in town for delivering your daily fresh groceries",
                            fontSize: 15,
                            ),
                      ),
                      
                      const SizedBox(
                        height: double.minPositive,
                      ),
                      Container(
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.white,
                        ),
                        child: Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(8.0),
                          child: InkWell(
                            onTap: () {
                           FirebaseSignService()
                                  .signInWithGoogle().then((value) => Navigator.pushReplacement(context,
                                   MaterialPageRoute(builder: (context) => const ScreenMain(),))).onError((error, stackTrace) {
                                        ScaffoldMessenger(child: SnackBar(content:Text(error.toString())));
                                      alertSnackbar(context,error.toString());
                                        log(error.toString());
                                      });
                                  
                            },
                            borderRadius: BorderRadius.circular(8.0),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal:
                                      8.0), // Equal padding from both sides
                              child: Row(
                                children: [
                                  const SizedBox(width: 8.0),
                                  Container(
                                    width: 22,
                                    height: 22,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/Images/google_icon.png'),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                        alignment: Alignment.center,
                                        child: const CustomTextWidget(
                                            text: 'Continue with google',
                                            fontSize: 15)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      PrimaryButtonWidget(
                          title: 'Create an account',
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SignupScreen()));
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CustomHintTextWidget(
                              text: 'Already have an account ?', fontSize: 12),
                          GestureDetector(
                            child: const CustomTextWidget(
                                text: ' Login', fontSize: 13),
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>  LoginScreen(),
                                )),
                          )
                        ],
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
