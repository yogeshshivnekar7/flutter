
import 'dart:collection';
import 'dart:convert';

import 'package:sso_futurescape/ui/module/meeting/base/meeting_base_model.dart';
import 'package:sso_futurescape/utils/network/api_handler.dart';
import 'package:sso_futurescape/utils/network/meeting_api.dart';

class SuggestionsModel extends MeetingBaseModel {

  void addSuggestion(String agendaId, HashMap<String, String> params,
      onSuccess, onFailure, onError, callingType) {
    NetworkHandler networkHandler = NetworkHandler((s) {
      onSuccess(jsonDecode(s.toString()), callingType: callingType);
    }, (f) {
      var failure = jsonDecode(f);
      onFailure(errorDecoder(failure), callingType: callingType);
    }, (e) {
      onError(e, callingType: callingType);
    });
    Network network = MeetingApiHandler.addSuggestion(networkHandler, agendaId, params);
    network.excute();
  }

  void deleteSuggestion(String agendaId, HashMap<String, String> params,
      onSuccess, onFailure, onError, callingType) {
    NetworkHandler networkHandler = NetworkHandler((s) {
      onSuccess(jsonDecode(s.toString()), callingType: callingType);
    }, (f) {
      var failure = jsonDecode(f);
      onFailure(errorDecoder(failure), callingType: callingType);
    }, (e) {
      onError(e, callingType: callingType);
    });
    Network network = MeetingApiHandler.deleteSuggestion(networkHandler, agendaId, params);
    network.excute();
  }

  void startOrCloseVotingForSuggestion(String agendaId, String suggestionId, HashMap<String, String> params,
      onSuccess, onFailure, onError, callingType) {
    NetworkHandler networkHandler = NetworkHandler((s) {
      onSuccess(jsonDecode(s.toString()), callingType: callingType);
    }, (f) {
      var failure = jsonDecode(f);
      onFailure(errorDecoder(failure), callingType: callingType);
    }, (e) {
      onError(e, callingType: callingType);
    });
    Network network = MeetingApiHandler.startOrCloseVotingForSuggestion(networkHandler,
        agendaId, suggestionId, params);
    network.excute();
  }

  void markVoteForSuggestion(String agendaId, String suggestionId, HashMap<String, String> params,
      onSuccess, onFailure, onError, callingType) {
    NetworkHandler networkHandler = NetworkHandler((s) {
      onSuccess(jsonDecode(s.toString()), callingType: callingType);
    }, (f) {
      var failure = jsonDecode(f);
      onFailure(errorDecoder(failure), callingType: callingType);
    }, (e) {
      onError(e, callingType: callingType);
    });
    Network network = MeetingApiHandler.markVoteForSuggestion(networkHandler,
        agendaId, suggestionId, params);
    network.excute();
  }
}