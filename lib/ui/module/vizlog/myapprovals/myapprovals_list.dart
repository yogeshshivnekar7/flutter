import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/ui/widgets/list_widget.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';
import 'package:sso_futurescape/utils/app_utils.dart';

class MyApprovalsList extends StatefulWidget {
  @override
  _MyApprovalsListState createState() => new _MyApprovalsListState();
}

class _MyApprovalsListState extends State<MyApprovalsList>
    implements PageLoadListener {
  FsListState listListner;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(
          'My Missed Approvals'.toLowerCase(),
          style: FSTextStyle.appbartextlight,
        ),
        elevation: 1.0,
        backgroundColor: FsColor.primaryvisitor,
        leading: FsBackButtonlight(),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
        child: FsListWidget(
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
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Image.asset(
                                "${item["photo"]}",
                                height: 48,
                                width: 48,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 10.0),
                            Column(
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
                                Text(
                                  '${item["designation"]}'.toLowerCase(),
                                  style: TextStyle(
                                      fontSize: FSTextStyle.h6size,
                                      fontFamily: 'Gilroy-SemiBold',
                                      color: FsColor.lightgrey),
                                ),
                              ],
                            )
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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      "visited at : ".toLowerCase(),
                                      style: TextStyle(
                                          fontSize: FSTextStyle.h6size,
                                          fontFamily: 'Gilroy-SemiBold',
                                          color: FsColor.lightgrey),
                                    ),
                                    Text(
                                      "${item["duration"]} ago",
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
                ),
              );
            },
            afterView: (FsListState v) {
              listListner = v;
              Timer(Duration(milliseconds: 100), () {
                setState(() {
                  /*listListner.addListList({
                    "total": 8,
                    "per_page": 10,
                    "current_page": 1,
                    "last_page": 1,
                    "from": 1,
                    "to": 10
                  }, approvals);*/
                });
              });
            }),
      ),
    );
  }

  @override
  lastPage(int page) {
    // TODO: implement lastPage
  }

  @override
  loadNextPage(String page) {
    // TODO: implement loadNextPage
  }
}
