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
import 'package:app/widgets/news_card.dart';
import 'package:app/widgets/profilecard.dart';
import 'package:app/widgets/profilslieder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double collapsedHeight = 90;
    const double expandedHeight = 160;
    var size = MediaQuery.of(context).size;
    final forapp = Provider.of<AppState>(context);

    double width = size.width;
    Future<List<OfferParsed>> userMeetups =
        MeetupManager.instance.getUserMeetups(forceFetch: true);

    final state = context.read<AppState>();
    if (state.userPosition != null) {
      MeetupManager.instance.currentPosition = state.userPosition!;
    }

    List<String> name = [
      'Anton',
      'Sophie',
      'Max',
      'Simon',
      'Laura',
      'Nico',
      'Jan',
    ];

    return BackgroundSVG(
      children: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          backgroundColor: DesignColors.transparent,
          title: Text(
            "ActivityRadar",
            style: TextStyle(
                color: DesignColors.naviColor, fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            IconButton(
              icon: AppIcons.notification,
              onPressed: () {},
            ),
          ],
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Column(
              children: [
                if (forapp.isLoggedIn) ...[ProfileCard(height: 0)] else
                  Text("Login"),
              ],
            ),
            SizedBox(
              height: 0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 9.0,
              ),
              child: TitleText(text: "Dein nächstes Sportplatz", width: width),
            ),
            if (forapp.isLoggedIn) ...[
              Padding(
                  padding: const EdgeInsets.only(
                    left: 9.0,
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        MeetStatistics(
                            icon: AppIcons.tabletennis, onTap: () {}),
                        MeetStatistics(
                          icon: AppIcons.volleyball,
                          onTap: () {},
                        ),
                        MeetStatistics(
                          icon: AppIcons.dumbbell,
                          onTap: () {},
                        ),
                        MeetStatistics(
                          icon: AppIcons.golf,
                          onTap: () {},
                        ),
                        MeetStatistics(
                          icon: AppIcons.soccer,
                          onTap: () {},
                        ),
                        MeetStatistics(
                          icon: AppIcons.swim,
                          onTap: () {},
                        ),
                        MeetStatistics(
                          icon: AppIcons.basketball,
                          onTap: () {},
                        ),
                      ],
                    ),
                  )),
            ] else ...[
              Padding(
                padding: const EdgeInsets.only(
                  left: 9.0,
                ),
                child: Wrap(
                  children: [
                    MeetStatistics(icon: AppIcons.tabletennis, onTap: () {}),
                    MeetStatistics(
                      icon: AppIcons.volleyball,
                      onTap: () {},
                    ),
                    MeetStatistics(
                      icon: AppIcons.dumbbell,
                      onTap: () {},
                    ),
                    MeetStatistics(
                      icon: AppIcons.golf,
                      onTap: () {},
                    ),
                    MeetStatistics(
                      icon: AppIcons.soccer,
                      onTap: () {},
                    ),
                    MeetStatistics(
                      icon: AppIcons.swim,
                      onTap: () {},
                    ),
                    MeetStatistics(
                      icon: AppIcons.basketball,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ],
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
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 9.0,
                    ),
                    child:
                        TitleText(text: "Freudschaftsvorschläge", width: width),
                  ),
                  ProfilSlider(
                    profil: name,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 9.0, top: 9.0),
                    child: TitleText(text: "News", width: width),
                  ),
                  NewsList(
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
          return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  children: snapshot.data!
                      .take(2) // only show the first two items
                      .map((offer) => MeetCard(offer: offer))
                      .toList()));
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
    required this.icon,
    required this.onTap,
  });

  final Widget icon;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: width / 5,
        height: width / 5,
        child: CustomCard(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [icon],
        )),
      ),
    );
  }
}
