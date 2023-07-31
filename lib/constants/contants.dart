import 'package:flutter/material.dart';

class DesignColors {
  static const Color naviColor = Color.fromARGB(255, 0, 131, 238);
  static const Color kBackgroundColor = Colors.white;
}

const double kDefaultPadding = 20.0;

enum Sport {
  kegeln,
  Bowling,
  American_Football,
  Tischtennis,
  Table_Soccer,
  Tennis,
  Rodelsport
}

Map<String, String> shorSport = {
  "9pin": "Kegeln",
  "10pin": "Bowling",
  "american_football": "American Football",
  "table_tennis": "Tischtennis",
  "table_soccer": "Table Soccer",
  "tennis": "Tennis",
  "toboggan": "Rodelsport",
};
