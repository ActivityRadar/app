import 'package:app/model/generated.dart';
import 'package:app/provider/backend.dart';

class ChatsProvider {
  /// Poll Users Chats
  static Future<void> pollUsersChats({required DateTime lastPollTime}) async {
    final Map<String, dynamic> __q = {"last_poll_time": lastPollTime};
    await BackendService.instance
        .sendRequest(HttpMethod.get, "/chats/", queryParams: __q);
  }

  /// Start Chat
  static Future<String> startChat({required String partnerId}) async {
    final Map<String, dynamic> __q = {"partner_id": partnerId};
    final responseBody = await BackendService.instance
        .sendRequest(HttpMethod.post, "/chats/", queryParams: __q);
    return responseBody;
  }

  /// Send Message
  static Future<void> sendMessage(
      {required String chatId, required Map<String, dynamic> data}) async {
    final Map<String, dynamic> __q = {"chat_id": chatId};
    await BackendService.instance.sendRequest(HttpMethod.post, "/chats/message",
        queryParams: __q, body: data);
  }
}
