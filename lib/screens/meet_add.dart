import 'package:app/constants/design.dart';
import 'package:app/widgets/custom/appbar.dart';
import 'package:app/model/functions.dart';
import 'package:app/model/generated.dart';
import 'package:app/provider/activity_type.dart';
import 'package:app/provider/generated/offers_provider.dart';
import 'package:app/screens/map.dart';
import 'package:app/widgets/activityType_short.dart';
import 'package:app/widgets/custom/card.dart';
import 'package:app/widgets/custom/snackbar.dart';
import 'package:app/widgets/custom_text.dart';
import 'package:app/widgets/custom/button.dart';
import 'package:app/widgets/custom/textfield.dart';
import 'package:app/widgets/gps.dart';
import 'package:app/widgets/timepicker.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class MeetAddScreen extends StatefulWidget {
  const MeetAddScreen({Key? key}) : super(key: key);

  @override
  State<MeetAddScreen> createState() => _MeetAddScreenState();
}

class _MeetAddScreenState extends State<MeetAddScreen> {
  PageController pageController = PageController();
  int _currentPage = 0;

  final _formTitleKey = GlobalKey<FormState>();
  TextEditingController typeSearchController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isLoading = false;

  ValueNotifier<bool> visibilityFriends = ValueNotifier<bool>(false);
  ValueNotifier<bool> timeFlexible = ValueNotifier<bool>(false);
  ValueNotifier<DateTime> dateTime = ValueNotifier<DateTime>(DateTime.now());
  ValueNotifier<RangeValues> participantNumberRange =
      ValueNotifier<RangeValues>(const RangeValues(1, 2));
  ValueNotifier<LatLng?> customLocation = ValueNotifier<LatLng?>(null);

  // location selection map
  final FocusedLocationNotifier locNotifier = FocusedLocationNotifier();
  late final ValueNotifier<String> activity = ValueNotifier<String>("soccer");
  final GpsLocationNotifier currentPosition = GpsLocationNotifier();
  late final ActivityMarkerMap map;

  List<String> chosenActivities = [];
  List<String> availableActivities =
      ActivityManager.instance.getAllDisplayTypes();

  late final List<Widget Function(ValueNotifier<bool>)> pagesFunctions;

  // validators
  late final List<ValueNotifier<bool>> validatorNotifiers;

