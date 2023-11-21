

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_mart/application/address/address_bloc.dart';
import 'package:fresh_mart/core/colors.dart';
import 'package:fresh_mart/domain/models/adress_model.dart';
import 'package:fresh_mart/presentation/Screens/adress/edit_address.dart';

class AddressCardWidget extends StatelessWidget {
  const AddressCardWidget({
    super.key,
    required this.address,
    this.index = 0,
    this.selectedIndex = 0,
  });

  final AddressModel address;
  final int selectedIndex;
  final int index;

  @override
  Widget build(BuildContext context) {
    final String? currentUser = FirebaseAuth.instance.currentUser!.email;
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Padding(
      padding: EdgeInsets.all(height * 0.01),
      child: Material(
        elevation: 10,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: Container(
          height: height * 0.17,
          width: width / 1,
          decoration: const BoxDecoration(
            color: backgroundColorWhite,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Padding(
            padding: EdgeInsets.all(
              width * 0.02,
            ),
            child: RadioListTile(
              activeColor: const Color(0xff388E3C),
              value: index,
              groupValue: selectedIndex,
              onChanged: (value) {
                BlocProvider.of<AddressBloc>(context)
                    .add(AddressCardSelected(index));
              },
              title: Row(
                children: [
                  Expanded(child: Text(address.name)),
                  (address.type != 'Other')
                      ? Container(
                          height: height * 0.028,
                          width: width * 0.14,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: const Color(0xff388E3C),
                          ),
                          child: Text(
                            address.type,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
              subtitle: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          address.house,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          '${address.street}, ${address.city}',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        Text(
                          '${address.state}, ${address.pincode}',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          address.phone,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ],
                    ),
                  ),
                   Column(
                          children: [
                            PopupMenuButton<String>(
                              color: Colors.white70,
                              iconSize: 28,
                              icon: const Icon(
                                Icons.more_vert,
                                color: Colors.black,
                                size: 28,
                              ),
                              padding: const EdgeInsets.all(1.0),
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry<String>>[
                                PopupMenuItem<String>(
                                  value: "Edit",
                                  child: TextButton(
                                    onPressed: () async {
                                      await Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EditAddressScreen(address: address,)));
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'Edit',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                  ),
                                ),
                                PopupMenuItem<String>(
                                  value: "Delete",
                                  child: TextButton(
                                    onPressed: () async {
                                     BlocProvider.of<AddressBloc>(context)
                                          .add(AddressDeleted(email: currentUser!, addressId: address.id));
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'Delete',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
