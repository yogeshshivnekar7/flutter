import 'package:sso_futurescape/ui/module/meeting/login/login_handler.dart';
import 'package:sso_futurescape/ui/module/meeting/login/meet_vote_login_view.dart';
import 'package:sso_futurescape/ui/module/meeting/login/profile_handler.dart';
import 'package:sso_futurescape/ui/module/meeting/pojo/meet_vote_pojos.dart';
import 'package:sso_futurescape/ui/module/meeting/utils/meet_vote_parser.dart';
import 'package:sso_futurescape/ui/module/meeting/utils/meet_vote_utils.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';
import 'meet_vote_profile_view.dart';
import 'member_type_handler.dart';
import 'member_type_view.dart';

class UserHelper1 implements MeetingLoginView, MeetingProfileView {

  UserDataListener1 _userDataListener;

  UserHelper1(this._userDataListener);

  void loadUserData({var societyId}) {
    _loginUser(societyId: societyId);
  }

  void _loginUser({var societyId}) {
    MeetingLoginHandler.getInstance()
        .loginIntoMeetingModule(MeetingLoginView.CALL_TYPE_MEETING_LOGIN,
        societyId: societyId, view: this);
  }

  void _loadUserProfile({var societyId}) {
    MeetingProfileHandler.getInstance()
        .loadUserProfile(MeetingProfileView.CALL_TYPE_USER_PROFILE,
        societyId: societyId, view: this);
  }

  @override
  profileError(error, {callingType}) {
    _userDataListener.userDataError1();
  }

  @override
  profileFailure(failed, {callingType}) {
    _userDataListener.userDataFailure1();
  }

  @override
  profileSuccess(success, {societyId, callingType}) {
    ApiData apiData = MeetVoteParser.parseUserProfile(success);
    var profileObj = apiData.data;
    if (profileObj != null) {
      SsoStorage.setMeetingUserProfile(profileObj);
      int userId = profileObj["user_id"];
      String meetingSocietyId;
      if (userId > 0) {
        meetingSocietyId = MeetVoteUtils.generateMeetingSocietyId(userId);
        var meetingSocietyObj = {
          "soc_id": meetingSocietyId
        };
        SsoStorage.setMeetingSociety(meetingSocietyObj);
      }
      _userDataListener.userDataSuccess1(meetingSocietyId);
    } else {
      _userDataListener.userDataFailure1();
    }
  }

  @override
  loginError(error, {callingType}) {
    _userDataListener.userDataError1();
  }

  @override
  loginFailure(failed, {callingType}) {
    _userDataListener.userDataFailure1();
  }

  @override
  loginSuccess(success, {societyId, callingType}) {
    ApiData apiData = MeetVoteParser.parseAccessToken(success);
    var accessTokenObj = apiData.data;
    if (accessTokenObj != null) {
      SsoStorage.setMeetingToken(accessTokenObj);
      _loadUserProfile(societyId: societyId);
    } else {
      _userDataListener.userDataFailure1();
    }
  }
}

abstract class UserDataListener1 {
  userDataSuccess1(var meetingSocietyId);

  userDataFailure1();

  userDataError1();
}