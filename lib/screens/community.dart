import 'package:app/constants/design.dart';
import 'package:app/screens/auth.dart';
import 'package:app/screens/meet_page.dart';
import 'package:app/screens/meet_search_page.dart';
import 'package:app/screens/settings.dart';
import 'package:app/screens/widgets_page.dart';
import 'package:app/widgets/custom/background.dart';
import 'package:app/widgets/custom/button.dart';
import 'package:app/widgets/custom/card.dart';
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

    return BackgroundSVG(
      children: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          backgroundColor: DesignColors.transparent,
          title: Text(
            "Community",
            style: TextStyle(
                color: DesignColors.naviColor, fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            IconButton(
              icon: AppIcons.chat,
              onPressed: () {},
            ),
          ],
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MeetSearchScreen(),
                  ),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(AppStyle.cornerRadiusSearch),
                ),
                child: IgnorePointer(
                  child: TextField(
                    decoration: InputDecoration(
                      filled: false,
                      border: AppInputBorders.none,
                      focusedErrorBorder: AppInputBorders.none,
                      errorBorder: AppInputBorders.none,
                      enabledBorder: AppInputBorders.none,
                      focusedBorder: AppInputBorders.none,
                      prefixIcon: IconButton(
                        icon: const Icon(AppIcons.filterAlt),
                        onPressed: () {},
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(AppIcons.search),
                        onPressed: () {},
                      ),
                      hintStyle: CustomTextStyle.hint,
                      hintText: "Such nach Meet  ... ",
                    ),
                    textInputAction: TextInputAction.search,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 9.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TitleText(text: "Dein Meet Statisch", width: width),
                  TextButton(onPressed: () {}, child: Text('Profil'))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 9.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MeetStatistics(
                    value: "5",
                    title: "Erstellte",
                    onTap: () {},
                  ),
                  MeetStatistics(
                    value: "10",
                    title: "Teilgenommen",
                    onTap: () {},
                  ),
                  MeetStatistics(
                    value: "1",
                    title: "Mit Freunden",
                    onTap: () {},
                  ),
                  MeetStatistics(
                    value: "4",
                    title: "Sportarten",
                    onTap: () {},
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 9.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TitleText(text: "Deine Meet Up's", width: width),
                      TextButton(onPressed: () {}, child: Text('mehr Anzeigen'))
                    ],
                  ),
                  MeetList(
                    width: width,
                    height: 40,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TitleText(text: "Meet's in deine Nähe", width: width),
                      TextButton(onPressed: () {}, child: Text('mehr Anzeigen'))
                    ],
                  ),
                  MeetList(
                    width: width,
                    height: 40,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  MediumHintText(
                    text: "App-Version: Beta",
                    width: width,
                  ),
                ],
              ),
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

class MeetStatistics extends StatelessWidget {
  const MeetStatistics({
    super.key,
    required this.value,
    required this.title,
    required this.onTap,
  });

  final String value;
  final String title;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 100,
        height: 90,
        child: CustomCard(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 20,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  value,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: DesignColors.naviColor),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 13, color: const Color.fromARGB(153, 0, 0, 0)),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
