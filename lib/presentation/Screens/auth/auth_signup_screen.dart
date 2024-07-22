import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fresh_mart/Presentation/widgets/custom_hint_text_widget.dart';
import 'package:fresh_mart/Presentation/widgets/custom_text_widget.dart';
import 'package:fresh_mart/core/colors.dart';
import 'package:fresh_mart/domain/models/profile_model.dart';
import 'package:fresh_mart/infrastructure/profile/profile_repository.dart';
import 'package:fresh_mart/presentation/screens/auth/login_screen.dart';
import 'package:fresh_mart/presentation/widgets/primary_button_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key,});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> validationKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _reenterPasswordController =
      TextEditingController();

  bool _isPasswordVisible = false;
  bool _isReenterPasswordVisible = false;

  Future<void> signUpWithEmailAndPassword(BuildContext context) async {
  if (validationKey.currentState!.validate()) {
    validationKey.currentState!.save();
    try {
      final authResult = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (authResult.user != null) {
        // Send email verification
        await authResult.user!.sendEmailVerification();

        // Display a message to the user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'A verification email has been sent to ${authResult.user!.email}. Please verify your email before logging in.',
            ),
          ),
        );
      final profile = FirebaseFirestore.instance.collection('users').doc(_emailController.text).collection('profile')
          .doc();
      ProfileModel newProfile = ProfileModel(userName: '', userEmail: _emailController.text,id:profile.id);
       await ProfileRepository().updateProfileData(_emailController.text, profile.id, newProfile
       );
        // Navigate to the login screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>  const LoginScreen(),
          ),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
        ),
      );
    }
  }
}

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: size.height - size.height * 0.55,
                child: Image.asset(
                  "assets/Images/create_account.png",
                  fit: BoxFit.cover,
                ),
              ),
              Form(
                key: validationKey,
                child: Container(
                  height: size.height * 0.5,
                  width: double.infinity,
                  color: backgroundColorlightgrey,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView(
                      children: [
                        const CustomTextWidget(
                          text: 'Create account',
                          fontSize: 25,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const CustomHintTextWidget(
                            text: 'Quickly create an account', fontSize: 15),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: [
                            TextFormField(
                              validator: (email) {
                                return email != null &&
                                        EmailValidator.validate(email)
                                    ? null
                                    : 'Enter a valid email';
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: _emailController,
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                prefixIcon: Icon(Icons.email),
                              ),
                            ),
                            const SizedBox(height: 5),
                            TextFormField(
                              validator: (password) {
                                return password != null && password.isNotEmpty
                                    ? null
                                    : 'This field is required';
                              },
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
                                      _isPasswordVisible =
                                          !_isPasswordVisible;
                                    });
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            TextFormField(
                              validator: (reenterPassword) {
                                if (reenterPassword != null &&
                                    reenterPassword.isNotEmpty &&
                                    reenterPassword ==
                                        _passwordController.text) {
                                  return null;
                                } else {
                                  return 'Passwords do not match';
                                }
                              },
                              controller: _reenterPasswordController,
                              obscureText: !_isReenterPasswordVisible,
                              decoration: InputDecoration(
                                labelText: 'Re-enter Password',
                                prefixIcon: const Icon(Icons.lock),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isReenterPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isReenterPasswordVisible =
                                          !_isReenterPasswordVisible;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        PrimaryButtonWidget(
                          title: 'Signup',
                          onPressed: () {
                            signUpWithEmailAndPassword(context);
                          },
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CustomHintTextWidget(
                                text: 'Already have an account ?',
                                fontSize: 12),
                            GestureDetector(
                              child: const CustomTextWidget(
                                  text: ' Login', fontSize: 13),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>  const LoginScreen(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}