import 'dart:collection';
import 'dart:convert';

import 'package:sso_futurescape/ui/module/meeting/base/meeting_base_model.dart';
import 'package:sso_futurescape/utils/app_constant.dart';
import 'package:sso_futurescape/utils/network/api_handler.dart';
import 'package:sso_futurescape/utils/network/meeting_api.dart';

class MemberTypeModel extends MeetingBaseModel {

  void loadMemberType(HashMap<String, String> params,
      int type, onSuccess, onFailure, onError,
      callingType, var id) {
    NetworkHandler networkHandler = NetworkHandler((s) {
      onSuccess(jsonDecode(s.toString()), id, type, callingType: callingType);
    }, (f) {
      var failure = jsonDecode(f);
      onFailure(errorDecoder(failure), callingType: callingType);
    }, (e) {
      onError(e, callingType: callingType);
    });
    Network network = MeetingApiHandler.loadMemberType(networkHandler, params);
    network.excute();
  }
}
