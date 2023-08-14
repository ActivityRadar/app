import 'package:app/constants/design.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.child,
  });

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: Color.fromARGB(51, 241, 241, 241),
        ),
        borderRadius: BorderRadius.circular(AppStyle.cornerRadius),
      ),
      child: child,
    );
  }
}
