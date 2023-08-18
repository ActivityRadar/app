import 'package:app/constants/design.dart';
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
  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}

class ButtonBack extends StatelessWidget {
  const ButtonBack({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
      backgroundColor: DesignColors.naviColor,
      onPressed: () {},
      child: Icon(
        Icons.arrow_back,
        size: 20,
        color: Colors.white70,
      ),
    );
  }
}

class ButtonMenu extends StatelessWidget {
  const ButtonMenu({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
      backgroundColor: DesignColors.naviColor,
      onPressed: () {},
      child: Icon(
        Icons.menu,
        size: 20,
        color: Colors.white70,
      ),
    );
  }
}

class ButtonCancel extends StatelessWidget {
  const ButtonCancel({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
      backgroundColor: DesignColors.naviColor,
      onPressed: () {},
      child: Icon(
        Icons.close,
        size: 20,
        color: Colors.white70,
      ),
    );
  }
}
