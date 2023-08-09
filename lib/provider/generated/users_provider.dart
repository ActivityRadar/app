import 'package:app/model/generated.dart';
import 'package:app/provider/backend.dart';

class UsersProvider {
  /// Report Profile Photo
  static Future<void> reportProfilePhoto({required String userId}) async {
    await BackendService.instance
        .sendRequest(HttpMethod.put, "/users/$userId/report-avatar");
  }

  /// Find Users By Name
  static Future<List<UserApiOut>> findUsersByName(
      {required String search}) async {
    final Map<String, dynamic> __q = {"search": search};
    final responseBody = await BackendService.instance
        .sendRequest(HttpMethod.get, "/users/", queryParams: __q);
    return responseBody.map((item) => UserApiOut.fromJson(item)).to_list();
  }

  /// Create User
  static Future<void> createUser({required UserApiIn data}) async {
    await BackendService.instance
        .sendRequest(HttpMethod.post, "/users/", body: data.toJson());
  }

  /// Get User Infos
  static Future<List<UserApiOut>> getUserInfos(
      {required List<String> q}) async {
    final Map<String, dynamic> __q = {"q": q};
    final responseBody = await BackendService.instance
        .sendRequest(HttpMethod.get, "/users/id", queryParams: __q);
    return responseBody.map((item) => UserApiOut.fromJson(item)).to_list();
  }

  /// Request Reset Password
  static Future<void> requestResetPassword(
      {required ResetPasswordRequest data}) async {
    await BackendService.instance.sendRequest(
        HttpMethod.put, "/users/reset_password",
        body: data.toJson());
  }

  /// Reset Password
  static Future<void> resetPassword(
      {required String token, required ResetPasswordForm data}) async {
    await BackendService.instance.sendRequest(
        HttpMethod.put, "/users/reset_password/$token",
        body: data.toJson());
  }

  /// Unarchive User
  static Future<void> unarchiveUser({required LoginBody data}) async {
    await BackendService.instance.sendRequest(
        HttpMethod.put, "/users/reactivate",
        body: data.toJson(),
        additionalHeaders: {
          "Content-Type": "application/x-www-form-urlencoded"
        },
        encodeToJson: false);
  }

  /// Report User
  static Future<void> reportUser({required int userId}) async {
    await BackendService.instance
        .sendRequest(HttpMethod.post, "/users/report/$userId");
  }

  /// Add As Friend
  static Future<void> addAsFriend({required String userId}) async {
    await BackendService.instance
        .sendRequest(HttpMethod.post, "/users/friends/$userId");
  }

  /// Accept Friend Request
  static Future<void> acceptFriendRequest({required String relationId}) async {
    await BackendService.instance
        .sendRequest(HttpMethod.post, "/users/friends/accept/$relationId");
  }

  /// Decline Friend Request
  static Future<void> declineFriendRequest({required String relationId}) async {
    await BackendService.instance
        .sendRequest(HttpMethod.post, "/users/friends/decline/$relationId");
  }

  /// Get All Friends
  static Future<List<UserApiOut>> getAllFriends() async {
    final responseBody = await BackendService.instance
        .sendRequest(HttpMethod.get, "/users/friends/");
    return responseBody.map((item) => UserApiOut.fromJson(item)).to_list();
  }

  /// Get Received Friend Requests
  static Future<List<UserRelation>> getReceivedFriendRequests() async {
    final responseBody = await BackendService.instance
        .sendRequest(HttpMethod.get, "/users/friends/open");
    return responseBody.map((item) => UserRelation.fromJson(item)).to_list();
  }

  /// Get This User
  static Future<UserDetailed> getThisUser() async {
    final responseBody =
        await BackendService.instance.sendRequest(HttpMethod.get, "/users/me/");
    return UserDetailed.fromJson(responseBody);
  }

  /// Update User
  static Future<void> updateUser({required Map<String, dynamic> data}) async {
    await BackendService.instance
        .sendRequest(HttpMethod.put, "/users/me/", body: data);
  }

  /// Delete User
  static Future<void> deleteUser({required LoginBody data}) async {
    await BackendService.instance.sendRequest(HttpMethod.delete, "/users/me/",
        body: data.toJson(),
        additionalHeaders: {
          "Content-Type": "application/x-www-form-urlencoded"
        },
        encodeToJson: false);
  }

  /// Change User Password
  static Future<void> changeUserPassword(
      {required ChangePasswordForm data}) async {
    await BackendService.instance.sendRequest(
        HttpMethod.put, "/users/me/change_password",
        body: data.toJson());
  }

  /// Get Profile Photo
  static Future<void> getProfilePhoto() async {
    await BackendService.instance
        .sendRequest(HttpMethod.get, "/users/me/photo/");
  }

  /// Create Profile Photo
  static Future<void> createProfilePhoto({required PhotoUrl data}) async {
    await BackendService.instance
        .sendRequest(HttpMethod.post, "/users/me/photo/", body: data.toJson());
  }

  /// Delete Profile Photo
  static Future<void> deleteProfilePhoto() async {
    await BackendService.instance
        .sendRequest(HttpMethod.delete, "/users/me/photo/");
  }
}
