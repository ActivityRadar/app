import 'package:app/constants/constants.dart';
import 'package:app/constants/design.dart';
import 'package:app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          "assets/images/background.svg",
          semanticsLabel: 'A red up arrow',
          alignment: Alignment.center,
          fit: BoxFit.fill,
          colorFilter: ColorFilter.mode(
              Color.fromARGB(16, 33, 126, 202), BlendMode.srcIn),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
        Column(
          children: <Widget>[
            Row(
              children: <Widget>[CustomText(text: "Hallo")],
            )
          ],
        ),
      ],
    );
  }
}
