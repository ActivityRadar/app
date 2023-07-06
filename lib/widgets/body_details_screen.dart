import 'package:app/constants/contants.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
    return Column(
      children: [
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
                child: imagesSlider(context),
              ),
            ],
          ),
        )
      ],
    );
  }

  Stack imagesSlider(BuildContext context) {
    int _current = 0;
    CarouselController _controller = CarouselController();

    return Stack(
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
                        image: DecorationImage(image: NetworkImage(i))));
              },
            );
          }).toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: images.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 12.0,
                height: 12.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black)
                        .withOpacity(_current == entry.key ? 0.9 : 0.4)),
              ),
            );
          }).toList(),
        )
      ],
    );
  }
}

List<String> images = [
  "https://cdn.pixabay.com/photo/2023/05/15/09/18/iceberg-7994536_960_720.jpg",
  "https://cdn.pixabay.com/photo/2023/04/30/11/44/spring-7960360_960_720.jpg",
  "https://cdn.pixabay.com/photo/2023/04/23/22/02/bird-7946807_960_720.jpg"
];
