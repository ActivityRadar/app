import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:fuzzywuzzy/fuzzywuzzy.dart' as fuzzy;
import 'package:fuzzywuzzy/ratios/partial_ratio.dart';

class ActivityManager {
  late final Map<String, String> _displayToBackend;
  late final Map<String, String> _backendToDisplay;

  late List<String> _allDisplayTypes;
  late List<String> _allBackendTypes;

  ActivityManager._create(Map<String, List<String>> backendToDisplay) {
    _backendToDisplay = {};
    _displayToBackend = {};

    for (var entry in backendToDisplay.entries) {
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

  static Future<ActivityManager> create() async {
    // TODO: load these depending on the language
    final String response =
        await rootBundle.loadString('shared/lang/de-DE.json');
    final data = await jsonDecode(response);

    final Map<String, List<String>> names = {};

    for (var entry in data.entries) {
      names[entry.key] =
          data[entry.key]["names"].map<String>((s) => s as String).toList();
    }

    return ActivityManager._create(names);
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
    return fuzzy
        .extractTop(
            query: search,
            choices: _allDisplayTypes,
            limit: 10,
            cutoff: 50,
            ratio: PartialRatio())
        .map((res) => res.choice)
        .toList();
  }
}
