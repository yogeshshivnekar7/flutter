import 'dart:collection';
import 'dart:convert';
import 'package:sso_futurescape/ui/module/meeting/base/meeting_base_model.dart';
import 'package:sso_futurescape/utils/network/api_handler.dart';
import 'package:sso_futurescape/utils/network/meeting_api.dart';

class MeetVoteListModel extends MeetingBaseModel {

  void loadMeetingOrVotingList(HashMap<String, String> params,
      onSuccess, onFailure, onError, callingType) {
    NetworkHandler networkHandler = NetworkHandler((s) {
      onSuccess(int.parse(params["page"]), jsonDecode(s.toString()), callingType: callingType);
    }, (f) {
      var failure = jsonDecode(f);
      onFailure(int.parse(params["page"]), errorDecoder(failure), callingType: callingType);
    }, (e) {
      onError(int.parse(params["page"]), e, callingType: callingType);
    });
    Network network = MeetingApiHandler.loadMeetingOrVotingList(networkHandler, params);
    network.excute();
  }
}
