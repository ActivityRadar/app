import 'package:app/constants/design.dart';
import 'package:app/screens/auth.dart';
import 'package:app/screens/settings.dart';
import 'package:app/screens/widgets_page.dart';
import 'package:app/widgets/custom/background.dart';
import 'package:app/widgets/custom/button.dart';
import 'package:app/widgets/custom_text.dart';
import 'package:app/widgets/meet_card.dart';
import 'package:app/widgets/news_card.dart';
import 'package:app/widgets/profilslieder.dart';
import 'package:app/widgets/search_activity_slieder.dart';
import 'package:flutter/material.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double collapsedHeight = 90;
    const double expandedHeight = 160;
    var size = MediaQuery.of(context).size;

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
          backgroundColor: DesignColors.transparent,
          leading: IconButton(
            icon: AppIcons.notification,
            onPressed: () {},
          ),
          /* title: SearchBar(
            hintText: "Search Meet and ",
          ),*/
          actions: <Widget>[
            IconButton(
              icon: AppIcons.chat,
              onPressed: () {},
            ),
          ],
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            SizedBox(
              height: 30,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleText(text: "Schnell suche nach Meet", width: width),
                ActivitySearchChipSlider(
                  activities: fruits,
                ),
                SizedBox(
                  height: 30,
                ),
                TitleText(text: "Deine nächste Verabredung", width: width),
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
