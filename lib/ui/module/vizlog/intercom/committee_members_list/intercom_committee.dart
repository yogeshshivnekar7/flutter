import 'package:common_config/utils/application.dart';
import 'package:common_config/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/config/environment/environment.dart';
import 'package:sso_futurescape/config/strings/strings.dart';
import 'package:sso_futurescape/ui/module/vizlog/intercom/gate_list/gate_view.dart';
import 'package:sso_futurescape/ui/module/vizlog/intercom/member_view/member_presenter.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';
import 'package:sso_futurescape/ui/widgets/page_loader.dart';
import 'package:sso_futurescape/utils/app_constant.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/permission/permission_service.dart';
import 'package:sso_futurescape/utils/user_util.dart';

class IntercomCommittee extends StatefulWidget {
  @override
  _IntercomCommitteeState createState() => new _IntercomCommitteeState();
}

class _IntercomCommitteeState extends State<IntercomCommittee>
    implements IntercomView {
  MemberPresenter _memberPresenter;
  String _societyId = "";
  List _committeeMembers = [];
  bool _isLoadingData = true;
  bool _errorInDataLoad = false;
  String _search = "";
  String _dataLoadMsg = null;
  bool _isCallInitiating = false;
  int _calledMemberPosition = -1;
  static const _CALL_TYPE_LOAD_MEMBERS = "LOAD_MEMBERS";
  static const _CALL_TYPE_INIT_CALL = "INIT_CALL";
  static const _TEST_PROFILE_PIC_URL =
      "https://s3.ap-south-1.amazonaws.com/stggateapi.cubeone.biz/visitors/visitor_17637666755466_small.jpg";

  @override
  void initState() {
    _memberPresenter = new MemberPresenter(this);
    loadSocietyId();
    loadCommitteeMembers();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        getSearchFieldWidget(),
        _isLoadingData ? getLoaderWidget() : getContentWidget(),
      ],
    );
  }

  Widget getLoaderWidget() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: PageLoader(),
      ),
    );
  }

  Widget getSearchFieldWidget() {
    return Padding(
      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey[50],
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        child: TextField(
          onChanged: (value) {
            if ((_search == null || _search.trim().isEmpty) &&
                (value == null || value.trim().isEmpty)) {
              return;
            }

            _search = value == null ? "" : value.trim();
            if (_search != null &&
                (_search.trim().length >= 3 || _search.trim().isEmpty)) {
              loadCommitteeMembers();
            }
          },
          style: TextStyle(
            fontSize: 15.0,
            color: FsColor.darkgrey,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
            hintText: FsString.HINT_SEARCH_COMMITTEE_MEMBER,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: FsColor.darkgrey),
            ),
            prefixIcon: Icon(
              FlutterIcon.search_1,
              color: Colors.blueGrey[200],
            ),
            hintStyle: TextStyle(
              fontSize: 15.0,
              color: Colors.blueGrey[300],
            ),
          ),
          maxLines: 1,
        ),
      ),
    );
  }

  Widget getContentWidget() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
        child: _dataLoadMsg == null ? getListWidget() : getErrorWidget(),
      ),
    );
  }

  Widget getListWidget() {
    return ListView(children: [
      ListView.builder(
        primary: false,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: _committeeMembers == null ? 0 : _committeeMembers.length,
        itemBuilder: (BuildContext context, int index) {
          Map committeeMember = _committeeMembers[index];
          return getListItemWidget(committeeMember, index);
        },
      ),
    ]);
  }

  Widget getListItemWidget(itemData, int position) {
    return Padding(
      padding: EdgeInsets.only(bottom: 0),
      child: Container(
        padding: const EdgeInsets.only(
          bottom: 10.0,
          top: 10.0,
        ),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 1, color: FsColor.darkgrey.withOpacity(0.1)))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: itemData["photo"] != null &&
                      itemData["photo"].toString().trim().isNotEmpty
                  ? FadeInImage.assetNetwork(
                      placeholder: FsString.DEFAULT_PROFILE_PIC_ASSET,
                      image: itemData["photo"],
                      height: 42,
                      width: 42,
                      fit: BoxFit.cover,
                      fadeInDuration: Duration(milliseconds: 300),
                      fadeOutDuration: Duration(milliseconds: 100),
                    )
                  : getDefaultProfilePicWidget(),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            '${itemData["name"]}'.toLowerCase(),
                            style: TextStyle(
                                fontSize: FSTextStyle.h6size,
                                fontFamily: 'Gilroy-SemiBold',
                                color: FsColor.primaryvisitor),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        itemData["is_connecting"] != null &&
                                itemData["is_connecting"]
                            ? Text(
                                'Connecting...'.trim().toLowerCase(),
                                style: TextStyle(
                                    fontSize: FSTextStyle.h6size,
                                    fontFamily: 'Gilroy-SemiBold',
                                    color: FsColor.darkgrey),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )
                            : getEmptyWidget()
                      ]),
                  SizedBox(height: 5),
                  Text(
                    '${itemData["committee_designation"]}'.toLowerCase(),
                    style: TextStyle(
                        fontSize: FSTextStyle.h6size,
                        fontFamily: 'Gilroy-SemiBold',
                        color: FsColor.darkgrey),
                  ),
                ],
              ),
            ),
            itemData["is_connecting"] != null && itemData["is_connecting"]
                ? getEmptyWidget()
                : GestureDetector(
                    child: Container(
                      height: 48.0,
                      width: 48.0,
                      alignment: Alignment.center,
                      child: IconButton(
                        onPressed: () {
                          initiateCall(
                              itemData, position, itemData["phone_number"]);
                        },
                        icon: Icon(
                          FlutterIcon.phone_1,
                          color: FsColor.green,
                          size: FSTextStyle.h3size,
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget getErrorWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        getErrorTextWidget(),
        _errorInDataLoad ? getErrorButtonWidget() : getEmptyWidget()
      ],
    );
  }

  Widget getErrorTextWidget() {
    return Text(
      _dataLoadMsg,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontFamily: 'Gilroy-Regular',
          letterSpacing: 1.0,
          height: 1.5,
          fontSize: FSTextStyle.h4size,
          color: FsColor.darkgrey),
    );
  }

  Widget getErrorButtonWidget() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: RaisedButton(
        textColor: FsColor.white,
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(4.0),
        ),
        onPressed: () {
          loadCommitteeMembers();
        },
        child: Text("try again",
            style: TextStyle(
              color: FsColor.white,
              fontSize: FSTextStyle.h6size,
              fontFamily: 'Gilroy-SemiBold',
            )),
        color: FsColor.basicprimary,
      ),
    );
  }

  Widget getEmptyWidget() {
    return SizedBox(
      height: 0,
      width: 0,
    );
  }

  Widget getDefaultProfilePicWidget() {
    return Image.asset(
      FsString.DEFAULT_PROFILE_PIC_ASSET,
      height: 42,
      width: 42,
      fit: BoxFit.cover,
    );
  }

  getInitial(String displayName) {
    return displayName.substring(0, 1).toUpperCase();
  }

  void loadSocietyId() {
    UserUtils.getCurrentUnits(app: AppConstant.VIZLOG).then((unit) {
      if (unit != null) {
        _societyId = unit["soc_id"];
      }
    });
  }

  void loadCommitteeMembers() {
    AppUtils.checkInternetConnection().then((value) {
      if (value) {
        _dataLoadMsg = null;
        _isLoadingData = true;
        _errorInDataLoad = true;
        _committeeMembers.clear();
        setState(() {});
        _memberPresenter.loadCommitteeMembers(
            _CALL_TYPE_LOAD_MEMBERS, _societyId,
            search: _search);
      } else {
        _dataLoadMsg = FsString.ERROR_NO_INTERNET;
        _isLoadingData = false;
        _errorInDataLoad = true;
        _committeeMembers.clear();
        setState(() {});
      }
    });
  }

  void parseCommitteeMembersResponseJson(dynamic responseObj) {
    if (responseObj != null) {
      List dataList = responseObj["data"];
      if (dataList != null && dataList.isNotEmpty) {
        try {
          for (int i = 0; i < dataList.length; i++) {
            var memberObj = dataList[i];
            var visitorObj = memberObj["visitors"];
            _committeeMembers.add({
              "initial": getInitial(visitorObj["first_name"]),
              "photo": memberObj["image_small"],
              "name": AppUtils.getFullName(visitorObj),
              "committee_designation": memberObj["committe_designation"],
              "phone_number": visitorObj["mobile"],
              "visitor_id": visitorObj["visitor_id"],
              "is_connecting": false
            });
          }
          _errorInDataLoad = false;
          _dataLoadMsg = null;
        } catch (e) {
          print(e);
          _errorInDataLoad = true;
          _dataLoadMsg = FsString.ERROR_UNKNOWN_RETRY;
        }
      } else {
        _dataLoadMsg = FsString.ERROR_EMPTY_COMMITTEE_MEMBERS;
        _errorInDataLoad = false;
      }
    }
  }

  void initiateCall(Map member, int position, String to) {
    AppUtils.checkInternetConnection().then((value) {
      if (value) {
        if (!_isCallInitiating) {
          if (Environment.config.geCurrentPlatForm() == FsPlatforms.IOS) {
            _isCallInitiating = true;
            _calledMemberPosition = position;
            member["is_connecting"] = true;
            setState(() {});
            _memberPresenter.initiatCall(to, _CALL_TYPE_INIT_CALL);
          } else if (Environment.config.geCurrentPlatForm() ==
              FsPlatforms.ANDROID) {
            PermissionsService1 permissionsService1 = new PermissionsService1();
            permissionsService1.requestPhonePermission().then((value) {
              if (value) {
                _isCallInitiating = true;
                _calledMemberPosition = position;
                member["is_connecting"] = true;
                setState(() {});
                _memberPresenter.initiatCall(to, _CALL_TYPE_INIT_CALL);
              } else {
                PermissionsService1 permissionsService1 =
                    new PermissionsService1();
                permissionsService1.showPermissionPhoneAlertDialog(context);
              }
            });
          }
        } else {
          Toasly.error(context, FsString.ERROR_CALL_ALREADY_IN_PROGRESS,
              duration: DurationToast.LONG, gravity: Gravity.CENTER);
        }
      } else {
        Toasly.error(context, FsString.ERROR_NO_INTERNET,
            duration: DurationToast.LONG, gravity: Gravity.CENTER);
      }
    });
  }

  void parseMemberCallingResponseJson(dynamic responseObj) {
    String callAt = responseObj["data"]["To"];
    _initCall(callAt);
  }

  _initCall(String callAt) async {
    await FlutterPhoneDirectCaller.callNumber(callAt);
  }

  List getDummyCommitteeMembers() {
    return [
      {
        "photo": "images/default.png",
        "name": "Gerrard Henderson",
        "role": "secretary",
      },
      {
        "photo": "images/default.png",
        "name": "Josephine Mayo",
        "role": "secretary",
      },
      {
        "photo": "images/default.png",
        "name": "Steffan Harding",
        "role": "secretary",
      },
      {
        "photo": "images/default.png",
        "name": "Nancy Mullen",
        "role": "secretary",
      },
    ];
  }

  @override
  error(error, {callingType}) {
    if (callingType == _CALL_TYPE_LOAD_MEMBERS) {
      _isLoadingData = false;
      _dataLoadMsg = FsString.ERROR_UNKNOWN_RETRY;
      _errorInDataLoad = true;
      _committeeMembers.clear();
      setState(() {});
    } else if (callingType == _CALL_TYPE_INIT_CALL) {
      _isCallInitiating = false;
      if (_calledMemberPosition >= 0 &&
          _calledMemberPosition < _committeeMembers.length) {
        _committeeMembers[_calledMemberPosition]["is_connecting"] = false;
      }
      _calledMemberPosition = -1;
      setState(() {});
    }
  }

  @override
  failure(failed, {callingType}) {
    if (callingType == _CALL_TYPE_LOAD_MEMBERS) {
      _isLoadingData = false;
      _dataLoadMsg = FsString.ERROR_LOAD_COMMITTEE_MEMBERS;
      _errorInDataLoad = true;
      _committeeMembers.clear();
      setState(() {});
    } else if (callingType == _CALL_TYPE_INIT_CALL) {
      _isCallInitiating = false;
      if (_calledMemberPosition >= 0 &&
          _calledMemberPosition < _committeeMembers.length) {
        _committeeMembers[_calledMemberPosition]["is_connecting"] = false;
      }
      _calledMemberPosition = -1;
      setState(() {});
    }
  }

  @override
  success(success, {callingType}) {
    if (callingType == _CALL_TYPE_LOAD_MEMBERS) {
      _isLoadingData = false;
      _committeeMembers.clear();
      parseCommitteeMembersResponseJson(success);
      setState(() {});
    } else if (callingType == _CALL_TYPE_INIT_CALL) {
      _isCallInitiating = false;
      if (_calledMemberPosition >= 0 &&
          _calledMemberPosition < _committeeMembers.length) {
        _committeeMembers[_calledMemberPosition]["is_connecting"] = false;
      }
      _calledMemberPosition = -1;
      parseMemberCallingResponseJson(success);
      setState(() {});
    }
  }
}
