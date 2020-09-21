import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/module/chsone/receipts/myflats_receiptslist.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';
import 'package:sso_futurescape/utils/app_utils.dart';

class MyFlatsReceipt extends StatefulWidget {
  var flatsReceipt;

  MyFlatsReceipt(this.flatsReceipt);

  @override
  _MyFlatsReceiptState createState() =>
      new _MyFlatsReceiptState(this.flatsReceipt);
}

class _MyFlatsReceiptState extends State<MyFlatsReceipt> {
  var flatsReceipt;
  var isLastReceipt = false;

  _MyFlatsReceiptState(this.flatsReceipt);

  @override
  void initState() {
    setState(() {
      initializeData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: new Container(
          child: Column(
            children: <Widget>[
              !isLastReceipt
                  ? Container()
                  : Container(
                child: Card(
                  elevation: 3.0,
                  key: null,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("images/dash-bg.jpg"),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(
                          width: 1.0,
                          color: FsColor.darkgrey.withOpacity(0.5)),
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Last Receipt".toLowerCase(),
                                style: TextStyle(
                                    fontSize: FSTextStyle.dashtitlesize,
                                    fontFamily: 'Gilroy-SemiBold',
                                    color: FsColor.primaryflat),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0.0, 0.0, 0, 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              RaisedButton(
                                elevation: 1.0,
                                shape: new RoundedRectangleBorder(
                                  borderRadius:
                                  new BorderRadius.circular(4.0),
                                ),
                                onPressed: () =>
                                {_download(flatsReceipt["url"])},
                                color: FsColor.primaryflat,
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10.0),
                                child: Text(
                                  "Download",
                                  style: TextStyle(
                                      fontSize: FSTextStyle.h6size,
                                      fontFamily: 'Gilroy-Bold',
                                      color: FsColor.white),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Icon(FlutterIcon.rupee,
                                          size: FSTextStyle.h4size,
                                          color: FsColor.darkgrey),
                                      Text(
                                        flatsReceipt == null
                                            ? ""
                                            : flatsReceipt[
                                        "payment_amount"] ==
                                            null
                                            ? ""
                                            : flatsReceipt[
                                        "payment_amount"]
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: FSTextStyle.h4size,
                                            fontFamily: 'Gilroy-Bold',
                                            color: FsColor.darkgrey),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Row(
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
                                        flatsReceipt == null
                                            ? ""
                                            : flatsReceipt["payment_date"] ==
                                            null
                                            ? ""
                                            : flatsReceipt[
                                        "payment_date"],
                                        style: TextStyle(
                                            fontSize: FSTextStyle.h6size,
                                            fontFamily: 'Gilroy-SemiBold',
                                            color: FsColor.darkgrey),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        "Receipt No. : ".toLowerCase(),
                                        style: TextStyle(
                                            fontSize: FSTextStyle.h6size,
                                            fontFamily: 'Gilroy-SemiBold',
                                            color: FsColor.lightgrey),
                                      ),
                                      Text(
                                        flatsReceipt == null
                                            ? ""
                                            : flatsReceipt[
                                        "receipt_number"] ==
                                            null
                                            ? ""
                                            : "#${flatsReceipt["receipt_number"]}",
                                        style: TextStyle(
                                            fontSize: FSTextStyle.h6size,
                                            fontFamily: 'Gilroy-SemiBold',
                                            color: FsColor.darkgrey),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0.0, 0.0, 0, 0.0),
                          decoration: BoxDecoration(
                              border: Border(
                              top: BorderSide(
                                  width: 1.0,
                                  color: FsColor.basicprimary.withOpacity(0.2)),
                            )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Paid by : ".toLowerCase(),
                                      style: TextStyle(
                                          fontSize: FSTextStyle.h6size,
                                          fontFamily: 'Gilroy-SemiBold',
                                          color: FsColor.lightgrey),
                                    ),
                                    Text(
                                      flatsReceipt == null
                                          ? ""
                                          : flatsReceipt["received_from"] ==
                                          null
                                          ? ""
                                          : flatsReceipt["received_from"],
                                      style: TextStyle(
                                          fontSize: FSTextStyle.h6size,
                                          fontFamily: 'Gilroy-SemiBold',
                                          color: FsColor.darkgrey),
                                      overflow: TextOverflow.fade,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: GestureDetector(
                                  child: FlatButton(
                                    onPressed: () {
                                      print(flatsReceipt);
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return MyFlatsReceiptsList(
                                                flatsReceipt['unit_id']
                                                    .toString());
                                          },
                                        ),
                                      );
                                      // Toasly.success(context, "dfghdfhgdf");
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          "View All",
                                          style: TextStyle(
                                              fontSize: FSTextStyle.h6size,
                                              fontFamily: 'Gilroy-SemiBold',
                                              color: FsColor.darkgrey),
                                        ),
                                        SizedBox(width: 10.0),
                                        Icon(FlutterIcon.right_big,
                                            color: FsColor.darkgrey,
                                            size: FSTextStyle.h6size),
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
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                alignment: Alignment.center,
              ),
              isLastReceipt
                  ? Container()
                  : Container(
                child: Card(
                  elevation: 3.0,
                  key: null,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("images/dash-bg.jpg"),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(
                          width: 1.0,
                          color: FsColor.darkgrey.withOpacity(0.5)),
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Last Receipt".toLowerCase(),
                                style: TextStyle(
                                    fontSize: FSTextStyle.dashtitlesize,
                                    fontFamily: 'Gilroy-SemiBold',
                                    color: FsColor.primaryflat),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0.0, 0.0, 0, 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
//                            RaisedButton(
//                              elevation: 1.0,
//                              shape: new RoundedRectangleBorder(
//                                borderRadius: new BorderRadius.circular(4.0),
//                              ),
//                              onPressed: _download(flatsReceipt["url"]),
//                              color: FsColor.primaryflat,
//                              padding: EdgeInsets.symmetric(
//                                  vertical: 10.0, horizontal: 10.0),
//                              child: Text(
//                                "Download",
//                                style: TextStyle(
//                                    fontSize: FSTextStyle.h6size,
//                                    fontFamily: 'Gilroy-Bold',
//                                    color: FsColor.white),
//                              ),
//                            ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        "no receipt generated",
                                        style: TextStyle(
                                            fontSize: FSTextStyle.h6size,
                                            fontFamily: 'Gilroy-SemiBold',
                                            color: FsColor.darkgrey),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0.0, 0.0, 0, 0.0),
                          decoration: BoxDecoration(
                              border: Border(
                              top: BorderSide(
                                  width: 1.0,
                                  color: FsColor.basicprimary.withOpacity(0.2)),
                            )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Container(
                                child: GestureDetector(
                                  child: FlatButton(
                                    onPressed: () {
                                      print(flatsReceipt);
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return MyFlatsReceiptsList(
                                                flatsReceipt['unit_id']
                                                    .toString());
                                          },
                                        ),
                                      );
                                      // Toasly.success(context, "dfghdfhgdf");
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          "View All",
                                          style: TextStyle(
                                              fontSize: FSTextStyle.h6size,
                                              fontFamily: 'Gilroy-SemiBold',
                                              color: FsColor.darkgrey),
                                        ),
                                        SizedBox(width: 10.0),
                                        Icon(FlutterIcon.right_big,
                                            color: FsColor.darkgrey,
                                            size: FSTextStyle.h6size),
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
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                alignment: Alignment.center,
              ),
            ],
          )),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return MyFlatsReceiptsList(flatsReceipt['unit_id'].toString());
            },
          ),
        );
      },
    );
  }

  void initializeData() {
    try {
      if (flatsReceipt != null &&
          flatsReceipt["payment_amount"] != null &&
          flatsReceipt["payment_amount"] > 0) {
        isLastReceipt = true;
      }
    } catch (e) {
      e.toString();
    }
  }

  _download(String url) {
    AppUtils.downloadFile(url);
  }
}

/*static Future<void> _launchUrlWithUrl(String url) async {
  try {
    print(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {}
  } catch (e) {
    print(e);
  }
}*/
