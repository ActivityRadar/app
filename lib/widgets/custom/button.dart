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
    return IconButton(
      icon: CircleAvatar(
        child: Icon(AppIcons.arrowBack),
        backgroundColor: DesignColors.naviColor,
      ),
      onPressed: onPressed,
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
    return IconButton(
      icon: CircleAvatar(
        child: Icon(AppIcons.menu),
        backgroundColor: DesignColors.naviColor,
      ),
      onPressed: onPressed,
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
    return IconButton(
      icon: CircleAvatar(
        child: Icon(AppIcons.close),
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
