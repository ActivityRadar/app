import 'package:app/constants/design.dart';
import 'package:app/widgets/custom/background.dart';
import 'package:flutter/material.dart';

class MeetUpMoreScreen extends StatelessWidget {
  const MeetUpMoreScreen({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

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
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 9.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //inhalt
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ]),
        )
      ]),
    ));
  }
}
