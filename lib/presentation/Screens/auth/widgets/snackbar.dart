import 'package:flutter/material.dart';

void alertSnackbar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(
      message,
      
    ),
    action: SnackBarAction(
      label: 'Okay',
      onPressed: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}