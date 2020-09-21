
import 'dart:collection';

import 'package:sso_futurescape/ui/module/meeting/conduct_meeting/suggestions_model.dart';
import 'package:sso_futurescape/ui/module/meeting/conduct_meeting/suggestions_view.dart';
import 'package:sso_futurescape/utils/app_constant.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

class SuggestionsPresenter {

  SuggestionsModel _suggestionsModel;
  SuggestionsView _suggestionsView;

  SuggestionsPresenter(this._suggestionsView) {
    this._suggestionsModel = SuggestionsModel();
  }

  void addSuggestion(String agendaId, String suggestion, int suggestionNumber,
      String participantId, callingType, [String participantName, int userId]) {
    HashMap<String, String> params = HashMap<String, String>();
    String suggestionId = participantId + "-$suggestionNumber";
    params["suggestion"] = suggestion;
    params["sid"] = suggestionId;

    if (participantId != null && participantId.trim().isNotEmpty) {
      params["by[cid]"] = participantId;
    } else if (participantName != null && participantName.trim().isNotEmpty) {
      params["by[name]"] = participantName;
    } else if (userId > 0) {
      params["by[user]"] = userId.toString();
    }

    SsoStorage.getMeetingToken().then((value) {
      params["access_token"] = value?.toString()?.trim() ?? "";

      _suggestionsModel.addSuggestion(agendaId, params,
          _suggestionsView.success, _suggestionsView.failure, _suggestionsView.error,
          callingType);
    });
  }

  void deleteSuggestion(String agendaId, String suggestionId, callingType) {
    HashMap<String, String> params = HashMap<String, String>();
    params["sid"] = suggestionId;

    SsoStorage.getMeetingToken().then((value) {
      params["access_token"] = value?.toString()?.trim() ?? "";

      _suggestionsModel.deleteSuggestion(agendaId, params,
          _suggestionsView.success, _suggestionsView.failure, _suggestionsView.error,
          callingType);
    });
  }

  void _startOrCloseVotingForSuggestion(String agendaId, String suggestionId,
      int operation, callingType) {
    HashMap<String, String> params = HashMap<String, String>();
    params["status"] = operation.toString();

    SsoStorage.getMeetingToken().then((value) {
      params["access_token"] = value?.toString()?.trim() ?? "";

      _suggestionsModel.startOrCloseVotingForSuggestion(agendaId, suggestionId, params,
          _suggestionsView.success, _suggestionsView.failure, _suggestionsView.error,
          callingType);
    });
  }

  void startVotingForSuggestion(String agendaId, String suggestionId,
      int operation, callingType) {
    _startOrCloseVotingForSuggestion(agendaId, suggestionId,
        AppConstant.START_SUGGESTION_VOTING, callingType);
  }


  void closeVotingForSuggestion(String agendaId, String suggestionId,
      int operation, callingType) {
    _startOrCloseVotingForSuggestion(agendaId, suggestionId,
        AppConstant.CLOSE_SUGGESTION_VOTING, callingType);
  }

  void _markVoteForSuggestion(String agendaId, String suggestionId, String participantId,
      String vote, callingType) {
    HashMap<String, String> params = HashMap<String, String>();
    params["cid"] = participantId;
    params["vote"] = vote;

    SsoStorage.getMeetingToken().then((value) {
      params["access_token"] = value?.toString()?.trim() ?? "";

      _suggestionsModel.markVoteForSuggestion(agendaId, suggestionId, params,
          _suggestionsView.success, _suggestionsView.failure, _suggestionsView.error,
          callingType);
    });
  }

  void agreeToSuggestion(String agendaId, String suggestionId, String participantId, callingType) {
    _markVoteForSuggestion(agendaId, suggestionId, participantId,
        AppConstant.VOTE_AGREE, callingType);
  }

  void disagreeToSuggestion(String agendaId, String suggestionId, String participantId, callingType) {
    _markVoteForSuggestion(agendaId, suggestionId, participantId,
        AppConstant.VOTE_DISAGREE, callingType);
  }

  void addConclusion(String agendaId, String suggestionId, callingType) {

  }
}