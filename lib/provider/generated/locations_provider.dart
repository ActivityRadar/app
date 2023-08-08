import 'package:app/model/generated.dart';
import 'package:app/provider/backend.dart';

class LocationsProvider {
  /// Get Locations By Bbox
  Future<List<LocationShortApi>> getLocationsByBbox(
      {required double west,
      required double south,
      required double east,
      required double north,
      List<String>? activities}) async {
    final Map<String, dynamic> __q = {
      "west": west,
      "south": south,
      "east": east,
      "north": north,
      if (activities != null) "activities": activities
    };
    final responseBody = await BackendService.instance
        .sendRequest(HttpMethod.get, "/locations/bbox", queryParams: __q);
    return responseBody
        .map((item) => LocationShortApi.fromJson(item))
        .to_list();
  }

  /// Get Locations Around
  Future<List<LocationDetailedApi>> getLocationsAround(
      {required double long,
      required double lat,
      double? radius,
      List<String>? activities,
      int? limit}) async {
    final Map<String, dynamic> __q = {
      "long": long,
      "lat": lat,
      if (radius != null) "radius": radius,
      if (activities != null) "activities": activities,
      if (limit != null) "limit": limit
    };
    final responseBody = await BackendService.instance
        .sendRequest(HttpMethod.get, "/locations/around", queryParams: __q);
    return responseBody
        .map((item) => LocationDetailedApi.fromJson(item))
        .to_list();
  }

  /// Get Location
  Future<LocationDetailedApi> getLocation({required String locationId}) async {
    final responseBody = await BackendService.instance
        .sendRequest(HttpMethod.get, "/locations/$locationId");
    return LocationDetailedApi.fromJson(responseBody);
  }

  /// Delete Location
  Future<void> deleteLocation({required int locationId}) async {
    await BackendService.instance
        .sendRequest(HttpMethod.delete, "/locations/$locationId");
  }

  /// Get Location Bulk
  Future<void> getLocationBulk({required List<String> id}) async {
    final Map<String, dynamic> __q = {"id": id};
    await BackendService.instance
        .sendRequest(HttpMethod.get, "/locations/bulk", queryParams: __q);
  }

  /// Update Location
  Future<void> updateLocation({required LocationHistoryIn data}) async {
    await BackendService.instance
        .sendRequest(HttpMethod.put, "/locations/", body: data.toJson());
  }

  /// Create New Location
  Future<void> createNewLocation({required LocationNew data}) async {
    await BackendService.instance
        .sendRequest(HttpMethod.post, "/locations/", body: data.toJson());
  }

  /// Get Location History
  Future<void> getLocationHistory(
      {required String locationId, int? offset}) async {
    final Map<String, dynamic> __q = {if (offset != null) "offset": offset};
    await BackendService.instance.sendRequest(
        HttpMethod.get, "/locations/$locationId/update-history",
        queryParams: __q);
  }

  /// Report Location Update
  Future<void> reportLocationUpdate(
      {required String updateId, required String reason}) async {
    final Map<String, dynamic> __q = {"reason": reason};
    await BackendService.instance.sendRequest(
        HttpMethod.post, "/locations/report-update/$updateId",
        queryParams: __q);
  }

  /// Get Reviews
  Future<ReviewsPage> getReviews(
      {required String locationId, int? offset, int? n}) async {
    final Map<String, dynamic> __q = {
      if (offset != null) "offset": offset,
      if (n != null) "n": n
    };
    final responseBody = await BackendService.instance.sendRequest(
        HttpMethod.get, "/locations/$locationId/reviews/",
        queryParams: __q);
    return ReviewsPage.fromJson(responseBody);
  }

  /// Create Review
  Future<void> createReview(
      {required String locationId, required ReviewBase data}) async {
    await BackendService.instance.sendRequest(
        HttpMethod.post, "/locations/$locationId/reviews/",
        body: data.toJson());
  }

  /// Update Review
  Future<void> updateReview(
      {required String locationId,
      required String reviewId,
      required ReviewBase data}) async {
    await BackendService.instance.sendRequest(
        HttpMethod.put, "/locations/$locationId/reviews/$reviewId",
        body: data.toJson());
  }

  /// Remove Review
  Future<void> removeReview(
      {required String locationId, required String reviewId}) async {
    await BackendService.instance.sendRequest(
        HttpMethod.delete, "/locations/$locationId/reviews/$reviewId");
  }

  /// Report Review
  Future<void> reportReview(
      {required String locationId,
      required String reviewId,
      required String reason}) async {
    final Map<String, dynamic> __q = {"reason": reason};
    await BackendService.instance.sendRequest(
        HttpMethod.put, "/locations/$locationId/reviews/$reviewId/report",
        queryParams: __q);
  }

  /// Set Confirmation
  Future<void> setConfirmation(
      {required String locationId, Map<String, dynamic>? confirm}) async {
    final Map<String, dynamic> __q = {if (confirm != null) "confirm": confirm};
    await BackendService.instance.sendRequest(
        HttpMethod.put, "/locations/$locationId/reviews/confirmation",
        queryParams: __q);
  }

  /// Add Photo
  Future<void> addPhoto(
      {required String locationId, required PhotoUrl data}) async {
    await BackendService.instance.sendRequest(
        HttpMethod.post, "/locations/$locationId/photos/",
        body: data.toJson());
  }

  /// Remove Photo
  Future<void> removePhoto(
      {required String locationId, required PhotoUrl data}) async {
    await BackendService.instance.sendRequest(
        HttpMethod.delete, "/locations/$locationId/photos/",
        body: data.toJson());
  }

  /// Report Photo
  Future<void> reportPhoto(
      {required String locationId, required PhotoUrl data}) async {
    await BackendService.instance.sendRequest(
        HttpMethod.put, "/locations/$locationId/photos/report",
        body: data.toJson());
  }
}
