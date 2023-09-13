

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fresh_mart/Presentation/Screens/Auth/login_screen.dart';



import 'package:fresh_mart/Presentation/screens/homeScreen/screen_home.dart';

import 'package:fresh_mart/Presentation/widgets/custom_hint_text_widget.dart';

import '../../../core/colors.dart';
import '../../widgets/custom_text_widget.dart';
import '../../widgets/primary_button_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
   final GlobalKey<FormState> validationKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible = false;
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
                        // mainAxisAlignment: MainAxisAlignment.start,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomTextWidget(
                            text: 'Create account',
                            fontSize: 25,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const CustomHintTextWidget(
                              text: ' Quikly create account', fontSize: 15),
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            children: [
                              TextFormField(
                                validator: (email){
                                  return email!=null && EmailValidator.validate(email) ? null : 'Enter a valid email';
                                },
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                controller: _emailController,
                                decoration: const InputDecoration(
                                  labelText: 'Email',
                                  prefixIcon: Icon(Icons.email),
                                ),
                              ),
                              const SizedBox(height: 5),
                              TextFormField(
                                validator: (phone) {
                                  return phone!=null&& EmailValidator.validate(phone)? null:'This field is required';
                                },
                                controller: _phoneNumberController,
                                keyboardType: TextInputType.phone,
                                decoration: const InputDecoration(
                                  labelText: 'Phone Number',
                                  prefixIcon: Icon(Icons.phone),
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
                          const SizedBox(
                            height: 5,
                          ),
                          PrimaryButtonWidget(
                              title: 'Signup',
                              onPressed: () {
                                if(validationKey.currentState!.validate()){
                                      validationKey.currentState!.save();
                                FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                        email: _emailController.text,
                                        password: _passwordController.text)
                                    .then((value) => Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ScreenHome())))
                                    .onError((error, stackTrace) {
                                  // ScaffoldMessenger(child: SnackBar(content:Text(error.toString())));
                                 return null;
                                });
                                }
                              }),
                          const SizedBox(
                            height: 5,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomHintTextWidget(
                                  text: 'Already have an account ?',
                                  fontSize: 12),
                              // GestureDetector(
                              //   child: const CustomTextWidget(
                              //       text: ' Login', fontSize: 13),
                              //   onTap: () { Navigator.push(
                              //       context,
                              //       MaterialPageRoute(
                              //         builder: (context) =>  LoginScreen();
                              //       ),
                                
                              //   );
                              //   }
                              // )
  
                            ],
                          ),
                        ],
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
