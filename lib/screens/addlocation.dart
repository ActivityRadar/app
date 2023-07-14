import 'package:app/constants/contants.dart';
import 'package:app/widgets/activityType_short.dart';
import 'package:flutter/material.dart';
import 'package:app/widgets/body_details_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:app/widgets/vote.dart';

class AddLocation extends StatefulWidget {
  const AddLocation({super.key});
  @override
  State<AddLocation> createState() => _AddLocation();
}

class _AddLocation extends State<AddLocation> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    double width = size.width;
    int _current = 0;
    CarouselController _controller = CarouselController();
    return Scaffold(
        backgroundColor: DesignColors.kBackgroundColor,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(25.0),
                ),
              ),
              shadowColor: DesignColors.kBackgroundColor,
              actions: [
                IconButton(
                  icon: const Icon(Icons.filter_alt),
                  onPressed: () {
                    print("LOLO");
                  },
                ),
              ],
              pinned: true,
              stretch: true,
              expandedHeight: 240.0,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  'Tischtennis',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: width * 0.06),
                ),
                background: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    CarouselSlider(
                      carouselController: _controller,
                      options: CarouselOptions(
                        reverse: false,
                        onPageChanged: (position, reason) {
                          setState(() {
                            _current = position;
                          });
                        },
                      ),
                      items: images.map<Widget>((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(i))));
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 9.0, top: 5.0),
                          child: Text(
                            "10963 Berlin",
                            style: TextStyle(
                                color: Color.fromARGB(88, 91, 91, 91),
                                fontSize: 15),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 9.0),
                          child: Text(
                            "Park",
                            style: TextStyle(
                                color: Color.fromARGB(88, 91, 91, 91),
                                fontSize: 15),
                          ),
                        )
                      ],
                    ),
                    vote_rate_small(),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 9.0, top: 30.0),
                  child: Text(
                    "description",
                    style: TextStyle(
                        color: const Color.fromARGB(182, 0, 0, 0),
                        fontWeight: FontWeight.bold,
                        fontSize: width * 0.05),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 9.0, top: 10.0),
                  child: Text(
                    "Parasdasdasdbasdbsdasjdkjsadhlasjdlasjdlkasjdlkjsadllasjdlkasjdlkjsadlkajsdlkajsdlkjk",
                    style: TextStyle(
                        color: const Color.fromARGB(182, 0, 0, 0),
                        fontSize: width * 0.04),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 9.0, top: 15.0),
                  child: Text(
                    "activityType",
                    style: TextStyle(
                        color: const Color.fromARGB(182, 0, 0, 0),
                        fontWeight: FontWeight.bold,
                        fontSize: width * 0.05),
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
                                "https://cdn.pixabay.com/photo/2016/09/05/23/28/blue-1648005_960_720.jpg",
                            lat: 13.4496164,
                            long: 52.5317128,
                            titel: "Tischtennis",
                            press: () {},
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 9.0, top: 15.0),
                  child: Text(
                    "activityType",
                    style: TextStyle(
                        color: const Color.fromARGB(182, 0, 0, 0),
                        fontWeight: FontWeight.bold,
                        fontSize: width * 0.05),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  height: height / 7,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      const SizedBox(width: 10.0),
                      ReviewContainer(
                        imageurl:
                            "https://cdn.pixabay.com/photo/2016/09/05/23/28/blue-1648005_960_720.jpg",
                        lat: 13.4496164,
                        long: 52.5317128,
                        titel: "Tischtennis",
                        press: () {},
                      ),
                    ],
                  ),
                )
              ]),
            ),
          ],
        ));
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
        title: const Text('AddLocation'),
        backgroundColor: Color.fromARGB(255, 217, 4, 4),
        elevation: 0,
        leading: IconButton(
            icon: const Icon(Icons.keyboard_backspace),
            color: DesignColors.kBackgroundColor,
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.ios_share),
            color: DesignColors.kBackgroundColor,
          ),
        ]);
  }
}
