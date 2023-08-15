import 'package:app/constants/constants.dart';
import 'package:app/constants/design.dart';
import 'package:app/widgets/custom_button.dart';
import 'package:app/widgets/custom_card.dart';
import 'package:app/widgets/custom_list_tile.dart';
import 'package:app/widgets/custom_text.dart';
import 'package:app/widgets/custom_textfield.dart';
import 'package:app/widgets/photo_picker.dart';
import 'package:app/widgets/timepicker.dart';
import 'package:flutter/material.dart';
import '../widgets/filter_discipline.dart';
import 'package:intl/intl.dart';

class AddMeet extends StatefulWidget {
  const AddMeet({super.key});
  @override
  State<AddMeet> createState() => _AddMeet();
}

class _AddMeet extends State<AddMeet> {
  TextEditingController nameController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  var _rating = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double width = size.width;
    bool isPublic = false;
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
                CustomTextButtonWhite(
                    onPressed: () {
                      Navigator.of(context).pop(); // Dialog schließen
                    },
                    text: 'Send'),
              ],
              pinned: true,
              stretch: true,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: PageTitleText(
                    text: 'Meet search',
                    width: width,
                  )),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Column(
                  children: [
                    MediumText(
                      text: "Allgemein",
                      width: width,
                    ),
                    CustomCard(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                              padding:
                                  const EdgeInsets.only(left: 9.0, top: 15.0),
                              child: CustomTextField(
                                  streetController: nameController,
                                  label: 'Titel')
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
                            padding:
                                const EdgeInsets.only(left: 9.0, top: 15.0),
                            child: DescriptionTextFieldwithoutBorder(
                              nameController: nameController,
                              label: 'description',
                            ),
                          ),
                          ListTile(
                            title: const SmallText(text: 'Nur Freunde'),
                            trailing: Switch(
                              value: isPublic,
                              activeColor: Colors.red,
                              onChanged: (bool value) {
                                setState(() {
                                  isPublic = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 9.0, top: 15.0),
                      child: MediumText(
                        text: "activityType",
                        width: width,
                      ),
                    ),
                    CustomCard(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          FilterDiscipline(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 9.0, top: 15.0),
                      child: MediumText(
                        text: "Wo und Wann",
                        width: width,
                      ),
                    ),
                    CustomCard(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomListTile(
                            onPressed: () {},
                            titleText: "Pick Location",
                          ),
                          DateTimePicker(),
                        ],
                      ),
                    ),
                  ],
                ),
              ]),
            ),
          ],
        ));
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
        title: const CustomText(text: 'Meet search'),
        elevation: 0,
        leading: IconButton(
            icon: const Icon(Icons.keyboard_backspace),
            color: DesignColors.kBackgroundColor,
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: <Widget>[
          CustomTextButton(onPressed: () {}, text: 'Send'),
        ]);
  }
}
