import 'package:app/constants/design.dart';
import 'package:app/widgets/custom/background.dart';
import 'package:app/widgets/custom/button.dart';
import 'package:app/widgets/custom/card.dart';
import 'package:app/widgets/custom_text.dart';
import 'package:app/widgets/meet_card.dart';
import 'package:flutter/material.dart';

class MeetUpMoreScreen extends StatelessWidget {
  const MeetUpMoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    double width = size.width;

    return Scaffold(
        body: BackgroundSVG(
      children: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30.0),
            ),
          ),
          backgroundColor: DesignColors.blue,
          title: Text(
            "Deine Meet Up's",
            style: TextStyle(
                color: DesignColors.kBackground, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(AppIcons.morevert),
            )
          ],
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 9.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MeetList(
                    width: width,
                    height: 40,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ]),
        )
      ]),
    ));
  }
}
