import 'dart:collection';
import 'dart:convert';

import 'package:sso_futurescape/ui/module/meeting/base/meeting_base_model.dart';
import 'package:sso_futurescape/utils/network/api_handler.dart';
import 'package:sso_futurescape/utils/network/meeting_api.dart';

class MeetingLoginModel extends MeetingBaseModel {

  void autoLoginIntoMeetingModule(
      HashMap<String, String> params, onSuccess, onFailure, onError, callingType, {var societyId}) {
    NetworkHandler networkHandler = NetworkHandler((s) {
      onSuccess(jsonDecode(s.toString()),
          societyId: societyId, callingType: callingType);
    }, (f) {
      var failure = jsonDecode(f);
      onFailure(errorDecoder(failure), callingType: callingType);
    }, (e) {
      onError(e, callingType: callingType);
    });
    Network network = MeetingApiHandler.autoLoginIntoMeetingModule(networkHandler, params);
    network.excute();
  }
}
