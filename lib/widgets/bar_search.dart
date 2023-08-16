import 'package:app/constants/design.dart';
import 'package:app/screens/map.dart';
import 'package:app/widgets/bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class MapSearchBar extends StatelessWidget {
  MapSearchBar({
    super.key,
    required this.mapState,
  });

  final MapScreenState mapState;
  TextEditingController textController = TextEditingController();

  void setActivity(String activity) {
    mapState.activity.value = activity;
    print('set activity to: $activity');
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppStyle.cornerRadiusSearch),
      ),
      child: TextField(
        controller: textController,
        decoration: InputDecoration(
          prefixIcon: IconButton(
            icon: Icon(Icons.filter_alt),
            onPressed: () {
              bottomSheetFilter(context);
            },
          ),
          suffixIcon: IconButton(
            icon: const Icon(Icons.search),
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
    );
  }
}
