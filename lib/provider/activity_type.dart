import 'package:fuzzywuzzy/fuzzywuzzy.dart' as fuzzy;
import 'package:fuzzywuzzy/ratios/partial_ratio.dart';

class ActivityManager {
  late final Map<String, String> _displayToBackend;
  late final Map<String, String> _backendtoDisplay;

  late List<String> _allDisplayTypes;
  late List<String> _allBackendTypes;

  ActivityManager() {
    // TODO: load these from shared json files
    _displayToBackend = {
      "Fussball": "soccer",
      "Basketball": "basketball",
      "Schwimmen": "swimming",
      "Tischtennis": "table_tennis",
      "Aikido": "aikido",
      "Bowling": "10pin",
      "Kegeln": "9pin",
    };

    _backendtoDisplay = {
      "soccer": "Fussball",
      "basketball": "Basketball",
      "swimming": "Schwimmen",
      "table_tennis": "Tischtennis",
      "aikido": "Aikido",
      "10pin": "Bowling",
      "9pin": "Kegeln",
    };

    _allDisplayTypes = _displayToBackend.keys.toList();
    _allBackendTypes = _backendtoDisplay.keys.toList();
  }

  String getBackendType(String displayType) {
    return _displayToBackend[displayType] ?? "";
  }

  String getDisplayType(String backendType) {
    return _backendtoDisplay[backendType] ?? "";
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
