import 'package:app/widgets/custom/button.dart';
import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.content,
    required this.firstbuttonText,
    required this.firstonPress,
    required this.secondbuttonText,
    required this.secondonPress,
  });

  final String title;
  final Widget content;
  final VoidCallback firstonPress;
  final String firstbuttonText;
  final VoidCallback secondonPress;
  final String secondbuttonText;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: content,
      actions: <Widget>[
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          CustomTextButton(text: firstbuttonText, onPressed: firstonPress),
          CustomTextButton(text: secondbuttonText, onPressed: secondonPress),
        ])
      ],
    );
  }
}
