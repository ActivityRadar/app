import 'package:app/constants/constants.dart';
import 'package:app/constants/design.dart';
import 'package:app/widgets/custom/appbar.dart';
import 'package:app/widgets/custom/card.dart';
import 'package:app/widgets/custom/list_tile.dart';
import 'package:app/widgets/custom_text.dart';
import 'package:app/widgets/custom/button.dart';
import 'package:app/widgets/custom/textfield.dart';
import 'package:app/widgets/timepicker.dart';
import 'package:flutter/material.dart';

class MeetAddScreen extends StatefulWidget {
  const MeetAddScreen({Key? key}) : super(key: key);

  @override
  State<MeetAddScreen> createState() => _MeetAddScreenState();
}

class _MeetAddScreenState extends State<MeetAddScreen> {
  PageController pageController = PageController();
  int _currentPage = 0;

  final _formTitleKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isLoading = false;

  ValueNotifier<bool> visibilityFriends = ValueNotifier<bool>(false);
  ValueNotifier<bool> timeFlexible = ValueNotifier<bool>(false);
  ValueNotifier<DateTime> dateTime = ValueNotifier<DateTime>(DateTime.now());
  ValueNotifier<RangeValues> participantNumberRange =
      ValueNotifier<RangeValues>(const RangeValues(1, 2));
  Set<Sport> chosenActivities = <Sport>{};

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
  }

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      chooseActivity(),
      chooseTime(),
      chooseParticipantNumber(),
      choosePlace(),
      addDescription(),
      chooseVisibility(),
      submitPage()
    ];

    Align previous = Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 60.0),
          child:
              CustomElevatedButton(onPressed: previousPage, text: "Previous"),
        ));
    Align next = Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 60.0),
          child: CustomElevatedButton(onPressed: nextPage, text: "Next"),
        ));

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
          children: pages,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: _currentPage == 0
            ? next
            : (_currentPage < pages.length - 1
                ? Stack(children: [previous, next])
                : previous));
  }

  Center chooseActivity() {
    var size = MediaQuery.of(context).size;

    double width = size.width;
    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      TitleText(text: "Was willst du spielen?", width: width),
      const SizedBox(
        height: 20,
      ),
      CustomCard(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.center,
              spacing: 5.0,
              children: Sport.values.map((Sport exercise) {
                return FilterChip(
                  label: CustomText(text: exercise.name),
                  selected: chosenActivities.contains(exercise),
                  selectedColor: DesignColors.naviColor,
                  showCheckmark: false,
                  onSelected: (bool selected) {
                    setState(() {
                      if (selected) {
                        chosenActivities.add(exercise);
                      } else {
                        chosenActivities.remove(exercise);
                      }
                    });
                  },
                );
              }).toList(),
            ),
          ],
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

  Center chooseTime() {
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

  Center choosePlace() {
    var size = MediaQuery.of(context).size;

    double width = size.width;
    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      TitleText(text: "Wo willst du spielen?", width: width),
      const SizedBox(
        height: 20,
      ),
      CustomListTile(
        onPressed: () {},
        text: "Pick Location",
      ),
      const SizedBox(
        height: 20,
      ),
    ]));
  }

  Center chooseParticipantNumber() {
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

  Center addDescription() {
    var size = MediaQuery.of(context).size;

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
                    controller: nameController, label: 'Titel')),
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

  Center chooseVisibility() {
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

  Center submitPage() {
    var size = MediaQuery.of(context).size;
    double width = size.width;

    Widget summaryRow(String key, String value, {bool spacer = true}) {
      return Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            MediumText(text: "$key: ", width: width),
            SmallText(text: value)
          ]),
          const SizedBox(height: 10)
        ],
      );
    }

    final rows = [
      summaryRow("Activity Type(s)", "soccer"),
      summaryRow("Time", "flexible"),
      summaryRow("Participants", "1-10"),
      summaryRow("Location", "53.909123; 13.1290839"),
      summaryRow("Visibility", "public"),
      summaryRow("Description", "Moin Moin"),
    ];

    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      TitleText(text: "Zusammenfassung", width: width),
      const SizedBox(
        height: 20,
      ),
      ...rows,
      const SizedBox(height: 20),
      CustomElevatedButton(onPressed: () {}, text: "Submit")
    ]));
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
