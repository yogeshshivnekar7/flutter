import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/config/strings/strings.dart';
import 'package:sso_futurescape/presentor/module/vizlog/login/login_presentor.dart';
import 'package:sso_futurescape/presentor/module/vizlog/login/login_view.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/ui/widgets/list_widget.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';
import 'package:sso_futurescape/utils/app_constant.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/user_util.dart';

class MyVisitorsList extends StatefulWidget {
  @override
  _MyVisitorsListState createState() => new _MyVisitorsListState();
}

class _MyVisitorsListState extends State<MyVisitorsList>
    implements PageLoadListener, VizLoginView {
  FsListState listListner;

  VizlogLoginPresentor vizLoginPresentor;

  var visitors = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    vizLoginPresentor = new VizlogLoginPresentor(this);
    getUnitDetails();
  }

  String _socId;
  var _unitId;
  String _memberId;

  void getUnitDetails() {
    UserUtils.getCurrentUnits(app: AppConstant.VIZLOG).then((unit) {
      if (unit == null) {
        setState(() {});
      } else {
        _socId = unit["soc_id"].toString();
        _unitId = unit["unit_id"].toString();
        _memberId = unit["member_id"].toString();
        vizLoginPresentor.getVisitors(_socId, _unitId,
            memberId: unit["member_id"]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(
          'My Visitors'.toLowerCase(),
          style: FSTextStyle.appbartextlight,
        ),
        elevation: 1.0,
        backgroundColor: FsColor.primaryvisitor,
        leading: FsBackButtonlight(),
      ),
      body: Padding(
          padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
          child: Center(
            child: FsListWidget(
                title: false,
                message: FsString.NO_VISITORS,
                pageLoadListner: this,
                itemBuilder: (BuildContext context, int index, var item) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Center(
                      child: Card(
                        elevation: 1.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(4.0),
                          ),
                        ),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(25),
                                    child: getImage(item),
                                  ),
                                  SizedBox(width: 10.0),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.topLeft,
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            '${item["first_name"]}'
                                                .toLowerCase(),
                                            style: TextStyle(
                                                fontSize: FSTextStyle.h5size,
                                                fontFamily: 'Gilroy-SemiBold',
                                                color: FsColor.primaryvisitor),
                                          ),
                                          SizedBox(height: 5),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Row(
                                                children: <Widget>[
                                                  Image.asset(
                                                    "images/purpose.png",
                                                    width: 18,
                                                    height: 18,
                                                    fit: BoxFit.contain,
                                                  ),
                                                  // Icon(FlutterIcon.location_1,
                                                  //     color: FsColor.lightgrey,
                                                  //     size: FSTextStyle.h6size),
                                                  Text(
                                                    '${item["purpose"]}'
                                                        .toLowerCase(),
                                                    style: TextStyle(
                                                        fontSize:
                                                        FSTextStyle.h6size,
                                                        fontFamily:
                                                        'Gilroy-SemiBold',
                                                        color:
                                                        FsColor.darkgrey),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(width: 15),
                                              Row(
                                                children: <Widget>[
                                                  Icon(FlutterIcon.location_1,
                                                      color: FsColor.lightgrey,
                                                      size: FSTextStyle.h6size),
                                                  Text(
                                                    '${item["coming_from"]}'
                                                        .toLowerCase(),
                                                    style: TextStyle(
                                                        fontSize:
                                                        FSTextStyle.h6size,
                                                        fontFamily:
                                                        'Gilroy-SemiBold',
                                                        color:
                                                        FsColor.darkgrey),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 5),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                child: Row(
                                                  children: <Widget>[
                                                    Image.asset(
                                                      'images/in.png',
                                                      fit: BoxFit.contain,
                                                      width: 20.0,
                                                      height: 20.0,
                                                    ),
                                                    SizedBox(
                                                      width: 5.0,
                                                    ),
                                                    Text(
                                                      '${item["in_time"]}',
                                                      style: TextStyle(
                                                          fontSize: FSTextStyle
                                                              .h6size,
                                                          fontFamily:
                                                          'Gilroy-SemiBold',
                                                          color:
                                                          FsColor.darkgrey),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(width: 20.0),
                                              item["is_out"]
                                                  ? Container(
                                                  child: Row(
                                                    children: <Widget>[
                                                      Image.asset(
                                                        'images/out.png',
                                                        fit: BoxFit.contain,
                                                        width: 20.0,
                                                        height: 20.0,
                                                      ),
                                                      SizedBox(
                                                        width: 5.0,
                                                      ),
                                                      Text(
                                                        '${item["out_time"]}',
                                                        style: TextStyle(
                                                            fontSize:
                                                            FSTextStyle
                                                                .h6size,
                                                            fontFamily:
                                                            'Gilroy-SemiBold',
                                                            color: FsColor
                                                                .darkgrey),
                                                      ),
                                                    ],
                                                  ))
                                                  : Container(),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0, 0.0),
                                padding: EdgeInsets.fromLTRB(0.0, 0.0, 0, 0.0),
                                decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                          width: 1.0,
                                          color: FsColor.basicprimary
                                              .withOpacity(0.2)),
                                    )),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    item["is_out"]
                                        ? Container(
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.end,
                                        children: <Widget>[
                                          Text(
                                            "Duration : ".toLowerCase(),
                                            style: TextStyle(
                                                fontSize:
                                                FSTextStyle.h6size,
                                                fontFamily:
                                                'Gilroy-SemiBold',
                                                color: FsColor.lightgrey),
                                          ),
                                          Text(
                                            "${item["duration"]}",
                                            style: TextStyle(
                                                fontSize:
                                                FSTextStyle.h6size,
                                                fontFamily:
                                                'Gilroy-SemiBold',
                                                color: FsColor.darkgrey),
                                          ),
                                        ],
                                      ),
                                    )
                                        : Container(
                                      // color: FsColor.primarytiffin.withOpacity(0.2),
                                      padding: EdgeInsets.fromLTRB(
                                          15.0, 5.0, 15, 5.0),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1.0,
                                            color: FsColor.lightgrey),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.0)),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.end,
                                        children: <Widget>[
                                          Text(
                                            "inside",
                                            style: TextStyle(
                                                fontSize:
                                                FSTextStyle.h7size,
                                                fontFamily:
                                                'Gilroy-SemiBold',
                                                color: FsColor.darkgrey),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: GestureDetector(
                                        child: FlatButton(
                                          onPressed: () {
                                            AppUtils.launchUrl(
                                                "tel:" + item["mobile"]);
                                          },
                                          child: Row(
                                            children: <Widget>[
                                              Icon(FlutterIcon.phone_1,
                                                  color: FsColor.darkgrey,
                                                  size: FSTextStyle.h6size),
                                              SizedBox(width: 5),
                                              Text(
                                                "Call",
                                                style: TextStyle(
                                                    fontSize:
                                                    FSTextStyle.h6size,
                                                    fontFamily: 'Gilroy-Bold',
                                                    color: FsColor.darkgrey),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
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
//              Timer(Duration(milliseconds: 100), () {
//                setState(() {
//                  listListner.addListList({
//                    "total": 8,
//                    "per_page": 10,
//                    "current_page": 1,
//                    "last_page": 1,
//                    "from": 1,
//                    "to": 10
//                  }, visitors);
//                });
//              });
                }),
          )),
    );
  }

  Image getImage(item) {
    try {
      return item["image_path"] != null && item["image_path"].length > 0
          ? Image.network(
        "${item["image_path"]}",
        height: 48,
        width: 48,
        fit: BoxFit.cover,

      )
          : Image.asset(
        "images/default.png",
        height: 48,
        width: 48,
        fit: BoxFit.cover,
      );
    } catch (e) {
      print("EXCEPTION --------------------- $e");
      Image.asset(
          "images/default.png",
          height: 48,
          width: 48,
          fit: BoxFit.cover);
    }

  }

  ImageProvider buildNetworkImage(profileUrl) {
    try {
      if (profileUrl == null) {
        return new ExactAssetImage("images/default.png",
            scale: 1.0, bundle: null);
      }
      return new NetworkImage(profileUrl);
    } catch (e) {
      return new ExactAssetImage("images/default.png",
          scale: 1.0, bundle: null);
    }
  }

//  List visitors = [
//    {
//      "photo": "images/default.png",
//      "name": "long long long long long long name here",
//      "location": "Vashi",
//      "designation": "Relatives",
//      "intime": "10:15AM",
//      "outtime": "10:30AM",
//      "duration": "30min",
//    },
//    {
//      "photo": "images/default.png",
//      "name": "Saara Gough Gough ",
//      "location": "Nerul",
//      "designation": "Relatives",
//      "intime": "10:15AM",
//      "outtime": "10:30AM",
//      "duration": "30min",
//    },
//    {
//      "photo": "images/default.png",
//      "name": "Lilia Wilde",
//      "location": "Chembur",
//      "designation": "Relatives",
//      "intime": "10:15AM",
//      "outtime": "10:30AM",
//      "duration": "30min",
//    },
//    {
//      "photo": "images/default.png",
//      "name": "Zion Frank",
//      "location": "Andheri",
//      "designation": "Relatives",
//      "intime": "10:15AM",
//      "outtime": "10:30AM",
//      "duration": "30min",
//    },
//    {
//      "photo": "images/default.png",
//      "name": "Hoorain Lucas",
//      "location": "Panvel",
//      "designation": "Relatives",
//      "intime": "10:15AM",
//      "outtime": "10:30AM",
//      "duration": "30min",
//    },
//  ];

  @override
  lastPage(int page) {
    // TODO: implement lastPage
  }

  @override
  loadNextPage(String page) {
    // TODO: implement loadNextPage
    vizLoginPresentor.getVisitors(
        _socId, _unitId, memberId: _memberId, page: page);
  }

  @override
  error(error) {
    // TODO: implement error
    ///throw UnimplementedError();
  }

  @override
  failure(failed) {
    // TODO: implement failure
//    throw UnimplementedError();
  }

  @override
  loginSuccess(success) {
    // TODO: implement loginSuccess
//    throw UnimplementedError();
  }

  @override
  visitorSuccess(success) {
    setState(() {
      var visitorList = success["data"]["results"];
      var metadata = success["data"]["metadata"];
      mergeList(metadata, visitorList);

//      visitors=      visitorList["visitors"]["first_name"];
    });
  }

  void mergeList(metadata, List visitorList) {
    if (visitorList != null && visitorList.length > 0) {
      for (int i = 0; i < visitorList.length; i++) {
        var visi = {
          "first_name": visitorList[i]["visitors"]["first_name"],
          "image_path": visitorList[i]["visitors"]["image_small"],
          "mobile": visitorList[i]["visitors"]["mobile"],
          "coming_from": visitorList[i]["visitors"]["coming_from"],
          "purpose": visitorList[i]["purpose_of_visit"],
          "in_time": AppUtils.getTime(visitorList[i]["in_time"]),
          "out_time": AppUtils.getTime(visitorList[i]["out_time"]),
          "is_out": visitorList[i]["out_time"] != null ? true : false,
          "duration": AppUtils.getTimeDiff(
              visitorList[i]["in_time"], visitorList[i]["out_time"])
        };
        visitors.add(visi);
      }
    }
    listListner.addListList(metadata, visitors);
  }
}
