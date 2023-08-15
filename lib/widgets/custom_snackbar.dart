import 'package:app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:app/constants/design.dart';

void showMessengeSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          const Radius.circular(15.0),
        ),
      ),
      backgroundColor: DesignColors.naviColor,
      behavior: SnackBarBehavior.floating,
      elevation: 6.0,
    ),
  );
}
