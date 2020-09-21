//import 'package:call_number/call_number.dart';
import 'package:common_config/utils/application.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/config/environment/environment.dart';
import 'package:sso_futurescape/config/strings/strings.dart';
import 'package:sso_futurescape/ui/module/vizlog/intercom/gate_list/gate_presenter.dart';
import 'package:sso_futurescape/ui/module/vizlog/intercom/gate_list/gate_view.dart';
import 'package:sso_futurescape/ui/widgets/list_widget.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';
import 'package:sso_futurescape/utils/permission/permission_service.dart';


class GateLists extends StatefulWidget {
  var currentUnit;

//  Function onQueryChange;

  GateLists(this.currentUnit);

  @override
  _GateListsState createState() =>
      new _GateListsState(currentUnit);
}

class _GateListsState extends State<GateLists>
    implements IntercomView, PageLoadListener {
  List gatelist = [];

  var currentUnit;

  String socId;

//  String unitId;

  var callingTypeGate = "gate_list";

  bool isLoading = false;

  GatePresenter presenter;

  var initatCall = "gsm_calling";

  bool isCallInitiating = false;

  FsListState listListner;

  _GateListsState(this.currentUnit) {
//    onQueryChange(this);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    socId = currentUnit["soc_id"].toString();
    isLoading = true;
    presenter = new GatePresenter(this);
    presenter.getGateDetails(callingTypeGate, socId);
  }

  @override
  Widget build(BuildContext context) {
    return
      Column(
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
                  changeQuery(text);
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
                  hintText: "search gate",
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
            child: Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: FsListWidget(
                  title: false,
                  message: FsString.NO_RECORDS_FIND,
                  pageLoadListner: this,
                  itemBuilder: (BuildContext context, int index, var item) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 0.0),
                      child: Card(
                        elevation: 1.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(4.0),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                              bottom: 0, left: 5, right: 5),
                          child: Container(
                            padding: const EdgeInsets.only(
                              bottom: 10.0,
                              left: 5,
                              right: 5,
                              top: 10.0,
                            ),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1,
                                        color: FsColor.darkgrey.withOpacity(
                                            0.1)))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  width: 52,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: FsColor.lightgrey),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  padding: EdgeInsets.all(0),
                                  child: Column(
                                    children: [
                                      Container(
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(5),
                                            child: Image.asset(
                                              "images/gate.png",
                                              height: 48,
                                              width: 48,
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                      ),
                                      Container(
                                        width: 52,
                                        color: getGateStatus(item) ? FsColor
                                            .primaryvisitor : FsColor
                                            .lightgreybg,
                                        child: Text(getGateStatus(item)
                                            ? "online"
                                            : "offline",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: FSTextStyle.h7size,
                                              fontFamily: 'Gilroy-SemiBold',
                                              color: getGateStatus(item)
                                                  ? FsColor.white
                                                  : FsColor.darkgrey),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                /*ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: Image.asset(
                                    "images/gate.png",
                                    height: 42,
                                    width: 42,
                                    fit: BoxFit.cover,
                                  ),
                                ),*/
                                SizedBox(width: 15),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text(
                                        '${item["gate_name"] }'.toLowerCase(),
                                        style: TextStyle(
                                            fontSize: FSTextStyle.h6size,
                                            fontFamily: 'Gilroy-SemiBold',
                                            color: FsColor.darkgrey),
                                      ),
                                    ],
                                  ),
                                ),
                                item["connecting"] != null && item["connecting"]
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
                                        String to = item["user"]["mobile"];
                                        print(item["user"]["mobile"]);
                                        initiatCall(item, to);
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
            ),
          )
        ],
      );
  }

  bool getGateStatus(item) {
    if (item["gate_status"] == null ||
        item["gate_status"].toString().toLowerCase() == "offline") {
      return false;
    } else {
      return true;
    }
  }

  @override
  error(error, {callingType}) {
    notifyUpdate();
  }

  @override
  failure(failed, {callingType}) {
    notifyUpdate();
  }

  @override
  success(success, {callingType}) {
    if (callingType == callingTypeGate) {
      listListner.clearListAndData();
      mergeData(success);
      notifyUpdate();
    } else if (callingType == initatCall) {
      isCallInitiating = false;
      selectedGate["connecting"] = false;
      String callAt = success["data"]["To"];
      setState(() {});
      _initCall(callAt);
//      AppUtils.callIntent(callAt);
    }
  }

  _initCall(String callAt) async {
    await FlutterPhoneDirectCaller.callNumber(callAt);
//    await new CallNumber().callNumber(callAt);
  }

  void notifyUpdate() {
    isLoading = false;

    setState(() {});
  }

  void mergeData(success) {
    print("success ---- $success");
    gatelist = [];
    List tempList = success["data"]["results"];
    var metadata = success["data"]["metadata"];
    if (tempList != null && tempList.length > 0) {
      for (int i = 0; i < tempList.length; i++) {
        if (tempList[i]["user"] != null) {
          gatelist.add(tempList[i]);
        }
      }
    }
    listListner.addListList(metadata, gatelist);

    setState(() {});
  }

  Map selectedGate;

  void initiatCall(Map gate, String to) {
    if (!isCallInitiating) {
      selectedGate = gate;
//    print(Environment.config.geCurrentPlatForm());
      if (Environment.config.geCurrentPlatForm() == FsPlatforms.IOS) {
        isCallInitiating = true;
        gate["connecting"] = true;
        setState(() {});
        presenter.initiatCall(to, initatCall);
      } else if (Environment.config.geCurrentPlatForm() ==
          FsPlatforms.ANDROID) {
        PermissionsService1 permissionsService1 = new PermissionsService1();
        permissionsService1.requestPhonePermission().then((value) {
          if (value) {
            isCallInitiating = true;
            gate["connecting"] = true;
            setState(() {});
            presenter.initiatCall(to, initatCall);
          } else {
            PermissionsService1 permissionsService1 = new PermissionsService1();
            permissionsService1.showPermissionPhoneAlertDialog(context);
          }
        });
      }
    }
  }


  void changeQuery(String search) {
    print("search gate--- $search");
    if (search.length > 2) {
      listListner.clearListAndData();
      presenter.getGateDetails(callingTypeGate, socId, search: search);
    } else if (search.length == 0) {
      listListner.clearListAndData();
      presenter.getGateDetails(callingTypeGate, socId);
    }
  }

  @override
  lastPage(int page) {
    // TODO: implement lastPage
    throw UnimplementedError();
  }

  @override
  loadNextPage(String page) {
    // TODO: implement loadNextPage
    throw UnimplementedError();
  }
}
