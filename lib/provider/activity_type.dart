import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:fuzzywuzzy/fuzzywuzzy.dart' as fuzzy;
import 'package:fuzzywuzzy/ratios/partial_ratio.dart';

class ActivityManager {
  final Map<String, String> _displayToBackend = {};
  final Map<String, String> _backendToDisplay = {};

  late List<String> _allDisplayTypes;
  late List<String> _allBackendTypes;

  static ActivityManager? _instance;
  static ActivityManager get instance {
    _instance ??= ActivityManager._();
    return _instance!;
  }

  ActivityManager._();

  // must be called before the app is started
  init() async {
    final String response =
        await rootBundle.loadString('shared/lang/de-DE.json');
    final data = await jsonDecode(response);

    final Map<String, List<String>> names = {};

    for (var entry in data.entries) {
      names[entry.key] =
          data[entry.key]["names"].map<String>((s) => s as String).toList();
    }

    for (var entry in names.entries) {
      _backendToDisplay[entry.key] =
          entry.value.isEmpty ? entry.key : entry.value[0];

      for (var name in entry.value) {
        _displayToBackend[name] = entry.key;
      }

      if (entry.value.isEmpty) {
        _displayToBackend[entry.key] = entry.key;
      }
    }

    _allDisplayTypes = _displayToBackend.keys.toList();
    _allBackendTypes = _backendToDisplay.keys.toList();
  }

  String getBackendType(String displayType) {
    return _displayToBackend[displayType] ?? "";
  }

  String getDisplayType(String backendType) {
    return _backendToDisplay[backendType] ?? "";
  }

  List<String> getAllDisplayTypes() {
    return _allDisplayTypes;
  }

  List<String> getAllBackendTypes() {
    return _allBackendTypes;
  }

  List<String> searchInDisplayTypes(String search) {
    return searchInSelection(search, _allDisplayTypes);
  }

  List<String> searchInSelection(String search, List<String> selection) {
    return fuzzy
        .extractTop(
            query: search,
            choices: selection,
            limit: 10,
            cutoff: 50,
            ratio: PartialRatio())
        .map((res) => res.choice)
        .toList();
  }
}
