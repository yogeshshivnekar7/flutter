import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/config/strings/strings.dart';
import 'package:sso_futurescape/ui/module/chsone/maintenence_dues/myflats_maintenencedetails.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';
import 'package:sso_futurescape/ui/widgets/no_data.dart';
import 'package:sso_futurescape/ui/widgets/page_loader.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/network/api_handler.dart';
import 'package:sso_futurescape/utils/network/chsone_api.dart';
import 'package:sso_futurescape/utils/storage/chsone_storage.dart';

class MaintenenceOverdue extends StatefulWidget {
  DUES_TYPE dueType;
  BILLTYPE billType;

  var currentUnit;

  MaintenenceOverdue(
    this.currentUnit,
    this.dueType,
      this.billType,
  );

  @override
  _MaintenenceOverdueState createState() =>
      new _MaintenenceOverdueState(currentUnit, dueType, billType);
}

class _MaintenenceOverdueState extends State<MaintenenceOverdue>
    implements MaintenenceDueView {
  MaintenenceDuePresentor presentor;

  List maintenencedues = [];

  ScrollController _scrollController = ScrollController();

  DUES_TYPE dueType;
  BILLTYPE billType;

  var currentUnit;

  bool isLoading = false;

  var metadata;

  _MaintenenceOverdueState(this.currentUnit, this.dueType, this.billType);

  @override
  void initState() {
    super.initState();
    presentor = new MaintenenceDuePresentor(this);
    isLoading = true;
    _getDues();
    _scrollController.addListener(() {
      /* print(_scrollController.position.pixels );
      print(_scrollController.position.maxScrollExtent );*/
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (metadata == null ||
            metadata['last_page'] != metadata['current_page'])
          currentPage =
          metadata == null || metadata['current_page'].toString() == null
              ? '1'
              : (metadata['current_page'] + 1).toString();
        _getDues();
      }
    });
  }

  void _getDues() {
    if (currentPage == 1) {
      isLoading = true;
    }
    try {
      String unitId = currentUnit["unit_id"].toString();
      //String unitId = "116";
      if (billType == BILLTYPE.MAINTANCE) {
        if (dueType == DUES_TYPE.ALL) {
          presentor.getDues(unitId, loadPage: currentPage);
        } else if (dueType == DUES_TYPE.UNPAID) {
          presentor.getDues(unitId, dueType: "unpaid", loadPage: currentPage);
        } else if (dueType == DUES_TYPE.PAID) {
          presentor.getDues(unitId, dueType: "paid", loadPage: currentPage);
        } else if (dueType == DUES_TYPE.PARTIAL_PAID) {
          presentor.getDues(unitId,
              dueType: "partialpaid", loadPage: currentPage);
        } else if (dueType == DUES_TYPE.OVERDUE) {
          presentor.getDues(unitId, dueType: "overdue", loadPage: currentPage);
        } else {
          print("Not supported duetype");
        }
      } else if (billType == BILLTYPE.INCIDENTAL) {
        presentor.getIncedental(unitId, loadPage: currentPage);
      } else {
        print("Not supported bill type");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? PageLoader()
        : maintenencedues.length == 0
        ? FsNoData(
      title: false,
      message: dueType == DUES_TYPE.OVERDUE ? FsString.NO_OVERDUE : dueType ==
          DUES_TYPE.UNPAID ? FsString.NO_PAID_TRANSACTION : dueType ==
          DUES_TYPE.UNPAID ? FsString.NO_UNPAID_TRANSACTION : dueType ==
          DUES_TYPE.ALL ? FsString.NO_ALL_TRANSCATION : billType ==
          BILLTYPE.INCIDENTAL ? FsString.NO_INCIDENTAL_BILLS : FsString
          .NO_ALL_TRANSCATION,)
        : ListView(
      children: <Widget>[
        Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15),
              child: ListView.builder(
                controller: _scrollController,
                primary: false,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: maintenencedues.length,
                itemBuilder: (BuildContext context, int index) {
                  if (maintenencedues.length == index) {
                    return Container(
                      child: RaisedButton(
                        onPressed: () {
                          _getDues();
                        },
                        child: Text("Click to Load more"),
                      ),
                    );
                  } else {
                    Map maintenence = maintenencedues[index];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Card(
                        elevation: 1.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(4.0),
                          ),
                          // side:BorderSide(color: FsColor.lightgrey, width: 1.0),
                        ),
                        child: InkWell(
                          child: Container(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.fromLTRB(
                                      0.0, 4.0, 0, 8.0),
                                  decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                            width: 1.0,
                                            color: FsColor.basicprimary
                                                .withOpacity(0.2)),
                                      )),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              "#" +
                                                  "${maintenence["invoicenum"]}",
                                              style: TextStyle(
                                                  fontSize:
                                                  FSTextStyle
                                                      .h6size,
                                                  fontFamily:
                                                  'Gilroy-SemiBold',
                                                  color: FsColor
                                                      .primaryflat),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.fromLTRB(
                                            0.0, 4.0, 0, 4.0),
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              "Amount : "
                                                  .toLowerCase(),
                                              style: TextStyle(
                                                  fontSize:
                                                  FSTextStyle
                                                      .h6size,
                                                  fontFamily:
                                                  'Gilroy-SemiBold',
                                                  color: FsColor
                                                      .lightgrey),
                                            ),
                                            Icon(FlutterIcon.rupee,
                                                size: FSTextStyle
                                                    .h6size,
                                                color:
                                                FsColor.darkgrey),
                                            Text(
                                              "${maintenence["invoiceamount"]}"
                                                  .toLowerCase(),
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
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(
                                      0.0, 8.0, 0, 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        child:
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              "Period : "
                                                  .toLowerCase(),
                                              style: TextStyle(
                                                  fontSize:
                                                  FSTextStyle
                                                      .h6size,
                                                  fontFamily:
                                                  'Gilroy-SemiBold',
                                                  color: FsColor
                                                      .lightgrey),
                                            ),
                                            Text(
                                              "${maintenence["period"]}"
                                                  .toLowerCase(),
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
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(
                                      0.0, 8.0, 0, 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: <Widget>[


                                      Container(
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              "Date : ".toLowerCase(),
                                              style: TextStyle(
                                                  fontSize:
                                                  FSTextStyle
                                                      .h6size,
                                                  fontFamily:
                                                  'Gilroy-SemiBold',
                                                  color: FsColor
                                                      .lightgrey),
                                            ),
                                            Text(
                                              "${maintenence["invoicedate"]}"
                                                  .toLowerCase(),
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
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              "Sub Total : "
                                                  .toLowerCase(),
                                              style: TextStyle(
                                                  fontSize:
                                                  FSTextStyle
                                                      .h6size,
                                                  fontFamily:
                                                  'Gilroy-SemiBold',
                                                  color: FsColor
                                                      .lightgrey),
                                            ),
                                            Icon(FlutterIcon.rupee,
                                                size: FSTextStyle
                                                    .h6size,
                                                color:
                                                FsColor.darkgrey),
                                            Text(
                                              "${maintenence["subtotal"]}"
                                                  .toLowerCase(),
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
                                        ),
                                      ),
                                    ],
                                  ),
                                ),


                                Container(
                                  padding: EdgeInsets.fromLTRB(
                                      0.0, 8.0, 0, 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              "Due on : "
                                                  .toLowerCase(),
                                              style: TextStyle(
                                                  fontSize:
                                                  FSTextStyle
                                                      .h6size,
                                                  fontFamily:
                                                  'Gilroy-SemiBold',
                                                  color: FsColor
                                                      .lightgrey),
                                            ),
                                            Text(
                                              "${maintenence["dueson"]}"
                                                  .toLowerCase(),
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
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              "Credit : "
                                                  .toLowerCase(),
                                              style: TextStyle(
                                                  fontSize:
                                                  FSTextStyle
                                                      .h6size,
                                                  fontFamily:
                                                  'Gilroy-SemiBold',
                                                  color: FsColor
                                                      .lightgrey),
                                            ),
                                            Icon(FlutterIcon.rupee,
                                                size: FSTextStyle
                                                    .h6size,
                                                color:
                                                FsColor.darkgrey),
                                            Text(
                                              "${maintenence["creditadjust"]}"
                                                  .toLowerCase(),
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
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(
                                      0.0, 8.0, 0, 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              "DPC : ".toLowerCase(),
                                              style: TextStyle(
                                                  fontSize:
                                                  FSTextStyle
                                                      .h6size,
                                                  fontFamily:
                                                  'Gilroy-SemiBold',
                                                  color: FsColor
                                                      .lightgrey),
                                            ),
                                            Icon(FlutterIcon.rupee,
                                                size: FSTextStyle
                                                    .h6size,
                                                color:
                                                FsColor.darkgrey),
                                            Text(
                                              "${maintenence["dpc"]}"
                                                  .toLowerCase(),
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
                                        ),


                                      ),
                                      Container(
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              "Tax : ".toLowerCase(),
                                              style: TextStyle(
                                                  fontSize:
                                                  FSTextStyle
                                                      .h6size,
                                                  fontFamily:
                                                  'Gilroy-SemiBold',
                                                  color: FsColor
                                                      .lightgrey),
                                            ),
                                            Icon(FlutterIcon.rupee,
                                                size: FSTextStyle
                                                    .h6size,
                                                color:
                                                FsColor.darkgrey),
                                            Text(
                                              "${maintenence["tax"]}"
                                                  .toLowerCase(),
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
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(
                                      0.0, 8.0, 0, 8.0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "${maintenence["paymentstatus"]}"
                                            .toLowerCase(),
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
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(
                                      0.0, 10.0, 0, 0.0),
                                  decoration: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                            width: 1.0,
                                            color: FsColor.basicprimary
                                                .withOpacity(0.2)),
                                      )),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              "Paid : ".toLowerCase(),
                                              style: TextStyle(
                                                  fontSize:
                                                  FSTextStyle
                                                      .h6size,
                                                  fontFamily:
                                                  'Gilroy-SemiBold',
                                                  color: FsColor
                                                      .lightgrey),
                                            ),
                                            Icon(FlutterIcon.rupee,
                                                size: FSTextStyle
                                                    .h6size,
                                                color:
                                                FsColor.darkgrey),
                                            Text(
                                              "${maintenence["paidamount"]}"
                                                  .toLowerCase(),
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
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              "Balance : "
                                                  .toLowerCase(),
                                              style: TextStyle(
                                                  fontSize:
                                                  FSTextStyle
                                                      .h6size,
                                                  fontFamily:
                                                  'Gilroy-SemiBold',
                                                  color: FsColor
                                                      .lightgrey),
                                            ),
                                            Icon(FlutterIcon.rupee,
                                                size: FSTextStyle
                                                    .h6size,
                                                color:
                                                FsColor.darkgrey),
                                            Text(
                                              "${maintenence["balancedues"]}"
                                                  .toLowerCase(),
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
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) =>
                                      MyFlatsMaintenenceDetails(
                                          maintenence["invoicenum"],
                                          billType, currentUnit['unit_id'])),
                            );
                          },
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        )
      ],
    );
  }

  @override
  errorDues() {
    isLoading = false;
  }

  @override
  failedDues() {
    isLoading = false;
  }

  String currentPage = "1";

  @override
  void successDues(matedata, List allInvoices) {
    try {
      print(matedata);
      //currentPage = (matedata["current_page"] + 1).toString();
      this.metadata = matedata;
    } catch (e) {
      print(e);
    }
    setState(() {
      isLoading = false;
      maintenencedues.addAll(allInvoices);
    });
  }
}

