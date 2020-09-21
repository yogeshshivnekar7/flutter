import 'package:sso_futurescape/ui/module/meeting/login/meet_vote_login_presenter.dart';
import 'package:sso_futurescape/ui/module/meeting/login/meet_vote_login_view.dart';
import 'package:sso_futurescape/ui/module/meeting/pojo/meet_vote_pojos.dart';
import 'package:sso_futurescape/ui/module/meeting/utils/meet_vote_parser.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

class MeetingLoginHandler implements MeetingLoginView {

  static MeetingLoginHandler _mInstance;

  MeetingLoginHandler() {}

  static MeetingLoginHandler getInstance() {
    if (_mInstance == null) {
      _mInstance = MeetingLoginHandler();
    }
    return _mInstance;
  }

  void loginIntoMeetingModule(callingType, {var societyId, MeetingLoginView view}) {
    MeetingLoginPresenter presenter = MeetingLoginPresenter((view ?? _mInstance));
    presenter.autoLoginIntoMeetingModule(callingType, societyId: societyId);
  }

  @override
  loginError(error, {callingType}) {}

  @override
  loginFailure(failed, {callingType}) {}

  @override
  loginSuccess(success, {societyId, callingType}) {
    ApiData apiData = MeetVoteParser.parseAccessToken(success);
    var accessTokenObj = apiData.data;
    if (accessTokenObj != null) {
      SsoStorage.setMeetingToken(accessTokenObj);
    }
  }
}