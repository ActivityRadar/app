import 'package:app/model/generated.dart';
import 'package:app/provider/backend.dart';

class LocationsProvider {
  /// Get Locations By Bbox
  static Future<List<LocationShortApi>> getLocationsByBbox(
      {required double west,
      required double south,
      required double east,
      required double north,
      List<String>? activities}) async {
    final Map<String, dynamic> __q = {
      "west": west.toString(),
      "south": south.toString(),
      "east": east.toString(),
      "north": north.toString(),
      if (activities != null) "activities": activities
    };
    final List responseBody = await BackendService.instance
        .sendRequest(HttpMethod.get, "/locations/bbox", queryParams: __q);
    return responseBody.map((item) => LocationShortApi.fromJson(item)).toList();
  }

  /// Get Locations Around
  static Future<List<LocationDetailedApi>> getLocationsAround(
      {required double long,
      required double lat,
      double? radius,
      List<String>? activities,
      int? limit}) async {
    final Map<String, dynamic> __q = {
      "long": long.toString(),
      "lat": lat.toString(),
      if (radius != null) "radius": radius.toString(),
      if (activities != null) "activities": activities,
      if (limit != null) "limit": limit.toString()
    };
    final List responseBody = await BackendService.instance
        .sendRequest(HttpMethod.get, "/locations/around", queryParams: __q);
    return responseBody
        .map((item) => LocationDetailedApi.fromJson(item))
        .toList();
  }

  /// Get Location
  static Future<LocationDetailedApi> getLocation(
      {required String locationId}) async {
    final responseBody = await BackendService.instance
        .sendRequest(HttpMethod.get, "/locations/$locationId");
    return LocationDetailedApi.fromJson(responseBody);
  }

  /// Delete Location
  static Future<void> deleteLocation({required int locationId}) async {
    await BackendService.instance
        .sendRequest(HttpMethod.delete, "/locations/$locationId");
  }

  /// Get Location Bulk
  static Future<void> getLocationBulk({required List<String> id}) async {
    final Map<String, dynamic> __q = {"id": id};
    await BackendService.instance
        .sendRequest(HttpMethod.get, "/locations/bulk", queryParams: __q);
  }

  /// Update Location
  static Future<void> updateLocation({required LocationHistoryIn data}) async {
    await BackendService.instance
        .sendRequest(HttpMethod.put, "/locations/", body: data.toJson());
  }

  /// Create New Location
  static Future<CreateLocationResponse> createNewLocation(
      {required LocationNew data}) async {
    final responseBody = await BackendService.instance
        .sendRequest(HttpMethod.post, "/locations/", body: data.toJson());
    return CreateLocationResponse.fromJson(responseBody);
  }

  /// Get Location History
  static Future<void> getLocationHistory(
      {required String locationId, int? offset}) async {
    final Map<String, dynamic> __q = {
      if (offset != null) "offset": offset.toString()
    };
    await BackendService.instance.sendRequest(
        HttpMethod.get, "/locations/$locationId/update-history",
        queryParams: __q);
  }

  /// Report Location Update
  static Future<void> reportLocationUpdate(
      {required String updateId, required String reason}) async {
    final Map<String, dynamic> __q = {"reason": reason.toString()};
    await BackendService.instance.sendRequest(
        HttpMethod.post, "/locations/report-update/$updateId",
        queryParams: __q);
  }

  /// Get Reviews
  static Future<ReviewsPage> getReviews(
      {required String locationId, int? offset, int? n}) async {
    final Map<String, dynamic> __q = {
      if (offset != null) "offset": offset.toString(),
      if (n != null) "n": n.toString()
    };
    final responseBody = await BackendService.instance.sendRequest(
        HttpMethod.get, "/locations/$locationId/reviews/",
        queryParams: __q);
    return ReviewsPage.fromJson(responseBody);
  }

  /// Create Review
  static Future<void> createReview(
      {required String locationId, required ReviewBase data}) async {
    await BackendService.instance.sendRequest(
        HttpMethod.post, "/locations/$locationId/reviews/",
        body: data.toJson());
  }

  /// Update Review
  static Future<void> updateReview(
      {required String locationId,
      required String reviewId,
      required ReviewBase data}) async {
    await BackendService.instance.sendRequest(
        HttpMethod.put, "/locations/$locationId/reviews/$reviewId",
        body: data.toJson());
  }

  /// Remove Review
  static Future<void> removeReview(
      {required String locationId, required String reviewId}) async {
    await BackendService.instance.sendRequest(
        HttpMethod.delete, "/locations/$locationId/reviews/$reviewId");
  }

  /// Report Review
  static Future<void> reportReview(
      {required String locationId,
      required String reviewId,
      required String reason}) async {
    final Map<String, dynamic> __q = {"reason": reason.toString()};
    await BackendService.instance.sendRequest(
        HttpMethod.put, "/locations/$locationId/reviews/$reviewId/report",
        queryParams: __q);
  }

  /// Set Confirmation
  static Future<void> setConfirmation(
      {required String locationId, bool? confirm}) async {
    final Map<String, dynamic> __q = {
      if (confirm != null) "confirm": confirm.toString()
    };
    await BackendService.instance.sendRequest(
        HttpMethod.put, "/locations/$locationId/reviews/confirmation",
        queryParams: __q);
  }

  /// Add Photo
  static Future<void> addPhoto(
      {required String locationId, required PhotoUrl data}) async {
    await BackendService.instance.sendRequest(
        HttpMethod.post, "/locations/$locationId/photos/",
        body: data.toJson());
  }

  /// Remove Photo
  static Future<void> removePhoto(
      {required String locationId, required PhotoUrl data}) async {
    await BackendService.instance.sendRequest(
        HttpMethod.delete, "/locations/$locationId/photos/",
        body: data.toJson());
  }

  /// Report Photo
  static Future<void> reportPhoto(
      {required String locationId, required PhotoUrl data}) async {
    await BackendService.instance.sendRequest(
        HttpMethod.put, "/locations/$locationId/photos/report",
        body: data.toJson());
  }
}