abstract class MaintenenceDueView extends IMaintenenceDue {}

class MaintenenceDuePresentor {
  MaintenenceDueView maintenenceDueView;

  MaintenenceDuePresentor(this.maintenenceDueView);

  void getDues(String unit_id, {String loadPage, String dueType}) {
    print("sdddssd");
    MaintenenceDue maintenence = new MaintenenceDue();
    print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
    maintenence.getDues(unit_id, maintenenceDueView,
        loadPage: loadPage, dueType: dueType);
  }

  void getIncedental(String unitId, {String loadPage}) {
    IncedentalDue incedental = new IncedentalDue();
    incedental.getDues(unitId, maintenenceDueView, loadPage: loadPage);
  }
}

abstract class IMaintenenceDue {
  void successDues(var matedata, List<dynamic> allInvoices);

  void errorDues();

  void failedDues();
}

class MaintenenceDue {
  void getDues(String unitId, IMaintenenceDue iMaintenenceDue,
      {String loadPage, String dueType}) {
    print("sdddssd");
    ChsoneStorage.getAccessToken().then((token) {
      HashMap<String, String> hashTable = new HashMap();
      hashTable["token"] = token;
      hashTable["unit_id"] = unitId;
      //hashTable["payment_status"] = "unpaid";
      if (loadPage != null) {
        hashTable["page"] = loadPage;
      }
      if (dueType != null) {
        hashTable["payment_status"] = dueType;
      }
      NetworkHandler handler = new NetworkHandler((a) {
        print(a);
        var resPonse = jsonDecode(a)["data"];
        var matedata = resPonse["metadata"];
        var listInvouces = resPonse["results"];
        var allInvoices = [];
        for (var data in listInvouces) {
          try {
            allInvoices.add({
              "invoicenum": data["invoice_number"],
              "subtotal": AppUtils.doubleFormat(data["sub_total"]),
              "period": data["from_date"] + " - " + data["to_date"],
              "dpc": AppUtils.doubleFormat(
                  data["invoice_amount_detail"]["late_charges"]),
              "invoicedate": data["invoice_date"],
              "tax": AppUtils.doubleFormat(data["tax_amount"]),
              "dueson": data["due_date"],
              "invoiceamount": AppUtils.doubleFormat(
                  data["invoice_amount_detail"]["invoice_amount"]),
              "creditadjust": AppUtils.doubleFormat(
                  data["invoice_amount_detail"]["advance_paid"]),
              "paidamount": AppUtils.doubleFormat(
                  data["invoice_amount_detail"]["total_paid"]),
              "balancedues": AppUtils.doubleFormat(
                  data["invoice_amount_detail"]["total_due"]),
              "paymentstatus": data["payment_status"]
            });
          } catch (e) {
            print(e);
          }
        }
        iMaintenenceDue.successDues(matedata, allInvoices);
      }, (s) {
        print(s);
      }, (s) {
        print(s);
      });
      CHSONEAPIHandler.getMaintainceDues(handler, hashTable).excute();
    });
  }
}

