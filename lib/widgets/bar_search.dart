import 'package:app/screens/map.dart';
import 'package:app/widgets/bottomsheet.dart';
import 'package:flutter/material.dart';

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

    return Padding(
      padding: EdgeInsets.symmetric(vertical: height / 25, horizontal: 16.0),
      child: Column(
        children: [
          Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(80),
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
                  hintStyle:
                      const TextStyle(fontSize: 15.0, color: Colors.black12),
                  hintText: "Search basketball, volleyball, table tennis ... ",
                ),
                textInputAction: TextInputAction.search,
                onSubmitted: setActivity,
              ))
        ],
      ),
    );
  }
}
