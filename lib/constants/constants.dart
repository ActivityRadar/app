import 'package:flutter/material.dart';
import 'dart:core';

enum ReviewPopupMenuItem { report }

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

  // start with a letter, then between 1 and 16 chars ., _, or letter/digits, where
  // a . is not followed by another . or a _ or vice versa.
  // at the end a letter or digit
  static RegExp username =
      RegExp(r'^[a-z](_(?!(\.|_))|\.(?!(_|\.))|[a-z0-9]){1,16}[a-z0-9]$');

  static RegExp password =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
  static RegExp email =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
}

class AssetImages {
  static const locationLoading =
      AssetImage("assets/locationPhotoLoadingPlaceholder.jpg");
  static const locationEmpty =
      AssetImage("assets/locationPhotoPlaceholder.jpg");
  static const locationError =
      AssetImage("assets/locationPhotoPlaceholder.jpg");

  static const avatarLoading =
      AssetImage("assets/locationPhotoLoadingPlaceholder.jpg");
  static const avatarEmpty = AssetImage("assets/locationPhotoPlaceholder.jpg");
  static const avatarError = AssetImage("assets/locationPhotoPlaceholder.jpg");
}
