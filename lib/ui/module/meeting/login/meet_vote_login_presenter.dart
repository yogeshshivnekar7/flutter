
import 'dart:collection';
import 'dart:convert';

import 'package:sso_futurescape/config/environment/environment.dart';
import 'package:sso_futurescape/ui/module/meeting/login/meet_vote_login_model.dart';
import 'package:sso_futurescape/ui/module/meeting/login/meet_vote_login_view.dart';
import 'package:sso_futurescape/ui/module/meeting/utils/meet_vote_utils.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

class MeetingLoginPresenter {
  MeetingLoginView _meetingLoginView;
  MeetingLoginModel _meetingLoginModel;

  MeetingLoginPresenter(MeetingLoginView meetingLoginView) {
    this._meetingLoginView = meetingLoginView;
    this._meetingLoginModel = MeetingLoginModel();
  }

  void autoLoginIntoMeetingModule(callingType, {var societyId}) async {
    HashMap<String, String> params = HashMap();
    params["grant_type"] = "password";
    params["auto_login"] = "1";
    params["platform"] = "web";
    params["client_id"] = Environment.config.meetingClientId;
    params["client_secret"] = Environment.config.meetingClientSecret;
    params["session_token"] = await SsoStorage.getSessionToken();

    societyId = await MeetVoteUtils.getDefaultMeetingSocietyIfInvalid(societyId);
    if (societyId != null && societyId.toString().trim().isNotEmpty) {
      params["company_id"] = societyId.toString();
    }

    var userProfile = await SsoStorage.getUserProfile();
    params["username"] = userProfile != null ? userProfile["username"] : "";

    _meetingLoginModel.autoLoginIntoMeetingModule(params,
        _meetingLoginView.loginSuccess, _meetingLoginView.loginFailure, _meetingLoginView.loginError,
        callingType, societyId: societyId);
  }
}