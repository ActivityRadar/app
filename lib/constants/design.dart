import 'package:flutter/material.dart';

class DesignColors {
  static const Color naviColor = Color.fromARGB(255, 33, 126, 202);
  static const Color kBackgroundColor = Color.fromARGB(255, 248, 248, 248);
}

class AppStyle {
  static const double cornerRadius = 20;
  static const double cornerRadiusSearch = 80;
  static const double cornerRadiusBottomSheet = 25.0;
  static const double kDefaultPadding = 20.0;
}

class CustomTextStyle {
  static const TextStyle hint =
      TextStyle(fontSize: 15.0, color: Colors.black12);
}

class AppInputBorders {
  static const OutlineInputBorder border = OutlineInputBorder(
    borderSide: BorderSide.none,
  );

  static const OutlineInputBorder focused = OutlineInputBorder(
    borderSide: BorderSide.none,
  );

  static const OutlineInputBorder enabled = OutlineInputBorder(
    borderSide: BorderSide.none,
  );

  static const OutlineInputBorder focusedError = OutlineInputBorder(
    borderSide: BorderSide.none,
  );

  static const OutlineInputBorder error = OutlineInputBorder(
    borderSide: BorderSide.none,
  );
}
