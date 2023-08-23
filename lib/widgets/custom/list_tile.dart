import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.onPressed,
    required this.text,
    this.icon,
  });

  final String text;
  final VoidCallback onPressed;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    if (icon != null) {
      return ListTile(leading: icon, title: Text(text), onTap: onPressed);
    }
    return ListTile(title: Text(text), onTap: onPressed);
  }
}

class TwoListTile extends StatelessWidget {
  const TwoListTile({
    super.key,
    required this.onPressed,
    required this.keyText,
    required this.valueText,
  });

  final VoidCallback onPressed;
  final String keyText;
  final String valueText;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(keyText),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(color: Colors.black12),
            ),
            onPressed: onPressed,
            child: Text(
              valueText,
              style: TextStyle(color: Colors.black12),
            ),
          ),
        ],
      ),
      onTap: onPressed,
    );
  }
}
