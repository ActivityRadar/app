import 'package:app/constants/constants.dart';
import 'package:flutter/material.dart';

SnackBar messageSnackBar(String message) {
  return SnackBar(
    content: Text(message),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(15.0),
      ),
    ),
    backgroundColor: DesignColors.naviColor,
    behavior: SnackBarBehavior.floating,
    elevation: 6.0,
  );
}
