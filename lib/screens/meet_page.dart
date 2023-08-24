import 'package:app/constants/constants.dart';
import 'package:app/constants/design.dart';
import 'package:app/widgets/custom/background.dart';
import 'package:app/widgets/custom/card.dart';
import 'package:app/widgets/custom/chip.dart';

import 'package:app/widgets/custom/alertdialog.dart';

import 'package:app/widgets/custom_text.dart';
import 'package:app/widgets/custom/button.dart';
import 'package:app/widgets/meet_map.dart';
import 'package:flutter/material.dart';

class MeetPage extends StatelessWidget {
  const MeetPage({super.key});

  @override
  Widget build(BuildContext context) {
    const double collapsedHeight = 90;
    const double expandedHeight = 160;
    var size = MediaQuery.of(context).size;
    var height = size.height;
    double width = size.width;
    return BackgroundSVG(
        children: Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
            expandedHeight: expandedHeight,
            collapsedHeight: collapsedHeight,
            flexibleSpace: FlexibleSpaceBar(
              background: SizedBox(
                height: 100,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        AppStyle.cornerRadius), // Radius der abgerundeten Ecken
                  ),
                  child: MeetMap(),
                ),
              ),
            ),
            actions: const [MeetPopupMenuCard()],
            iconTheme: const IconThemeData(
              color: DesignColors.naviColor,
            )),
        SliverPersistentHeader(
          delegate: MyHeaderDelegate(
            child: Container(
              color: DesignColors.transparent,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(children: [
                            Row(children: [
                              const Padding(
                                  padding: EdgeInsets.only(left: 10, top: 60)),
                              const CircleAvatar(
                                backgroundImage: AssetImages.avatarEmpty,
                                radius: 20,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              MediumText(
                                text: 'Max Mustermann',
                                width: width,
                              ),
                            ]),
                          ]),
                          CustomTextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Dialog schließen
                              },
                              text: 'Anfrage senden'),
                        ]),
                    Center(
                      child: TitleText(
                        text: "Table Tennis",
                        width: width,
                      ),
                    ),
                  ]),
            ),
          ),

          pinned: true, // Nur dieser Header wird gepinnt
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.only(left: 9.0, top: 10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CardPeople(
                        people: '1-4',
                      ),
                      CardEvent(date: "14.02.13"),
                      CardSchedule(
                        time: "14 Uhr",
                      ),
                      CardPublic(),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SingleChildScrollView(
                      scrollDirection:
                          Axis.horizontal, // Horizontales Scrollen aktivieren
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 12.0),
                            child: CustomChip(
                              text: "Table Tennis",
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 12.0),
                            child: CustomChip(
                              text: "Tennis",
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 12.0),
                            child: CustomChip(
                              text: "Swimming",
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 12.0),
                            child: CustomChip(
                              text: "Football",
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 12.0),
                            child: CustomChip(
                              text: "soccer",
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 12.0),
                            child: CustomChip(
                              text: "Volleyball",
                            ),
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 9.0, top: 10.0),
                    child: TitleText(text: "description", width: width),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: DescriptionText(
                          text:
                              "Moin, Moin, Moin, Moin, Moin, Moin, Moin, Moin, Moin, Moin, Moin, Moin, Moin, Moin, Moin, Moin, Moin, Moin, Moin, Moin, Moin, Moin, Moin, Moin, Moin, Moin, Moin, Moin, ",
                          width: width)),
                  Padding(
                    padding: const EdgeInsets.only(left: 9.0, top: 10.0),
                    child: TitleText(text: "Sind auch dabei:", width: width),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: Column(
                        children: [
                          ProfilListeCardView(
                              width: width, name: 'Max Mustermann'),
                          Divider(
                            // Hier wird die Trennlinie hinzugefügt
                            color: const Color.fromARGB(
                                63, 0, 0, 0), // Farbe der Trennlinie
                          ),
                          ProfilListeCardView(
                              width: width, name: 'Max Mustermann'),
                          Divider(
                            // Hier wird die Trennlinie hinzugefügt
                            color: const Color.fromARGB(
                                63, 0, 0, 0), // Farbe der Trennlinie
                          ),
                          ProfilListeCardView(
                              width: width, name: 'Max Mustermann'),
                        ],
                      )),
                  Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ButtonBookMark(),
                          CustomElevatedButton(
                              onPressed: () {}, text: "Anfrage senden")
                        ],
                      )),
                  Padding(
                      padding:
                          const EdgeInsets.only(top: 8, left: 15, bottom: 4),
                      child: Container(
                        height: 70.0,
                      )),
                ]),
          ]),
        )
      ]),
    ));
  }
}

