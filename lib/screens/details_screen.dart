import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';

import 'package:app/constants/contants.dart';
import 'package:app/model/generated.dart';
import 'package:app/provider/backend.dart';
import 'package:app/provider/photos.dart';
import 'package:app/widgets/activityType_short.dart';
import 'package:app/widgets/photo_picker.dart';
import 'package:app/widgets/vote.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({
    super.key,
    this.locationId,
    this.locationInfo,
  });

  final String? locationId;
  final LocationDetailedApi? locationInfo;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  Future<LocationDetailedApi>? _data;

  @override
  void initState() {
    super.initState();
    if (widget.locationInfo != null) {
      // no need to wait if we already have the data
      _data = Future<LocationDetailedApi>.value(widget.locationInfo);
    } else {
      _data = LocationService().getDetails(widget.locationId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    double width = size.width;
    int current = 0;
    CarouselController controller = CarouselController();

    return FutureBuilder(
        future: _data,
        builder: (BuildContext context,
            AsyncSnapshot<LocationDetailedApi> snapshot) {
          Widget body;
          Widget? appBar;
          if (snapshot.hasData) {
            final locInfo = snapshot.data!;
            appBar = _appBar(width, controller, current, locInfo);
            body = _contentList(width, height, locInfo);
          } else if (snapshot.hasError) {
            body = Text("Error: ${snapshot.error}");
          } else {
            body = SliverList(
                delegate: SliverChildListDelegate(
                    [const CircularProgressIndicator()]));
          }

          appBar ??= _appBarPlaceHolder(width);

          return Scaffold(
              backgroundColor: DesignColors.kBackgroundColor,
              body: CustomScrollView(
                slivers: <Widget>[appBar, body],
              ));
        });
  }

  void _addPhoto() {
    bottomSheetPhotoSourcePicker(
        context: context, mode: "location", locationId: widget.locationId);
  }

  SliverAppBar _appBarPlaceHolder(double width) {
    return SliverAppBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(25.0),
        ),
      ),
      shadowColor: DesignColors.kBackgroundColor,
      actions: <Widget>[
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.ios_share),
          color: DesignColors.kBackgroundColor,
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.add_a_photo),
          color: DesignColors.kBackgroundColor,
        ),
      ],
      pinned: true,
      stretch: true,
      expandedHeight: 240.0,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          'Loading...',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: width * 0.06),
        ),
        background: const Stack(
          fit: StackFit.expand,
          children: <Widget>[],
        ),
      ),
    );
  }

  SliverAppBar _appBar(double width, CarouselController controller, int current,
      LocationDetailedApi info) {
    return SliverAppBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(25.0),
        ),
      ),
      shadowColor: DesignColors.kBackgroundColor,
      actions: <Widget>[
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.ios_share),
          color: DesignColors.kBackgroundColor,
        ),
        IconButton(
          onPressed: () => _addPhoto(),
          icon: const Icon(Icons.add_a_photo),
          color: DesignColors.kBackgroundColor,
        ),
      ],
      pinned: true,
      stretch: true,
      expandedHeight: 260.0,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          info.name ?? info.activityType,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: width * 0.06),
        ),
        background:
            PhotoSlider(photos: info.photos, onExtraPhotoPress: _addPhoto),
      ),
    );
  }

  SliverList _contentList(
      double width, double height, LocationDetailedApi info) {
    return SliverList(
      delegate: SliverChildListDelegate([
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 9.0, top: 5.0),
                  child: Text(
                    "10963 Berlin",
                    style: TextStyle(
                        color: Color.fromARGB(88, 91, 91, 91), fontSize: 15),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 9.0),
                  child: Text(
                    "Park",
                    style: TextStyle(
                        color: Color.fromARGB(88, 91, 91, 91), fontSize: 15),
                  ),
                )
              ],
            ),
            RatingSummary(count: 0, average: info.averageRating),
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
            "FILLER", // info.tags["description"],
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
      ]),
    );
  }
}

class PhotoSlider extends StatefulWidget {
  const PhotoSlider(
      {super.key, required this.photos, required this.onExtraPhotoPress});

  final List<PhotoInfo> photos;
  final Function onExtraPhotoPress;

  @override
  State<PhotoSlider> createState() => _PhotoSliderState();
}

class _PhotoSliderState extends State<PhotoSlider> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  late List<Widget> imageBoxes;

  @override
  void initState() {
    super.initState();

    imageBoxes = widget.photos.map<Widget>((photo) {
      Future<MemoryImage> futImage = PhotoManager.instance.getPhoto(photo.url);
      return FutureBuilder(
        future: futImage,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          BoxDecoration decoration;
          if (snapshot.hasData) {
            decoration =
                BoxDecoration(image: DecorationImage(image: snapshot.data));
          } else if (snapshot.hasError) {
            decoration = const BoxDecoration(color: Colors.red);
            print(snapshot.error);
          } else {
            decoration = const BoxDecoration(color: Colors.grey);
          }

          return Builder(
            builder: (BuildContext context) {
              return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: decoration);
            },
          );
        },
      );
    }).toList();

    imageBoxes.add(Builder(
        builder: (BuildContext context) => GestureDetector(
              onTap: () => widget.onExtraPhotoPress(),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: const DecoratedBox(
                      decoration: BoxDecoration(color: Colors.grey),
                      child: Icon(Icons.image))),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
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
        items: imageBoxes,
      ),
      Container(
          margin: const EdgeInsets.symmetric(vertical: 2),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            for (int i = 0; i < imageBoxes.length; i++)
              GestureDetector(
                  onTap: () => _controller.animateToPage(i),
                  child: Container(
                    width: 12.0,
                    height: 12.0,
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (Theme.of(context).brightness == Brightness.light
                                ? Colors.white
                                : Colors.black)
                            .withOpacity(_current == i ? 0.9 : 0.4)),
                  ))
          ]))
    ]);
  }
}
          ),
        ]);
  }
}
