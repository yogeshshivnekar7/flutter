import 'package:common_config/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/config/strings/strings.dart';
import 'package:sso_futurescape/presentor/module/member_invitation/member_invitation_presenter.dart';
import 'package:sso_futurescape/presentor/module/member_invitation/member_invitation_view.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/ui/widgets/list_widget.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';
import 'package:sso_futurescape/ui/widgets/update_profile_dialog.dart';
import 'package:sso_futurescape/utils/app_constant.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

class MyFlatsInvitees extends StatefulWidget {
  @override
  _MyFlatsInviteesState createState() => new _MyFlatsInviteesState();
}

class _MyFlatsInviteesState extends State<MyFlatsInvitees>
    implements PageLoadListener, MemberInvitationView {
  FsListState listListner;
  MemberInvitationPresenter invitationPresenter;

  bool isRespond = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    invitationPresenter = new MemberInvitationPresenter(this);
    invitationPresenter.getMemberInvitation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      primaryColor: FsColor.primaryflat,
      appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: FsColor.white,
        title: Text(
          "notifications",
          style: FSTextStyle.appbartext,
        ),
        leading: FsBackButton(
          backEvent: (context) {
            backCliked(context);
          },
        ),
        actions: <Widget>[],
      ),
      body: Padding(
          padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
          child: Center(
            child: FsListWidget(
                message: FsString.NO_NOTIFICATION,
                title: false,
                pageLoadListner: this,
                itemBuilder: (BuildContext context, int index, var item) {
                  // return Container(
                  //   decoration: BoxDecoration(
                  //       border: Border(
                  //         bottom: BorderSide(
                  //             width: 1.0,
                  //             color: FsColor.lightgrey.withOpacity(0.5)),
                  //       )),
                  //   padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  //   margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  //   child: Row(
                  //     children: <Widget>[
                  //       Expanded(
                  //         child: Text(
                  //           '${item["member_unit_number"]}'.toLowerCase(),
                  //           style: TextStyle(
                  //             fontFamily: 'Gilroy-SemiBold',
                  //             fontSize: FSTextStyle.h6size,
                  //             color: FsColor.darkgrey,
                  //           ),
                  //         ),
                  //       ),
                  //       Container(
                  //         alignment: Alignment.center,
                  //         width: MediaQuery
                  //             .of(context)
                  //             .size
                  //             .width < 767 ? 50 : 150,
                  //         child: Wrap(
                  //           children: <Widget>[
                  //             Container(
                  //               width: 50,
                  //               child: RaisedButton(
                  //                 padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  //                 shape: new CircleBorder(),
                  //                 onPressed: () {
                  //                   if (!((item["accept_loading"] != null &&
                  //                       item["accept_loading"]) ||
                  //                       (item["reject_loading"] != null &&
                  //                           item["reject_loading"]))) {
                  //                     _checkForProfile("accepted", item);
                  //                   }
                  //                 },
                  //                 color: FsColor.green,
                  //                 child: item["accept_loading"] != null &&
                  //                     item["accept_loading"]
                  //                     ? CircularProgressIndicator(
                  //                   valueColor: AlwaysStoppedAnimation<Color>(
                  //                       FsColor.white),
                  //                   strokeWidth: 5.0,
                  //                 )
                  //                     : Icon(FlutterIcon.ok,
                  //                     color: FsColor.white,
                  //                     size: FSTextStyle.h5size),
                  //               ),
                  //             ),
                  //             Container(
                  //               width: 50,
                  //               child: RaisedButton(
                  //                 padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  //                 shape: new CircleBorder(),
                  //                 onPressed: () {
                  //                   if (!((item["accept_loading"] != null &&
                  //                       item["accept_loading"]) ||
                  //                       (item["reject_loading"] != null &&
                  //                           item["reject_loading"]))) {
                  //                     _checkForProfile("rejected", item);
                  //                   }
                  //                 },
                  //                 color: FsColor.red,
                  //                 child: item["reject_loading"] != null &&
                  //                     item["reject_loading"]
                  //                     ? CircularProgressIndicator(
                  //                   valueColor: AlwaysStoppedAnimation<Color>(
                  //                       FsColor.white),
                  //                   strokeWidth: 5.0,
                  //                 )
                  //                     : Icon(FlutterIcon.cancel_1,
                  //                     color: FsColor.white,
                  //                     size: FSTextStyle.h5size),
                  //               ),
                  //             )
                  //           ],
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // );

                  return Container(
                    decoration: BoxDecoration(
                        border: Border(
                      bottom: BorderSide(
                          width: 1.0,
                          color: FsColor.lightgrey.withOpacity(0.5)),
                    )),
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              width: 48,
                              height: 48,
                              margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                color: FsColor.darkgrey.withOpacity(0.2),
                              ),
                              child: Icon(FlutterIcon.bell,
                                  color: FsColor.darkgrey,
                                  size: FSTextStyle.h4size),
                            ),
                            Expanded(
                              child: Text(
                                '${item["member_unit_number"]}'.toLowerCase(),
                                style: TextStyle(
                                  fontFamily: 'Gilroy-SemiBold',
                                  fontSize: FSTextStyle.h5size,
                                  color: FsColor.darkgrey,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              onPressed: () {
                                if (!((item["accept_loading"] != null &&
                                        item["accept_loading"]) ||
                                    (item["reject_loading"] != null &&
                                        item["reject_loading"]))) {
                                  _checkForProfile("rejected", item);
                                }
                              },
                              child: item["reject_loading"] != null &&
                                      item["reject_loading"]
                                  ? CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          FsColor.white),
                                      strokeWidth: 5.0,
                                    )
                                  : Text(
                                      'Reject',
                                      style: TextStyle(
                                        fontSize: FSTextStyle.h6size,
                                        fontFamily: 'Gilroy-SemiBold',
                                        letterSpacing: 1,
                                        color: FsColor.red,
                                      ),
                                    ),
                            ),
                            FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              onPressed: () {
                                if (!((item["accept_loading"] != null &&
                                        item["accept_loading"]) ||
                                    (item["reject_loading"] != null &&
                                        item["reject_loading"]))) {
                                  _checkForProfile("accepted", item);
                                }
                              },
                              child: item["accept_loading"] != null &&
                                      item["accept_loading"]
                                  ? CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          FsColor.white),
                                      strokeWidth: 5.0,
                                    )
                                  : Text(
                                      'Accept',
                                      style: TextStyle(
                                        fontSize: FSTextStyle.h6size,
                                        fontFamily: 'Gilroy-SemiBold',
                                        letterSpacing: 1,
                                        color: FsColor.green,
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                afterView: (FsListState v) {
                  listListner = v;
//              Timer(Duration(milliseconds: 100), () {
//                setState(() {
//                  listListner.addListList({
//                    "total": 8,
//                    "per_page": 10,
//                    "current_page": 1,
//                    "last_page": 1,
//                    "from": 1,
//                    "to": 10
//                  }, inviteeslist);
//                });
//              });
                }),
          )),
    );
  }

  @override
  lastPage(int page) {
    // TODO: implement lastPage
//    throw UnimplementedError();
  }

  @override
  loadNextPage(String page) {
    // TODO: implement loadNextPage
//    throw UnimplementedError();
  }

  @override
  void onError(error) {
    invitation["accept_loading"] = false;
    invitation["reject_loading"] = false;
    setState(() {});
    Toasly.error(context, AppUtils.errorDecoder(error));
  }

  @override
  void onFailure(failure) {
    invitation["accept_loading"] = false;
    invitation["reject_loading"] = false;
    setState(() {});
    Toasly.error(context, AppUtils.errorDecoder(failure));
  }

  @override
  void onSuccess(success) {
    var metaData = {
      "total": 1,
      "per_page": 10,
      "current_page": 1,
      "last_page": 1,
      "from": 1,
      "to": 10
    };
    listListner.addListList(metaData, success);
    setState(() {});
  }

  var invitation;
  String action;

  respondInvitation(String action1, var invitationItem) {
    invitation = invitationItem;
    action = action1;

    if (action == "accepted") {
      invitation["accept_loading"] = true;
    } else {
      invitation["reject_loading"] = true;
    }
    setState(() {});
    if (invitation["both_invite"] != null && invitation["both_invite"]) {
      invitationPresenter.respondInvitation(
          action, invitation["invite_id_chsone"].toString(),
          app: AppConstant.CHSONE);
    } else {
      if (invitation["invite_id_chsone"] != null &&
          invitation["invite_id_chsone"].toString().length > 0) {
        invitationPresenter.respondInvitation(
            action, invitation["invite_id_chsone"].toString(),
            app: AppConstant.CHSONE);
      } else {
        invitationPresenter.respondInvitation(
            action, invitation["invite_id_vizlog"].toString(),
            app: AppConstant.VIZLOG);
      }
    }
  }

  void _checkForProfile(String action1, var invitationItem) {
    invitation = invitationItem;
    action = action1;

    SsoStorage.getUserProfile().then((profile) {
      var _userProfiew = profile;

      bool isUnNotSet = false;
      if (_userProfiew["first_name"] == null ||
          _userProfiew["first_name"].toString().length <= 0) {
        isUnNotSet = true;
      }
      bool isEmailSet = false;
      if ((_userProfiew["email"] == null ||
          _userProfiew["email"].toString().length <= 0)) {
        isEmailSet = true;
      }
      if (isUnNotSet || isEmailSet) {
        UpdateProfileDialog(context, onUpdateProfile,
            name: isUnNotSet, email: isEmailSet);
      } else {
        respondInvitation(action1, invitationItem);
      }
    });
  }

  onUpdateProfile() {
    Toasly.success(context, "Successfully updated");
    respondInvitation(action, invitation);
  }

  @override
  void onRespondSuccess(success) {
    if (invitation["both_invite"] != null && invitation["both_invite"]) {
      invitationPresenter.respondInvitation(
          action, invitation["invite_id_vizlog"].toString(),
          app: AppConstant.VIZLOG);
      invitation["both_invite"] = false;
    } else {
      invitation["accept_loading"] = false;
      invitation["reject_loading"] = false;
      Toasly.success(context, success["message"].toString());
      listListner.clearList();
      invitationPresenter.getMemberInvitation();
      isRespond = true;
      setState(() {});
    }
  }

  void backCliked(context) {
    if (isRespond) {
      Navigator.of(context).pushNamed('/loading');
    } else {
      Navigator.pop(context);
    }
  }
}
