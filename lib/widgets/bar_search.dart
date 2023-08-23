import 'package:app/constants/design.dart';
import 'package:app/provider/activity_type.dart';
import 'package:app/screens/map.dart';
import 'package:app/widgets/activityType_short.dart';
import 'package:app/widgets/bottomsheet.dart';
import 'package:flutter/material.dart';

class MapSearchBar extends StatefulWidget {
  const MapSearchBar({
    super.key,
    required this.mapState,
  });

  final MapScreenState mapState;

  @override
  State<MapSearchBar> createState() => _MapSearchBarState();
}

class _MapSearchBarState extends State<MapSearchBar> {
  TextEditingController textController = TextEditingController();

  List<String> choices = [];

  void setActivity(String activity) {
    widget.mapState.activity.value =
        ActivityManager.instance.getBackendType(activity);
    print('set activity to: $activity');
  }

  @override
  void initState() {
    super.initState();

    textController.addListener(() {
      setState(() {
        choices =
            ActivityManager.instance.searchInDisplayTypes(textController.text);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    return Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppStyle.cornerRadiusSearch),
          ),
          child: TextField(
            controller: textController,
            decoration: InputDecoration(
              border: AppInputBorders.none,
              focusedErrorBorder: AppInputBorders.none,
              errorBorder: AppInputBorders.none,
              enabledBorder: AppInputBorders.none,
              focusedBorder: AppInputBorders.none,
              prefixIcon: IconButton(
                icon: const Icon(AppIcons.filterAlt),
                onPressed: () {
                  bottomSheetFilter(context);
                },
              ),
              suffixIcon: IconButton(
                icon: const Icon(AppIcons.search),
                onPressed: () {
                  setActivity(textController.text);
                },
              ),
              hintStyle: CustomTextStyle.hint,
              hintText: "Search basketball, volleyball, table tennis ... ",
            ),
            textInputAction: TextInputAction.search,
            onSubmitted: setActivity,
          ),
        ),
        const SizedBox(height: 5),
        Align(
          alignment: Alignment.centerLeft,
          child: ActivityChipSlider(
              activities: choices,
              onPressed: (choice) {
                textController.text = choice;
                setActivity(choice);
              }),
        )
      ],
    );
  }
}
