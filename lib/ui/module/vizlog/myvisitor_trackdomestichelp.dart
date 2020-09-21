import 'package:common_config/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/config/strings/strings.dart';
import 'package:sso_futurescape/presentor/module/vizlog/my_visitor_setting/my_visitor_track_domestic_presentor.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/ui/widgets/list_widget.dart';
import 'package:sso_futurescape/utils/app_utils.dart';

class MyVisitorTrackDomesticHelp extends StatefulWidget {
  var selectedUnit;

  String visitorId;

  MyVisitorTrackDomesticHelp(this.selectedUnit, this.visitorId);

  @override
  _MyVisitorTrackDomesticHelpState createState() =>
      new _MyVisitorTrackDomesticHelpState(this.selectedUnit, this.visitorId);
}

class _MyVisitorTrackDomesticHelpState extends State<MyVisitorTrackDomesticHelp>
    implements PageLoadListener, MyVisitorTrackDomesticView {
  FsListState listListner;

  MyVisitorTrackDomesticPresentor myVisitorTrackDomesticPresentor;

  var selectedUnit;

  String visitorId;

  _MyVisitorTrackDomesticHelpState(this.selectedUnit, this.visitorId);

  @override
  void initState() {
    super.initState();
    myVisitorTrackDomesticPresentor = new MyVisitorTrackDomesticPresentor(this);
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*primaryColor: FsColor.primaryvisitor,*/
      appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: FsColor.primaryvisitor,
        title: Text(
          "Track Domestic Help",
          style: FSTextStyle.appbartextlight,
        ),
        leading: FsBackButtonlight(),
        actions: <Widget>[],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
          child: Center(
            child: FsListWidget(
                title: false,
                message: FsString.NO_DOMESTIC_HELP,
                pageLoadListner: this,
                itemBuilder: (BuildContext context, int index, var item) {
                  List track_staff = item["track_staff"];
                  bool isSwitched = track_staff.length != 0;
                  var firstNameItem = item["first_name"];
                  var lastNameItem = item["last_name"];

                  String firstName = firstNameItem == null ||
                      firstNameItem
                          .toString()
                          .trim()
                          .isEmpty
                      ? ""
                      : firstNameItem;
                  String lastName =
                  lastNameItem == null || lastNameItem
                      .toString()
                      .trim().isEmpty
                      ? ""
                      : lastNameItem;

                  String fullName = firstNameItem.toString().isEmpty
                      ? lastName
                      : lastName.isEmpty
                          ? firstName
                          : firstName + " " + lastName;
                  item["full_name"] = fullName;

                  return Card(
                    child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: FSUserIconAvatar(item["image_small"]),
                        ),
                        title: Text(
                          '${fullName}'.toLowerCase(),
                          style: TextStyle(
                            fontFamily: 'Gilroy-SemiBold',
                            fontSize: FSTextStyle.h6size,
                            color: FsColor.basicprimary,
                          ),
                        ),
                        trailing: Container(
                          child: item["progress"] != null &&
                              item["progress"] == true
                              ? CircularProgressIndicator()
                              : isSwitched
                              ? RaisedButton(
                            onPressed: () {
                              item["progress"] = true;
                              listListner.stateUpdate();
                              myVisitorTrackDomesticPresentor
                                  .getTrackDemesticHelpStaff(visitorId,
                                  item["visitor_id"].toString(),
                                      (sucesss) {
                                    item["progress"] = false;

                                    trackedFailed(item, index);
                                    listListner.stateUpdate();
                                  }, (failed) {
                                    item["progress"] = false;
                                    listListner.stateUpdate();
                                    Toasly.error(
                                        context, AppUtils.errorDecoder(failed));
                                  });
                              setState(() {

                              });
                            },
                            color: FsColor.primaryvisitor,
                            child: Text(
                              "Track",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                              : RaisedButton(
                            onPressed: () {
                              listListner.receiptList[index]["progress"] =
                              true;
                              listListner.stateUpdate();
                              myVisitorTrackDomesticPresentor
                                  .getTrackDemesticHelpStaff(visitorId,
                                  item["visitor_id"].toString(),
                                      (sucesss) {
                                    listListner.receiptList[index]["progress"] =
                                    false;
                                    listListner.stateUpdate();
                                    trackedSuccess(item, index);
                                  }, (failed) {
                                    item["progress"] = false;
                                    listListner.stateUpdate();
                                    Toasly.error(
                                        context, AppUtils.errorDecoder(failed));
                                  });
                              setState(() {

                              });
                            },
                            color: FsColor.lightgrey,
                            child: Text(
                              "Untrack",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )

//                    child: Switch(
//                      value: track_staff.length != 0,
//                      inactiveThumbColor: FsColor.red,
//                      inactiveTrackColor: const Color(0xFFffb3b3),
//                      activeColor: FsColor.green,
//                      activeTrackColor: const Color(0xFF80d6aa),
//                      onChanged: (value) {
//                        if (value) {
//                          track_staff.add("added");
//                        } else {
//                          track_staff.clear();
//                        }
//                        print(item);
//                        print("vvvvvvvvvvvvvvvvvvvvv");
//                        print(visitorId);
//                        myVisitorTrackDomesticPresentor
//                            .getTrackDemesticHelpStaff(visitorId,
//                            item["visitor_id"].toString(), value);
//                        setState(() {
//
//                        });
//                      },
//                    )),
                    ),
                  );
                  /*);*/
                },
                afterView: (FsListState v) {
                  listListner = v;
                }),
          )

      ),
    );
  }

  @override
  lastPage(int page) {}

  @override
  loadNextPage(String page) {}

  void getData() {
    print(this.selectedUnit);
    myVisitorTrackDomesticPresentor.geDemesticHelpTrackingList(
        selectedUnit["soc_id"].toString(), selectedUnit["unit_id"].toString());
  }

  @override
  void errorDomesticHelpList(String error) {
    listListner.addListList(null, []);
    setState(() {});
  }

  @override
  void failureDomesticHelpList(jsonDecode) {
    print("dddddddd");
    listListner.addListList(null, []);
    setState(() {});
  }

  @override
  void successDomesticHelpList(metadata, receiptList) {
    print("dddddddd");
    listListner.addListList(metadata, receiptList);
    setState(() {});
  }

  void trackedSuccess(item, index) {
    Toasly.success(context, "Tracking turned on for ${item["full_name"]}");

    print("dddddd");
    listListner.receiptList[index]["track_staff"].add("added");
    print(listListner.receiptList[index]);
    listListner.stateUpdate();
    setState(() {});


  }

  void trackedFailed(item, index) {
    Toasly.success(context, "Tracking turned off for ${item["full_name"]}");
    listListner.receiptList[index]["track_staff"].clear();
    listListner.stateUpdate();
    setState(() {});
  }

/*  @override
  void errorTrackDomesticHelp(String error) {
    Toasly.error(context, AppUtils.errorDecoder(error));
  }

  @override
  void failureTrackDomesticHelp(jsonDecode) {
    Toasly.error(context, AppUtils.errorDecoder(jsonDecode));
  }

  @override
  void successTrackDomesticHelp(jsonDecode) {
    Toasly.success(context, AppUtils.errorDecoder(jsonDecode["message"]));
  }*/
}

class FSUserIconAvatar extends StatelessWidget {
  var url;

  FSUserIconAvatar(this.url);

  @override
  Widget build(BuildContext context) {
    Widget image;
    try {
      return url != null
          ? Image.network(
        "${url}",
        height: 48,
        width: 48,
        fit: BoxFit.cover,
      )
          : Image.asset(
        'images/default.png',
        height: 48,
        width: 48,
        fit: BoxFit.cover,
      );
    } catch (e) {
      return Image.asset(
        'images/default.png',
        height: 48,
        width: 48,
        fit: BoxFit.cover,
      );
    }
  }
}
