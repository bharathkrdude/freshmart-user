
import 'package:flutter/material.dart';
import 'package:fresh_mart/core/colors.dart';
import 'package:fresh_mart/domain/models/adress_model.dart';
import 'package:fresh_mart/presentation/Screens/adress/edit_address.dart';

class CheckoutAddressCard extends StatelessWidget {
  final AddressModel address;
  const CheckoutAddressCard({
    super.key,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
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
            color:backgroundColorWhite,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Padding(
            padding: EdgeInsets.all(
              width * 0.02,
            ),
            child: ListTile(
              title: Row(
                children: [
                  Expanded(child: Text(address.name)),
                  (address.type != 'Other')
                      ? Container(
                          height: height * 0.028,
                          width: width * 0.14,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color:primary,
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
                      SizedBox(
                        height: height * 0.028,
                      ),
                      InkWell(
                        onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditAddressScreen(address: address)));
                        },
                        child: Container(
                          height: height * 0.028,
                          width: width * 0.14,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.black),
                          ),
                          child: Text(
                            'Edit',
                            textAlign: TextAlign.center,
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
