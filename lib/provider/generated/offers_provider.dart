import 'package:app/model/generated.dart';
import 'package:app/provider/backend.dart';

class OffersProvider {
  /// Get Offers
  static Future<void> getOffers({required List<String> id}) async {
    final Map<String, dynamic> __q = {"id": id};
    await BackendService.instance
        .sendRequest(HttpMethod.get, "/offers/", queryParams: __q);
  }

  /// Create Offer
  static Future<void> createOffer({required OfferIn data}) async {
    await BackendService.instance
        .sendRequest(HttpMethod.post, "/offers/", body: data.toJson());
  }

  /// Get Offers At Location
  static Future<void> getOffersAtLocation(
      {required String locationId,
      DateTime? timeFrom,
      DateTime? timeUntil}) async {
    final Map<String, dynamic> __q = {
      if (timeFrom != null) "time_from": timeFrom,
      if (timeUntil != null) "time_until": timeUntil
    };
    await BackendService.instance.sendRequest(
        HttpMethod.get, "/offers/location/$locationId",
        queryParams: __q);
  }

  /// Get Offers In Area
  static Future<void> getOffersInArea(
      {required double long,
      required double lat,
      required double radius,
      DateTime? timeFrom,
      DateTime? timeUntil,
      List<String>? activities}) async {
    final Map<String, dynamic> __q = {
      "long": long.toString(),
      "lat": lat.toString(),
      "radius": radius.toString(),
      if (timeFrom != null) "time_from": timeFrom,
      if (timeUntil != null) "time_until": timeUntil,
      if (activities != null) "activities": activities
    };
    await BackendService.instance
        .sendRequest(HttpMethod.get, "/offers/around", queryParams: __q);
  }

  /// Set Offer Status
  static Future<void> setOfferStatus(
      {required String offerId, required OfferStatus status}) async {
    final Map<String, dynamic> __q = {"status": status};
    await BackendService.instance
        .sendRequest(HttpMethod.put, "/offers/me/$offerId", queryParams: __q);
  }

  /// Contact Offerer
  static Future<void> contactOfferer(
      {required String offerId, required String message}) async {
    final Map<String, dynamic> __q = {"message": message.toString()};
    await BackendService.instance
        .sendRequest(HttpMethod.put, "/offers/$offerId", queryParams: __q);
  }

  /// Delete Offer
  static Future<void> deleteOffer({required String offerId}) async {
    await BackendService.instance
        .sendRequest(HttpMethod.delete, "/offers/$offerId");
  }
}
