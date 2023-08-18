import 'package:app/constants/constants.dart';
import 'package:app/constants/design.dart';
import 'package:app/widgets/custom/card.dart';
import 'package:app/widgets/custom/list_tile.dart';
import 'package:app/widgets/custom_text.dart';
import 'package:app/widgets/custom/snackbar.dart';
import 'package:app/widgets/custom/button.dart';
import 'package:app/widgets/custom/textfield.dart';
import 'package:app/widgets/photo_picker.dart';
import 'package:app/widgets/timepicker.dart';
import 'package:flutter/material.dart';

class LocationAddScreen extends StatefulWidget {
  const LocationAddScreen({Key? key}) : super(key: key);

  @override
  State<LocationAddScreen> createState() => _LocationAddScreenState();
}

class _LocationAddScreenState extends State<LocationAddScreen> {
  PageController pageController = PageController();

  final _formTitleKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isLoading = false;

  String? newUserId;

  Set<Place> filtersPlace = <Place>{};
  Set<Sport> filtersSport = <Sport>{};
  @override
  void previousPage() {
    pageController.previousPage(
        duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
  }

  void nextPage() {
    pageController.nextPage(
        duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0.0,
          backgroundColor: DesignColors.kBackgroundColor,
          leading: CustomTextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            text: "Cancel",
          )),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: <Widget>[
          activity(),
          privatorpublic(),
          where(),
          titleanddescription(),
          pickPhoto(),
        ],
      ),
    );
  }

  Center activity() {
    var size = MediaQuery.of(context).size;

    double width = size.width;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TitleText(text: "Welche Sportmöglichkeiten gibt es ?", width: width),
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
                      selected: filtersSport.contains(exercise),
                      selectedColor: DesignColors.naviColor,
                      showCheckmark: false,
                      onSelected: (bool selected) {
                        setState(() {
                          if (selected) {
                            filtersSport.add(exercise);
                          } else {
                            filtersSport.remove(exercise);
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomElevatedButton(
                onPressed: () {
                  previousPage();
                },
                text: "Previous",
              ),
              CustomElevatedButton(
                onPressed: () {
                  nextPage();
                },
                text: "Next",
              ),
            ],
          )
        ],
      ),
    );
  }

  Center privatorpublic() {
    var size = MediaQuery.of(context).size;

    double width = size.width;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TitleText(text: "Wo befindet der Platz ?", width: width),
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
                  children: Place.values.map((Place exercise) {
                    return FilterChip(
                      label: CustomText(text: exercise.name),
                      selected: filtersPlace.contains(exercise),
                      selectedColor: DesignColors.naviColor,
                      showCheckmark: false,
                      onSelected: (bool selected) {
                        setState(() {
                          if (selected) {
                            filtersPlace.add(exercise);
                          } else {
                            filtersPlace.remove(exercise);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
                Container(
                  alignment: Alignment.center,
                  width: width,
                  child: const PrivatSwitch(
                    secondText: 'Öffentlich',
                    firstText: 'Privat Gelände',
                  ),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomElevatedButton(
                onPressed: () {
                  previousPage();
                },
                text: "Previous",
              ),
              CustomElevatedButton(
                onPressed: () {
                  nextPage();
                },
                text: "Next",
              ),
            ],
          )
        ],
      ),
    );
  }

  Center where() {
    var size = MediaQuery.of(context).size;

    double width = size.width;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TitleText(text: "Wo sind die Sport anlagen?", width: width),
          const SizedBox(
            height: 20,
          ),
          CustomListTile(
            onPressed: () {},
            titleText: "Pick Location",
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomElevatedButton(
                onPressed: () {
                  previousPage();
                },
                text: "Previous",
              ),
              CustomElevatedButton(
                onPressed: () {
                  nextPage();
                },
                text: "Next",
              ),
            ],
          )
        ],
      ),
    );
  }

  Center titleanddescription() {
    var size = MediaQuery.of(context).size;

    double width = size.width;
    return Center(
      child: Form(
        key: _formTitleKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                          streetController: nameController, label: 'Titel')),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomElevatedButton(
                  onPressed: () {
                    previousPage();
                  },
                  text: "Previous",
                ),
                CustomElevatedButton(
                  onPressed: () {
                    if (_formTitleKey.currentState!.validate()) {
                      nextPage();
                    } else {
                      showMessageSnackBar(context, 'Please fill input');
                    }
                  },
                  text: "Next",
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Center pickPhoto() {
    var size = MediaQuery.of(context).size;

    double width = size.width;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TitleText(text: "Füge noch ein paar Bilder hinzu", width: width),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(9.0),
            child: TextButton(
              onPressed: () => bottomSheetPhotoSourcePicker(
                  context: context, mode: "location", locationId: 'asdas'),
              //TODO
              child: const SmallText(
                text: "Bilder hochladen",
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomElevatedButton(
                onPressed: () {
                  previousPage();
                },
                text: "Previous",
              ),
              CustomElevatedButton(
                onPressed: () {
                  nextPage();
                },
                text: "Next",
              ),
            ],
          )
        ],
      ),
    );
  }
}

class RangeSliderExample extends StatefulWidget {
  const RangeSliderExample({super.key});

  @override
  State<RangeSliderExample> createState() => _RangeSliderExampleState();
}

class _RangeSliderExampleState extends State<RangeSliderExample> {
  RangeValues _currentRangeValues = const RangeValues(1, 2);

  @override
  Widget build(BuildContext context) {
    return RangeSlider(
      values: _currentRangeValues,
      max: 30,
      divisions: 30,
      labels: RangeLabels(
        _currentRangeValues.start.round().toString(),
        _currentRangeValues.end.round().toString(),
      ),
      onChanged: (RangeValues values) {
        setState(() {
          _currentRangeValues = values;
        });
      },
    );
  }
}

class PrivatSwitch extends StatefulWidget {
  const PrivatSwitch({
    super.key,
    required this.firstText,
    required this.secondText,
  });

  final String firstText;
  final String secondText;
  @override
  _PrivatSwitchState createState() => _PrivatSwitchState();
}

class _PrivatSwitchState extends State<PrivatSwitch> {
  bool _isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SystemText(text: widget.firstText),
        Switch(
          value: _isSwitched,
          onChanged: (value) {
            setState(() {
              _isSwitched = value;
            });
          },
        ),
        SystemText(text: widget.secondText),
      ],
    );
  }
}
