import 'package:app/constants/design.dart';
import 'package:app/screens/widgets_page.dart';
import 'package:app/widgets/custom/background.dart';
import 'package:app/widgets/custom/button.dart';
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
            SizedBox(
              height: 140,
            ),
            Row(
              children: <Widget>[
                CustomText(text: "Hallo"),
                ButtonCircle(
                  icon: AppIcons.arrowBack,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TestWidget(),
                      ),
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
