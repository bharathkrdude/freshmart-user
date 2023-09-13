import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fresh_mart/Presentation/screens/Auth/auth_welcome_screen.dart';
import 'dart:async';

import 'package:fresh_mart/Presentation/screens/main_screen/screen_main.dart';
import 'package:fresh_mart/core/colors.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
        const Duration(seconds: 3),
        () =>navigateUser());
  }
  void navigateUser()async{
 if(FirebaseAuth.instance.currentUser!=null){
 Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const ScreenMain()));
 }else{
 Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const WelcomeScreen()));
 }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: splashColor,
      body: Center(
          child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 48,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            "assets/Images/image 3.png",
            scale: 4.0,
          ),
        ),
      )),
    );
  }
}
