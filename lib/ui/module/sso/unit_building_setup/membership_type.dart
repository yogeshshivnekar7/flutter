import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/module/sso/unit_building_setup/pending_approval.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/utils/storage/complex.dart';

class MembershipTypePage extends StatefulWidget {
  @override
  _MembershipTypePageState createState() => new _MembershipTypePageState();
}

class _MembershipTypePageState extends State<MembershipTypePage> {
  TextEditingController userNameController = new TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        backgroundColor: FsColor.primaryflat,
        elevation: 0.0,
        title: new Text(
          'Complex Name Here',
          style: FSTextStyle.appbartextlight,
        ),
        leading: FsBackButtonlight(),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                top: 15.0, bottom: 15.0, left: 10.0, right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(width: 5.0),
                Container(
                  alignment: Alignment.center,
                  width: 30.0,
                  height: 30.0,
                  decoration: BoxDecoration(
                    color: FsColorStepper.active,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Text(
                    '1',
                    style: TextStyle(
                      fontFamily: 'Gilroy-Bold',
                      fontSize: FSTextStyle.h6size,
                      color: FsColor.white,
                    ),
                  ),
                ),
                Expanded(
                    child: Divider(
                  color: FsColorStepper.active,
                  height: 1,
                )),
                Container(
                  alignment: Alignment.center,
                  width: 30.0,
                  height: 30.0,
                  decoration: BoxDecoration(
                    color: FsColorStepper.active,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Text(
                    '2',
                    style: TextStyle(
                      fontFamily: 'Gilroy-Bold',
                      fontSize: FSTextStyle.h6size,
                      color: FsColor.white,
                    ),
                  ),
                ),
                Expanded(
                    child: Divider(
                  color: FsColorStepper.active,
                  height: 1,
                )),
                Container(
                  alignment: Alignment.center,
                  width: 30.0,
                  height: 30.0,
                  decoration: BoxDecoration(
                    color: FsColorStepper.active,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Text(
                    '3',
                    style: TextStyle(
                      fontFamily: 'Gilroy-Bold',
                      fontSize: FSTextStyle.h6size,
                      color: FsColor.white,
                    ),
                  ),
                ),
                Expanded(
                    child: Divider(
                  color: FsColorStepper.active,
                  height: 1,
                )),
                Container(
                  alignment: Alignment.center,
                  width: 30.0,
                  height: 30.0,
                  decoration: BoxDecoration(
                    color: FsColorStepper.active,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Text(
                    '4',
                    style: TextStyle(
                      fontFamily: 'Gilroy-Bold',
                      fontSize: FSTextStyle.h6size,
                      color: FsColor.white,
                    ),
                  ),
                ),
                SizedBox(width: 5.0),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
                child: Text(
                  'your membership type',
                  style: TextStyle(
                    fontSize: FSTextStyle.h5size,
                    fontFamily: 'Gilroy-SemiBold',
                    color: FsColor.darkgrey,
                    height: 1.2,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: ListView.builder(
                  primary: false,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: access == null ? 0 : access.length,
                  itemBuilder: (BuildContext context, int index) {
                    Map place = access[index];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: InkWell(
                        child: place["selected"]
                            ? Container(
                                padding: const EdgeInsets.only(
                                  bottom: 10.0,
                                  top: 10.0,
                                ),
                                decoration: BoxDecoration(
                                  color: FsColor.primaryflat.withOpacity(0.1),
                                  border: Border.all(
                                      width: 1.0, color: FsColor.primaryflat),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4.0)),
                                ),
                                // height: 85,
                                child: Row(
                                  children: <Widget>[
                                    // SizedBox(width: 15),
                                    Container(
                                      alignment: Alignment.center,
                                      // height: 80,
                                      width: MediaQuery.of(context).size.width -
                                          100,
                                      child: ListView(
                                        primary: false,
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        children: <Widget>[
                                          Container(
                                            padding: const EdgeInsets.only(
                                                left: 5.0),
                                            alignment: Alignment.centerLeft,
                                            child: RichText(
                                                text: TextSpan(
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .body1,
                                                    children: [
                                                  TextSpan(
                                                    text: '${place["name"]}',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'Gilroy-SemiBold',
                                                      fontSize:
                                                          FSTextStyle.h6size,
                                                      color: FsColor
                                                          .basicprimary,
                                                    ),
                                                  ),
                                                ])),
                                          ),
                                          SizedBox(height: 5),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container(
                                padding: const EdgeInsets.only(
                                  bottom: 10.0,
                                  top: 10.0,
                                ),
                                // height: 85,
                                child: Row(
                                  children: <Widget>[
                                    // SizedBox(width: 15),
                                    Container(
                                      alignment: Alignment.center,
                                      // height: 80,
                                      width: MediaQuery.of(context).size.width -
                                          100,
                                      child: ListView(
                                        primary: false,
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        children: <Widget>[
                                          Container(
                                            padding: const EdgeInsets.only(
                                                left: 5.0),
                                            alignment: Alignment.centerLeft,
                                            child: RichText(
                                                text: TextSpan(
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .body1,
                                                    children: [
                                                  TextSpan(
                                                    text: '${place["name"]}',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'Gilroy-SemiBold',
                                                      fontSize:
                                                          FSTextStyle.h6size,
                                                      color: FsColor.basicprimary,
                                                    ),
                                                  ),
                                                ])),
                                          ),
                                          SizedBox(height: 5),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                        onTap: () {
                          _confirmsetupDialog();
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void _confirmsetupDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("please confirm",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Gilroy-SemiBold',
                  fontSize: FSTextStyle.h4size,
                  color: FsColor.darkgrey)),
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(7.0),
          ),
          content: Container(
            height: 250.0,
            alignment: Alignment.centerLeft,
            // width: 900.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Text(
                      'confirm your complex details so we can send your details to complex office',
                      style: TextStyle(
                          fontFamily: 'Gilroy-Regular',
                          fontSize: FSTextStyle.h6size,
                          color: FsColor.darkgrey)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: <TextSpan>[
                        // TextSpan(
                        //     text: 'complex : ',
                        //     style: TextStyle(
                        //         fontFamily: 'Gilroy-Regular',
                        //         fontSize: FSTextStyle.h6size,
                        //         color: FsColor.darkgrey)),
                        TextSpan(
                            text: 'Exotica CHS',
                            style: TextStyle(
                                fontFamily: 'Gilroy-Bold',
                                fontSize: FSTextStyle.h5size,
                                color: FsColor.darkgrey)),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: <TextSpan>[
                        // TextSpan(
                        //     text: 'building : ',
                        //     style: TextStyle(
                        //         fontFamily: 'Gilroy-Regular',
                        //         fontSize: FSTextStyle.h6size,
                        //         color: FsColor.darkgrey)),
                        TextSpan(
                            text: 'A Wing',
                            style: TextStyle(
                                fontFamily: 'Gilroy-Bold',
                                fontSize: FSTextStyle.h6size,
                                color: FsColor.darkgrey)),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: '2 Floor / ',
                            style: TextStyle(
                                fontFamily: 'Gilroy-Bold',
                                fontSize: FSTextStyle.h6size,
                                color: FsColor.darkgrey)),
                        TextSpan(
                            text: '204',
                            style: TextStyle(
                                fontFamily: 'Gilroy-Bold',
                                fontSize: FSTextStyle.h6size,
                                color: FsColor.darkgrey)),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: 'tenant',
                            style: TextStyle(
                                fontFamily: 'Gilroy-Bold',
                                fontSize: FSTextStyle.h6size,
                                color: FsColor.darkgrey)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
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

            RaisedButton(
              child: new Text(
                "Confirm",
                style: TextStyle(
                    fontFamily: 'Gilroy-SemiBold',
                    fontSize: FSTextStyle.h6size,
                    color: FsColor.white),
              ),
              color: FsColor.primaryflat,
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PendingApprovalPage("","")),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
