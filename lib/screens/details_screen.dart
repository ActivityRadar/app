import 'package:app/constants/design.dart';
import 'package:app/model/functions.dart';
import 'package:app/provider/activity_type.dart';
import 'package:app/provider/generated/locations_provider.dart';
import 'package:app/widgets/activityType_short.dart';
import 'package:app/widgets/bottomsheet.dart';

import 'package:app/widgets/custom/alertdialog.dart';
import 'package:app/widgets/custom/background.dart';
import 'package:app/widgets/custom/button.dart';
import 'package:app/widgets/custom/card.dart';
import 'package:app/widgets/custom_text.dart';
import 'package:app/widgets/login_reminder.dart';
import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:readmore/readmore.dart';

import 'package:app/constants/constants.dart';
import 'package:app/model/generated.dart';
import 'package:app/provider/photos.dart';
import 'package:app/provider/user_manager.dart';

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
  late String locationId;

  @override
  void initState() {
    super.initState();
    locationId = widget.locationId ?? widget.locationInfo!.id;
    if (widget.locationInfo != null) {
      // no need to wait if we already have the data
      _data = Future<LocationDetailedApi>.value(widget.locationInfo);
    } else {
      _data = LocationsProvider.getLocation(locationId: widget.locationId!);
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
            body = SmallText(text: "Error: ${snapshot.error}");
          } else {
            body = SliverList(
                delegate: SliverChildListDelegate(
                    [const CircularProgressIndicator()]));
          }

          appBar ??= _appBarPlaceHolder(width);

          return Scaffold(
              body: BackgroundSVG(
                  children: CustomScrollView(
            slivers: <Widget>[appBar, body],
          )));
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
      shadowColor: DesignColors.kBackground,
      actions: <Widget>[
        IconButton(
          onPressed: () {},
          icon: const Icon(AppIcons.share),
          color: DesignColors.kBackground,
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(AppIcons.addAPhoto),
          color: DesignColors.kBackground,
        ),
      ],
      pinned: true,
      stretch: true,
      expandedHeight: 240.0,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: PageTitleText(
          text: 'Loading...',
          width: width,
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
      actions: <Widget>[
        IconButton(
          onPressed: () {},
          icon: const Icon(AppIcons.share),
          color: DesignColors.kBackground,
        ),
        IconButton(
          onPressed: () => _addPhoto(),
          icon: const Icon(AppIcons.addAPhoto),
          color: DesignColors.kBackground,
        ),
      ],
      pinned: true,
      stretch: true,
      backgroundColor: DesignColors.blue,
      expandedHeight: 220.0,
      flexibleSpace: FlexibleSpaceBar(
          title: PageTitleText(
            text: getTitle(info),
            width: width,
          ),
          background: Stack(children: [
            AssetImages.backgroundAR,
            PhotoSlider(photos: info.photos, onExtraPhotoPress: _addPhoto),
          ])),
    );
  }

  SliverList _contentList(
      double width, double height, LocationDetailedApi info) {
    return SliverList(
      delegate: SliverChildListDelegate([
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(left: 9.0, top: 5.0),
                    child: MediumHintText(
                      text: "10963 Berlin",
                      width: width,
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 9.0),
                  child: MediumHintText(
                    text: "Park",
                    width: width,
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
            child: TitleText(
              text: "Beschreibung",
              width: width,
            )),
        Padding(
            padding: const EdgeInsets.only(left: 9.0, top: 10.0),
            child: MediumText(
              text: info.tags["description"] ?? "Keine Beschreibung vorhanden.",
              width: width,
            )),
        Padding(
            padding: const EdgeInsets.only(left: 9.0, top: 15.0),
            child: TitleText(
              text: "Assoziierte Aktivitäten",
              width: width,
            )),
        ActivityChipSlider(
            activities:
                ActivityManager.instance.getDisplayTypes(info.activityTypes)),
        Padding(
            padding: const EdgeInsets.only(left: 9.0, top: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TitleText(
                  text: "Bewertungen",
                  width: width,
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
                                ReviewWithId? oldReview;
                                LocationsProvider
                                        .getCurrentUserReviewForLocation(
                                            locationId: locationId)
                                    .then((r) {
                                  oldReview = r;
                                }).catchError((error) {
                                  print(error);
                                }).whenComplete(() => reviewBottomSheet(
                                        context: context,
                                        oldReview: oldReview,
                                        locationId: locationId));
                              }),
                          text: "Hinzufügen"),
                      const Icon(AppIcons.editNote),
                    ])),
              ],
            )),
        ReviewList(reviews: info.reviews.recent, width: width, height: height),
        Padding(
            //TODO Verlinkung
            padding: const EdgeInsets.only(left: 9.0, top: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TitleText(
                  text: "Verabredungen",
                  width: width,
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
                                ReviewWithId? oldReview;
                                LocationsProvider
                                        .getCurrentUserReviewForLocation(
                                            locationId: locationId)
                                    .then((r) {
                                  oldReview = r;
                                }).catchError((error) {
                                  print(error);
                                }).whenComplete(() => reviewBottomSheet(
                                        context: context,
                                        oldReview: oldReview,
                                        locationId: locationId));
                              }),
                          text: "Hinzufügen"),
                      const Icon(AppIcons.editNote),
                    ])),
              ],
            )),
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
                      child: Icon(AppIcons.image))),
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
          enableInfiniteScroll: false,
        ),
        items: imageBoxes,
      ),
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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (var review in reviews) ...[
            ReviewBox(review: review),
            ReviewBox(review: review),
            ReviewBox(review: review)
          ]
        ],
      ),
    );
  }
}

