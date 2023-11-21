import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fresh_mart/Presentation/screens/Auth/auth_signup_screen.dart';
import 'package:fresh_mart/Presentation/screens/Auth/widgets/snackbar.dart';
import 'package:fresh_mart/Presentation/screens/main_screen/screen_main.dart';
import 'package:fresh_mart/Presentation/widgets/custom_hint_text_widget.dart';
import 'package:fresh_mart/core/constants.dart';
import 'package:fresh_mart/presentation/Screens/auth/auth_welcome_screen.dart';
import '../../../core/colors.dart';
import '../../widgets/custom_text_widget.dart';
import '../../widgets/primary_button_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> validationKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: size.height / 2.5,
                child: Image.asset(
                  "assets/Images/create_account.png",
                  fit: BoxFit.fill,
                ),
              ),
              Form(
                key: validationKey,
                child: Container(
                  height: size.height /2.5,
                  width: double.infinity,
                  color: backgroundColorlightgrey,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomTextWidget(
                          text: 'Login',
                          fontSize: 25,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const CustomHintTextWidget(
                          text: 'Enter your credentials',
                          fontSize: 15,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: [
                            TextFormField(
                              validator: validateEmail,
                              controller: _emailController,
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                prefixIcon: Icon(Icons.email),
                              ),
                            ),
                            const SizedBox(height: 5),
                            TextFormField(
                              validator: password,
                              controller: _passwordController,
                              obscureText: !_isPasswordVisible,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                prefixIcon: const Icon(Icons.lock),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isPasswordVisible = !_isPasswordVisible;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        PrimaryButtonWidget(
                          title: 'Login',
                          onPressed: () {
                            // Implement your login logic here
                            // Access email and password using the controllers
                            if (_emailController.text.isEmpty &&
                                _passwordController.text.isEmpty) {
                              alertSnackbar(context, 'Fields Should be Filled');
                            }
                            if (_emailController.text.isNotEmpty &&
                                _passwordController.text.isNotEmpty) {
                              log('Here');
                              FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: _emailController.text,
                                      password: _passwordController.text)
                                  .then((value) => Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const ScreenMain(),
                                        ),
                                      ))
                                  .onError((error, stackTrace) {
                                // ScaffoldMessenger(child: SnackBar(content:Text(error.toString())));
                                alertSnackbar(context, error.toString());
                                log(error.toString());
                              });
                            }
                          },
                        ),
                        kHeight,
                       
                      ],
                    ),
                  ),
                ),
              ),
               googleLogin(context),
                        kHeight,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CustomHintTextWidget(
                              text: 'Don\'t have an account?',
                              fontSize: 12,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignupScreen()));
                              },
                              child: const CustomTextWidget(
                                text: ' Sign Up',
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
            ],
          ),
        ),
      ),
    );
  }
}

String? validateEmail(value) {
  if (value!.isEmpty) {
    return 'Please enter an email';
  }
  String? match = r'\w+@\w+\.\w+';
  RegExp regex = RegExp(match);
  if (!regex.hasMatch(value)) {
    return 'invalid email';
  }
  return null;
}

String? password(value) {
  if (value == '' || value == null) {
    return 'Enter the password';
  }
  return null;
}
