import 'package:app/constants/design.dart';
import 'package:app/provider/meetup_manager.dart';
import 'package:app/widgets/custom/background.dart';
import 'package:app/widgets/custom/card.dart';
import 'package:app/widgets/custom_text.dart';
import 'package:app/widgets/meet_card.dart';
import 'package:flutter/material.dart';

class MeetUpMoreScreen extends StatelessWidget {
  const MeetUpMoreScreen({
    Key? key,
    required this.title,
    required this.participating,
  }) : super(key: key);

  final String title;
  final bool participating;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final Future<List<OfferParsed>> meetups = participating
        ? MeetupManager.instance.getUserMeetups()
        : MeetupManager.instance.getAvailableMeetups();

    double width = size.width;

    return Scaffold(
        body: BackgroundSVG(
      children: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30.0),
            ),
          ),
          backgroundColor: DesignColors.blue,
          title: Text(
            title,
            style: TextStyle(
                color: DesignColors.kBackground, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(AppIcons.morevert),
            )
          ],
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 9.0,
              ),
              child: FutureBuilder(
                future: meetups,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  var children;
                  if (snapshot.hasData) {
                    children = snapshot.data!
                        .map<Widget>((m) => MeetCard(offer: m))
                        .toList();
                  } else if (snapshot.hasError) {
                    children = [
                      CustomCard(
                          child: TitleText(
                              text: "Error loading items!", width: width))
                    ];
                  } else {
                    children = [const CircularProgressIndicator()];
                  }

                  return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: children);
                },
              ),
            ),
          ]),
        )
      ]),
    ));
  }
}
