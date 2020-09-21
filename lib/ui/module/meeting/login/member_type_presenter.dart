import 'dart:collection';
import 'dart:convert';
import 'package:sso_futurescape/utils/app_constant.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';
import 'meet_vote_profile_model.dart';
import 'meet_vote_profile_view.dart';
import 'member_type_model.dart';
import 'member_type_view.dart';

class MemberTypePresenter {
  MemberTypeView _memberTypeView;
  MemberTypeModel _memberTypeModel;

  MemberTypePresenter(MemberTypeView memberTypeView) {
    this._memberTypeView = memberTypeView;
    this._memberTypeModel = MemberTypeModel();
  }

  void _loadMemberType(var id, int type, callingType) async {
    HashMap<String, String> params = HashMap();

    String accessToken = await SsoStorage.getMeetingToken();
    params["access_token"] = accessToken?.toString()?.trim() ?? "";

    if (type == AppConstant.TYPE_MEETING) {
      params["meeting_id"] = id.toString();
      type = AppConstant.TYPE_MEETING;
    } else {
      params["company_id"] = id.toString();
      type = AppConstant.TYPE_SOCIETY;
    }

    var userProfile = await SsoStorage.getUserProfile();
    String email = userProfile != null ? userProfile["email"] : "";
    String mobile = userProfile != null ? userProfile["mobile"] : "";

    if (mobile != null && mobile.trim().isNotEmpty) {
      params["mobile"] = mobile.trim();
    } else if (email != null && email.trim().isNotEmpty) {
      params["email"] = email.trim();
    }

    _memberTypeModel.loadMemberType(params, type,
        _memberTypeView.memberTypeSuccess, _memberTypeView.memberTypeFailure, _memberTypeView.memberTypeError,
        callingType, id);
  }

  void loadMemberTypeForMeeting(int meetingId, callingType) async {
    _loadMemberType(meetingId, AppConstant.TYPE_MEETING, callingType);
  }

  void loadMemberTypeForSociety(callingType, {var societyId}) async {
    if (societyId <= 0) {
      dynamic socObj = await SsoStorage.getDefaultChsoneUnit();
      if (socObj != null) {
        socObj = jsonDecode(socObj);
      }
      String socIdStr = socObj != null ? socObj["soc_id"] : "-1";
      societyId = (socIdStr != null && socIdStr.trim().isNotEmpty) ? int.parse(socIdStr) : 0;
    }
    _loadMemberType(societyId, AppConstant.TYPE_SOCIETY, callingType);
  }
}

