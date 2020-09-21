import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/module/sso/unit_building_setup/membership_type.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/utils/storage/complex.dart';

class UnitPage extends StatefulWidget {
  @override
  _UnitPageState createState() => new _UnitPageState();
}

class _UnitPageState extends State<UnitPage> {
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
                  color: FsColorStepper.inactive,
                  height: 1,
                )),
                Container(
                  alignment: Alignment.center,
                  width: 30.0,
                  height: 30.0,
                  decoration: BoxDecoration(
                    color: FsColorStepper.inactive,
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
                  'choose your unit',
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
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0,
                    // childAspectRatio: 2.0,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 3.0),
                  ),
                  primary: false,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: unit == null ? 0 : unit.length,
                  itemBuilder: (BuildContext context, int index) {
                    Map place = unit[index];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: InkWell(
                        child: place["selected"]
                            ? Container(
                                padding: const EdgeInsets.only(
                                  bottom: 5.0,
                                  top: 5.0,
                                ),
                                decoration: BoxDecoration(
                                  color: FsColor.primaryflat.withOpacity(0.1),
                                  border: Border.all(
                                      width: 1.0, color: FsColor.primaryflat),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4.0)),
                                ),
                                // height: 85,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.asset(
                                        "${place["img"]}",
                                        height: 48,
                                        width: 80,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
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
                                            alignment: Alignment.center,
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
                                  bottom: 5.0,
                                  top: 5.0,
                                ),
                                // height: 85,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.asset(
                                        "${place["img"]}",
                                        height: 48,
                                        width: 80,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
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
                                            alignment: Alignment.center,
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
                              ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MembershipTypePage()),
                          );
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
}