class ProfilListeCardView extends StatelessWidget {
  const ProfilListeCardView({
    super.key,
    required this.width,
    required this.name,
  });

  final double width;
  final String name;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(children: [
          const Padding(padding: EdgeInsets.only(left: 10, top: 60)),
          const CircleAvatar(
            backgroundImage: AssetImages.avatarEmpty,
            radius: 15,
          ),
          const SizedBox(
            width: 10,
          ),
          MediumText(
            text: name,
            width: width,
          ),
        ]),
        Row(
          children: [
            AppIcons.chat,
            Icon(AppIcons.close),
          ],
        )
      ]),
    ]);
  }
}

class CardPeople extends StatelessWidget {
  const CardPeople({
    super.key,
    required this.people,
  });

  final String people;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 9.0),
      child: Column(
        children: [Icon(AppIcons.person), SmallText(text: people)],
      ),
    );
  }
}

class CardPublic extends StatelessWidget {
  const CardPublic({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Icon(AppIcons.public), SmallText(text: "Öffenlicht")],
    );
  }
}

class CardPrivat extends StatelessWidget {
  const CardPrivat({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Icon(AppIcons.lock), SmallText(text: "nur Freunde")],
    );
  }
}

class CardSchedule extends StatelessWidget {
  const CardSchedule({
    super.key,
    required this.time,
  });

  final String time;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Icon(AppIcons.schedule), SmallText(text: time)],
    );
  }
}

class CardEvent extends StatelessWidget {
  const CardEvent({
    super.key,
    required this.date,
  });

  final String date;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(AppIcons.event),
        SmallText(
          text: date,
        )
      ],
    );
  }
}

class MeetPopupMenuCard extends StatefulWidget {
  const MeetPopupMenuCard({super.key});

  @override
  State<MeetPopupMenuCard> createState() => _MeetPopupMenuCardState();
}

class _MeetPopupMenuCardState extends State<MeetPopupMenuCard> {
  ReviewPopupMenuItem? selectedMenu;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<ReviewPopupMenuItem>(
      initialValue: selectedMenu,
      // Callback that sets the selected popup menu item.
      onSelected: (ReviewPopupMenuItem item) {
        setState(() {
          selectedMenu = item;
        });
      },
      itemBuilder: (BuildContext context) =>
          <PopupMenuEntry<ReviewPopupMenuItem>>[
        PopupMenuItem<ReviewPopupMenuItem>(
          value: ReviewPopupMenuItem.report,
          child: const SystemText(text: 'Report as inappropriate'),
          onTap: () => _showDialog(context),
        ),
      ],
    );
  }
}

void _showDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomAlertDialog(
          title: 'Report as inappropriate',
          content: const SystemText(
              text:
                  'Thank you for contributing to the safety and respect of our community. If you believe that this content violates our policies or is inappropriate, please click on Report.   Your message will be treated confidentially and verified by our moderation team. '),
          firstbuttonText: "Cancel",
          firstonPress: () {
            Navigator.of(context).pop();
          }, // Dialog schließen
          secondbuttonText: 'Send',
          secondonPress: () {
            Navigator.of(context).pop();
          });
    },
  );
}

class MyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  MyHeaderDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 100.0;

  @override
  double get minExtent => 100.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
