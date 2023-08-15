import 'package:app/constants/constants.dart';
import 'package:app/constants/design.dart';
import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  const SmallText({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.black54,
        fontSize: 18.0,
      ),
    );
  }
}

class MediumText extends StatelessWidget {
  const MediumText({
    super.key,
    required this.text,
    required this.width,
  });

  final String text;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: Colors.black54,
          fontWeight: FontWeight.bold,
          fontSize: width * 0.04),
    );
  }
}

class TitleText extends StatelessWidget {
  const TitleText({
    super.key,
    required this.text,
    required this.width,
  });

  final String text;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: Colors.black54,
          fontWeight: FontWeight.bold,
          fontSize: width * 0.05),
    );
  }
}

class DescriptionText extends StatelessWidget {
  const DescriptionText({
    super.key,
    required this.text,
    required this.width,
  });

  final String text;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 0.033 * width,
        color: Colors.black87,
      ),
    );
  }
}

class NaviText extends StatefulWidget {
  const NaviText({
    super.key,
    required this.text,
    required this.currentTab,
  });

  final bool currentTab;
  final String text;

  @override
  State<NaviText> createState() => _NaviTextState();
}

class _NaviTextState extends State<NaviText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: TextStyle(
          color: widget.currentTab ? DesignColors.naviColor : Colors.grey),
    );
  }
}

class PageTitleText extends StatelessWidget {
  const PageTitleText({
    super.key,
    required this.width,
    required this.text,
  });

  final double width;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: width * 0.06),
    );
  }
}

class MediumhintText extends StatelessWidget {
  const MediumhintText({
    super.key,
    required this.text,
    required this.width,
  });

  final String text;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: Colors.black38, fontSize: width * 0.035),
    );
  }
}

class UserText extends StatelessWidget {
  const UserText({
    super.key,
    required this.displayName,
    required this.width,
  });

  final String displayName;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Text(
      "@$displayName",
      style: TextStyle(fontSize: width * 0.033, color: Colors.black45),
    );
  }
}

class LittleText extends StatelessWidget {
  const LittleText({
    super.key,
    required this.text,
    required this.width,
  });

  final String text;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: Colors.black38, fontSize: width * 0.030),
    );
  }
}

class SystemText extends StatelessWidget {
  const SystemText({
    super.key,
    required this.text,
  });

  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(fontSize: 14, color: Colors.black54));
  }
}

class MapText extends StatelessWidget {
  const MapText({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(color: Colors.white),
    );
  }
}

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
  });

  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(text);
  }
}

class infoText extends StatelessWidget {
  const infoText({
    super.key,
    required this.text,
  });

  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: Colors.black12),
    );
  }
}
