import 'package:app/constants/contants.dart';
import 'package:app/model/generated.dart';
import 'package:app/provider/backend.dart';
import 'package:app/widgets/photo_picker.dart';
import 'package:flutter/material.dart';
import 'package:app/widgets/body_details_screen.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key, required this.locationId});

  final String locationId;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  Future<LocationDetailedApi>? _data;

  @override
  void initState() {
    super.initState();
    _data = LocationService().getDetails(widget.locationId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _data,
        builder: (BuildContext context,
            AsyncSnapshot<LocationDetailedApi> snapshot) {
          Widget child;
          if (snapshot.hasData) {
            child = BodyDetails(id: widget.locationId, data: snapshot.data!);
          } else if (snapshot.hasError) {
            child = Text("Error: ${snapshot.error}");
          } else {
            child = const CircularProgressIndicator();
          }
          return Scaffold(
              backgroundColor: DesignColors.kBackgroundColor,
              appBar: buildAppBar(context),
              body: child);
        });
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
        backgroundColor: DesignColors.naviColor,
        elevation: 0,
        leading: IconButton(
            icon: const Icon(Icons.keyboard_backspace),
            color: DesignColors.kBackgroundColor,
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.ios_share),
            color: DesignColors.kBackgroundColor,
          ),
          IconButton(
            onPressed: () => bottomSheetPhotoSourcePicker(
                context: context,
                mode: "location",
                locationId: widget.locationId),
            icon: const Icon(Icons.add_a_photo),
            color: DesignColors.kBackgroundColor,
          ),
        ]);
  }
}
