import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_mart/application/profile/profile_bloc.dart';
import 'package:fresh_mart/core/colors.dart';
import 'package:fresh_mart/core/utils.dart';
import 'package:fresh_mart/domain/models/profile_model.dart';
import 'package:fresh_mart/presentation/screens/adress/add_adress.dart';
import 'package:fresh_mart/presentation/screens/adress/widgets/custom_textfield.dart';
import 'package:fresh_mart/presentation/screens/profile/widgets/profile_date_picker.dart';
import 'package:fresh_mart/presentation/screens/profile/widgets/profile_dropdown.dart';
import 'package:fresh_mart/presentation/screens/profile/widgets/profile_photo.dart';


class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  static const String routeName = '/profile';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => ProfileScreen(),
    );
  }

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final genderController = TextEditingController();
  final dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColorlightgrey,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 100,
        backgroundColor: backgroundColorWhite,
        iconTheme: const IconThemeData(color: textColor),
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(color: textColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoaded) {
              nameController.text = state.profile.userName;
              phoneController.text = state.profile.userPhone;
              genderController.text = state.selectedGender;
              dateController.text = state.profile.userDob;
              log('<<<<<<<<<----------->>>>>>>>>');
        
              log('<<<<<<<<<<<<message>>>>>>>>>>>>');
              return Form(
                key: formKey,
                child: ListView(
                  children: [
                    const ProfilePhotoWidget(
                      isEdit: true,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      controller: nameController,
                      labelText: 'Full Name',
                      iconData: Icons.person,
                      validator: (name) =>
                          name != '' ? null : 'Name is required!!',
                    ),
                    CustomTextFormField(
                      controller: phoneController,
                      labelText: 'Phone Number',
                      isMaxLength: true,
                      maxLength: 10,
                      iconData: Icons.phone_android,
                      keyboardType: TextInputType.number,
                      validator: (phone) => (phone != null &&
                              phone.length != 10 &&
                              !RegExp(r'^[0-9]{10}$').hasMatch(phone))
                          ? 'Phone number should be 10 digits'
                          : null,
                    ),
                    CustomProfileDropDown(genderController: genderController),
                    ProfileDatePicker(dateController: dateController),
                    // const Spacer(),
                    Row(
                      children: [
                        MainButtonWidget(
                            buttonText: 'Save Profile',
                            onPressed: () async{
                              final isValid = formKey.currentState!.validate();
                              if (isValid) {
                                final updatedProfile = ProfileModel(
                                  id: state.profile.id,
                                  userName: nameController.text.trim(),
                                  userEmail: state.profile.userEmail,
                                  userPhone: phoneController.text.trim(),
                                  userGender: genderController.text.trim(),
                                  userDob: dateController.text.trim(),
                                  userImageUrl: state.profile.userImageUrl,
                                );
                                BlocProvider.of<ProfileBloc>(context).add(
                                    ProfileUpdated(newProfile: updatedProfile));
                                // Utils.showSnackBar(
                                //     'Profile updated successfully.',
                                //     const Color.fromARGB(255, 255, 183, 89));
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile updated successfully')));
                                Navigator.pop(context);
                              } else {
                                log('not valid');
                                Utils.showSnackBar(
                                    'All the fields are required.',
                                    Colors.redAccent);
                              }
                            }),
                      ],
                    ),
                  ],
                ),
              );
            } else {
              return const Icon(
                Icons.error,
                color: Colors.red,
              );
            }
          },
        ),
      ),
    );
  }
}