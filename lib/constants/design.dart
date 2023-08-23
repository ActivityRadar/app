import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DesignColors {
  static const Color red = Color(0xFFFF7942);
  static const Color green = Color(0xFF70BF44);
  static const Color blue = Color(0xFF3542CC);
  static const Color grey = Colors.grey;
  static const Color naviColor = blue;
  static const Color transparent = Color.fromARGB(0, 248, 248, 248);
  static const Color kBackground = Color.fromARGB(255, 248, 248, 248);
  static const Color rangeactive = Color.fromARGB(237, 53, 66, 204);
  static const Color inactive = Color.fromARGB(180, 53, 66, 204);
  static const Color border = Color.fromARGB(51, 241, 241, 241);
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

  static const TextStyle label = TextStyle(color: Colors.black38);
}

class AppInputBorders {
  static const OutlineInputBorder none = OutlineInputBorder(
    borderSide: BorderSide.none,
  );

  static const OutlineInputBorder red = OutlineInputBorder(
    borderSide: BorderSide(color: DesignColors.red),
  );

  static const OutlineInputBorder blue = OutlineInputBorder(
    borderSide: BorderSide(color: DesignColors.blue),
  );
}

const InputDecoration searchDecoration = InputDecoration(
  border: AppInputBorders.none,
  focusedErrorBorder: AppInputBorders.none,
  errorBorder: AppInputBorders.none,
  enabledBorder: AppInputBorders.none,
  focusedBorder: AppInputBorders.none,
);

class AppIcons {
  static const IconData add = Icons.add;
  static const IconData home = Icons.home;
  static const IconData mapSharp = Icons.map_sharp;
  static const IconData group = Icons.group;
  static const IconData settings = Icons.settings;
  static const IconData share = Icons.ios_share;
  static const IconData addAPhoto = Icons.add_a_photo;
  static const IconData editNote = Icons.edit_note;
  static const IconData image = Icons.image;
  static const IconData thumbUp = Icons.thumb_up;
  static const IconData thumbDown = Icons.thumb_down;
  static const IconData pushPin = Icons.push_pin;
  static const IconData locationOn = Icons.location_on;
  static const IconData person = Icons.person;
  static const IconData public = Icons.public;
  static const IconData lock = Icons.lock;
  static const IconData schedule = Icons.schedule;
  static const IconData event = Icons.event;
  static const IconData calendarToday = Icons.calendar_today;
  static const IconData keyboardBackspace = Icons.keyboard_backspace;
  static const IconData icecream = Icons.icecream;
  static const IconData upload = Icons.upload;
  static const IconData filterAlt = Icons.filter_alt;
  static const IconData search = Icons.search;
  static const IconData star = Icons.star;
  static const IconData gpsFixed = Icons.gps_fixed;
  static const IconData gpsOff = Icons.gps_off;
  static const IconData remove = Icons.remove;
  static const IconData photo = Icons.photo;
  static const IconData cameraAlt = Icons.camera_alt;
  static const IconData favorite = Icons.favorite;
  static const IconData accessTime = Icons.access_time;
  static const IconData starHalfSharp = Icons.star_half_sharp;
  static const IconData menu = Icons.menu;
  static const IconData close = Icons.close;
  static const IconData bookmarkAdded = Icons.bookmark_added;
  static const IconData bookmark = Icons.bookmark;
  static const IconData edit = Icons.edit;
  static const IconData arrowBack = Icons.arrow_back;
  static const IconData done = Icons.done;
  static Widget chat = SvgPicture.asset(
      "assets/icons/chat.svg", // https://remixicon.com/
      colorFilter:
          ColorFilter.mode(Color.fromARGB(255, 0, 0, 0), BlendMode.srcIn),
      semanticsLabel: 'chaticon');
  static Widget notification = SvgPicture.asset(
      "assets/icons/notification.svg", // https://remixicon.com/
      colorFilter:
          ColorFilter.mode(Color.fromARGB(255, 0, 0, 0), BlendMode.srcIn),
      semanticsLabel: 'chaticon');
}
