import 'package:flutter/material.dart';
import 'dart:core';

class DesignColors {
  static const Color naviColor = Color.fromARGB(255, 0, 131, 238);
  static const Color kBackgroundColor = Color.fromARGB(255, 248, 248, 248);
}

class AppStyle {
  static const double cornerRadius = 20;
  static const double kDefaultPadding = 20.0;
}

class AppInputBorders {
  static const OutlineInputBorder border = OutlineInputBorder(
    borderSide: BorderSide.none,
  );

  static const OutlineInputBorder focusedBorder = OutlineInputBorder(
    borderSide: BorderSide.none,
  );

  static const OutlineInputBorder enabledBorder = OutlineInputBorder(
    borderSide: BorderSide.none,
  );

  static const OutlineInputBorder focusedErrorBorder = OutlineInputBorder(
    borderSide: BorderSide.none,
  );

  static const OutlineInputBorder errorBorder = OutlineInputBorder(
    borderSide: BorderSide.none,
  );
}

enum Sport {
  kegeln,
  Bowling,
  American_Football,
  Tischtennis,
  Table_Soccer,
  Tennis,
  Rodelsport
}

Map<String, String> shortSports = {
  "9pin": "Kegeln",
  "10pin": "Bowling",
  "american_football": "American Football",
  "table_tennis": "Tischtennis",
  "table_soccer": "Table Soccer",
  "tennis": "Tennis",
  "toboggan": "Rodelsport",
};

class RegExps {
//RegExp
  static RegExp displayname = RegExp(r'^[A-Za-züöä\s]+$');
  static RegExp username = RegExp(
      r'[a-zA-Z0-9](_(?!(\.|_))|\.(?!(_|\.))|[a-zA-Z0-9]){6,18}[a-zA-Z0-9]');

  static RegExp password =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
  static RegExp email =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
}