class IncedentalDue {
  void getDues(String unitId, IMaintenenceDue iMaintenenceDue,
      {String loadPage /*, String dueType*/
      }) {
    ChsoneStorage.getAccessToken().then((token) {
      HashMap<String, String> hashTable = new HashMap();
      hashTable["token"] = token;
      hashTable["unit_id"] = unitId;
      //hashTable["payment_status"] = "unpaid";
      if (loadPage != null) {
        hashTable["page"] = loadPage;
      }
      /* if (dueType != null) {
        hashTable["payment_status"] = dueType;
      }*/
      NetworkHandler handler = new NetworkHandler((a) {
        print(a);
        var resPonse = jsonDecode(a)["data"];
        var matedata = resPonse["metadata"];
        var listInvouces = resPonse["results"];
        var allInvoices = [];
        for (var data in listInvouces) {
          try {
            allInvoices.add({
              "invoicenum": data["invoice_number"],
              "subtotal": AppUtils.doubleFormat(data["sub_total"]),
              "period": data["from_date"] + " - " + data["to_date"],
              "dpc": AppUtils.doubleFormat(
                  data["invoice_amount_detail"]["late_charges"]),
              "invoicedate": data["invoice_date"],
              "tax": AppUtils.doubleFormat(data["tax_amount"]),
              "dueson": data["due_date"],
              "invoiceamount": AppUtils.doubleFormat(
                  data["invoice_amount_detail"]["invoice_amount"]),
              "creditadjust": AppUtils.doubleFormat(
                  data["invoice_amount_detail"]["advance_paid"]),
              "paidamount": AppUtils.doubleFormat(
                  data["invoice_amount_detail"]["total_paid"]),
              "balancedues": AppUtils.doubleFormat(
                  data["invoice_amount_detail"]["total_due"]),
              "paymentstatus": data["payment_status"]
            });
          } catch (e) {
            print(e);
          }
        }
        iMaintenenceDue.successDues(matedata, allInvoices);
      }, (s) {
        print(s);
      }, (s) {
        print(s);
      });
      CHSONEAPIHandler.getIncedentalDues(handler, hashTable).excute();
    });
  }
}

enum DUES_TYPE {
  PAID,
  UNPAID,
  PARTIAL_PAID,
  ALL,
  OVERDUE /*INCIDENTAL,MAINTANCE*/
}
enum BILLTYPE { INCIDENTAL, MAINTANCE }
