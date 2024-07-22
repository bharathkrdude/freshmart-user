import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_mart/application/profile/profile_bloc.dart';

class ProfilePhotoWidget extends StatelessWidget {
  final bool isEdit;
  const ProfilePhotoWidget({
    super.key,
    this.isEdit = false,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return Center(
            child: Transform.scale(
              scale: 0.7,
              child: const CircularProgressIndicator(
                strokeWidth: 3,
                backgroundColor: Colors.white,
                color: Colors.black,
              ),
            ),
          );
        } else if (state is ProfileLoaded) {
          return Center(
            child: (isEdit)
                ? Stack(
                    children: [
                      Container(
                        width: size.width * 0.3,
                        height: size.width * 0.3,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(90),
                            border: Border.all(
                                width: 1.5, color: const Color(0x0ff38e3c))),
                        child: (state.profilePhotoUrl == '')
                            ? ClipRRect(borderRadius: BorderRadius.circular(90), child: Image.asset('assets/Images/profile.png'))
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(90),
                                child: Image.network(
                                  state.profilePhotoUrl,
                                  fit: BoxFit.cover,
                                  loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress==null) {
                                      return child;
                                    } else {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  },
                                ),
                              ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () {
                            BlocProvider.of<ProfileBloc>(context)
                                .add(const ProfilePictureUploaded());
                          },
                          child: const CircleAvatar(
                            backgroundColor: Color.fromARGB(255, 199, 228, 232),
                            radius: 18,
                            child: Icon(
                              Icons.add_a_photo,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(
                    width: size.width * 0.3,
                    height: size.width * 0.3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(90),
                        border: Border.all(
                            width: 1.5, color: const Color.fromARGB(255, 192, 216, 212))),
                    child: (state.profilePhotoUrl == '')
                        ? ClipRRect(borderRadius: BorderRadius.circular(90), child: Image.asset('assets/Images/profile.png'))
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(90),
                            child: Image.network(
                              state.profilePhotoUrl,
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress==null) {
                                      return child;
                                    } else {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  },
                            ),
                          ),
                  ),
          );
        } else {
          return const Icon(
            Icons.error,
            color: Colors.red,
          );
        }
      },
    );
  }
}