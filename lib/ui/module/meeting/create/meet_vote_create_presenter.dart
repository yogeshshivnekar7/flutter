import 'dart:collection';
import 'package:sso_futurescape/config/environment/environment.dart';
import 'package:sso_futurescape/ui/module/meeting/details/meet_vote_details_model.dart';
import 'package:sso_futurescape/ui/module/meeting/details/meet_vote_details_view.dart';
import 'package:sso_futurescape/ui/module/meeting/utils/meet_vote_utils.dart';

import 'meet_vote_create_model.dart';
import 'meet_vote_create_view.dart';

class MeetVoteCreatePresenter {
  MeetVoteCreateView _meetVoteCreateView;
  MeetVoteCreateModel _meetVoteCreateModel;

  MeetVoteCreatePresenter(MeetVoteCreateView meetVoteCreateView) {
    this._meetVoteCreateView = meetVoteCreateView;
    this._meetVoteCreateModel = MeetVoteCreateModel();
  }

  void _createMeetingOrVoting(data, String type, callingType, {var societyId}) async {
    HashMap<String, String> params = HashMap<String, String>();

    societyId = await MeetVoteUtils.getDefaultMeetingSocietyIfInvalid(societyId);
    String accessToken = await MeetVoteUtils.getMeetingToken();

    if (societyId != null && societyId.toString().trim().isNotEmpty) {
      params["company_id"] = societyId.toString();
    }
    params["access_token"] = accessToken;
    params["app_id"] = Environment.config.meetingAppId.toString();

    params["title"] = data["title"];
    params["description"] = data["description"];
    params["start_date"] = data["start_date"];
    params["end_date"] = data["end_date"];
    params["start_time"] = data["start_time"];
    params["end_time"] = data["end_time"];
    params["invitation_info"] = data["invitation_info"];
    params["schedule[date]"] = data["invite_date"];
    params["schedule[time]"] = data["invite_time"];
    params["meeting_type"] = type;

    _meetVoteCreateModel.createMeetingOrVoting(params,
        _meetVoteCreateView.createMeetVoteSuccess, _meetVoteCreateView.createMeetVoteFailure, _meetVoteCreateView.createMeetVoteError,
        callingType);
  }

  void createMeeting(data, callingType, {var societyId}) {
    _createMeetingOrVoting(data, "meeting", callingType, societyId: societyId);
  }

  void createVoting(data, callingType, {var societyId}) {
    _createMeetingOrVoting(data, "voting", callingType, societyId: societyId);
  }
}