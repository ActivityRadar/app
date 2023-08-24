import 'package:app/constants/design.dart';
import 'package:app/screens/auth.dart';
import 'package:app/screens/settings.dart';
import 'package:app/screens/widgets_page.dart';
import 'package:app/widgets/custom/background.dart';
import 'package:app/widgets/custom/button.dart';
import 'package:app/widgets/custom_text.dart';
import 'package:app/widgets/meet_card.dart';
import 'package:app/widgets/news_card.dart';
import 'package:app/widgets/profilecard.dart';
import 'package:app/widgets/profilslieder.dart';
import 'package:app/widgets/search_activity_slieder.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double collapsedHeight = 90;
    const double expandedHeight = 160;
    var size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    List<String> fruits = [
      'Apple',
      'Banana',
      'Orange',
      'Grapes',
      'Mango',
      'Strawberry',
      'Pineapple',
    ];
    List<String> name = [
      'Simon',
      'Anton',
      'Laura',
      'Sophia',
      'Nico',
      'Jan',
      'Max',
    ];

    return BackgroundSVG(
      children: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          title: Text(
            "ActivityRadar",
            style: TextStyle(
                color: const Color.fromARGB(180, 53, 66, 204),
                fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            IconButton(
              icon: AppIcons.notification,
              onPressed: () {},
            ),
          ],
          backgroundColor: DesignColors.transparent,
        ),
        //SliverPersistentHeader(delegate: SliverPersistentHeaderDelegate()),
        SliverList(
          delegate: SliverChildListDelegate([
            ProfileCard(height: 0),
            SizedBox(
              height: 0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleText(text: "Schnell suche nach Meet", width: width),
                TextButton(onPressed: () {}, child: Text("Deine Meet Ups")),
                SizedBox(
                  height: 30,
                ),
                SearchBar(
                  hintText: "Search Meet and ",
                ),
                TitleText(text: "Deine nächste Verabredung", width: width),
                MeetList(
                  width: width,
                  height: 40,
                ),
                MeetList(
                  width: width,
                  height: 40,
                ),
                MeetList(
                  width: width,
                  height: 40,
                ),
                MeetList(
                  width: width,
                  height: 40,
                ),
                MeetList(
                  width: width,
                  height: 40,
                ),
                MeetList(
                  width: width,
                  height: 40,
                ),
                MeetList(
                  width: width,
                  height: 40,
                ),
                MeetList(
                  width: width,
                  height: 40,
                ),
                MeetList(
                  width: width,
                  height: 40,
                ),
                SizedBox(
                  height: 30,
                ),
                TitleText(text: "Freudschaftsvorschläge", width: width),
                ProfilSlider(
                  profil: name,
                ),
                SizedBox(
                  height: 30,
                ),
                TitleText(text: "News", width: width),
                NewsList(
                  width: width,
                  height: 40,
                ),
                MediumHintText(
                  text: "App-Version: Beta",
                  width: width,
                ),
              ],
            ),
            Padding(
                padding: const EdgeInsets.only(top: 8, left: 15, bottom: 4),
                child: Container(
                  height: 70.0,
                )),
          ]),
        )
      ]),
    );
  }
}
