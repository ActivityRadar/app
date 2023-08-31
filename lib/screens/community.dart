import 'package:app/app_state.dart';
import 'package:app/constants/design.dart';
import 'package:app/screens/more_meetups_screen.dart';
import 'package:app/provider/meetup_manager.dart';
import 'package:app/screens/meet_add.dart';
import 'package:app/screens/meet_search_page.dart';
import 'package:app/widgets/custom/background.dart';
import 'package:app/widgets/custom/button.dart';
import 'package:app/widgets/custom/card.dart';
import 'package:app/widgets/custom_text.dart';
import 'package:app/widgets/meet_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double collapsedHeight = 90;
    const double expandedHeight = 160;
    var size = MediaQuery.of(context).size;

    double width = size.width;

    final state = context.read<AppState>();
    if (state.userPosition != null) {
      MeetupManager.instance.currentPosition = state.userPosition!;
    }

    Future<List<OfferParsed>> userMeetups =
        MeetupManager.instance.getUserMeetups(forceFetch: true);

    Future<List<OfferParsed>> availableMeetups =
        MeetupManager.instance.getAvailableMeetups(forceFetch: true);

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
                  TitleText(text: "Dein Meet Statistik", width: width),
                  TextButton(onPressed: () {}, child: Text('Profil'))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 9.0,
              ),
              child: Wrap(
                alignment:
                    WrapAlignment.center, // Ausrichtung am Anfang der Zeile
                spacing: 8.0,
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
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MeetUpMoreScreen(
                                    title: "Deine Meet Up's",
                                    participating: true),
                              ),
                            );
                          },
                          child: Text('mehr Anzeigen'))
                    ],
                  ),
                  meetCardLoader(userMeetups,
                      emptyMessage: "Du hast derzeit keine offenen Meetups!"),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TitleText(text: "Meet's in deiner Nähe", width: width),
                      TextButton(
                          onPressed: () {},
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const MeetUpMoreScreen(
                                            title: "Meet's in deine Nähe",
                                            participating: false),
                                  ),
                                );
                              },
                              child: Text('mehr Anzeigen')))
                    ],
                  ),
                  meetCardLoader(availableMeetups,
                      emptyMessage:
                          "In deiner Nähe wurden keine offenen Meetups gefunden!",
                      errorMessage:
                          "Aktiviere deinen Standort, um nach Angeboten zu suchen!"),
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

  Widget emptyMeetupsContainer(BuildContext context, String message) {
    return Card(
      child: ListTile(
        title: Text(message),
        subtitle: Text(
          "Erstelle ein neues Angebot...",
        ),
        trailing: ButtonCircle(
          icon: AppIcons.arrowForward,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const MeetAddScreen()));
          },
        ),
      ),
    );
  }

  Widget meetCardLoader(Future<List<OfferParsed>> future,
      {required String emptyMessage, String? errorMessage}) {
    return FutureBuilder(
      future: future,
      builder:
          (BuildContext context, AsyncSnapshot<List<OfferParsed>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isEmpty) {
            return emptyMeetupsContainer(context, emptyMessage);
          }
          return Column(
              children: snapshot.data!
                  .take(2) // only show the first two items
                  .map((offer) => MeetCard(offer: offer))
                  .toList());
        }

        if (snapshot.hasError) {
          print(snapshot.error);
          return Text(errorMessage ?? "Fehler beim Laden der Meetups!");
        }

        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }

        return emptyMeetupsContainer(context, emptyMessage);
      },
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
    var size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: width / 3.5,
        height: height / 10,
        child: CustomCard(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: ((height / 10) / 5),
            ),
            SizedBox(
              height: ((height / 10) / 4),
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
              height: ((height / 10) / 10),
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
