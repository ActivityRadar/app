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
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => const MeetPage(),
          //   ),
          // );
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
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(AppStyle
                                    .cornerRadius), // Radius der abgerundeten Ecken
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    AppStyle.cornerRadius),
                                child: Transform.scale(
                                  scale: 8,
                                  child: SvgPicture.asset(
                                      "assets/images/background.svg",
                                      colorFilter: ColorFilter.mode(
                                          Color.fromARGB(66, 0, 17, 255),
                                          BlendMode.srcIn),
                                      semanticsLabel:
                                          'BackgroundDetails Screen'),
                                ),
                              ),
                            ),
                            Center(
                                child: Text(
                              "Tennis",
                              style: TextStyle(
                                  color: DesignColors.kBackground,
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold),
                            )),
                            Center(
                                child: Text(
                              "Tennis",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 26, 255, 0),
                                  fontSize: 45,
                                  fontWeight: FontWeight.bold),
                            )),
                          ],
                        )),
                  ],
                ))));
  }
}
