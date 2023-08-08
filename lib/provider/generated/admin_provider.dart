import 'package:app/model/generated.dart';
import 'package:app/provider/backend.dart';

class AdminProvider {
  /// Revert Location Update
  Future<void> revertLocationUpdate({required String updateId}) async {
    await BackendService.instance.sendRequest(
        HttpMethod.put, "/admin/locations/revert-update/$updateId");
  }
}
