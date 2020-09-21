import 'dart:collection';

import 'package:common_config/utils/toast/toast.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/config/strings/strings.dart';
import 'package:sso_futurescape/presentor/module/vizlog/guest/guest.dart';
import 'package:sso_futurescape/presentor/module/vizlog/guest/guest_view.dart';
import 'package:sso_futurescape/ui/widgets/list_widget.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';
import 'package:sso_futurescape/ui/widgets/page_loader.dart';
import 'package:sso_futurescape/utils/app_constant.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';
import 'package:sso_futurescape/utils/user_util.dart';

class GuestNotVisited extends StatefulWidget {
  @override
  _GuestNotVisitedState createState() => new _GuestNotVisitedState();
}

class _GuestNotVisitedState extends State<GuestNotVisited>
    implements PageLoadListener, GuestView {
  FsListState listListner;

  GuestPresenter guestPresenter;

  var visitorsList = [];

  String _socId;
  String _unitId;

  bool isLoading = false;

  var inviteDateController = new TextEditingController();

  HashMap<String, String> hmInviteDetails;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    guestPresenter = GuestPresenter(this);
    getUnitDetails();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? PageLoader(
      title: FsString.INVITATING_GUEST,
    )
        : Padding(
      padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: FsListWidget(
          title: false,
          message: FsString.NO_INVITED_GUEST,
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
                              height: 48,
                              width: 48,
                              fit: BoxFit.cover,)
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
                                                fontSize:
                                                FSTextStyle.h6size,
                                                fontFamily:
                                                'Gilroy-SemiBold',
                                                color: FsColor.darkgrey),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
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
                            Container(
                              height: 30,
                              child: GestureDetector(
                                child: RaisedButton(
                                  color: FsColor.primaryvisitor,
                                  padding:
                                  EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  onPressed: () {
                                    _openReInviteGuestDialog(item);
                                        },
                                  child: Row(
                                    children: <Widget>[
                                      SizedBox(width: 5),
                                      Text(
                                        "Re-Invite",
                                        style: TextStyle(
                                            fontSize: FSTextStyle.h6size,
                                            fontFamily: 'Gilroy-Bold',
                                            color: FsColor.white),
                                      ),
                                    ],
                                  ),
                                ),
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
    guestPresenter.getGuests(_socId, _unitId, page: page, visitedGuest: false);
  }

  void _openReInviteGuestDialog(item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ReInviteGuestDialog(item,
                (item, String date) => reInviteGuest(item, date),
                () => Navigator.of(context, rootNavigator: true).pop('dialog'));
      },
    );
  }

  /*void _openReInviteGuestDialog(item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Re-Invite Guest details".toLowerCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Gilroy-SemiBold',
                  fontSize: FSTextStyle.h4size,
                  color: FsColor.darkgrey)),
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(7.0),
          ),
          content: SingleChildScrollView(
            child: Container(
              height: 250.0,
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
                        child: DateTimeField(
                          controller: inviteDateController,
                          format: DateFormat("dd-MM-yyyy hh:ss a"),
                          onShowPicker: (context, currentValue) async {
                            final date = await showDatePicker(
                                context: context,
                                firstDate: getCurrentDate(),
                                initialDate: currentValue ?? DateTime.now(),
                                lastDate: DateTime(2100));
                            if (date != null) {
                              final time = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.fromDateTime(
                                    currentValue ?? DateTime.now()),
                              );
                              return DateTimeField.combine(date, time);
                            } else {
                              return currentValue;
                            }
                          },
                          decoration: InputDecoration(
                            labelText: "Visit Date".toLowerCase(),
                            labelStyle: TextStyle(
                                fontFamily: 'Gilroy-Regular',
                                fontSize: FSTextStyle.h6size,
                                color: FsColor.darkgrey),
                          ),
                        ),
                      ),
//                      Container(
//                        alignment: Alignment.topLeft,
//                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
//                        child: DateTimeField(
//                          format: DateFormat("HH:mm"),
//                          // format: format,
//                          onShowPicker: (context, currentValue) async {
//                            final time = await showTimePicker(
//                              context: context,
//                              initialTime: TimeOfDay.fromDateTime(
//                                  currentValue ?? DateTime.now()),
//                            );
//                            return DateTimeField.convert(time);
//                          },
//                          decoration: InputDecoration(
//                            labelText: "Visit Time".toLowerCase(),
//                            labelStyle: TextStyle(
//                                fontFamily: 'Gilroy-Regular',
//                                fontSize: FSTextStyle.h6size,
//                                color: FsColor.darkgrey),
//                          ),
//                        ),
//                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: new Text(
                "Cancel",
                style: TextStyle(
                    fontFamily: 'Gilroy-SemiBold',
                    fontSize: FSTextStyle.h6size,
                    color: FsColor.darkgrey),
              ),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop('dialog');
              },
            ),
//            isLoading ? SizedBox(
//              height: 20.0,
//              width: 20.0,
//              child: CircularProgressIndicator(
//                valueColor: AlwaysStoppedAnimation<Color>(FsColor.darkgrey),
//                strokeWidth: 3.0,
//              ),
//            ) :
            RaisedButton(
              child: new Text(
                "ReInvite",
                style: TextStyle(
                    fontFamily: 'Gilroy-SemiBold',
                    fontSize: FSTextStyle.h6size,
                    color: FsColor.white),
              ),
              color: FsColor.primaryvisitor,
              onPressed: () {
                reInviteGuest(item);
              },
            ),
          ],
        );
      },
    );
  }*/

  @override
  error(error) {
    Toasly.error(context, AppUtils.errorDecoder(error));
  }

  @override
  failure(failed) {
    Toasly.error(context, AppUtils.errorDecoder(failed));
  }

  @override
  success(success) {
    if (isLoading != null && isLoading) {
      setState(() {
        isLoading = false;
        visitorsList.clear();
//        Navigator.of(context, rootNavigator: true).pop('dialog');
      });

      Toasly.success(context, "Guest reinvited successfully");

      guestPresenter.getGuests(_socId, _unitId, page: "1", visitedGuest: false);
    } else {
      var result = success["data"];
      var metaData = {
        "total": result["total"],
        "per_page": result["per_page"],
        "current_page": result["current_page"],
        "last_page": result["last_page"],
        "next_page_url": result["next_page_url"],
        "prev_page_url": result["prev_page_url"],
        "from": result["from"],
        "to": result["to"],
      };
      List list = result["data"];
      setState(() {
        mergeList(metaData, list);
      });
    }
  }

  void mergeList(metadata, List visitors) {
    if (visitors != null && visitors.length > 0) {
      for (int i = 0; i < visitors.length; i++) {
        var visi = {
          "name": getName(visitors[i]),
          "photo": visitors[i]["image_small"],
          "mobile": visitors[i]["mobile"],
          "coming_from": visitors[i]["coming_from"],
          "purpose": visitors[i]["purpose"],
          "pass_type": visitors[i]["pass_type"],
          "visitor_id": visitors[i]["visitor_id"],
          "pass_validity": visitors[i]["pass_validity"],
//          "in_time": AppUtils.getTime(visitorList[i]["in_time"]),
//          "out_time": AppUtils.getTime(visitorList[i]["out_time"]),
//          "is_out": visitorList[i]["out_time"] != null ? true : false,
//          "duration": AppUtils.getTimeDiff(
//              visitorList[i]["in_time"], visitorList[i]["out_time"])
        };
        visitorsList.add(visi);
      }
    }
    listListner.addListList(metadata, visitorsList);
  }

  String getName(visitorList) {
    if (visitorList["last_name"] != null &&
        visitorList["last_name"].length > 0) {
      return visitorList["first_name"] + " " + visitorList["last_name"];
    }
    return visitorList["first_name"];
  }

  void getUnitDetails() {
    UserUtils.getCurrentUnits(app: AppConstant.VIZLOG).then((data) {
      _socId = data["soc_id"];
      _unitId = data["unit_id"];
      guestPresenter.getGuests(_socId, _unitId, page: "1", visitedGuest: false);
    });
  }

  DateTime getCurrentDate() {
    DateTime date = DateTime.now();
    return DateTime(date.year, date.month, date.day);
  }

  void reInviteGuest(item, String date) {
    setState(() {
      isLoading = true;
    });
    Navigator.of(context, rootNavigator: true).pop('dialog');
    SsoStorage.getVizProfile().then((data) {
//      print(data["data"]["users"]["visitor_id"]);
      hmInviteDetails = new HashMap();
      hmInviteDetails["unit_id"] = _socId;
      hmInviteDetails["building_unit_id"] = _unitId;
      hmInviteDetails["coming_from"] = item["coming_from"];
//      hmInviteDetails["visitor_type"] = "guest";
      hmInviteDetails["pass_type"] = item["pass_type"];
      hmInviteDetails["pass_validity"] = item["pass_validity"].toString();
      hmInviteDetails["purpose"] =
      item["purpose"] == null ? "not mentioned" : item["purpose"];
      hmInviteDetails["expected_date_time"] = AppUtils.getDateTime(
          date, sourceFormat: "dd-MM-yyyy hh:mm a");

      hmInviteDetails["added_by"] =
          data["data"]["users"]["visitor_id"].toString();
      hmInviteDetails["added_to"] = item["visitor_id"].toString();
      hmInviteDetails["mobile"] = item["mobile"];
//      hmInviteDetails["is_existing_guest"] = "1"; //newVisitor
      guestPresenter.reInviteGuest(hmInviteDetails);
    });
//
    print(hmInviteDetails.toString());
  }
}

