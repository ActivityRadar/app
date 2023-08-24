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

class MeetSearchScreen extends StatelessWidget {
  const MeetSearchScreen({Key? key}) : super(key: key);

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

    return Scaffold(
        backgroundColor: DesignColors.kBackground,
        body: BackgroundSVG(
          children: CustomScrollView(slivers: <Widget>[
            SliverAppBar(
              backgroundColor: DesignColors.transparent,
              /*leading: IconButton(
            icon: AppIcons.notification,
            onPressed: () {},
          ),

           actions: <Widget>[
            IconButton(
              icon: AppIcons.chat,
              onPressed: () {},
            ),/
          ],*/
            ),
            //SliverPersistentHeader(delegate: SliverPersistentHeaderDelegate()),
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
                        hintText:
                            "Search basketball, volleyball, table tennis ... ",
                      ),
                      textInputAction: TextInputAction.search,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NewsCard(),
                    NewsCard(),
                    NewsCard(),
                    NewsCard(),
                    NewsCard(),
                    NewsCard(),
                    NewsCard(),
                    NewsCard(),
                    NewsCard(),
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
        ));
  }
}
