import 'package:app/widgets/custom/background.dart';
import 'package:app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackgroundSVG(
      children: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[CustomText(text: "Hallo")],
            )
          ],
        ),
      ),
    );
  }
}
