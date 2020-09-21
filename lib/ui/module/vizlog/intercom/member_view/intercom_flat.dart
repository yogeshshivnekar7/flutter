import 'package:common_config/utils/application.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:random_color/random_color.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/config/environment/environment.dart';
import 'package:sso_futurescape/config/strings/strings.dart';
import 'package:sso_futurescape/ui/module/vizlog/intercom/gate_list/gate_view.dart';
import 'package:sso_futurescape/ui/module/vizlog/intercom/member_view/member_presenter.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';
import 'package:sso_futurescape/ui/widgets/no_data.dart';
import 'package:sso_futurescape/ui/widgets/page_loader.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/permission/permission_service.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

// Ref Link : https://www.developerlibs.com/2018/06/flutter-apply-search-box-in-appbar.html

class IntercomFlat extends StatefulWidget {
  var building;

  IntercomFlat(this.building);

  @override
  _IntercomFlatState createState() => new _IntercomFlatState(building);
}

class _IntercomFlatState extends State<IntercomFlat> implements IntercomView {
  List intercomunits = [];

  var building;

  MemberPresenter presnter;

  var MEMBERDETAILS = "member_details";

  var userId = 0;

  bool noRecordfound = false;

  bool isSearching = false;

  var _randomColor;

  bool isCallInitiating = false;

  Map selectedMember;

  var initatCall = "init_call";

