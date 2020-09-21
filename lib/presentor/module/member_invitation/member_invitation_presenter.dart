import 'package:sso_futurescape/config/environment/environment.dart';
import 'package:sso_futurescape/config/strings/strings.dart';
import 'package:sso_futurescape/presentor/module/member_invitation/member_invitaion_model.dart';
import 'package:sso_futurescape/presentor/module/member_invitation/member_invitation_view.dart';

class MemberInvitationPresenter {
  MemberInvitationView memberInvitationView;

  MemberInvitationPresenter(this.memberInvitationView);

  void getMemberInvitation() {
    MemberInvitaionModel.getMemberInvitaion(onSuccess,
        memberInvitationView.onFailure, memberInvitationView.onError);
  }

  void onSuccess(data) {
    List invitaionList = [];
    List tempList = data["data"];
    for (int i = 0; tempList != null && i < tempList.length; i++) {
      if (tempList[i]["app_id"].toString() ==
          Environment().getCurrentConfig().vizlogAppId.toString()) {
        tempList[i]["invite_id_vizlog"] = tempList[i]["invite_id"];
      } else {
        tempList[i]["invite_id_chsone"] = tempList[i]["invite_id"];
      }
      tempList[i]["member_unit_number"] = FsString.INVITAION +
          tempList[i]["company"]["company_name"] +
          "/" +
          tempList[i]["building_name"] +
          "/" +
//          tempList[i]["floor_no"] +
//          "/" +
          tempList[i]["unit_number"];
//      if (invitaionList.length <= 0) {
//        invitaionList.add(tempList[i]);
//      }
      bool unitFound = false;
      for (int j = 0; j < invitaionList.length; j++) {
        if (tempList[i]["building_name"] == invitaionList[j]["building_name"] &&
            tempList[i]["floor_no"] == invitaionList[j]["floor_no"] &&
            tempList[i]["unit_number"] == invitaionList[j]["unit_number"] &&
            tempList[i]["app_id"].toString() !=
                invitaionList[j]["app_id"].toString()) {
          invitaionList[j]["both_invite"] = true;
          if (tempList[i]["app_id"].toString() ==
              Environment().getCurrentConfig().vizlogAppId.toString()) {
            invitaionList[j]["invite_id_vizlog"] = tempList[i]["invite_id"];
          } else {
            invitaionList[j]["invite_id_chsone"] = tempList[i]["invite_id"];
          }

          unitFound = true;
          break;
        }
      }
      if (!unitFound) {
        unitFound = false;
        invitaionList.add(tempList[i]);
      }
//
    }
    memberInvitationView.onSuccess(invitaionList);
//    print("invitaionList------------------------------ " +
//        invitaionList.toString());
  }

  void respondInvitation(String action, String inviteId, {String app}) {
    MemberInvitaionModel.respondInvitation(
        action,
        inviteId,
        memberInvitationView.onRespondSuccess,
        memberInvitationView.onFailure,
        memberInvitationView.onError,
        app: app);
  }
}
