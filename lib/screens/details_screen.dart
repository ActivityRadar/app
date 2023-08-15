import 'package:app/constants/design.dart';
import 'package:app/widgets/bottomsheet.dart';
import 'package:app/widgets/custom_alertdialog.dart';
import 'package:app/widgets/custom_button.dart';
import 'package:app/widgets/custom_card.dart';
import 'package:app/widgets/custom_textfield.dart';
import 'package:app/widgets/login_reminder.dart';
import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:readmore/readmore.dart';

import 'package:app/constants/constants.dart';
import 'package:app/model/generated.dart';
import 'package:app/provider/backend.dart';
import 'package:app/provider/photos.dart';
import 'package:app/provider/user_manager.dart';
import 'package:app/widgets/activityType_short.dart';
import 'package:app/widgets/photo_picker.dart';
import 'package:app/widgets/vote.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
  late String locationId;

  TextEditingController usernameController = TextEditingController();
  TextEditingController desController = TextEditingController();

  Future<void> _showReviewBottomSheet(BuildContext context) async {
    var rating = 0;
    bottomSheetBase(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 9.0, top: 9.0),
                        child: CustomTextButton(
                            onPressed: () => Navigator.pop(context),
                            text: 'Cancel'),
                      ),
                      const Text(
                        "Review",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      CustomTextButton(
                          onPressed: () => Navigator.pop(context),
                          text: 'Send'),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RatingBar.builder(
                            minRating: 0,
                            direction: Axis.horizontal,
                            allowHalfRating: false,
                            itemCount: 5,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: DesignColors.naviColor,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 9.0, top: 15.0),
                    child: Column(children: [
                      UsernameTextFormField(
                        controller: usernameController,
                        labelText: "Title",
                        validator: (_) => null,
                      ),
                      DescriptionTextFormField(
                        desController: desController,
                        hinText: 'Description',
                      ),
                    ]),
                  ),
                ],
              ));
        });
  }

  @override
  void initState() {
    super.initState();
    locationId = widget.locationId ?? widget.locationInfo!.id;
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

            // fetch the data first, this is not awaited, so it might cause problems...
            UserInfoManager.instance.fetchInfoList([
              ...locInfo.reviews.recent.map((r) => r.userId).toList(),
              ...locInfo.photos.map((p) => p.userId).toList()
            ]).ignore();

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
    conditionalShowLoginReminder(
        context: context,
        loggedInCallback: () => bottomSheetPhotoSourcePicker(
            context: context, mode: "location", locationId: locationId));
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
            RatingSummary(
                count: info.reviews.count, average: info.reviews.averageRating),
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
        Padding(
            padding: const EdgeInsets.only(left: 9.0, top: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Reviews",
                  style: TextStyle(
                      color: const Color.fromARGB(182, 0, 0, 0),
                      fontWeight: FontWeight.bold,
                      fontSize: width * 0.05),
                ),
                Padding(
                    padding: const EdgeInsets.only(
                      right: 9.0,
                    ),
                    child: Row(children: [
                      CustomTextButton(
                          onPressed: () => conditionalShowLoginReminder(
                              context: context,
                              loggedInCallback: () async {
                                _showReviewBottomSheet(context);
                              }),
                          text: "review"),
                      const Icon(Icons.edit_note),
                    ])),
              ],
            )),
        ReviewList(reviews: info.reviews.recent, width: width, height: height)
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

class ReviewList extends StatelessWidget {
  const ReviewList(
      {super.key,
      required this.reviews,
      required this.width,
      required this.height});

  final List<ReviewWithId> reviews;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var review in reviews) ...[
          ReviewBox(review: review),
          ReviewBox(review: review),
          ReviewBox(review: review)
        ]
      ],
    );
  }
}

class ReviewBox extends StatelessWidget {
  const ReviewBox({super.key, required this.review});

  final ReviewWithId review;

  @override
  Widget build(BuildContext context) {
    UserApiOut? userInfo;
    Future<MemoryImage?> photo =
        UserInfoManager.instance.getUserInfo(review.userId).then((info) {
      userInfo = info;
      if (info.avatar != null) {
        return PhotoManager.instance.getThumbnail(info.avatar!.url);
      }
      return null;
    });

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 3.0),
      child: Container(
          child: CustomCard(
              child: Column(
        children: [
          // Name, Profilimage,
          FutureBuilder(
            future: photo,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              ImageProvider? image;
              String username;
              String displayName;

              const double diameter = 50.0;
              if (snapshot.hasData) {
                image = snapshot.data ?? AssetImages.avatarEmpty;
              } else if (snapshot.hasError) {
                print(snapshot.error);
                image = AssetImages.avatarError;
              }

              if (userInfo != null) {
                username = userInfo!.username;
              } else {
                username = review.userId.substring(0, 6).toUpperCase();
              }

              if (userInfo != null) {
                displayName = userInfo!.displayName;
              } else {
                displayName = review.userId.substring(0, 6).toUpperCase();
              }

              image ??= AssetImages.avatarLoading;

              return Column(children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ClipOval(
                          child: Image(
                              image: image,
                              width: diameter,
                              height: diameter,
                              fit: BoxFit.cover)),
                    ),
                    Text("@$displayName"),
                    const Spacer(),
                    Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: RatingScore(score: review.overallRating),
                      ),
                      Text(
                        "${DateTime.now().difference(review.creationDate).inDays} days ago",
                        style: const TextStyle(
                            color: Colors.black38, fontSize: 11),
                      ),
                    ]),
                    const ReviewPopupMenuCard(),
                  ],
                ),
              ]);
            },
          ),

          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 10.0, right: 10.0),
            child: SizedBox(
                width: double.infinity,
                child: ExpandableText(text: review.text)),
          ),
          Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
              child: Row(
                children: [
                  const Text(
                      "X out of Y people found this helpful", // TODO: make dynamic
                      style: TextStyle(color: Colors.grey)),
                  const Spacer(),
                  IconButton(
                      onPressed: () {}, // TODO: send thumbs up
                      icon: const Icon(Icons.thumb_up,
                          color: Color.fromARGB(142, 0, 0, 0))),
                  IconButton(
                      onPressed: () {}, // TODO: send thumbs down
                      icon: const Icon(Icons.thumb_down,
                          color: Color.fromARGB(142, 244, 67, 54))),
                ],
              ))
        ],
      ))),
    );
  }
}

class ExpandableText extends StatelessWidget {
  const ExpandableText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(text,
        trimLines: 3,
        style: const TextStyle(color: Colors.black),
        colorClickableText: Colors.grey,
        trimMode: TrimMode.Line,
        trimCollapsedText: "More",
        trimExpandedText: " Less");
  }
}

class ReviewPopupMenuCard extends StatefulWidget {
  const ReviewPopupMenuCard({super.key});

  @override
  State<ReviewPopupMenuCard> createState() => _ReviewPopupMenuCardState();
}

class _ReviewPopupMenuCardState extends State<ReviewPopupMenuCard> {
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
      return CustomAlertDialog(
          title: 'Report as inappropriate',
          content: Text(
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
