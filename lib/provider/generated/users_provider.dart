import 'package:app/model/generated.dart';
import 'package:app/provider/backend.dart';

class UsersProvider {
  /// Report Profile Photo
  Future<void> reportProfilePhoto({required String userId}) async {
    await BackendService.instance
        .sendRequest(HttpMethod.put, "/users/$userId/report-avatar");
  }

  /// Find Users By Name
  Future<List<UserApiOut>> findUsersByName({required String search}) async {
    final Map<String, dynamic> __q = {"search": search};
    final responseBody = await BackendService.instance
        .sendRequest(HttpMethod.get, "/users/", queryParams: __q);
    return responseBody.map((item) => UserApiOut.fromJson(item)).to_list();
  }

  /// Create User
  Future<void> createUser({required UserApiIn data}) async {
    await BackendService.instance
        .sendRequest(HttpMethod.post, "/users/", body: data.toJson());
  }

  /// Get User Infos
  Future<List<UserApiOut>> getUserInfos({required List<String> q}) async {
    final Map<String, dynamic> __q = {"q": q};
    final responseBody = await BackendService.instance
        .sendRequest(HttpMethod.get, "/users/id", queryParams: __q);
    return responseBody.map((item) => UserApiOut.fromJson(item)).to_list();
  }

  /// Request Reset Password
  Future<void> requestResetPassword(
      {required ResetPasswordRequest data}) async {
    await BackendService.instance.sendRequest(
        HttpMethod.put, "/users/reset_password",
        body: data.toJson());
  }

  /// Reset Password
  Future<void> resetPassword(
      {required String token, required ResetPasswordForm data}) async {
    await BackendService.instance.sendRequest(
        HttpMethod.put, "/users/reset_password/$token",
        body: data.toJson());
  }

  /// Unarchive User
  Future<void> unarchiveUser({required LoginBody data}) async {
    await BackendService.instance.sendRequest(
        HttpMethod.put, "/users/reactivate",
        body: data.toJson(),
        additionalHeaders: {
          "Content-Type": "application/x-www-form-urlencoded"
        },
        encodeToJson: false);
  }

  /// Report User
  Future<void> reportUser({required int userId}) async {
    await BackendService.instance
        .sendRequest(HttpMethod.post, "/users/report/$userId");
  }

  /// Add As Friend
  Future<void> addAsFriend({required String userId}) async {
    await BackendService.instance
        .sendRequest(HttpMethod.post, "/users/friends/$userId");
  }

  /// Accept Friend Request
  Future<void> acceptFriendRequest({required String relationId}) async {
    await BackendService.instance
        .sendRequest(HttpMethod.post, "/users/friends/accept/$relationId");
  }

  /// Decline Friend Request
  Future<void> declineFriendRequest({required String relationId}) async {
    await BackendService.instance
        .sendRequest(HttpMethod.post, "/users/friends/decline/$relationId");
  }

  /// Get All Friends
  Future<List<UserApiOut>> getAllFriends() async {
    final responseBody = await BackendService.instance
        .sendRequest(HttpMethod.get, "/users/friends/");
    return responseBody.map((item) => UserApiOut.fromJson(item)).to_list();
  }

  /// Get Received Friend Requests
  Future<List<UserRelation>> getReceivedFriendRequests() async {
    final responseBody = await BackendService.instance
        .sendRequest(HttpMethod.get, "/users/friends/open");
    return responseBody.map((item) => UserRelation.fromJson(item)).to_list();
  }

  /// Get This User
  Future<UserDetailed> getThisUser() async {
    final responseBody =
        await BackendService.instance.sendRequest(HttpMethod.get, "/users/me/");
    return UserDetailed.fromJson(responseBody);
  }

  /// Update User
  Future<void> updateUser({required Map<String, dynamic> data}) async {
    await BackendService.instance
        .sendRequest(HttpMethod.put, "/users/me/", body: data);
  }

  /// Delete User
  Future<void> deleteUser({required LoginBody data}) async {
    await BackendService.instance.sendRequest(HttpMethod.delete, "/users/me/",
        body: data.toJson(),
        additionalHeaders: {
          "Content-Type": "application/x-www-form-urlencoded"
        },
        encodeToJson: false);
  }

  /// Change User Password
  Future<void> changeUserPassword({required ChangePasswordForm data}) async {
    await BackendService.instance.sendRequest(
        HttpMethod.put, "/users/me/change_password",
        body: data.toJson());
  }

  /// Get Profile Photo
  Future<void> getProfilePhoto() async {
    await BackendService.instance
        .sendRequest(HttpMethod.get, "/users/me/photo/");
  }

  /// Create Profile Photo
  Future<void> createProfilePhoto({required PhotoUrl data}) async {
    await BackendService.instance
        .sendRequest(HttpMethod.post, "/users/me/photo/", body: data.toJson());
  }

  /// Delete Profile Photo
  Future<void> deleteProfilePhoto() async {
    await BackendService.instance
        .sendRequest(HttpMethod.delete, "/users/me/photo/");
  }
}
