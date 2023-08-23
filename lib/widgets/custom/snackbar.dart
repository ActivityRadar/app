import 'package:flutter/material.dart';
import 'package:app/constants/design.dart';

void showMessageSnackBar(BuildContext context, String message,
    {bool fixed = false}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      behavior: fixed ? SnackBarBehavior.fixed : SnackBarBehavior.floating,
    ),
  );
}
