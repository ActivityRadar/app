import 'package:app/model/generated.dart';
import 'package:app/provider/generated/offers_provider.dart';
import 'package:latlong2/latlong.dart';

class OfferParsed extends OfferOut {
  OfferParsed(
      {required OfferOut offer, required this.time_, required this.location_})
      : super(
            activity: offer.activity,
            time: offer.time,
            description: offer.description,
            visibility: offer.visibility,
            visibilityRadius: offer.visibilityRadius,
            location: offer.location,
            participantLimits: offer.participantLimits,
            participants: offer.participants,
            id: offer.id,
            userInfo: offer.userInfo,
            blurrInfo: offer.blurrInfo);

  factory OfferParsed.fromGenerated(OfferOut offer) {
    final time = offer.time["type"] == "flexible"
        ? OfferTimeFlexible.fromJson(offer.time)
        : OfferTimeSingle.fromJson(offer.time);

    var location;
    if (offer.location != null) {
      location = offer.location!["id"] == null
          ? OfferLocationArea.fromJson(offer.location!)
          : OfferLocationConnected.fromJson(offer.location!);
    }

    return OfferParsed(offer: offer, time_: time, location_: location);
  }

  dynamic time_;
  dynamic location_;
}

class OfferInParsed extends OfferIn {
  OfferInParsed(
      {required OfferIn offer, required this.time_, required this.location_})
      : super(
            activity: offer.activity,
            time: time_.toJson(),
            description: offer.description,
            visibility: offer.visibility,
            visibilityRadius: offer.visibilityRadius,
            location: location_.toJson(),
            participantLimits: offer.participantLimits,
            blurr: offer.blurr);

  /// overwrites the time and location values with the proper serialization
  @override
  Map<String, dynamic> toJson() {
    final map = super.toJson();
    if (time_ is OfferTimeSingle || time_ is OfferTimeFlexible) {
      map["time"] = time_.toJson();
    }

    if (location_ is OfferLocationArea || location_ is OfferLocationConnected) {
      map["location"] = location_.toJson();
    }

    return map;
  }

  dynamic time_;
  dynamic location_;
}

class MeetupManager {
  static final Map<String, OfferParsed> _storage = {};
  static final List<String> _userMeetups = [];
  static final List<String> _availableMeetups = [];

  static final MeetupManager _instance = MeetupManager._internal();
  static MeetupManager get instance => _instance;
  MeetupManager._internal();

  static LatLng? _currentPosition;
  static LatLng? _lastFetchPosition;
  static Distance distance = const Distance();

  set currentPosition(LatLng position) {
    _currentPosition = position;

    if (_lastFetchPosition != null) {
      // if the person moved 200 from the last fetch, well do an automatic fetch
      if (distance(_lastFetchPosition!, _currentPosition!) > 200) {
        getAvailableMeetups(forceFetch: true);
      }
    }
  }

  Future<List<OfferParsed>> getUserMeetups(
      {bool forceFetch = false, bool forceUpdate = false}) async {
    var meetups;
    if (forceUpdate) {
      meetups = await OffersProvider.getOffers(id: _availableMeetups);
    } else if (forceFetch) {
      meetups = await OffersProvider.getOffers(allForUser: true);
      _userMeetups.clear();
    }

    for (var m in meetups ?? []) {
      _storage[m.id] = OfferParsed.fromGenerated(m);
      _userMeetups.add(m.id);
    }

    print(_userMeetups.length);

    return _userMeetups.map((id) => _storage[id]!).toList();
  }

  Future<List<OfferParsed>> getAvailableMeetups(
      {bool forceUpdate = false, bool forceFetch = false}) async {
    var meetups;
    if (forceUpdate) {
      meetups = await OffersProvider.getOffers(id: _availableMeetups);
    } else if (forceFetch) {
      if (_currentPosition != null) {
        meetups = await OffersProvider.getOffersInArea(
            long: _currentPosition!.longitude,
            lat: _currentPosition!.latitude,
            radius: 4);

        _lastFetchPosition = _currentPosition;
      } else {
        throw Exception("No position available!");
      }
      _availableMeetups.clear();
    }

    for (var m in meetups ?? []) {
      _storage[m.id] = OfferParsed.fromGenerated(m);
      _availableMeetups.add(m.id);
    }

    return _availableMeetups.map((id) => _storage[id]!).toList();
  }

  Future<OfferParsed> updateMeetupInfo(String id) async {
    final meetup = await OffersProvider.getOffers(id: [id]);

    _storage[id] = OfferParsed.fromGenerated(meetup[0]);

    return _storage[id]!;
  }

  Future createMeetup(OfferInParsed offer) async {
    final newOffer = await OffersProvider.createOffer(data: offer);

    _storage[newOffer.id] = OfferParsed.fromGenerated(newOffer);
    _userMeetups.add(newOffer.id);
  }

  Future refreshAll() async {
    await getUserMeetups(forceUpdate: true);
    await getAvailableMeetups(forceUpdate: true);
  }

  Future fetchAll() async {
    await getUserMeetups(forceFetch: true);
    await getAvailableMeetups(forceFetch: true);
  }
}
