import 'package:app/constants/constants.dart';
import 'package:app/screens/meet_page.dart';
import 'package:app/widgets/custom/chip.dart';
import 'package:app/widgets/custom_text.dart';
import 'package:app/widgets/meet_map.dart';
import 'package:app/constants/design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NewsList extends StatelessWidget {
  const NewsList({super.key, required this.width, required this.height});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [NewsCard(), NewsCard(), NewsCard()],
      ),
    );
  }
}

class NewsCard extends StatelessWidget {
  const NewsCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    double width = size.width;
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MeetPage(),
            ),
          );
        },
        child: SizedBox(
            width: width,
            child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppStyle.cornerRadius),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: height / 6.5,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppStyle
                              .cornerRadius), // Radius der abgerundeten Ecken
                        ),
                        child: Transform.scale(
                          scale: 3.0,
                          child: SvgPicture.asset(
                              "assets/images/background.svg",
                              colorFilter: ColorFilter.mode(
                                  Color.fromARGB(66, 0, 17, 255),
                                  BlendMode.srcIn),
                              semanticsLabel: 'BackgroundDetails Screen'),
                        ),
                      ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(children: [
                            Row(children: [
                              Padding(
                                  padding: EdgeInsets.only(left: 10, top: 60)),
                              CircleAvatar(
                                backgroundImage: AssetImages.avatarEmpty,
                                radius: 20,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              MediumText(
                                text: 'Max Mustermann',
                                width: width,
                              ),
                            ]),
                          ]),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: LittleText(
                                    text: "12h ago",
                                    width: width,
                                  ),
                                )
                              ]),
                        ]),
                  ],
                ))));
  }
}
