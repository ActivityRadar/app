import 'package:app/app_state.dart';
import 'package:app/constants/constants.dart';
import 'package:app/constants/design.dart';
import 'package:app/model/functions.dart';
import 'package:app/provider/activity_type.dart';
import 'package:app/model/generated.dart';
import 'package:app/provider/generated/offers_provider.dart';
import 'package:app/provider/meetup_manager.dart';
import 'package:app/provider/photos.dart';
import 'package:app/provider/user_manager.dart';
import 'package:app/widgets/activityType_short.dart';
import 'package:app/widgets/custom/background.dart';

import 'package:app/widgets/custom/alertdialog.dart';

import 'package:app/widgets/custom_text.dart';
import 'package:app/widgets/custom/button.dart';
import 'package:app/widgets/meet_map.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MeetPage extends StatefulWidget {
  const MeetPage({super.key, required this.id});

  final String id;

  @override
  State<MeetPage> createState() => _MeetPageState();
}

class _MeetPageState extends State<MeetPage> {
  late final Future<OfferParsed> offerFuture;

  @override
  void initState() {
    super.initState();

    offerFuture = MeetupManager.instance.updateMeetupInfo(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: offerFuture,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        return buildWhenLoaded(snapshot.data);
      },
    );
  }

  Widget buildWhenLoaded(OfferParsed offer) {
    final state = context.read<AppState>();

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

      timeWidgets = [
        CardDate(date: start),
        CardTime(
          time: formatMeetupTime(start),
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
                  child: Stack(
                    children: [
                      MeetMap(
                          center: toLatLng(isHost
                              ? offer.location_.coords
                              : offer.blurrInfo.center),
                          radius: isHost ? 0.3 : offer.blurrInfo.radius,
                          circleScale: isHost ? 50 : 150),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: Chip(label: Text(offer.status.toString())))
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              MeetPopupMenuCard(
                  isHost: isHost,
                  offer: offer,
                  onChangeCallback: onChangeCallback)
            ],
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

  void onChangeCallback() {
    setState(() {
      offerFuture = MeetupManager.instance.updateMeetupInfo(widget.id);
    });
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
            final result = getNameAndAvatar(snapshot, userInfo);

            return Row(children: [
              const Padding(padding: EdgeInsets.only(left: 10, top: 60)),
              CircleAvatar(backgroundImage: result.image, radius: 15),
              const SizedBox(
                width: 10,
              ),
              MediumText(
                text: result.displayName,
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

class CardDate extends StatelessWidget {
  const CardDate({
    super.key,
    required this.date,
  });

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(AppIcons.event),
        SmallText(
          text: getDateDescription(date),
        )
      ],
    );
  }
}

class CardTime extends StatelessWidget {
  const CardTime({
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

class MeetPopupMenuCard extends StatelessWidget {
  const MeetPopupMenuCard({
    super.key,
    required this.isHost,
    required this.offer,
    required this.onChangeCallback,
  });

  final bool isHost;
  final OfferParsed offer;
  final VoidCallback onChangeCallback;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        if (!isHost)
          PopupMenuItem(
            child: const SystemText(text: 'Report as inappropriate'),
            onTap: () => _showDialog(context),
          ),
        if (isHost) ...[
          PopupMenuItem(
            child: const SystemText(text: 'Angebot löschen'),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                        content: const Text(
                            "Willst du das Angebot wirklich löschen?"),
                        actions: [
                          CustomTextButton(
                              onPressed: () {
                                OffersProvider.deleteOffer(offerId: offer.id)
                                    .then((_) async {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                });
                              },
                              text: "Ja"),
                          CustomTextButton(
                              onPressed: () => Navigator.pop(context),
                              text: "Nein")
                        ]);
                  });
            },
          ),
          if (offer.status == OfferStatus.open)
            PopupMenuItem(
              child: const SystemText(text: 'Angebot schliessen'),
              onTap: () {
                OffersProvider.setOfferStatus(
                        offerId: offer.id, status: OfferStatus.closed)
                    .then((_) async {
                  await MeetupManager.instance.updateMeetupInfo(offer.id);
                  onChangeCallback();
                });
              },
            ),
          if (offer.status == OfferStatus.closed)
            PopupMenuItem(
              child: const SystemText(text: 'Angebot öffnen'),
              onTap: () {
                OffersProvider.setOfferStatus(
                        offerId: offer.id, status: OfferStatus.open)
                    .then((_) async {
                  await MeetupManager.instance.updateMeetupInfo(offer.id);
                  onChangeCallback();
                });
              },
            )
        ],
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
