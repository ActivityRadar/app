import 'package:app/constants/constants.dart';
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
