import 'package:common_config/utils/application.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:random_color/random_color.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/config/environment/environment.dart';
import 'package:sso_futurescape/config/strings/strings.dart';
import 'package:sso_futurescape/presentor/module/member_invitation/member_invitaion_model.dart';
import 'package:sso_futurescape/ui/module/vizlog/intercom/gate_list/gate_view.dart';
import 'package:sso_futurescape/ui/module/vizlog/intercom/member_view/intercom_flat.dart';
import 'package:sso_futurescape/ui/module/vizlog/intercom/member_view/member_presenter.dart';
import 'package:sso_futurescape/ui/widgets/list_widget.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';
import 'package:sso_futurescape/ui/widgets/page_loader.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/permission/permission_service.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

import '../query_change.dart';

class IntercomAllMembers extends StatefulWidget {
//  String searchQuery;

  _IntercomAllMembersState v;

//  Function onTextChanged;

  IntercomAllMembers();

  @override
  _IntercomAllMembersState createState() {
    v = new _IntercomAllMembersState();
    return v;
  }
}

class _IntercomAllMembersState extends State<IntercomAllMembers>
    implements PageLoadListener, IntercomView, OnQueryChange {
  FsListState listListner;

  MemberPresenter presnter;

  var MEMBERDETAILS = "member_details";

  int userId = 0;

  var MEMBERDETAILS_SEARCH = "mem_search";

  bool isCallInitiating = false;

  var initatCall = "initcall";

  bool isTower = true;

  var intercomlisttower = [];

  bool isTowerLoading = false;

  var _randomColor;

  String searchQuery="";

  ScrollController _scrollController = ScrollController();

  var metadata;

  bool isScrolling=false;

  _IntercomAllMembersState() {
//    onChangedText(this);
//      print("_IntercomAllMembersState ---- $searchQuery");
  }

  @override
  void initState() {
    // TODO: implement initState
    _scrollController.addListener(() {
//      print("ssssssssssssssss");
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print("position.maxScrollExtent");
        if(!isTower){
        if (metadata == null ||
            metadata['last_page'] != metadata['current_page']) {
          print("page no " + metadata.toString());
          String pageNumber =
          metadata == null || metadata['current_page'].toString() == null
              ? '1'
              : (metadata['current_page'] + 1).toString();
          isScrolling=true;
          setState(() { });
          loadNextPage(pageNumber);
//          loadMore(pageNumber);
        }
        }

      }
    });
    super.initState();
    userProfile();
    _randomColor = RandomColor();
    presnter = new MemberPresenter(this);
    isTowerLoading = true;
    presnter.getBuilding();
    setState(() {});
//    presnter.getMemberDetails(MEMBERDETAILS, "1");
  }

  void userProfile() {
    SsoStorage.getUserProfile().then((profile) {
      print("profile -------- $profile");
      userId = profile["user_id"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
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
              onChanged: (String text) {
                print(text);
                searchQuery=text;

                if (text.length > 2) {
                  if (isTower) {
                    isTower = false;
                    setState(() {});
                  }

                  changeQuery(text);
//                        setState(() {});
                } else {
//                  if(text.length==0){
                    if (!isTower) {
                      isTower = true;
                      isTowerLoading=true;
                      presnter.getBuilding();
                      setState(() {});
                    }

//                  }
//                  if (!isTower) {
//                    isTower = true;
//                    setState(() {});
//                  }
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
        Expanded(
          child: ListView(
            controller: _scrollController,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: isTower
                    ? isTowerLoading
                        ? PageLoader()
                        : GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 5.0,
                              mainAxisSpacing: 5.0,
                              // childAspectRatio: 2.0,
                              childAspectRatio: MediaQuery.of(context)
                                      .size
                                      .width /
                                  (MediaQuery.of(context).size.height / 3.0),
                            ),
                            primary: false,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: intercomlisttower == null
                                ? 0
                                : intercomlisttower.length,
                            itemBuilder: (BuildContext context, int index) {
                              Map listtower = intercomlisttower[index];

                              return Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 5.0, top: 5.0),
                                child: InkWell(
                                  child: listtower["selected"]
                                      ? Container(
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.only(
                                            bottom: 5.0,
                                            top: 5.0,
                                          ),
                                          decoration: BoxDecoration(
                                            color: FsColor.primaryvisitor
                                                .withOpacity(0.1),
                                            border: Border.all(
                                                width: 1.0,
                                                color: FsColor.primaryvisitor),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4.0)),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                child: Icon(
                                                    FlutterIcon.building,
                                                    color: FsColor.darkgrey,
                                                    size: FSTextStyle.h1size),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      100,
                                                  child: Text(
                                                    '${listtower["name"]}',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'Gilroy-SemiBold',
                                                      fontSize:
                                                          FSTextStyle.h6size,
                                                      color: FsColor.darkgrey,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Container(
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.only(
                                            bottom: 5.0,
                                            top: 5.0,
                                          ),
                                          // height: 85,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                child: Icon(
                                                    FlutterIcon.building,
                                                    color: FsColor.darkgrey,
                                                    size: FSTextStyle.h1size),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  // height: 80,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      100,
                                                  child: Text(
                                                    '${listtower["name"]}',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'Gilroy-SemiBold',
                                                      fontSize:
                                                          FSTextStyle.h6size,
                                                      color: FsColor.darkgrey,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              IntercomFlat(listtower)),
                                    );
                                  },
                                ),
                              );
                            },
                          )
                    :
                FsListWidget(

                    shrinkWrap: true,
                    title: false,
                    message: FsString.NO_RECORDS_FIND,
                    pageLoadListner: this,
                    itemBuilder:
                        (BuildContext context, int index, var item) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Card(
                          elevation: 1.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(4.0),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 0, left: 5),
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
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: <Widget>[
//                              ClipRRect(
//                                borderRadius: BorderRadius.circular(25),
//                                child: Image.asset(
//                                  "${item["photo"]}",
//                                  height: 42,
//                                  width: 42,
//                                  fit: BoxFit.cover,
//                                ),
//                              ),
                                  Container(
                                    width: 42,
                                    height: 42,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(25),
                                      color: _randomColor.randomColor(),
                                    ),
                                    child: Text(
                                      item["initial"],
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
                                          '${item["name"]}'.toLowerCase(),
                                          style: TextStyle(
                                              fontSize: FSTextStyle.h6size,
                                              fontFamily: 'Gilroy-SemiBold',
                                              color:
                                              FsColor.primaryvisitor),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          '${item["unit"]}'.toLowerCase(),
                                          style: TextStyle(
                                              fontSize: FSTextStyle.h6size,
                                              fontFamily: 'Gilroy-SemiBold',
                                              color: FsColor.darkgrey),
                                        ),
                                      ],
                                    ),
                                  ),
                                  item["connecting"] != null &&
                                      item["connecting"]
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
                                          initiatCall(item,
                                              item["phone_number"]);
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
                          ),
                        ),
                      );
                    },
                    afterView: (FsListState v) {
                      listListner = v;
                    }),

              )
            ],
          ),
        ),
        _loader(),
      ],
    );
  }


  Widget _loader() {
    return isScrolling
        ? new Align(
      child: new Container(
        width: 45.0,
        height: 45.0,
        child: new Padding(
            padding: const EdgeInsets.all(5.0),
            child: new Center(
                child: new CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(
                      FsColor.primaryvisitor),
                ))),
      ),
      alignment: FractionalOffset.bottomCenter,
    )
        : new SizedBox(
      width: 0.0,
      height: 0.0,
    );
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  lastPage(int page) {
    // TODO: implement lastPage
  }

  @override
  loadNextPage(String page) {
    print("load next page -- "+page);
    if(searchQuery==null || searchQuery.length<=0){
      presnter.getMemberDetails(MEMBERDETAILS, page);
    }else {
      presnter.getMemberDetails(searchQuery, page, search: searchQuery);
    }
  }

  @override
  error(error, {callingType}) {
    // TODO: implement error
    print("error --- $error");

//    Toasly.error(context, error.toString());
    if (callingType == null) {
      isTowerLoading = false;
      setState(() {});
    }
  }

  @override
  failure(failure, {callingType}) {
    // TODO: implement failure
    print("failure--- $failure");
//    Toasly.error(context, failure.toString());
    if (callingType == null) {
      isTowerLoading = false;
      setState(() {});
    }
  }

  @override
  success(success, {callingType}) {
    print("intercomSuccess callingType --- $callingType");
    print("intercomSuccess --- $success");
    List list = success["data"]["results"];
    var metaData = success["data"]["metadata"];
    print("list --- $list");
    if (callingType == initatCall) {
      isCallInitiating = false;
      selectedMember["connecting"] = false;
      String callAt = success["data"]["To"];
      setState(() {});
      _initCall(callAt);
//      AppUtils.callIntent(callAt);
    }
    else if (callingType == MEMBERDETAILS ||
        callingType == searchQuery) {
//      if (callingType == MEMBERDETAILS_SEARCH) {
//        listListner.clearListAndData();
//      }
//      else if(callingType==searchQuery){
//        mergeList(metaData, list);
//      }
      this.metadata=metaData;
      mergeList(metaData, list);

    }
    else if(callingType==null){
      mergeTower(list);
      isTowerLoading = false;
      setState(() {});
    }
  }

  _initCall(String callAt) async {
    await FlutterPhoneDirectCaller.callNumber(callAt);
//    await new CallNumber().callNumber(callAt);
  }

  void mergeList(metaData, List list) {
    List memberList = [];
    print("list --- $list");
    print(list.length);
    if (list != null && list.length > 0) {
      for (int i = 0; i < list.length; i++) {
        var memberDetails = list[i];
//        print("memberDetails---- $memberDetails");
        String unitNo = memberDetails["unit_number"];
        List listMem = memberDetails["member"];
        Map building = memberDetails["building"];
//        print("member-------- $listMem");
        for (int j = 0; listMem != null && j < listMem.length; j++) {
          var mem = listMem[j];
          if (mem["auth_id"] != userId) {
            var vistor = mem["visitors"];
            if (vistor != null) {
              memberList.add({
                "initial": getInitial(vistor["first_name"]),
                "photo": "images/default.png",
                "name": AppUtils.getFullName(vistor),
                "unit": building["building_name"] + ", " + unitNo,
                "phone_number": vistor["mobile"],
              });
            }
          }
        }
      }
    }
    listListner.addListList(metaData, memberList);
    isScrolling=false;
    setState(() { });
  }

  getInitial(String displayName) {
    return displayName.substring(0, 1).toUpperCase();
  }

  Map selectedMember;

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

  void changeQuery(String search) {
    print("ssninini" + search);

    if (search != null && search.length > 2) {
      presnter.getMemberDetails(search, "1", search: search);
      listListner.clearListAndData();
    } else if (search.length <= 0) {
      presnter.getMemberDetails(MEMBERDETAILS, "1");
      listListner.clearListAndData();
    }
  }

  void mergeTower(List list) {
    intercomlisttower = [];
    for (int i = 0; i < list.length; i++) {
      intercomlisttower.add({
        "name": list[i]["building_name"],
        "selected": false,
        "building_id": list[i]["building_id"]
      });
    }
    setState(() {});
  }
}
