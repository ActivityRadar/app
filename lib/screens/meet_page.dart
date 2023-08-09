import 'package:app/constants/constants.dart';
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
      backgroundColor: Color.fromARGB(255, 245, 245, 245),
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
                      MeetMap(),
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
                                    child: Chip(
                                        label: Text(
                                          "Table Tennis",
                                          style: TextStyle(
                                              color:
                                                  DesignColors.kBackgroundColor,
                                              fontSize: 10),
                                        ),
                                        backgroundColor:
                                            DesignColors.naviColor),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(right: 12.0),
                                      child: Chip(
                                          label: Text(
                                            "ab 14 Uhr",
                                            style: TextStyle(
                                                color: DesignColors
                                                    .kBackgroundColor,
                                                fontSize: 10),
                                          ),
                                          backgroundColor:
                                              DesignColors.naviColor)),
                                ],
                              ))),
                    ])),
              ),
            ),
            actions: [MeetPopupMenuCard()],
            iconTheme: IconThemeData(
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
                            Padding(
                                padding: EdgeInsets.only(left: 10, top: 60)),
                            CircleAvatar(
                              backgroundImage: AssetImage(
                                  'assets/locationPhotoLoadingPlaceholder.jpg'), // Beispielbild
                              radius: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Max Mustermann',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.black54),
                            ),
                          ]),
                        ]),
                        TextButton(
                            onPressed: () {}, child: Text("Anfrage senden")),
                      ]),
                  Padding(
                    padding: const EdgeInsets.only(left: 9.0, top: 10.0),
                    child: Text(
                      "description",
                      style: TextStyle(
                          color: const Color.fromARGB(182, 0, 0, 0),
                          fontWeight: FontWeight.bold,
                          fontSize: width * 0.05),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(9.0),
                    child: Text(
                        'Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin '),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 9.0, top: 10.0),
                    child: Text(
                      "description",
                      style: TextStyle(
                          color: const Color.fromARGB(182, 0, 0, 0),
                          fontWeight: FontWeight.bold,
                          fontSize: width * 0.05),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(9.0),
                    child: Text(
                        'Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin '),
                  ),
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
          child: const Text('Report as inappropriate',
              style: TextStyle(fontSize: 14)),
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
      return AlertDialog(
        title: const Text('Report as inappropriate'),
        content: const Text(
            'Thank you for contributing to the safety and respect of our community. If you believe that this content violates our policies or is inappropriate, please click on Report.   Your message will be treated confidentially and verified by our moderation team. '),
        actions: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Dialog schließen
              },
            ),
            TextButton(
              child: const Text('Send'),
              onPressed: () {
                Navigator.of(context).pop(); // Dialog schließen
              },
            ),
          ])
        ],
      );
    },
  );
}
