// ignore_for_file: avoid_print
import 'package:app/constants/design.dart';
import 'package:app/model/generated.dart';
import 'package:app/provider/generated/locations_provider.dart';
import 'package:app/screens/location_picker.dart';
import 'package:app/widgets/custom/list_tile.dart';
import 'package:app/widgets/custom_text.dart';
import 'package:app/widgets/custom/button.dart';
import 'package:app/widgets/custom/textfield.dart';
import 'package:app/widgets/filter_discipline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

Future<dynamic> bottomSheetBase(
    {required BuildContext context, required dynamic builder}) {
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppStyle.cornerRadiusBottomSheet),
        ),
      ),
      builder: builder);
}

Future<dynamic> bottomSheetAdd(BuildContext context) {
  return bottomSheetBase(
      context: context,
      builder: (context) => Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CustomListTile(
                icon: const Icon(AppIcons.pushPin),
                text: "Add Location",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LocationPickerMap(),
                    ),
                  );
                },
              ),
              CustomListTile(
                icon: const Icon(Icons.event),
                text: "Add Event",
                onPressed: () {},
              ),
            ],
          ));
}

Future<dynamic> bottomSheetFilter(BuildContext context) {
  return bottomSheetBase(
      context: context,
      builder: (context) => Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 9.0, top: 9.0),
                        child: CustomTextButton(
                          text: 'Reset',
                          onPressed: () {
                            print("Moin");
                          },
                        ),
                      ),
                    ],
                  ),
                  CustomTextButton(
                    text: 'filter',
                    onPressed: () {},
                  ),
                ],
              ),
              const FilterDiscipline(),
            ],
          ));
}

Future<void> reviewBottomSheet(
    {required BuildContext context,
    ReviewWithId? oldReview,
    required String locationId}) async {
  TextEditingController titleController =
      TextEditingController(text: oldReview?.title);
  TextEditingController textController =
      TextEditingController(text: oldReview?.text);
  double rating = oldReview?.overallRating ?? 1.0;
  final update = oldReview != null;

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
                    const SmallText(
                      text: "Review",
                    ),
                    CustomTextButton(
                        onPressed: () async {
                          try {
                            final newReview = ReviewBase(
                                locationId: locationId,
                                title: titleController.text,
                                text: textController.text,
                                overallRating: rating,
                                details: {});
                            if (update) {
                              LocationsProvider.updateReview(
                                  locationId: locationId,
                                  reviewId: oldReview.id,
                                  data: newReview);
                            } else {
                              await LocationsProvider.createReview(
                                  locationId: locationId, data: newReview);
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString())),
                            );
                          }
                          Navigator.pop(context);
                        },
                        text: 'Send'),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RatingBar.builder(
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: false,
                          itemCount: 5,
                          initialRating: rating,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => const Icon(
                            AppIcons.star,
                            color: DesignColors.naviColor,
                          ),
                          onRatingUpdate: (r) {
                            rating = r;
                          },
                        ),
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 9.0, top: 15.0),
                  child: Column(children: [
                    DescriptionTextFormField(
                        controller: titleController,
                        hint: "Title",
                        maxLines: 1),
                    DescriptionTextFormField(
                        controller: textController,
                        hint: 'Description',
                        maxLines: 5),
                  ]),
                ),
              ],
            ));
      });
}