  void previousPage() {
    pageController.previousPage(
        duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
    setState(() {
      _currentPage--;
    });
  }

  void nextPage() {
    pageController.nextPage(
        duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
    setState(() {
      _currentPage++;
    });
    FocusScope.of(context).unfocus();
  }

  @override
  void initState() {
    super.initState();

    map = ActivityMarkerMap(
        key: UniqueKey(),
        focusedLocation: locNotifier,
        activity: activity,
        currentPosition: currentPosition,
        onNewMarkerCreate: (LatLng position) {
          customLocation.value = position;
        });

    pagesFunctions = [
      chooseActivity,
      chooseTime,
      chooseParticipantNumber,
      choosePlace,
      addDescription,
      chooseVisibility,
      submitPage
    ];

    // has to be in the correct order according to the pagesFunctions list
    final defaultSkippable = [false, true, true, false, false, true, false];

    validatorNotifiers =
        defaultSkippable.map((b) => ValueNotifier<bool>(b)).toList();
  }

  @override
  Widget build(BuildContext context) {
    Padding previous = Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: CustomElevatedButton(onPressed: previousPage, text: "Previous"),
    );

    Padding next = Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: ValueListenableBuilder(
            valueListenable: validatorNotifiers[_currentPage],
            builder: (context, canContinue, child) {
              var onPressed = nextPage;
              var style = null;
              if (!canContinue) {
                style = ElevatedButton.styleFrom(backgroundColor: Colors.grey);
                onPressed = () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const AlertDialog(
                            title: Text("Can't continue"),
                            content: Text(
                                "You cant continue as you need to enter input on this page!"));
                      });
                };
              }
              return CustomElevatedButton(
                  style: style, onPressed: onPressed, text: "Next");
            }));

    return Scaffold(
        appBar: CustomAppBar(
          context,
          () {
            Navigator.pop(context);
          },
        ),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: pagesFunctions
              .asMap()
              .entries
              .map((entry) => entry.value.call(validatorNotifiers[entry.key]))
              .toList(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 60.0),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                if (_currentPage != 0) previous,
                const Spacer(),
                if (_currentPage < pagesFunctions.length - 1) next
              ]),
            )));
  }

  Center chooseActivity(ValueNotifier<bool> canContinue) {
    var size = MediaQuery.of(context).size;

    double width = size.width;

    CustomCard scrollableSelectionCard(Widget child) {
      return CustomCard(
          child: ConstrainedBox(
              constraints: BoxConstraints(
                  minHeight: 50, maxHeight: 120, minWidth: width),
              child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [child]))));
    }

    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      TitleText(text: "Was willst du spielen?", width: width),
      const SizedBox(
        height: 20,
      ),
      scrollableSelectionCard(
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          spacing: 5.0,
          children: chosenActivities.map((exercise) {
            return ActivityChip(
              type: exercise,
              onPressed: () {
                setState(() {
                  chosenActivities.remove(exercise);
                  availableActivities.add(exercise);
                  canContinue.value = chosenActivities.isNotEmpty;
                });
              },
            );
          }).toList(),
        ),
      ),
      CustomTextField(
          streetController: typeSearchController, label: "Suche Aktivität"),
      scrollableSelectionCard(
        ValueListenableBuilder(
          valueListenable: typeSearchController,
          builder: (context, search, child) {
            var available = availableActivities.toList();
            if (search.text.isNotEmpty) {
              available = ActivityManager.instance
                  .searchInSelection(search.text, available);
            }

            return Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.center,
                spacing: 5.0,
                children: available.map((exercise) {
                  return ActivityChip(
                    type: exercise,
                    backgroundColor: Colors.grey,
                    onPressed: () {
                      setState(() {
                        chosenActivities.add(exercise);
                        availableActivities.remove(exercise);
                        canContinue.value = chosenActivities.isNotEmpty;
                      });
                    },
                  );
                }).toList());
          },
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      const InfoText(
        text:
            "Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin",
      ),
    ]));
  }

  Center chooseTime(ValueNotifier<bool> canContinue) {
    var size = MediaQuery.of(context).size;

    double width = size.width;
    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      TitleText(text: "Wann willst du spielen?", width: width),
      const SizedBox(
        height: 20,
      ),
      CustomCard(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomSwitch(
                switchNotifier: timeFlexible,
                textLeft: "Spezifische Zeit",
                textRight: "Flexibel"),
            ValueListenableBuilder(
                valueListenable: timeFlexible,
                builder: (context, flexible, child) {
                  if (flexible) {
                    return Container();
                  } else {
                    return DateTimePicker(notifier: dateTime);
                  }
                })
          ],
        ),
      ),
      const SizedBox(
        height: 20,
      ),
    ]));
  }

  WillPopScope choosePlace(ValueNotifier<bool> canContinue) {
    var size = MediaQuery.of(context).size;

    locNotifier.addListener(() {
      setState(() {
        canContinue.value = !(locNotifier.changedBy == FocusChangeReason.back);
      });
    });

    double width = size.width;

    return WillPopScope(
        onWillPop: () async {
          if (locNotifier.changedBy != FocusChangeReason.back) {
            locNotifier.setFocused(
                info: null, changedBy: FocusChangeReason.back);
            return false;
          }
          return true;
        },
        child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          TitleText(text: "Wo willst du spielen?", width: width),
          const SizedBox(
            height: 20,
          ),
          Flexible(child: map),
        ])));
  }

  Center chooseParticipantNumber(ValueNotifier<bool> canContinue) {
    var size = MediaQuery.of(context).size;

    double width = size.width;
    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      TitleText(text: "Wie viele Mitspielende brauchst du?", width: width),
      const SizedBox(
        height: 20,
      ),
      CustomCard(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: "mindestes"),
                CustomText(text: "maximal")
              ],
            ),
            RangeSliderExample(notifier: participantNumberRange),
          ],
        ),
      ),
      const SizedBox(
        height: 20,
      ),
    ]));
  }

  Center addDescription(ValueNotifier<bool> canContinue) {
    var size = MediaQuery.of(context).size;

    void checkTextEmpty() {
      canContinue.value = descriptionController.text.isNotEmpty &&
          titleController.text.isNotEmpty;
    }

    titleController.addListener(() {
      checkTextEmpty();
    });

    descriptionController.addListener(() {
      checkTextEmpty();
    });

    double width = size.width;
    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      TitleText(text: "Füge eine kurze Beschreibung hinzu", width: width),
      const SizedBox(
        height: 20,
      ),
      CustomCard(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.only(left: 9.0, top: 15.0),
                child: CustomTextField(
                    controller: titleController, label: 'Titel')),
            Padding(
              padding: const EdgeInsets.only(left: 9.0, top: 15.0),
              child: DescriptionTextFieldwithoutBorder(
                nameController: descriptionController,
                label: 'Description',
              ),
            ),
          ],
        ),
      ),
      const SizedBox(
        height: 20,
      ),
    ]));
  }

  Center chooseVisibility(ValueNotifier<bool> canContinue) {
    var size = MediaQuery.of(context).size;
    double width = size.width;

    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      TitleText(text: "Für wen soll das Angebot sichtbar sein?", width: width),
      const SizedBox(
        height: 20,
      ),
      CustomCard(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              width: width,
              child: CustomSwitch(
                  switchNotifier: visibilityFriends,
                  textLeft: "Öffentlich",
                  textRight: "Nur Freunde"),
            )
          ],
        ),
      ),
      const SizedBox(
        height: 20,
      ),
    ]));
  }

  Center submitPage(ValueNotifier<bool> canContinue) {
    var size = MediaQuery.of(context).size;
    double width = size.width;

    Widget summaryRow(String key, String value, {bool spacer = true}) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              MediumText(text: "$key: ", width: width),
              const SizedBox(width: 8),
              Expanded(
                child: Text(value, softWrap: true),
              )
            ]),
            const SizedBox(height: 10)
          ],
        ),
      );
    }

    final range = participantNumberRange.value;

    final rows = [
      summaryRow(
          "Activity Type(s)",
          chosenActivities.fold("", (t, sport) {
            return t.isEmpty ? sport.toString() : "$t, ${sport.toString()}";
          })),
      summaryRow("Time",
          timeFlexible.value ? "flexible" : dateTime.value.toIso8601String()),
      summaryRow(
          "Participants",
          range.start == range.end
              ? "${range.start.toInt()}"
              : "${range.start.toInt()} - ${range.end.toInt()}"),
      summaryRow("Location", "53.909123; 13.1290839"),
      summaryRow("Visibility", visibilityFriends.value ? "friends" : "public"),
      summaryRow("Description", descriptionController.text, spacer: true),
    ];

    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      TitleText(text: "Zusammenfassung", width: width),
      const SizedBox(
        height: 20,
      ),
      ...rows,
      const SizedBox(height: 20),
      CustomElevatedButton(
          onPressed: () {
            submitMeetingOffer()
                .then((offerId) => Navigator.pop(context))
                .onError((error, stackTrace) => showMessageSnackBar(
                    context, "Something went wrong: $error",
                    fixed: true));
          },
          text: "Submit")
    ]));
  }

  Future<String> submitMeetingOffer() async {
    late final Map<String, dynamic> location;
    late final Map<String, dynamic> time;

    if (locNotifier.changedBy == FocusChangeReason.markerTap) {
      location = {
        "coords": locNotifier.info!.location.toJson(),
        "id": locNotifier.info!.id.toString()
      };
    } else {
      final coords = toLongLat(customLocation.value!).toJson();
      location = {"coords": coords, "radius": 2000};
    }

    if (timeFlexible.value) {
      time = OfferTimeFlexible(type: "flexible").toJson();
    } else {
      time = OfferTimeSingle(type: "single", times: [
        dateTime.value,
        dateTime.value.add(const Duration(hours: 2)),
      ]).toJson();
    }

    final offer = OfferIn(
        location: location,
        activity: chosenActivities,
        time: time,
        description: descriptionController.text,
        visibility: OfferVisibility.public);

    final response = await OffersProvider.createOffer(data: offer);
    return response.offerId;
  }
}