  _IntercomFlatState(this.building);

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    userProfile();
    _randomColor = RandomColor();
    isLoading = true;
    print("building ---- $building");
    presnter = new MemberPresenter(this);
    presnter.getMemberDetails(MEMBERDETAILS, "1",
        buildingId: building["building_id"].toString(), perPage: "1000");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 1,
        backgroundColor: FsColor.primaryvisitor,
        leading: FsBackButtonlight(),
        title: GestureDetector(
            child: Row(
          children: [
            Icon(
              FlutterIcon.building,
              color: FsColor.white.withOpacity(0.5),
              size: FSTextStyle.h2size,
            ),
            SizedBox(width: 10),
            Text(
              building["name"],
              style: FSTextStyle.appbartextlight,
            ),
          ],
        )),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blueGrey[50],
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              child: TextField(
                onChanged: (text) {
                  if (text.length > 2) {
                    if (!isLoading) {
                      isLoading = true;
                      setState(() {});
                    }

                    changeQuery(text);
//                        setState(() {});
                  } else {
                    if (text.length == 0) {
                      changeQuery(null);
                    }
                    if (isLoading) {
                      isLoading = false;
                      setState(() {});
                    }
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
                  hintText: "search member name or flat number",
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
          ),
          isLoading
              ? PageLoader()
              : noRecordfound
                  ? FsNoData(
                      title: false,
                      message: FsString.NO_RECORDS_FIND,
                    )
                  : CardList(),
        ],
      ),
    );
  }

  Widget CardList() {
    return Expanded(
      child: ListView(
        children: [
          ListView.builder(
            primary: false,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: intercomunits == null ? 0 : intercomunits.length,
            itemBuilder: (BuildContext context, int index) {
              Map listunits = intercomunits[index];
              List intercomlistmembers = listunits["list_member"];
              return Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            width: 1,
                            color: FsColor.darkgrey.withOpacity(0.1)))),
                child: ExpansionTile(
                  initiallyExpanded: isSearching,
//                    tilePadding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                  title: Container(
                    child: Row(
                      children: [
                        Text(
                          "Flat No : ${listunits["unit"]}",
                          style: TextStyle(
                              fontSize: FSTextStyle.h6size,
                              fontFamily: 'Gilroy-SemiBold',
                              color: FsColor.darkgrey),
                        ),
                        listunits["iscovidavailable"]
                            ? Container(
                                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.0),
                                  color: FsColor.red.withOpacity(0.2),
                                ),
                                child: Text(
                                  'covid-19',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: FSTextStyle.h7size,
                                    fontFamily: 'Gilroy-SemiBold',
                                    letterSpacing: 0.5,
                                    color: FsColor.red,
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),

                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                      child: ListView.builder(
                        primary: false,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: intercomlistmembers == null
                            ? 0
                            : intercomlistmembers.length,
                        itemBuilder: (BuildContext context, int index) {
                          Map listmembers = intercomlistmembers[index];
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
                                          width: 1,
                                          color: FsColor.darkgrey
                                              .withOpacity(0.1)))),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
//                                  ClipRRect(
//                                    borderRadius: BorderRadius.circular(25),
//                                    child: Image.asset(
//                                      "${listmembers["photo"]}",
//                                      height: 42,
//                                      width: 42,
//                                      fit: BoxFit.cover,
//                                    ),
//                                  ),
                                  Container(
                                    width: 42,
                                    height: 42,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: _randomColor.randomColor(),
                                    ),
                                    child: Text(
                                      listmembers["initial"],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: FSTextStyle.h3size,
                                          fontFamily: 'Gilroy-Regular',
                                          color: FsColor.white),
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${listmembers["name"]}'
                                              .toLowerCase(),
                                          style: TextStyle(
                                              fontSize: FSTextStyle.h6size,
                                              fontFamily: 'Gilroy-SemiBold',
                                              color: FsColor.primaryvisitor),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          '${listmembers["type"]}'
                                              .toLowerCase(),
                                          style: TextStyle(
                                              fontSize: FSTextStyle.h6size,
                                              fontFamily: 'Gilroy-SemiBold',
                                              color: FsColor.darkgrey),
                                        ),
                                      ],
                                    ),
                                  ),
                                  listmembers["connecting"] != null &&
                                          listmembers["connecting"]
                                      ? Text(
                                          'Connecting...'.toLowerCase(),
                                          style: TextStyle(
                                              fontSize: FSTextStyle.h6size,
                                              fontFamily: 'Gilroy-SemiBold',
                                              color: FsColor.darkgrey),
                                        )
                                      : GestureDetector(
                                          child: Container(
                                            height: 48.0,
                                            width: 48.0,
                                            alignment: Alignment.center,
                                            child: IconButton(
                                              onPressed: () {
                                                initiatCall(
                                                    listmembers,
                                                    listmembers[
                                                        "phone_number"]);
                                              },
                                              icon: Icon(
                                                FlutterIcon.phone_1,
                                                color: FsColor.green,
                                                size: FSTextStyle.h3size,
                                              ),
                                            ),
                                          ),
                                        )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  error(error, {callingType}) {
    setState(() {
      isLoading = false;
    });
  }

  @override
  failure(failed, {callingType}) {
    setState(() {
      isLoading = false;
    });
  }

  @override
  success(success, {callingType}) {
    if (callingType == initatCall) {
      isCallInitiating = false;
      selectedMember["connecting"] = false;
      String callAt = success["data"]["To"];
      setState(() {});
      _initCall(callAt);
//      AppUtils.callIntent(callAt);
    } else {
      print("intercomSuccess --- $success");
      List list = success["data"]["results"];
      var metaData = success["data"]["metadata"];
      mergeList(metaData, list);
    }
  }

  void userProfile() {
    SsoStorage.getUserProfile().then((profile) {
      print("profile -------- $profile");
      userId = profile["user_id"];
    });
  }

  void mergeList(metaData, List list) {
    print("list --- $list");
    print(list.length);

    if (list != null && list.length > 0) {
      intercomunits = [];
      for (int i = 0; i < list.length; i++) {
        var memberDetails = list[i];
//        print("memberDetails---- $memberDetails");
        String unitNo = memberDetails["unit_number"];
        List listMem = memberDetails["member"];
        Map building = memberDetails["building"];
        String tags = memberDetails["tags"];
        List memberList = [];
//        print("member-------- $listMem");
        for (int j = 0; listMem != null && j < listMem.length; j++) {
          var mem = listMem[j];
          if (mem["auth_id"] != userId) {
            var vistor = mem["visitors"];
            if (vistor != null) {
              memberList.add({
                "initial": getInitial(vistor["first_name"]),
                "type": getMemberType(mem["member_type"]),
                "photo": "images/default.png",
                "name": AppUtils.getFullName(vistor),
                "unit": building["building_name"] + ", " + unitNo,
                "phone_number": vistor["mobile"],
              });
            }
          }
        }
        noRecordfound = false;
        if (memberList.length > 0) {
          intercomunits.add({
            "unit": unitNo,
            "list_member": memberList,
            "iscovidavailable":
                tags != null && tags == 'covid-19' ? true : false
          });
        }
      }
    } else {
      noRecordfound = true;
    }

    setState(() {
      isLoading = false;
    });
  }

  getMemberType(memType) {
    print("member_tuype -- $memType");
    if ("owner" == memType.toString().toLowerCase()) {
      return "member";
    }
    return memType;
  }

  getInitial(String displayName) {
    return displayName.substring(0, 1).toUpperCase();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void changeQuery(String text) {
    if (text == null) {
      isSearching = false;
      presnter.getMemberDetails(MEMBERDETAILS, "1",
          buildingId: building["building_id"].toString(), perPage: "1000");
      setState(() {});
    } else {
      isSearching = true;
      presnter.getMemberDetails(MEMBERDETAILS, "1",
          search: text,
          buildingId: building["building_id"].toString(),
          perPage: "1000");
    }
  }

  void initiatCall(Map member, String to) {
    if (!isCallInitiating) {
      selectedMember = member;
//    print(Environment.config.geCurrentPlatForm());
      if (Environment.config.geCurrentPlatForm() == FsPlatforms.IOS) {
        isCallInitiating = true;
        member["connecting"] = true;
        setState(() {});
        presnter.initiatCall(to, initatCall);
      } else if (Environment.config.geCurrentPlatForm() ==
          FsPlatforms.ANDROID) {
        PermissionsService1 permissionsService1 = new PermissionsService1();
        permissionsService1.requestPhonePermission().then((value) {
          if (value) {
            isCallInitiating = true;
            member["connecting"] = true;
            setState(() {});
            presnter.initiatCall(to, initatCall);
          } else {
            PermissionsService1 permissionsService1 = new PermissionsService1();
            permissionsService1.showPermissionPhoneAlertDialog(context);
          }
        });
      }
    }
  }

  _initCall(String callAt) async {
    await FlutterPhoneDirectCaller.callNumber(callAt);
//    await new CallNumber().callNumber(callAt);
  }
}
