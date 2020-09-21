import 'package:sso_futurescape/ui/module/meeting/login/meet_vote_profile_presenter.dart';
import 'package:sso_futurescape/ui/module/meeting/pojo/meet_vote_pojos.dart';
import 'package:sso_futurescape/ui/module/meeting/utils/meet_vote_parser.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';
import 'meet_vote_profile_view.dart';

class MeetingProfileHandler implements MeetingProfileView {

  static MeetingProfileHandler _mInstance;

  MeetingProfileHandler() {}

  static MeetingProfileHandler getInstance() {
    if (_mInstance == null) {
      _mInstance = MeetingProfileHandler();
    }
    return _mInstance;
  }

  void loadUserProfile(callingType, {var societyId, MeetingProfileView view}) {
    MeetingProfilePresenter presenter = MeetingProfilePresenter((view ?? _mInstance));
    presenter.loadUserProfile(callingType, societyId: societyId);
  }

  @override
  profileError(error, {callingType}) {}

  @override
  profileFailure(failed, {callingType}) {}

  @override
  profileSuccess(success, {societyId, callingType}) {
    ApiData apiData = MeetVoteParser.parseUserProfile(success);
    var profileObj = apiData.data;
    if (profileObj != null) {
      SsoStorage.setMeetingUserProfile(profileObj);
    }
  }
}