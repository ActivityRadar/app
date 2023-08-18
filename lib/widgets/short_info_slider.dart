import 'package:app/constants/constants.dart';
import 'package:app/constants/design.dart';
import 'package:app/model/functions.dart';
import 'package:app/model/generated.dart';
import 'package:app/provider/photos.dart';
import 'package:app/widgets/custom_text.dart';
import 'package:app/screens/details_screen.dart';
import 'package:app/screens/map.dart';
import 'package:app/widgets/vote.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ShortInfoBox extends StatelessWidget {
  const ShortInfoBox({
    super.key,
    required this.info,
    required this.onPressed,
  });

  final LocationDetailedApi? info;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final height = constraints.maxHeight;
      final width = constraints.maxWidth;
      print("$height, $width");

      final thumbnailDiameter = height;
      final infoWidth = width - height;

      late Future thumbnail;
      if (info == null || info!.photos.isEmpty) {
        thumbnail = Future.value(AssetImages.locationEmpty);
      } else {
        thumbnail = PhotoManager.instance.getThumbnail(info!.photos[0].url);
      }
      return GestureDetector(
        onTap: onPressed,
        child: FittedBox(
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            borderRadius: BorderRadius.circular(25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  width: thumbnailDiameter,
                  height: thumbnailDiameter,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24.0),
                    child: FutureBuilder(
                      future: thumbnail,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return Image(
                            fit: BoxFit.fill,
                            image: snapshot.data,
                          );
                        } else {
                          return const Image(
                              fit: BoxFit.fill,
                              image: AssetImages.locationLoading);
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(
                    height: height,
                    width: infoWidth,
                    child: InfoContainer(info: info))
              ],
            ),
          ),
        ),
      );
    });
  }
}

class InfoContainer extends StatelessWidget {
  const InfoContainer({
    super.key,
    required this.info,
  });

  final LocationDetailedApi? info;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    double width = size.width;
    var count, avg, title;
    if (info != null) {
      count = info!.reviews.count;
      avg = info!.reviews.averageRating;
      title = getTitle(info!);
    } else {
      count = null;
      avg = null;
      title = "action";
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Spacer(),
            Flexible(
              child: RatingSummary(count: count, average: avg),
            ),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.favorite,
                  color: DesignColors.naviColor,
                )),
          ],
        ),
        Flexible(
          child: Text(
            title,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: width * 0.05),
          ),
        ),
        Spacer(),
        LittleText(text: "Bar - 2 km entfernt", width: width),
      ],
    );
  }
}

class ShortInfoSlider extends StatefulWidget {
  const ShortInfoSlider(
      {super.key,
      required this.infos,
      required this.indexNotifier,
      required this.locationNotifier});

  final List<LocationDetailedApi> infos;
  final ValueNotifier<int> indexNotifier;
  final FocusedLocationNotifier locationNotifier;

  @override
  State<ShortInfoSlider> createState() => _ShortInfoSliderState();
}

class _ShortInfoSliderState extends State<ShortInfoSlider> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  late List<Widget> _boxes;

  void onIndexChange() {
    // make animations between pages, that are further away, longer
    final duration = 300 + 70 * (widget.indexNotifier.value - _current).abs();
    _controller.animateToPage(widget.indexNotifier.value,
        duration: Duration(milliseconds: duration), curve: Curves.easeInOut);
  }

  @override
  void initState() {
    super.initState();

    _boxes = widget.infos
        .map((info) => ShortInfoBox(
              info: info,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsScreen(locationInfo: info),
                  ),
                );
              },
            ))
        .toList();

    widget.indexNotifier.addListener(onIndexChange);
  }

  @override
  void dispose() {
    widget.indexNotifier.removeListener(onIndexChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    final verticalSpace = height / 6;
    final horizontalSpace = size.width;
    const viewportFraction = 0.8;

    return CarouselSlider(
      // key: UniqueKey(),
      items: _boxes
          .map((b) => SizedBox(
                height: verticalSpace,
                width: horizontalSpace * 0.9,
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: b),
              ))
          .toList(),
      carouselController: _controller,
      options: CarouselOptions(
        initialPage: _current,
        // ratio between width and height
        aspectRatio: horizontalSpace / verticalSpace * 1 / viewportFraction,
        // how much space does the focused box take
        viewportFraction: viewportFraction,
        scrollDirection: Axis.horizontal,
        enableInfiniteScroll: false,
        // enlargeCenterPage: true,
        // enlargeFactor: 0.3,
        onPageChanged: (position, reason) {
          print(reason);
          setState(() {
            _current = position;
            if (reason != CarouselPageChangedReason.controller) {
              widget.locationNotifier.setFocused(
                  info: fromDetailed(widget.infos[position]),
                  changedBy: FocusChangeReason.slider);
            }
          });
        },
      ),
    );
  }
}