class ReviewBox extends StatelessWidget {
  const ReviewBox({super.key, required this.review});

  final ReviewWithId review;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final width = size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 3.0),
      child: SizedBox(
          width: width,
          child: CustomCard(
              child: Column(
            children: [
              ReviewMetaInfo(
                review: review,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 8.0, left: 10.0, right: 10.0),
                child: SizedBox(
                    width: double.infinity,
                    child: ExpandableText(text: review.description.text)),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 10.0),
                  child: ReviewFeeback(width: width))
            ],
          ))),
    );
  }
}

class ReviewFeeback extends StatelessWidget {
  const ReviewFeeback({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MediumHintText(
          text: "X von Y Nutzern fanden das hilfreich", // TODO: make dynamic
          width: width,
        ),
        const Spacer(),
        IconButton(
            onPressed: () {}, // TODO: send thumbs up
            icon: const Icon(AppIcons.thumbUp,
                color: Color.fromARGB(142, 0, 0, 0))),
        IconButton(
            onPressed: () {}, // TODO: send thumbs down
            icon: const Icon(AppIcons.thumbDown,
                color: Color.fromARGB(142, 244, 67, 54))),
      ],
    );
  }
}

class ReviewMetaInfo extends StatelessWidget {
  const ReviewMetaInfo({
    super.key,
    required this.review,
  });

  final ReviewWithId review;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double width = size.width;

    UserApiOut? userInfo;
    Future<MemoryImage?> photo =
        UserInfoManager.instance.getUserInfo(review.userId).then((info) {
      userInfo = info;
      if (info.avatar != null) {
        return PhotoManager.instance.getThumbnail(info.avatar!.url);
      }
      return null;
    });

    return FutureBuilder(
      future: photo,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        final result = getNameAndAvatar(snapshot, userInfo);

        return Column(mainAxisSize: MainAxisSize.min, children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: CircleAvatar(backgroundImage: result.image, radius: 25),
              ),
              UserText(displayName: result.displayName, width: width),
              const Spacer(),
              Column(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: RatingScore(score: review.overallRating),
                ),
                LittleText(
                    text:
                        "Vor ${DateTime.now().difference(review.creationDate).inDays} Tagen",
                    width: width)
              ]),
              const ReviewPopupMenuCard(),
            ],
          ),
        ]);
      },
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
        style: const TextStyle(color: Colors.black87),
        colorClickableText: Colors.grey,
        trimMode: TrimMode.Line,
        trimCollapsedText: "Mehr",
        trimExpandedText: " Weniger");
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
          child: const SystemText(
            text: 'Report as inappropriate',
          ),
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
          content: const SystemText(
            text:
                'Thank you for contributing to the safety and respect of our community. If you believe that this content violates our policies or is inappropriate, please click on Report.   Your message will be treated confidentially and verified by our moderation team. ',
          ),
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
