import 'dart:collection';
import 'dart:convert';
import 'package:sso_futurescape/ui/module/meeting/base/meeting_base_model.dart';
import 'package:sso_futurescape/utils/network/api_handler.dart';
import 'package:sso_futurescape/utils/network/meeting_api.dart';

class MeetVoteCreateModel extends MeetingBaseModel {

  void createMeetingOrVoting(HashMap<String, String> params,
      onSuccess, onFailure, onError, callingType) {
    NetworkHandler networkHandler = NetworkHandler((s) {
      onSuccess(jsonDecode(s.toString()), callingType: callingType);
    }, (f) {
      var failure = jsonDecode(f);
      onFailure(errorDecoder(failure), callingType: callingType);
    }, (e) {
      onError(e, callingType: callingType);
    });
    Network network = MeetingApiHandler.createMeetingOrVoting(networkHandler, params);
    network.excute();
  }
}
