import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';

class MyVisitorsTrustCitizenPass extends StatefulWidget {
  @override
  _MyVisitorsTrustCitizenPassState createState() =>
      new _MyVisitorsTrustCitizenPassState();
}

class _MyVisitorsTrustCitizenPassState
    extends State<MyVisitorsTrustCitizenPass> {
  @override
  Widget build(BuildContext context) {
    return new Container(
        child: Column(
      children: <Widget>[
        Container(
          child: Card(
            elevation: 1.0,
            key: null,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/dash-bg.jpg"),
                  fit: BoxFit.cover,
                ),
                border: Border.all(
                    width: 1.0, color: FsColor.darkgrey.withOpacity(0.5)),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Trust Citizen Pass".toLowerCase(),
                          style: TextStyle(
                              fontSize: FSTextStyle.dashtitlesize,
                              fontFamily: 'Gilroy-SemiBold',
                              color: FsColor.primaryvisitor),
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
                            borderRadius: new BorderRadius.circular(4.0),
                          ),
                          onPressed: () => {_showPassDialog()},
                          color: FsColor.primaryvisitor,
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          child: Text(
                            "V Pass",
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
                            Image.network(
                                "https://image.flaticon.com/icons/svg/241/241528.svg",
                                height: 80,
                                width: 80,
                                fit: BoxFit.fitHeight),
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
                          width: 1.0, color: FsColor.basicprimary.withOpacity(0.2)),
                    )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Container(
                          child: GestureDetector(
                            child: FlatButton(
                              onPressed: () {},
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
    ));
  }

  void _showPassDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(7.0),
            ),
            content: Container(
              height: 450.0,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 72,
                    margin: const EdgeInsets.only(
                        left: 10.0, right: 15.0, top: 10.0, bottom: 10.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: Image.asset(
                        'images/default.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                    child: new Text(
                      "Name Comes Here".toLowerCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Gilroy-SemiBold',
                          fontSize: FSTextStyle.h4size,
                          color: FsColor.darkgrey),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                    child: new Text(
                      "email@domain.com".toLowerCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Gilroy-Regular',
                          fontSize: FSTextStyle.h6size,
                          color: FsColor.darkgrey),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                    child: new Text(
                      "+91 9876543210".toLowerCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Gilroy-Regular',
                          fontSize: FSTextStyle.h6size,
                          color: FsColor.darkgrey),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    height: 200.0,
                    child: new Image.network(
                      'https://image.flaticon.com/icons/svg/241/241528.svg',
                      fit: BoxFit.fill,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0, 0.0, 0),
                    child: new Text(
                      "powered by CubeOne".toLowerCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Gilroy-Regular',
                          fontSize: FSTextStyle.h7size,
                          color: FsColor.darkgrey),
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}
