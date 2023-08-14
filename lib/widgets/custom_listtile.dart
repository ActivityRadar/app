import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.onPressed,
    this.titleText,
    this.splitTitle,
    this.icon,
  });

  final String? titleText;
  final VoidCallback onPressed;
  final Icon? icon;
  final Widget? splitTitle;

  @override
  Widget build(BuildContext context) {
    if (icon != null || titleText != null) {
      return ListTile(leading: icon, title: Text(titleText!), onTap: onPressed);
    }
    return ListTile(title: splitTitle, onTap: onPressed);
  }
}

class TwoListTile extends StatelessWidget {
  const TwoListTile({
    super.key,
    required this.onPressed,
    required this.firstText,
    required this.secoundText,
  });

  final VoidCallback onPressed;
  final String firstText;
  final String secoundText;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(firstText),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(color: Colors.black12),
            ),
            onPressed: onPressed,
            child: Text(
              secoundText,
              style: TextStyle(color: Colors.black12),
            ),
          ),
        ],
      ),
      onTap: onPressed,
    );
  }
}
