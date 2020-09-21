import 'dart:collection';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';
import 'meet_vote_profile_model.dart';
import 'meet_vote_profile_view.dart';

class MeetingProfilePresenter {
  MeetingProfileView _meetingProfileView;
  MeetingProfileModel _meetingProfileModel;

  MeetingProfilePresenter(MeetingProfileView meetingProfileView) {
    this._meetingProfileView = meetingProfileView;
    this._meetingProfileModel = MeetingProfileModel();
  }

  void loadUserProfile(callingType, {var societyId}) async {
    HashMap<String, String> params = HashMap();

    SsoStorage.getMeetingToken().then((value) {
      params["access_token"] = value?.toString()?.trim() ?? "";

      _meetingProfileModel.loadUserProfile(params,
          _meetingProfileView.profileSuccess, _meetingProfileView.profileFailure, _meetingProfileView.profileError,
          callingType, societyId: societyId);
    });
  }
}