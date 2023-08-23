import 'package:app/constants/design.dart';
import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  const CustomChip({
    super.key,
    required this.text,
    this.backgroundColor,
  });

  final String text;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Chip(
        label: Text(
          text,
        ),
        backgroundColor: backgroundColor ?? DesignColors.naviColor);
  }
}
