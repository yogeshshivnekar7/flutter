import 'package:sso_futurescape/utils/storage/sso_storage.dart';

class VizlogStorage {
  static Future<String> getAccessToken() async {
    var accessTokenModel = await SsoStorage.getVizlogToken();
    var accessToken = accessTokenModel["data"]["access_token"];
    return Future.value(accessToken);
  }
}
