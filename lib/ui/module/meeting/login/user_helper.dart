import 'package:sso_futurescape/ui/module/meeting/login/login_handler.dart';
import 'package:sso_futurescape/ui/module/meeting/login/meet_vote_login_view.dart';
import 'package:sso_futurescape/ui/module/meeting/login/profile_handler.dart';
import 'package:sso_futurescape/ui/module/meeting/pojo/meet_vote_pojos.dart';
import 'package:sso_futurescape/ui/module/meeting/utils/meet_vote_parser.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';
import 'meet_vote_profile_view.dart';
import 'member_type_handler.dart';
import 'member_type_view.dart';

class UserHelper implements MeetingLoginView, MeetingProfileView, MemberTypeView {
  static const String _CALL_TYPE_MEETING_LOGIN = "MEETING_LOGIN";
  static const String _CALL_TYPE_USER_PROFILE = "USER_PROFILE";
  static const String _CALL_TYPE_MEMBER_TYPE = "MEMBER_TYPE";

  UserDataListener _userDataListener;

  UserHelper(this._userDataListener);

  void loadUserData(callingType, {var societyId}) {
    _loginUser(societyId: societyId);
  }

  void _loginUser({var societyId}) {
    MeetingLoginHandler.getInstance()
        .loginIntoMeetingModule(_CALL_TYPE_MEETING_LOGIN,
        societyId: societyId, view: this);
  }

  void _loadUserProfile({int societyId}) {
    MeetingProfileHandler.getInstance()
        .loadUserProfile(_CALL_TYPE_USER_PROFILE,
        societyId: societyId, view: this);
  }

  void _loadMemberType({int societyId}) {
    MemberTypeHandler.getInstance()
        .loadMemberTypeForSociety(_CALL_TYPE_MEMBER_TYPE,
    societyId: societyId, view: this);
  }

  @override
  profileError(error, {callingType}) {
    _userDataListener.userDataError();
  }

  @override
  profileFailure(failed, {callingType}) {
    _userDataListener.userDataFailure();
  }

  @override
  profileSuccess(success, {societyId, callingType}) {
    ApiData apiData = MeetVoteParser.parseUserProfile(success);
    var profileObj = apiData.data;
    if (profileObj != null) {
      SsoStorage.setMeetingUserProfile(profileObj);
      _loadMemberType(societyId: societyId);
    } else {
      _userDataListener.userDataFailure();
    }
  }

  @override
  loginError(error, {callingType}) {
    _userDataListener.userDataError();
  }

  @override
  loginFailure(failed, {callingType}) {
    _userDataListener.userDataFailure();
  }

  @override
  loginSuccess(success, {societyId, callingType}) {
    ApiData apiData = MeetVoteParser.parseAccessToken(success);
    var accessTokenObj = apiData.data;
    if (accessTokenObj != null) {
      SsoStorage.setMeetingToken(accessTokenObj);
      _loadUserProfile(societyId: societyId);
    } else {
      _userDataListener.userDataFailure();
    }
  }

  @override
  memberTypeError(error, {callingType}) {
    _userDataListener.userDataError();
  }

  @override
  memberTypeFailure(failed, {callingType}) {
    _userDataListener.userDataFailure();
  }

  @override
  memberTypeSuccess(success, var id, int type, {callingType}) {
    ApiData apiData = MeetVoteParser.parseMemberType(success);
    _userDataListener.userDataSuccess(apiData.data);
  }
}

abstract class UserDataListener {
  userDataSuccess(bool isAdmin);

  userDataFailure();

  userDataError();
}