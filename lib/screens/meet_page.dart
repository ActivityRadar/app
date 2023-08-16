import 'package:app/constants/constants.dart';
import 'package:app/constants/design.dart';
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
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
            expandedHeight: expandedHeight,
            collapsedHeight: collapsedHeight,
            flexibleSpace: FlexibleSpaceBar(
              background: SizedBox(
                height: 100,
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppStyle
                          .cornerRadius), // Radius der abgerundeten Ecken
                    ),
                    child: Stack(children: [
                      const MeetMap(),
                      Positioned(
                          bottom:
                              0, // Positioniert den Container am unteren Rand
                          left: 0,
                          right: 0,
                          child: Container(
                              alignment: Alignment.bottomCenter,
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 12.0),
                                    child: CustomChip(
                                      text: "Table Tennis",
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 12.0),
                                    child: CustomChip(text: "ab 14 Uhr"),
                                  )
                                ],
                              ))),
                    ])),
              ),
            ),
            actions: const [MeetPopupMenuCard()],
            iconTheme: const IconThemeData(
              color: DesignColors.naviColor,
            )),
        SliverList(
          delegate: SliverChildListDelegate([
            Column(
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
                  Padding(
                      padding: const EdgeInsets.only(left: 9.0, top: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TitleText(text: "Time", width: width),
                          TitleText(text: '11:00', width: width),
                        ],
                      )),
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
                ]),
          ]),
        )
      ]),
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
