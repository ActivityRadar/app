import 'package:app/constants/design.dart';
import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  const CustomChip({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Chip(
        label: Text(
          text,
          style: const TextStyle(
              color: DesignColors.kBackgroundColor, fontSize: 10),
        ),
        backgroundColor: DesignColors.naviColor);
  }
}