class RangeSliderExample extends StatefulWidget {
  const RangeSliderExample({super.key, this.notifier});

  final ValueNotifier<RangeValues>? notifier;

  @override
  State<RangeSliderExample> createState() => _RangeSliderExampleState();
}

class _RangeSliderExampleState extends State<RangeSliderExample> {
  late RangeValues _currentRangeValues;

  @override
  void initState() {
    super.initState();
    _currentRangeValues = widget.notifier?.value ?? const RangeValues(1, 2);
  }

  @override
  Widget build(BuildContext context) {
    return RangeSlider(
      activeColor: DesignColors.rangeactive,
      inactiveColor: DesignColors.inactive,
      values: _currentRangeValues,
      min: 1,
      max: 30,
      divisions: 29,
      labels: RangeLabels(
        _currentRangeValues.start.round().toString(),
        _currentRangeValues.end.round().toString(),
      ),
      onChanged: (RangeValues values) {
        setState(() {
          _currentRangeValues = values;
        });

        widget.notifier?.value = values;
      },
    );
  }
}

class CustomSwitch extends StatefulWidget {
  const CustomSwitch(
      {super.key,
      this.switchNotifier,
      required this.textLeft,
      required this.textRight});

  final ValueNotifier<bool>? switchNotifier;
  final String textLeft;
  final String textRight;

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  late bool _isSwitched;

  @override
  void initState() {
    super.initState();
    _isSwitched = widget.switchNotifier?.value ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SystemText(text: widget.textLeft),
        Switch(
          value: _isSwitched,
          onChanged: (value) {
            widget.switchNotifier?.value = value;
            setState(() {
              _isSwitched = value;
            });
          },
        ),
        SystemText(text: widget.textRight),
      ],
    );
  }
}
