import 'package:app/model/generated.dart';
import 'package:app/provider/backend.dart';

class OffersProvider {
  /// Get Offers
  static Future<List<OfferOut>> getOffers(
      {List<String>? id, bool? allForUser}) async {
    final Map<String, dynamic> __q = {
      if (id != null) "id": id,
      if (allForUser != null) "all-for-user": allForUser.toString()
    };
    final List responseBody = await BackendService.instance
        .sendRequest(HttpMethod.get, "/offers/", queryParams: __q);
    return responseBody.map((item) => OfferOut.fromJson(item)).toList();
  }

  /// Create Offer
  static Future<OfferOut> createOffer({required OfferIn data}) async {
    final responseBody = await BackendService.instance
        .sendRequest(HttpMethod.post, "/offers/", body: data.toJson());
    return OfferOut.fromJson(responseBody);
  }

  /// Get Offers At Location
  static Future<List<OfferOut>> getOffersAtLocation(
      {required String locationId,
      DateTime? timeFrom,
      DateTime? timeUntil}) async {
    final Map<String, dynamic> __q = {
      if (timeFrom != null) "time_from": timeFrom,
      if (timeUntil != null) "time_until": timeUntil
    };
    final List responseBody = await BackendService.instance.sendRequest(
        HttpMethod.get, "/offers/location/$locationId",
        queryParams: __q);
    return responseBody.map((item) => OfferOut.fromJson(item)).toList();
  }

  /// Get Offers In Area
  static Future<List<OfferOut>> getOffersInArea(
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
    final List responseBody = await BackendService.instance
        .sendRequest(HttpMethod.get, "/offers/around", queryParams: __q);
    return responseBody.map((item) => OfferOut.fromJson(item)).toList();
  }

  /// Set Offer Status
  static Future<void> setOfferStatus(
      {required String offerId, required OfferStatus status}) async {
    final Map<String, dynamic> __q = {"status": status};
    await BackendService.instance
        .sendRequest(HttpMethod.put, "/offers/me/$offerId", queryParams: __q);
  }

  /// Request To Join
  static Future<void> requestToJoin(
      {required String offerId, required String data}) async {
    await BackendService.instance
        .sendRequest(HttpMethod.put, "/offers/$offerId", body: data);
  }

  /// Delete Offer
  static Future<void> deleteOffer({required String offerId}) async {
    await BackendService.instance
        .sendRequest(HttpMethod.delete, "/offers/$offerId");
  }

  /// Decline Request
  static Future<void> declineRequest(
      {required String offerId, required String userId}) async {
    await BackendService.instance
        .sendRequest(HttpMethod.put, "/offers/me/$offerId/decline/$userId");
  }

  /// Accept Request
  static Future<void> acceptRequest(
      {required String offerId, required String userId}) async {
    await BackendService.instance
        .sendRequest(HttpMethod.put, "/offers/me/$offerId/accept/$userId");
  }
}
