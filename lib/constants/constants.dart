import 'package:flutter/material.dart';
import 'package:app/constants/design.dart';
import 'dart:core';
import 'package:flutter_svg/flutter_svg.dart';

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

enum Place {
  bar,
  spielplatz,
  hinterhof,
  schulgeleande,
  im_gebeaude,
  club,
  park
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
      AssetImage("assets/images/locationPhotoLoadingPlaceholder.jpg");
  static const locationEmpty =
      AssetImage("assets/images/locationPhotoPlaceholder.jpg");
  static const locationError =
      AssetImage("assets/images/locationPhotoPlaceholder.jpg");

  static const avatarLoading =
      AssetImage("assets/images/locationPhotoLoadingPlaceholder.jpg");
  static const avatarEmpty =
      AssetImage("assets/images/locationPhotoPlaceholder.jpg");
  static const avatarError =
      AssetImage("assets/images/locationPhotoPlaceholder.jpg");
  static Widget backgroundAR = SvgPicture.asset("assets/images/background.svg",
      colorFilter:
          ColorFilter.mode(Color.fromARGB(22, 248, 248, 248), BlendMode.srcIn),
      semanticsLabel: 'A red up arrow');
}