class ReInviteGuestDialog extends StatefulWidget {

  var inviteDateController = new TextEditingController();
  var reInviteFunction;
  var cancelFunction;
  dynamic item;

  ReInviteGuestDialog(item, Function reInviteFunction,
      Function cancelFunction) {
    this.reInviteFunction = reInviteFunction;
    this.cancelFunction = cancelFunction;
    this.item = item;
  }

  @override
  State<StatefulWidget> createState() {
    return new _ReInviteGuestDialogState(
        item, reInviteFunction, cancelFunction);
  }
}

class _ReInviteGuestDialogState extends State<ReInviteGuestDialog> {

  var inviteDateController = new TextEditingController();
  var reInviteFunction;
  var cancelFunction;
  dynamic item;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _ReInviteGuestDialogState(item, Function reInviteFunction,
      Function cancelFunction) {
    this.reInviteFunction = reInviteFunction;
    this.cancelFunction = cancelFunction;
    this.item = item;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text("Re-Invite Guest details".toLowerCase(),
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: 'Gilroy-SemiBold',
              fontSize: FSTextStyle.h4size,
              color: FsColor.darkgrey)),
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(7.0),
      ),
      content: SingleChildScrollView(
        child: Container(
          height: 250.0,
          alignment: Alignment.centerLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
                    child: Form(
                      key: _formKey,
                      child: DateTimeField(
                        controller: inviteDateController,
                        format: DateFormat("dd-MM-yyyy hh:ss a"),
                        onShowPicker: (context, currentValue) async {
                          final date = await showDatePicker(
                              context: context,
                              firstDate: getCurrentDate(),
                              initialDate: currentValue ?? DateTime.now(),
                              lastDate: DateTime(2100));
                          if (date != null) {
                            final time = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.fromDateTime(
                                  currentValue ?? DateTime.now()),
                            );
                            return DateTimeField.combine(date, time);
                          } else {
                            return currentValue;
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "Visit Date".toLowerCase(),
                          labelStyle: TextStyle(
                              fontFamily: 'Gilroy-Regular',
                              fontSize: FSTextStyle.h6size,
                              color: FsColor.darkgrey),
                        ),
                        validator: (value) {
                          String date = inviteDateController.text;
                          if (date == null || date
                              .trim()
                              .isEmpty) {
                            return "please enter expected date and time";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
//                      Container(
//                        alignment: Alignment.topLeft,
//                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
//                        child: DateTimeField(
//                          format: DateFormat("HH:mm"),
//                          // format: format,
//                          onShowPicker: (context, currentValue) async {
//                            final time = await showTimePicker(
//                              context: context,
//                              initialTime: TimeOfDay.fromDateTime(
//                                  currentValue ?? DateTime.now()),
//                            );
//                            return DateTimeField.convert(time);
//                          },
//                          decoration: InputDecoration(
//                            labelText: "Visit Time".toLowerCase(),
//                            labelStyle: TextStyle(
//                                fontFamily: 'Gilroy-Regular',
//                                fontSize: FSTextStyle.h6size,
//                                color: FsColor.darkgrey),
//                          ),
//                        ),
//                      ),
                ],
              )
            ],
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: new Text(
            "Cancel",
            style: TextStyle(
                fontFamily: 'Gilroy-SemiBold',
                fontSize: FSTextStyle.h6size,
                color: FsColor.darkgrey),
          ),
          onPressed: () {
            if (cancelFunction != null) {
              cancelFunction();
            }
          },
        ),
//            isLoading ? SizedBox(
//              height: 20.0,
//              width: 20.0,
//              child: CircularProgressIndicator(
//                valueColor: AlwaysStoppedAnimation<Color>(FsColor.darkgrey),
//                strokeWidth: 3.0,
//              ),
//            ) :
        RaisedButton(
          child: new Text(
            "ReInvite",
            style: TextStyle(
                fontFamily: 'Gilroy-SemiBold',
                fontSize: FSTextStyle.h6size,
                color: FsColor.white),
          ),
          color: FsColor.primaryvisitor,
          onPressed: () {
            String date = inviteDateController.text;
            if (_formKey.currentState.validate()) {
              if (reInviteFunction != null) {
                reInviteFunction(item, date);
              }
            }
          },
        ),
      ],
    );
  }

  DateTime getCurrentDate() {
    DateTime date = DateTime.now();
    return DateTime(date.year, date.month, date.day);
  }
}
