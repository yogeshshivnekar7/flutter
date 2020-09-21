import 'dart:collection';
import 'package:sso_futurescape/config/environment/environment.dart';
import 'package:sso_futurescape/ui/module/meeting/listing/meet_vote_list_model.dart';
import 'package:sso_futurescape/ui/module/meeting/utils/meet_vote_utils.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

import 'meet_vote_list_view.dart';

class MeetVoteListPresenter {

  static const String _LIST_TYPE_MEETING = "meeting";
  static const String _LIST_TYPE_VOTING = "voting";
  static const int _DEFAULT_PAGE_SIZE = 20;
  static const int _DEFAULT_PAGE = 1;

  MeetVoteListView _meetVoteListView;
  MeetVoteListModel _meetVoteListModel;

  MeetVoteListPresenter(MeetVoteListView meetVoteListView) {
    this._meetVoteListView = meetVoteListView;
    this._meetVoteListModel = MeetVoteListModel();
  }

  void _loadMeetingOrVotingList(int page, int pageSize, callingType, String listType, {var societyId}) async {
    HashMap<String, String> params = HashMap();
    params["per_page"] = pageSize < 0 ? "$_DEFAULT_PAGE_SIZE" : "$pageSize";
    params["page"] = page <= 0 ? "$_DEFAULT_PAGE" : "$page";

    societyId = await MeetVoteUtils.getDefaultMeetingSocietyIfInvalid(societyId);
    if (societyId != null && societyId.toString().trim().isNotEmpty) {
      params["company_id"] = societyId.toString();
    }
    params["app_id"] = Environment.config.meetingAppId.toString();

    String accessToken = await MeetVoteUtils.getMeetingToken();
    params["access_token"] = accessToken;

    _meetVoteListModel.loadMeetingOrVotingList(params,
        _meetVoteListView.success, _meetVoteListView.failure, _meetVoteListView.error,
        callingType);
  }

  void loadMeetingList(int page, int pageSize, callingType) {
    _loadMeetingOrVotingList(page, pageSize, callingType, _LIST_TYPE_MEETING);
  }

  void loadVotingList(int page, int pageSize, callingType) {
    _loadMeetingOrVotingList(page, pageSize, callingType, _LIST_TYPE_VOTING);
  }
}