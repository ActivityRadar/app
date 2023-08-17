import 'package:app/constants/constants.dart';
import 'package:app/constants/design.dart';
import 'package:app/widgets/custom/card.dart';
import 'package:app/widgets/custom/list_tile.dart';
import 'package:app/widgets/custom_text.dart';
import 'package:app/widgets/custom/snackbar.dart';
import 'package:app/widgets/custom/button.dart';
import 'package:app/widgets/custom/textfield.dart';
import 'package:app/widgets/timepicker.dart';
import 'package:flutter/material.dart';

class MeetAddScreen extends StatefulWidget {
  const MeetAddScreen({Key? key}) : super(key: key);

  @override
  State<MeetAddScreen> createState() => _MeetAddScreenState();
}

<<<<<<< Updated upstream
class _AddMeet extends State<AddMeet> {
=======
class _MeetAddScreenState extends State<MeetAddScreen> {
  PageController pageController = PageController();

  final _formTitleKey = GlobalKey<FormState>();
>>>>>>> Stashed changes
  TextEditingController nameController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isLoading = false;

  String? newUserId;
  Set<Sport> filters = <Sport>{};
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
          whan(),
          howMany(),
          where(),
          titleanddescription(),
          privat(),
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
                      selected: filters.contains(exercise),
                      selectedColor: DesignColors.naviColor,
                      showCheckmark: false,
                      onSelected: (bool selected) {
                        setState(() {
                          if (selected) {
                            filters.add(exercise);
                          } else {
                            filters.remove(exercise);
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

  Center whan() {
    var size = MediaQuery.of(context).size;

    double width = size.width;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TitleText(text: "Wann willst du Spielen ?", width: width),
          const SizedBox(
            height: 20,
          ),
          const CustomCard(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                DateTimePicker(),
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
          TitleText(text: "Wo willst du Spielen ?", width: width),
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

  Center howMany() {
    var size = MediaQuery.of(context).size;

    double width = size.width;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TitleText(text: "Wie viele Mitspiele brauchst du ?", width: width),
          const SizedBox(
            height: 20,
          ),
          const CustomCard(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(text: "mindestes"),
                    CustomText(text: "maximal")
                  ],
                ),
                RangeSliderExample(),
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
            TitleText(text: "Wo willst du Spielen ?", width: width),
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
                          streetController: nameController, label: 'Titel')
                      /*TextFormField(
                              controller: nameController,
                              onChanged: (v) => nameController.text = v,
                              decoration: const InputDecoration(
                                hintText: 'Titel',
                                border: AppInputBorders.border,
                                focusedErrorBorder:
                                    AppInputBorders.focusedError,
                                errorBorder: AppInputBorders.error,
                                enabledBorder: AppInputBorders.enabled,
                                focusedBorder: AppInputBorders.focused,
                              ),
                            ),*/
                      ),
                  Padding(
                    padding: const EdgeInsets.only(left: 9.0, top: 15.0),
                    child: DescriptionTextFieldwithoutBorder(
                      nameController: descriptionController,
                      label: 'description',
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

  Center privat() {
    var size = MediaQuery.of(context).size;

    double width = size.width;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TitleText(text: "Für wem soll das Sichtbar sein ?", width: width),
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
                  child: const PrivatSwitch(),
                )
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
  const PrivatSwitch({super.key});

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
        const SystemText(text: 'Öffentlich'),
        Switch(
          value: _isSwitched,
          onChanged: (value) {
            setState(() {
              _isSwitched = value;
            });
          },
        ),
        const SystemText(text: 'nur Freude'),
      ],
    );
  }
}
