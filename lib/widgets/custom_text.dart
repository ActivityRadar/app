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
          color: const Color.fromARGB(182, 0, 0, 0),
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
          color: const Color.fromARGB(182, 0, 0, 0),
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
      style: TextStyle(fontSize: 0.033 * width, color: Colors.black87),
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
