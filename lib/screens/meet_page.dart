import 'package:app/app_state.dart';
import 'package:app/constants/constants.dart';
import 'package:app/constants/design.dart';
import 'package:app/model/functions.dart';
import 'package:app/provider/activity_type.dart';
import 'package:app/model/generated.dart';
import 'package:app/provider/photos.dart';
import 'package:app/provider/user_manager.dart';
import 'package:app/widgets/activityType_short.dart';
import 'package:app/widgets/custom/background.dart';

import 'package:app/widgets/custom/alertdialog.dart';

import 'package:app/widgets/custom_text.dart';
import 'package:app/widgets/custom/button.dart';
import 'package:app/widgets/meet_map.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MeetPage extends StatelessWidget {
  const MeetPage({super.key, this.x});

  final OfferOut? x;

  @override
  Widget build(BuildContext context) {
    final state = context.read<AppState>();
    final OfferOut offer = x ??
        OfferOut(
            id: "209dhj128e",
            participants: [
              Participant(
                  id: state.currentUser!.id, status: ParticipantStatus.host),
              Participant(
                  id: "64d0f9312b6597c92fb2f15f",
                  status: ParticipantStatus.requested),
            ],
            participantLimits: [1, 4],
            visibilityRadius: 2.0,
            location: OfferLocationArea(
                coords: GeoJsonLocation(
                    type: "Point", coordinates: [13.4, 52.5])).toJson(),
            activity: ["table_tennis"],
            // time: OfferTimeFlexible(type: "flexible").toJson(),
            time: OfferTimeSingle(type: "single", times: [
              DateTime.parse("2023-08-29T19:30:20Z"),
              DateTime.parse("2023-08-29T21:30:20Z")
            ]).toJson(),
            userInfo: OfferCreatorInfo(
                username: state.currentUser!.username,
                displayName: state.currentUser!.displayName,
                id: state.currentUser!.id),
            blurrInfo: LocationBlurrOut(
                radius: 2,
                center:
                    GeoJsonLocation(type: "Point", coordinates: [13.4, 52.5])),
            description: DescriptionWithTitle(
                title: "Wer hat Bock?",
                text:
                    "Ich würde gern mit mindestens 3 anderen spielen, wenns geht."),
            visibility: OfferVisibility.public);

    final bool isHost = state.currentUser!.id == offer.userInfo.id;
    final bool isParticipant =
        isHost || offer.participants.any((p) => p.id == state.currentUser!.id);

    double collapsedHeight = 90;
    const double expandedHeight = 160;

    var size = MediaQuery.of(context).size;
    var height = size.height;
    double width = size.width;

    List<Widget> timeWidgets = [const CardTimeFlexible()];
    if (offer.time["type"] != "flexible") {
      final start = DateTime.parse(offer.time["times"][0]);
      final DateFormat dateFormatter = DateFormat("dd.MM.yyyy");
      final DateFormat timeFormatter = DateFormat("hh:mm");

      timeWidgets = [
        CardEvent(date: dateFormatter.format(start)),
        CardSchedule(
          time: "${timeFormatter.format(start)} Uhr",
        ),
      ];
    }

    return BackgroundSVG(
        children: Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
            expandedHeight: expandedHeight,
            collapsedHeight: collapsedHeight,
            flexibleSpace: FlexibleSpaceBar(
              background: SizedBox(
                height: 100,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppStyle.cornerRadius),
                  ),
                  child: MeetMap(
                      center: toLatLng(isHost
                          ? GeoJsonLocation.fromJson(offer.location!["coords"])
                          : offer.blurrInfo.center),
                      radius: isHost ? 0.01 : offer.blurrInfo.radius),
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
                                text: offer.userInfo.displayName,
                                width: width,
                              ),
                            ]),
                          ]),
                          if (!isParticipant)
                            CustomTextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Dialog schließen
                                },
                                text: 'Anfrage senden'),
                        ]),
                    Center(
                      child: TitleText(
                        text: offer.description.title,
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
                      CardParticipantLimits(
                        min: offer.participantLimits[0],
                        max: offer.participantLimits[1],
                      ),
                      ...timeWidgets,
                      CardVisibility(visibility: offer.visibility)
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ActivityChipSlider(
                      activities: ActivityManager.instance
                          .getDisplayTypes(offer.activity)),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 9.0, top: 10.0),
                    child: TitleText(text: "Beschreibung", width: width),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: DescriptionText(
                          text: offer.description.text, width: width)),
                  Padding(
                    padding: const EdgeInsets.only(left: 9.0, top: 10.0),
                    child: TitleText(text: "Sind auch dabei:", width: width),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: Column(
                          children: offer.participants
                              .where((p) =>
                                  p.id != state.currentUser!.id &&
                                  (p.status == ParticipantStatus.accepted ||
                                      isHost))
                              .map(
                                (p) => Column(children: [
                                  ProfileListCard(width: width, userId: p.id),
                                  const Divider(
                                    // Hier wird die Trennlinie hinzugefügt
                                    color: Color.fromARGB(
                                        63, 0, 0, 0), // Farbe der Trennlinie
                                  )
                                ]),
                              )
                              .toList())),
                  Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ButtonBookMark(),
                          if (!isParticipant)
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

class ProfileListCard extends StatelessWidget {
  const ProfileListCard({
    super.key,
    required this.width,
    required this.userId,
  });

  final double width;
  final String userId;

  @override
  Widget build(BuildContext context) {
    UserApiOut? userInfo;
    Future<MemoryImage?> photo =
        UserInfoManager.instance.getUserInfo(userId).then((info) {
      userInfo = info;
      if (info.avatar != null) {
        return PhotoManager.instance.getThumbnail(info.avatar!.url);
      }
      return null;
    });

    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        FutureBuilder(
          future: photo,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            var name = "<name>";
            ImageProvider thumbnail = AssetImages.avatarLoading;

            // if photo was fetched, so was the user data
            if (snapshot.hasData) {
              name = userInfo!.displayName;

              if (snapshot.data != null) {
                thumbnail = snapshot.data;
              } else {
                thumbnail = AssetImages.avatarEmpty;
              }
            }

            return Row(children: [
              const Padding(padding: EdgeInsets.only(left: 10, top: 60)),
              CircleAvatar(backgroundImage: thumbnail, radius: 15),
              const SizedBox(
                width: 10,
              ),
              MediumText(
                text: name,
                width: width,
              ),
            ]);
          },
        ),
        Row(
          children: [
            AppIcons.chat,
            const Icon(AppIcons.close),
          ],
        )
      ]),
    ]);
  }
}

class CardParticipantLimits extends StatelessWidget {
  const CardParticipantLimits({
    super.key,
    required this.min,
    required this.max,
  });

  final int min;
  final int max;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 9.0),
      child: Column(
        children: [const Icon(AppIcons.person), SmallText(text: "$min - $max")],
      ),
    );
  }
}

class CardVisibility extends StatelessWidget {
  const CardVisibility({
    super.key,
    required this.visibility,
  });

  final OfferVisibility visibility;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: visibility == OfferVisibility.public
          ? [const Icon(AppIcons.public), const SmallText(text: "Öffentlich")]
          : [const Icon(AppIcons.lock), const SmallText(text: "Freunde")],
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
      children: [const Icon(AppIcons.schedule), SmallText(text: time)],
    );
  }
}

class CardTimeFlexible extends StatelessWidget {
  const CardTimeFlexible({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(children: [
          Icon(AppIcons.event),
          Text("+"),
          Icon(AppIcons.schedule)
        ]),
        SmallText(text: "Flexibel")
      ],
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
        const Icon(AppIcons.event),
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
