import 'package:app/constants/contants.dart';
import 'package:app/widgets/activityType_short.dart';
import 'package:app/widgets/details_short.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:app/widgets/vote.dart';

// ignore_for_file: avoid_print

class BodyDetails extends StatefulWidget {
  const BodyDetails({super.key});
  @override
  State<BodyDetails> createState() => _BodyDetails();
}

class _BodyDetails extends State<BodyDetails> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    int _current = 0;
    CarouselController _controller = CarouselController();

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        decoration: const BoxDecoration(
            color: DesignColors.naviColor,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40))),
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(vertical: kDefaultPadding),
              child: Stack(
                children: <Widget>[
                  CarouselSlider(
                    carouselController: _controller,
                    options: CarouselOptions(
                      height: 200,
                      reverse: false,
                      enlargeFactor: 0.3,
                      onPageChanged: (position, reason) {
                        setState(() {
                          _current = position;
                        });
                      },
                      enableInfiniteScroll: true,
                    ),
                    items: images.map<Widget>((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              decoration: BoxDecoration(
                                  image:
                                      DecorationImage(image: NetworkImage(i))));
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: images.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => _controller.animateToPage(entry.key),
                    child: Container(
                      width: 12.0,
                      height: 12.0,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Colors.white
                                  : Colors.black)
                              .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      const Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 9.0, top: 9.0),
                    child: Text(
                      "Table Tennis",
                      style: TextStyle(
                          color: Color.fromARGB(182, 0, 0, 0),
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 9.0),
                    child: Text(
                      "Park",
                      style: TextStyle(
                          color: Color.fromARGB(182, 0, 0, 0), fontSize: 15),
                    ),
                  )
                ],
              ),
              vote_rate_small(),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 9.0, top: 10.0),
                child: Text(
                  "description",
                  style: TextStyle(
                      color: Color.fromARGB(182, 0, 0, 0),
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 9.0),
                child: Text(
                  "Parasdasdasdbasdbsdasjdkjsadhlasjdlasjdlkasjdlkjsadllasjdlkasjdlkjsadlkajsdlkajsdlkjk",
                  style: TextStyle(
                      color: Color.fromARGB(182, 0, 0, 0), fontSize: 15),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 9.0, top: 10.0),
                child: Text(
                  "address",
                  style: TextStyle(
                      color: Color.fromARGB(182, 0, 0, 0),
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 9.0),
                child: Text(
                  "10963 Berlin",
                  style: TextStyle(
                      color: Color.fromARGB(182, 0, 0, 0), fontSize: 15),
                ),
              ),
            ],
          ),
        ],
      ),
      const Padding(
        padding: EdgeInsets.only(left: 9.0, top: 15.0),
        child: Text(
          "activityType",
          style: TextStyle(
              color: Color.fromARGB(182, 0, 0, 0),
              fontWeight: FontWeight.bold,
              fontSize: 15),
        ),
      ),
      Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: height / 7,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            const SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ActivityDetails(
                imageurl:
                    "https://cdn.pixabay.com/photo/2016/02/18/23/27/table-tennis-1208383_960_720.jpg",
                lat: 13.3086758,
                long: 52.5748306,
                titel: "Tischtennis",
                press: () {},
              ),
            ),
            const SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ActivityDetails(
                imageurl:
                    "https://cdn.pixabay.com/photo/2014/11/29/17/49/playground-550535_960_720.jpg",
                lat: 13.4496164,
                long: 52.5317128,
                titel: "Tischtennis",
                press: () {},
              ),
            ),
            const SizedBox(width: 10.0),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: ActivityDetails(
                  imageurl:
                      "https://cdn.pixabay.com/photo/2016/09/05/23/28/blue-1648005_960_720.jpg",
                  lat: 13.4496164,
                  long: 52.5317128,
                  titel: "Tischtennis",
                  press: () {},
                )),
            const SizedBox(width: 10.0),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: ActivityDetails(
                  imageurl:
                      "https://cdn.pixabay.com/photo/2016/09/05/23/28/blue-1648005_960_720.jpg",
                  lat: 13.4496164,
                  long: 52.5317128,
                  titel: "Tischtennis",
                  press: () {},
                )),
          ],
        ),
      )
    ]);
  }
}

List<String> images = [
  "https://cdn.pixabay.com/photo/2023/05/15/09/18/iceberg-7994536_960_720.jpg",
  "https://cdn.pixabay.com/photo/2023/04/30/11/44/spring-7960360_960_720.jpg",
  "https://cdn.pixabay.com/photo/2023/04/23/22/02/bird-7946807_960_720.jpg"
];