import 'package:app/constants/design.dart';
import 'package:app/widgets/custom/icon.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  final String text;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(color: DesignColors.naviColor),
      ),
    );
  }
}

class CustomTextButtonWhite extends StatelessWidget {
  const CustomTextButtonWhite({
    super.key,
    required this.onPressed,
    required this.text,
  });

  final String text;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
      ),
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {super.key, required this.onPressed, required this.text, this.style});

  final String text;
  final VoidCallback onPressed;
  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: style ??
          ButtonStyle(
            backgroundColor: MaterialStateProperty.all(DesignColors.naviColor),
          ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}

class ButtonCircle extends StatelessWidget {
  const ButtonCircle({
    super.key,
    required this.onPressed,
    required this.icon,
  });
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: CircleAvatar(
        child: Icon(icon),
        backgroundColor: DesignColors.naviColor,
      ),
      onPressed: onPressed,
    );
  }
}

class ButtonBookMark extends StatefulWidget {
  @override
  _ButtonBookMarkState createState() => _ButtonBookMarkState();
}

class _ButtonBookMarkState extends State<ButtonBookMark> {
  bool isIconSwitched = false;

  void toggleIcon() {
    setState(() {
      isIconSwitched = !isIconSwitched;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        toggleIcon();
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(DesignColors.naviColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          isIconSwitched
              ? Icon(AppIcons.bookmarkAdded)
              : Icon(AppIcons.bookmark),
          SizedBox(width: 8.0),
          Text('Merken'),
        ],
      ),
    );
  }
}
