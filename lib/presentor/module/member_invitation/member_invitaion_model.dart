import 'dart:collection';
import 'dart:convert';

import 'package:sso_futurescape/utils/network/api_handler.dart';
import 'package:sso_futurescape/utils/network/sso_api.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

class MemberInvitaionModel {
  static getMemberInvitaion(onSuccess, onFailure, onError) {
    NetworkHandler a = new NetworkHandler((s) {
      onSuccess(jsonDecode(s.toString()));
    }, (f) {
      var userFalure = jsonDecode(f);
      onFailure(userFalure);
    }, (e) {
      onError(e);
    });
    SsoStorage.getAccessToken().then((token) {
      Network network = SSOAPIHandler.getMemberInvitation(a, token);
      network.excute();
    });
  }

  static void respondInvitation(
      String action, String inviteId, onSuccess, onFailure, onError,
      {String app}) async {
    String token;
    NetworkHandler a = new NetworkHandler((s) {
      onSuccess(jsonDecode(s.toString()));
    }, (f) {
      var userFalure = jsonDecode(f);
      onFailure(userFalure);
    }, (e) {
      onError(e);
    });

    HashMap<String, String> hashMap = new HashMap();
    hashMap["access_token"] = await SsoStorage.getAccessToken();
    hashMap["action"] = action;
    Network network = SSOAPIHandler.respondInvitation(inviteId, a, hashMap);
    network.excute();
  }
}
