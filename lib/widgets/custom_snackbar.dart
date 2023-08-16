import 'package:flutter/material.dart';
import 'package:app/constants/design.dart';

void showMessageSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
      ),
      backgroundColor: DesignColors.naviColor,
      behavior: SnackBarBehavior.floating,
      elevation: 6.0,
    ),
  );
}
