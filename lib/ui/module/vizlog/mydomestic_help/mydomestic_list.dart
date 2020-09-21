import 'package:common_config/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/config/strings/strings.dart';
import 'package:sso_futurescape/presentor/module/vizlog/guest/guest.dart';
import 'package:sso_futurescape/presentor/module/vizlog/guest/guest_view.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/ui/widgets/list_widget.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';
import 'package:sso_futurescape/utils/app_constant.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/user_util.dart';

class MyDomesticHelpList extends StatefulWidget {
  @override
  _MyDomesticHelpListState createState() => new _MyDomesticHelpListState();
}

class _MyDomesticHelpListState extends State<MyDomesticHelpList>
    implements PageLoadListener, GuestView {
  FsListState listListner;

  GuestPresenter guestPresenter;

  String unitId;
  String socId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    guestPresenter = GuestPresenter(this);
    getUnitDetails();
  }

  void getUnitDetails() {
    UserUtils.getCurrentUnits(app: AppConstant.VIZLOG).then((unit) {
      if (unit == null) {
        setState(() {});
      } else {
        setState(() {
          socId = unit["soc_id"].toString();
          unitId = unit["unit_id"].toString();
          guestPresenter.getStaff(socId, unitId);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(
          'My Domestic Help'.toLowerCase(),
          style: FSTextStyle.appbartextlight,
        ),
        elevation: 1.0,
        backgroundColor: FsColor.primaryvisitor,
        leading: FsBackButtonlight(),
      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: () => {
////          Navigator.push(
////            context,
////            new MaterialPageRoute(builder: (context) => MyDomesticHelpSearch()),
////          ),
//        },
//        child: Icon(FlutterIcon.user_plus),
//        backgroundColor: FsColor.primaryvisitor,
//      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
        child: Center(
          child: FsListWidget(
              title: false,
              message: FsString.NO_DOMESTIC_HELP,
              pageLoadListner: this,
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
                    child: InkWell(
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
                                    child: item["photo"] != null &&
                                        item["photo"].length > 0
                                        ? Image.network("${item["photo"]}",
                                      height: 48, width: 48, fit: BoxFit.cover,)
                                        : Image.asset(
                                      "images/default.png",
                                      height: 48,
                                      width: 48,
                                      fit: BoxFit.cover,
                                    )),
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
                                          '${item["name"]}'.toLowerCase(),
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
                                            Icon(
                                              Icons.location_on,
                                              color: FsColor.lightgrey,
                                              size: 18,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              '${item["coming_from"]}'
                                                  .toLowerCase(),
                                              style: TextStyle(
                                                  fontSize: FSTextStyle.h6size,
                                                  fontFamily: 'Gilroy-SemiBold',
                                                  color: FsColor.lightgrey),
                                            ),
                                            SizedBox(width: 15),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            item["in_time"] != null &&
                                                    item["in_time"]
                                                        .trim()
                                                        .isNotEmpty
                                                ? Container(
                                                    child: Row(
                                                      children: <Widget>[
                                                        Image.asset(
                                                          'images/in.png',
                                                          fit: BoxFit.contain,
                                                          width: 18.0,
                                                          height: 18.0,
                                                        ),
                                                        SizedBox(
                                                          width: 5.0,
                                                        ),
                                                        Text(
                                                          '${item["in_time"]}',
                                                          style: TextStyle(
                                                              fontSize:
                                                                  FSTextStyle
                                                                      .h6size,
                                                              fontFamily:
                                                                  'Gilroy-SemiBold',
                                                              color: FsColor
                                                                  .darkgrey),
                                                        ),
                                                        SizedBox(width: 20.0),
                                                      ],
                                                    ),
                                                  )
                                                : Container(),
                                            item["is_checked_out"] &&
                                                    (item["out_time"] != null &&
                                                        item["out_time"]
                                                            .trim()
                                                            .isNotEmpty)
                                                ? Container(
                                                    child: Row(
                                                    children: <Widget>[
                                                      Image.asset(
                                                        'images/out.png',
                                                        fit: BoxFit.contain,
                                                        width: 18.0,
                                                        height: 18.0,
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
                                        color:
                                        FsColor.basicprimary.withOpacity(0.2)),
                                  )),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
//                                  Container(
//                                    child: FlatButton(
//                                      shape: new RoundedRectangleBorder(
//                                        borderRadius:
//                                            new BorderRadius.circular(4.0),
//                                      ),
//                                      onPressed: () => {
//                                        _showGiveSomethingDialog(),
//                                      },
//                                      padding: EdgeInsets.symmetric(
//                                          vertical: 10.0, horizontal: 10.0),
//                                      child: Row(
//                                        children: <Widget>[
//                                          Text(
//                                            "Give Something",
//                                            style: TextStyle(
//                                                fontSize: FSTextStyle.h6size,
//                                                fontFamily: 'Gilroy-Bold',
//                                                color: FsColor.darkgrey),
//                                          ),
//                                        ],
//                                      ),
//                                    ),
//                                  ),
                                  item["is_checked_out"] &&
                                      (item["duration"] != null &&
                                          item["duration"]
                                              .trim()
                                              .isNotEmpty)
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
                      onTap: () {
//                    Navigator.push(
//                          context,
//                          MaterialPageRoute(
//                          builder: (context) => MyDomesticHelpDetails()),
//                    );
                      },
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
//                  }, domestichelp);
//                });
//              });
              }),
        ),
      ),
    );
  }

  @override
  lastPage(int page) {
    // TODO: implement lastPage
  }

  @override
  loadNextPage(String page) {
    guestPresenter.getStaff(socId, unitId, page: page);
  }

  void _showGiveSomethingDialog() {
    // flutter defined function
    Toasly.success(context, "Coming soon..");
//    showDialog(
//      context: context,
//      builder: (BuildContext context) {
//        // return object of type Dialog
//        return AlertDialog(
//            shape: new RoundedRectangleBorder(
//              borderRadius: new BorderRadius.circular(7.0),
//            ),
//            content: Container(
//              height: 550.0,
//              child: Column(
//                children: <Widget>[
//                  Container(
//                    height: 72,
//                    margin: const EdgeInsets.only(
//                        left: 10.0, right: 15.0, top: 10.0, bottom: 10.0),
//                    child: ClipRRect(
//                      borderRadius: BorderRadius.circular(50.0),
//                      child: Image.asset(
//                        'images/default.png',
//                        fit: BoxFit.cover,
//                      ),
//                    ),
//                  ),
//                  Padding(
//                    padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
//                    child: new Text(
//                      "Name Comes Here".toLowerCase(),
//                      textAlign: TextAlign.center,
//                      style: TextStyle(
//                          fontFamily: 'Gilroy-SemiBold',
//                          fontSize: FSTextStyle.h4size,
//                          color: FsColor.darkgrey),
//                    ),
//                  ),
//                  Padding(
//                    padding: const EdgeInsets.all(0.0),
//                    child: new Text(
//                      "i have given a item to <Darrel Woodward>, my <maid> allow him/her to exit",
//                      textAlign: TextAlign.center,
//                      style: TextStyle(
//                          fontFamily: 'Gilroy-Regular',
//                          fontSize: FSTextStyle.h5size,
//                          color: FsColor.darkgrey),
//                    ),
//                  ),
//                  Container(
//                    padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
//                    child: TextField(
//                      maxLines: 2,
//                      decoration: InputDecoration(
//                          labelStyle: TextStyle(
//                              fontFamily: 'Gilroy-Regular',
//                              color: FsColor.darkgrey),
//                          // hintStyle: ,
//                          labelText: 'Enter Items'.toLowerCase(),
//                          focusedBorder: UnderlineInputBorder(
//                              borderSide:
//                                  BorderSide(color: FsColor.basicprimary))),
//                    ),
//                  ),
//                  Column(
//                    children: <Widget>[
//                      // Container(
//                      //   height: 180,
//                      //   width: 180,
//                      //   margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
//                      //   child: new FlatButton(
//                      //     onPressed: () => {
//                      //       _uploadImageDialog(),
//                      //     },
//                      //     padding: EdgeInsets.all(10.0),
//                      //     child: new Icon(
//                      //       Icons.camera_alt,
//                      //       size: 30.0,
//                      //       color: FsColor.white,
//                      //     ),
//                      //   ),
//                      // ),
//
//                      Container(
//                        height: 100,
//                        width: 100,
//                        decoration: BoxDecoration(
//                          border: Border.all(
//                            color: FsColor.darkgrey,
//                            width: 2.0,
//                          ),
//                          image: DecorationImage(
//                            image: AssetImage("images/no-image.jpg"),
//                            fit: BoxFit.fill,
//                          ),
//                        ),
//                        margin: const EdgeInsets.only(
//                            left: 10.0, right: 15.0, top: 10.0, bottom: 10.0),
//                        child: FlatButton(
//                          onPressed: () => {
////                            _uploadImageDialog(),
//                          },
//                          padding: EdgeInsets.all(10.0),
//                          child: new Icon(
//                            Icons.camera_alt,
//                            size: 30.0,
//                            color: FsColor.white,
//                          ),
//                          color: FsColor.basicprimary.withOpacity(0.5),
//                        ),
//                      ),
//
//                      Container(
//                        child: Text(
//                          'Upload a Photos of Items',
//                          style: TextStyle(
//                              fontFamily: 'Gilroy-SemiBold',
//                              fontSize: FSTextStyle.h7size,
//                              color: FsColor.lightgrey),
//                        ),
//                      ),
//                      Container(
//                        margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
//                        child: RaisedButton(
//                          padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
//                          shape: new RoundedRectangleBorder(
//                            borderRadius: new BorderRadius.circular(4.0),
//                          ),
//                          child: Text('Submit',
//                              style: TextStyle(
//                                fontSize: FSTextStyle.h6size,
//                                fontFamily: 'Gilroy-SemiBold',
//                              )),
//                          onPressed: () {},
//                          color: FsColor.primaryvisitor,
//                          textColor: FsColor.white,
//                        ),
//                      )
//                    ],
//                  )
//                ],
//              ),
//            ));
//      },
//    );
  }

  @override
  error(error) {}

  @override
  failure(failed) {}

  @override
  success(success) {
    print("success-----------------------------------------$success");

    mergeList(success["data"]["metadata"], success["data"]["results"]);
  }

  var visitorsList = [];

  void mergeList(metadata, List visitorList) {
    if (visitorList != null && visitorList.length > 0) {
      for (int i = 0; i < visitorList.length; i++) {
        var staff = visitorList[i];

        String checkInTime = staff["in_time"];
        String checkOutTime = staff["out_time"];
        bool isCheckedOut = false;
        String visitDuration;

        if ((checkInTime != null && checkInTime
            .trim()
            .isNotEmpty) &&
            (checkOutTime != null && checkOutTime
                .trim()
                .isNotEmpty)) {
          isCheckedOut = true;
          visitDuration = AppUtils.getTimeDiff(checkInTime, checkOutTime);
        }

        checkInTime = (checkInTime != null && checkInTime
            .trim()
            .isNotEmpty) ?
        AppUtils.getTime(checkInTime) : "";
        checkOutTime = (checkOutTime != null && checkOutTime
            .trim()
            .isNotEmpty) ?
        AppUtils.getTime(checkOutTime) : "";

        var visitors = staff["visitors"];
        var visi = {
//          "purpose": visitorList[i]["purpose"],
//          "date": AppUtils.getDateTime(visitorList[i]["expected_date_time"],
//              requiredFormat: "dd-MM-yyyy",
//              sourceFormat: "yyyy-MM-dd HH:mm:ss"),
//               sourceFormat: "yyyy-MM-dd HH:mm:ss"),
          "photo": visitors["image_small"],
          "name": getName(visitors),
          "mobile": visitors["mobile"],
          "coming_from": visitors["coming_from"],
          "in_time": checkInTime,
          "out_time": checkOutTime,
          "is_checked_out": isCheckedOut,
          "duration": visitDuration,
//          "in_time": AppUtils.getTime(visitorList[i]["in_time"]),
//          "out_time": AppUtils.getTime(visitorList[i]["out_time"]),
//          "is_checked_out": visitorList[i]["out_time"] != null ? true : false,
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
/*void _uploadImageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("choose image",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Gilroy-SemiBold',
              fontSize: FSTextStyle.h4size,
              color: FsColor.darkgrey)),
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(7.0),
          ),
          content: Container(
            height: 120.0,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 10, left: 0),
                  height: 120,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    primary: false,
                    itemCount: uploadimage == null ? 0 : uploadimage.length,
                    itemBuilder: (BuildContext context, int index) {
                      Map upload = uploadimage[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 0, top: 10),
                        child: InkWell(
                          child: Container(
                            height: 120,
                            width: 90,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(height: 8),
                                ClipRRect(
                                  child: Image.asset(
                                    "${upload["img"]}",
                                    height: 50,
                                    width: 50,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${upload["name"]}",
                                    style: TextStyle(
                                      fontSize: FSTextStyle.h6size,
                                      fontFamily: 'Gilroy-Regular',
                                    ),
                                    maxLines: 2,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {},
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: new Text(
                "Cancel",
                style: TextStyle(
                  fontFamily: 'Gilroy-SemiBold',
                  fontSize: FSTextStyle.h6size,
                  color: FsColor.darkgrey,),
              ),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop('dialog');
              },
            ),
          ],
        );
      },
    );
  }
*/

}
