import 'package:common_config/utils/fs_navigator.dart';
import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/utils/app_constant.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

import 'intercom/myvisitors_intercomlist.dart';

class MyVisitorHelp extends StatefulWidget {
  String comingFrom;

  var currenUnit;

  @override
  _MyVisitorHelpState createState() =>
      new _MyVisitorHelpState(comingFrom, currenUnit);

  MyVisitorHelp({this.comingFrom, this.currenUnit});
}

class _MyVisitorHelpState extends State<MyVisitorHelp> {
  String comingFrom;

  var currenUnit;

  _MyVisitorHelpState(this.comingFrom, this.currenUnit);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: FsColor.primaryvisitor,
        title: Text(
          "Help".toLowerCase(),
          style: FSTextStyle.appbartextlight,
        ),
        leading: FsBackButtonlight(),
        actions: <Widget>[],
      ),
      body: SingleChildScrollView(
        child: Container(
//              padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
            margin: EdgeInsets.fromLTRB(20, 10, 10, 10),
            child: Stack(
              children: <Widget>[
                Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(
                          top: 5.0, left: 5.0, right: 5.0, bottom: 15.0),
                      child: Text(
                        'Member to Gate Calling'.toLowerCase(),
                        style: TextStyle(
                          fontSize: FSTextStyle.h5size,
                          fontFamily: 'Gilroy-SemiBold',
                          color: FsColor.basicprimary,
                          height: 1.5,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 5, 0, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              alignment: Alignment.center,
                              color: FsColor.primaryvisitor.withOpacity(0.25),
                              width: 24,
                              height: 24,
                              child: Text(
                                "1",
                                style: TextStyle(
                                    fontSize: FSTextStyle.h5size,
                                    color: FsColor.primaryvisitor,
                                    fontFamily: 'Gilroy-SemiBold'),
                              )),
                          SizedBox(width: 10),
                          comingFrom == null || comingFrom == "help"
                              ? Expanded(
                                  child: Wrap(children: <Widget>[
                                    Text(
                                      "Click the call icon".toLowerCase(),
                                      style: TextStyle(
                                          fontSize: FSTextStyle.h6size,
                                          color: FsColor.darkgrey,
                                          fontFamily: 'Gilroy-SemiBold'),
                                    ),
                                    Container(
                                      width: 24,
                                      child: Icon(
                                        Icons.phone_in_talk,
                                        size: 20,
                                        color: FsColor.green,
                                      ),
                                    ),
                                    Text(
                                      "in the 'my visitor' card.".toLowerCase(),
                                      style: TextStyle(
                                          fontSize: FSTextStyle.h6size,
                                          color: FsColor.darkgrey,
                                          fontFamily: 'Gilroy-SemiBold'),
                                    )
                                  ]),
                                )
                              : Expanded(
                                  child: Text(
                                    "go to 'Gate' tab.",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: FSTextStyle.h6size,
                                        color: FsColor.darkgrey,
                                        fontFamily: 'Gilroy-SemiBold'),
                                  ),
                                ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 5, 0, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              alignment: Alignment.center,
                              color: FsColor.primaryvisitor.withOpacity(0.25),
                              width: 24,
                              height: 24,
                              child: Text(
                                "2",
                                style: TextStyle(
                                    fontSize: FSTextStyle.h5size,
                                    color: FsColor.primaryvisitor,
                                    fontFamily: 'Gilroy-SemiBold'),
                              )),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              "Choose/Search the gate name that you want to call."
                                  .toLowerCase(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: FSTextStyle.h6size,
                                  color: FsColor.darkgrey,
                                  fontFamily: 'Gilroy-SemiBold'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 5, 0, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              alignment: Alignment.center,
                              color: FsColor.primaryvisitor.withOpacity(0.25),
                              width: 24,
                              height: 24,
                              child: Text(
                                "3",
                                style: TextStyle(
                                    fontSize: FSTextStyle.h5size,
                                    color: FsColor.primaryvisitor,
                                    fontFamily: 'Gilroy-SemiBold'),
                              )),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              "Click the call button beside your chosen gate."
                                  .toLowerCase(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: FSTextStyle.h6size,
                                  color: FsColor.darkgrey,
                                  fontFamily: 'Gilroy-SemiBold'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 5, 0, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              alignment: Alignment.center,
                              color: FsColor.primaryvisitor.withOpacity(0.25),
                              width: 24,
                              height: 24,
                              child: Text(
                                "4",
                                style: TextStyle(
                                    fontSize: FSTextStyle.h5size,
                                    color: FsColor.primaryvisitor,
                                    fontFamily: 'Gilroy-SemiBold'),
                              )),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              "Your call will be connected to the respective gatekeeper."
                                  .toLowerCase(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: FSTextStyle.h6size,
                                  color: FsColor.darkgrey,
                                  fontFamily: 'Gilroy-SemiBold'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(
                          top: 5.0, left: 5.0, right: 5.0, bottom: 15.0),
                      child: Text(
                        'Member to Member Calling'.toLowerCase(),
                        style: TextStyle(
                          fontSize: FSTextStyle.h5size,
                          fontFamily: 'Gilroy-SemiBold',
                          color: FsColor.basicprimary,
                          height: 1.5,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 5, 0, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              alignment: Alignment.center,
                              color: FsColor.primaryvisitor.withOpacity(0.25),
                              width: 24,
                              height: 24,
                              child: Text(
                                "1",
                                style: TextStyle(
                                    fontSize: FSTextStyle.h5size,
                                    color: FsColor.primaryvisitor,
                                    fontFamily: 'Gilroy-SemiBold'),
                              )),
                          SizedBox(width: 10),
                          comingFrom == null || comingFrom == "help"
                              ? Expanded(
                                  child: Wrap(children: <Widget>[
                                    Text(
                                      "Click the call icon".toLowerCase(),
                                      style: TextStyle(
                                          fontSize: FSTextStyle.h6size,
                                          color: FsColor.darkgrey,
                                          fontFamily: 'Gilroy-SemiBold'),
                                    ),
                                    Container(
                                      width: 24,
                                      child: Icon(
                                        Icons.phone_in_talk,
                                        size: 20,
                                        color: FsColor.green,
                                      ),
                                    ),
                                    Text(
                                      "in the 'my visitor' card.".toLowerCase(),
                                      style: TextStyle(
                                          fontSize: FSTextStyle.h6size,
                                          color: FsColor.darkgrey,
                                          fontFamily: 'Gilroy-SemiBold'),
                                    )
                                  ]),
                                )
                              :
//                  .
                              Expanded(
                                  child: Text(
                                    "go to 'All Members' tab",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: FSTextStyle.h6size,
                                        color: FsColor.darkgrey,
                                        fontFamily: 'Gilroy-SemiBold'),
                                  ),
                                ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 5, 0, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              alignment: Alignment.center,
                              color: FsColor.primaryvisitor.withOpacity(0.25),
                              width: 24,
                              height: 24,
                              child: Text(
                                "2",
                                style: TextStyle(
                                    fontSize: FSTextStyle.h5size,
                                    color: FsColor.primaryvisitor,
                                    fontFamily: 'Gilroy-SemiBold'),
                              )),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              "Choose/Search the member name/ flat number you want to call"
                                  .toLowerCase(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: FSTextStyle.h6size,
                                  color: FsColor.darkgrey,
                                  fontFamily: 'Gilroy-SemiBold'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 5, 0, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              alignment: Alignment.center,
                              color: FsColor.primaryvisitor.withOpacity(0.25),
                              width: 24,
                              height: 24,
                              child: Text(
                                "3",
                                style: TextStyle(
                                    fontSize: FSTextStyle.h5size,
                                    color: FsColor.primaryvisitor,
                                    fontFamily: 'Gilroy-SemiBold'),
                              )),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              "Click the call button beside your chosen member name / flat number."
                                  .toLowerCase(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: FSTextStyle.h6size,
                                  color: FsColor.darkgrey,
                                  fontFamily: 'Gilroy-SemiBold'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 5, 0, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              alignment: Alignment.center,
                              color: FsColor.primaryvisitor.withOpacity(0.25),
                              width: 24,
                              height: 24,
                              child: Text(
                                "4",
                                style: TextStyle(
                                    fontSize: FSTextStyle.h5size,
                                    color: FsColor.primaryvisitor,
                                    fontFamily: 'Gilroy-SemiBold'),
                              )),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              "Your call will be connected to the respective member."
                                  .toLowerCase(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: FSTextStyle.h6size,
                                  color: FsColor.darkgrey,
                                  fontFamily: 'Gilroy-SemiBold'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    getCommitteeMemberCallingInfoSectionWidget(),
                    SizedBox(height: 20),
                    comingFrom == null ||
                            comingFrom == "help" ||
                            comingFrom == "inter_help"
                        ? Container()
                        : Container(
                            padding: EdgeInsets.all(8.0),
                            child: GestureDetector(
                              child: RaisedButton(
                                padding:
                                    EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(4.0),
                                ),
                                child: Text('Got It',
                                    style: TextStyle(
                                        fontSize: FSTextStyle.h6size,
                                        fontFamily: 'Gilroy-SemiBold')),
                                onPressed: () {
                                  Navigator.pop(context);
                                  SsoStorage.setIntercomHelp(AppConstant.SEEN);
                                  FsNavigator.push(context,
                                      MyVisitorsIntercomList(currenUnit));
                                },
                                color: FsColor.primaryvisitor,
                                textColor: FsColor.white,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            )),
      ),
    );
  }

  Widget getCommitteeMemberCallingInfoSectionWidget() {
    List infoList = getCommitteeMemberCallingInfoList();
    return Container(
      margin: EdgeInsets.fromLTRB(0, 5, 0, 20),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return getInfoSectionItemWidget(
              infoList[index], index);
        },
        itemCount: infoList.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
      ),
    );
  }

  Widget getInfoSectionItemWidget(itemData, int position) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 5, 0, 20),
      child: itemData["is_title"]
          ? getSectionTitleWidget(itemData, position)
          : getInfoMessageWidget(itemData, position),
    );
  }

  Widget getSectionTitleWidget(itemData, int position) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        itemData["text"].toLowerCase(),
        style: TextStyle(
          fontSize: FSTextStyle.h5size,
          fontFamily: 'Gilroy-SemiBold',
          color: FsColor.basicprimary,
          height: 1.5,
        ),
      ),
    );
  }

  Widget getInfoMessageWidget(itemData, int position) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        getStepsCounterWidget(position),
        SizedBox(width: 10),
        getInfoMessageTextWidget(itemData),
      ],
    );
  }

  Widget getInfoMessageTextWidget(itemData) {
    String message = itemData["text"];
    int iconPosition = itemData["icon_position"];

    String preIconMessage = "";
    String postIconMessage = "";

    if (iconPosition >= 0) {
      preIconMessage = message.substring(0, iconPosition);
      postIconMessage = message.substring(iconPosition + 1, message.length);
    }

    return Expanded(
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: iconPosition > 0 ? preIconMessage : message,
                style: TextStyle(
                    fontSize: FSTextStyle.h6size,
                    color: FsColor.darkgrey,
                    fontFamily: 'Gilroy-SemiBold'),
              ),
              WidgetSpan(
                child: iconPosition > 0
                    ? Icon(
                  Icons.phone_in_talk,
                  size: 20,
                  color: FsColor.green,
                )
                    : Text(""),
              ),
              TextSpan(
                  text: postIconMessage,
                  style: TextStyle(
                      fontSize: FSTextStyle.h6size,
                      color: FsColor.darkgrey,
                      fontFamily: 'Gilroy-SemiBold')),
            ],
          ),
        ));
  }

  Widget getStepsCounterWidget(int position) {
    return Container(
        alignment: Alignment.center,
        color: FsColor.primaryvisitor.withOpacity(0.25),
        width: 24,
        height: 24,
        child: Text(
          position.toString(),
          style: TextStyle(
              fontSize: FSTextStyle.h5size,
              color: FsColor.primaryvisitor,
              fontFamily: 'Gilroy-SemiBold'),
        ));
  }

  List getCommitteeMemberCallingInfoList() {
    return [
      {
        "text": "Member to Committee Member Calling",
        "is_title": true,
        "icon": null,
        "icon_position": -1
      },
      comingFrom == null || comingFrom == "help"
          ? {
        "text": "click the   icon in the 'my visitor' card",
        "is_title": false,
        "icon": null,
        "icon_position": 10
      }
          : {
        "text": "go to 'Committee Members' tab",
        "is_title": false,
        "icon": null,
        "icon_position": -1
      },
      {
        "text": "Choose/search the committee member name you want to call",
        "is_title": false,
        "icon": null,
        "icon_position": -1
      },
      {
        "text": "click the call button beside your chosen committee member name",
        "is_title": false,
        "icon": null,
        "icon_position": -1
      },
      {
        "text":
        "your call will be connected to the respective committee member",
        "is_title": false,
        "icon": null,
        "icon_position": -1
      }
    ];
  }
}
