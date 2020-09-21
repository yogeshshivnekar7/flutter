import 'dart:collection';

import 'package:common_config/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/config/strings/strings.dart';
import 'package:sso_futurescape/presentor/module/vizlog/guest/guest.dart';
import 'package:sso_futurescape/presentor/module/vizlog/guest/guest_view.dart';
import 'package:sso_futurescape/ui/widgets/list_widget.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';
import 'package:sso_futurescape/utils/app_constant.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/user_util.dart';

class GuestExpected extends StatefulWidget {
  @override
  _GuestExpectedState createState() => new _GuestExpectedState();
}

class _GuestExpectedState extends State<GuestExpected>
    implements PageLoadListener, GuestView {
  FsListState listListner;

  String _socId;
  String _unitId;

  GuestPresenter guestPresenter;

//  var visitorsList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    guestPresenter = new GuestPresenter(this);
    getUnitDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: FsListWidget(
          pageLoadListner: this,
          title: false,
          message: FsString.NO_EXPECTED_GUEST,
          itemBuilder: (BuildContext context, int index, var item) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
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
                            child: item["image_path"] != null &&
                                item["image_path"].length > 0
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
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Expanded(
                            child: Container(
                              alignment: Alignment.topLeft,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '${item["name"]}'.toLowerCase(),
                                    style: TextStyle(
                                        fontSize: FSTextStyle.h5size,
                                        fontFamily: 'Gilroy-SemiBold',
                                        color: FsColor.primaryvisitor),
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                          Text(
                                            '${item["purpose"]}'.toLowerCase(),
                                            style: TextStyle(
                                                fontSize: FSTextStyle.h6size,
                                                fontFamily: 'Gilroy-SemiBold',
                                                color: FsColor.darkgrey),
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
                                                fontSize: FSTextStyle.h6size,
                                                fontFamily: 'Gilroy-SemiBold',
                                                color: FsColor.darkgrey),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                              item["time"],
                                              style: TextStyle(
                                                  fontSize: FSTextStyle.h6size,
                                                  fontFamily: 'Gilroy-SemiBold',
                                                  color: FsColor.darkgrey),
                                            ),
                                          ],
                                        ),
                                      ),
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
                              color: FsColor.basicprimary.withOpacity(0.2)),
                        )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.fromLTRB(10.0, 5.0, 10, 5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    "Date : ".toLowerCase(),
                                    style: TextStyle(
                                        fontSize: FSTextStyle.h6size,
                                        fontFamily: 'Gilroy-SemiBold',
                                        color: FsColor.lightgrey),
                                  ),
                                  Text(
                                    "${item["date"]}",
                                    style: TextStyle(
                                        fontSize: FSTextStyle.h6size,
                                        fontFamily: 'Gilroy-SemiBold',
                                        color: FsColor.darkgrey),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: GestureDetector(
                                child: FlatButton(
                                  onPressed: () {
                                    AppUtils.launchUrl("tel:" + item["mobile"]);
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
                                            fontSize: FSTextStyle.h6size,
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
            );
          },
          afterView: (FsListState v) {
            listListner = v;
//            Timer(Duration(milliseconds: 100), () {
//              setState(() {
//                listListner.addListList({
//                  "total": 8,
//                  "per_page": 10,
//                  "current_page": 1,
//                  "last_page": 1,
//                  "from": 1,
//                  "to": 10
//                }, []);
//              });
//            });
          }),
    );
  }

  @override
  lastPage(int page) {
    // TODO: implement lastPage
  }

  @override
  loadNextPage(String page) {
    hashMap["page"] = page;
    guestPresenter.getExpectedGuest(hashMap, _socId, _unitId);
  }

  HashMap<String, String> hashMap = new HashMap();

  void getUnitDetails() {
    UserUtils.getCurrentUnits(app: AppConstant.VIZLOG).then((data) {
      _socId = data["soc_id"];
      _unitId = data["unit_id"];
      hashMap["page"] = "1";
      guestPresenter.getExpectedGuest(hashMap, _socId, _unitId);
    });
  }

  @override
  error(error) {
    Toasly.error(context, AppUtils.errorDecoder(error));
//    throw UnimplementedError();
  }

  @override
  failure(failed) {
    Toasly.error(context, AppUtils.errorDecoder(failed));
//    throw UnimplementedError();
  }

  @override
  success(success) {
    print("fffffffffffffff");
    // TODO: implement success
//    throw UnimplementedError();
//    print("success-----------------------------------------$success");
    mergeList(success["data"]["metadata"], success["data"]["results"]);
    print("successsuccesssuccesssuccesssuccesssuccess");
  }

  void mergeList(metadata, List visitorList) {
    var visitorsList = [];
    if (visitorList != null && visitorList.length > 0) {
      for (int i = 0; i < visitorList.length; i++) {
        var visitors = visitorList[i]["visitors"];
        var visi = {
          "purpose": visitorList[i]["purpose"] == null
              ? "Not Mentioned"
              : visitorList[i]["purpose"],
          "date": AppUtils.getDateTime(visitorList[i]["expected_date_time"],
              requiredFormat: "dd-MM-yyyy",
              sourceFormat: "yyyy-MM-dd HH:mm:ss"),
          "time": AppUtils.getDateTime(visitorList[i]["expected_date_time"],
              requiredFormat: "hh:mm a", sourceFormat: "yyyy-MM-dd HH:mm:ss"),
          "photo": visitors["image_small"],
          "name": getName(visitors),
          "mobile": visitors["mobile"],
          "coming_from": visitors["coming_from"],
//          "in_time": AppUtils.getTime(visitorList[i]["in_time"]),
//          "out_time": AppUtils.getTime(visitorList[i]["out_time"]),
//          "is_out": visitorList[i]["out_time"] != null ? true : false,
//          "expected_date_time": AppUtils.getTimeDiff(
//              visitorList[i]["in_time"], visitorList[i]["out_time"])
        };
        visitorsList.add(visi);
      }
    }
    listListner.addListList(metadata, visitorsList);
    print("fffffffffffffff");
    setState(() {});
  }

  String getName(visitorList) {
    if (visitorList["last_name"] != null &&
        visitorList["last_name"].length > 0) {
      return visitorList["first_name"] + " " + visitorList["last_name"];
    }
    return visitorList["first_name"];
  }
}
