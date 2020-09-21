import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';
import 'package:sso_futurescape/ui/widgets/responsive_widget.dart';

class GuestPass extends StatefulWidget {
  @override
  _GuestPassState createState() => _GuestPassState();
}

class _GuestPassState extends State<GuestPass> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      primaryColor: FsColor.primaryvisitor,
      appBar: AppBar(
        backgroundColor: FsColor.primaryvisitor,
        elevation: 0.0,
        title: Text(
          'Guest Pass'.toLowerCase(),
          style: FSTextStyle.appbartextlight,
        ),
        leading: FsBackButtonlight(),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 568,
                child: Image.asset(
                  'images/pass.jpg',
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 15),
              Container(
                child: Text(
                  'Share via',
                  style: TextStyle(
                      fontFamily: 'Gilroy-SemiBold',
                      fontSize: FSTextStyle.h7size,
                      color: FsColor.darkgrey),
                ),
              ),
              Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 50,
                        child: GestureDetector(
                          child: RaisedButton(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            shape: new CircleBorder(),
                            onPressed: () => {},
                            color: FsColor.basicprimary,
                            child: Icon(FlutterIcon.whatsapp,
                                color: FsColor.white, size: FSTextStyle.h5size),
                          ),
                        ),
                      ),
                      Container(
                        width: 50,
                        child: GestureDetector(
                          child: RaisedButton(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            shape: new CircleBorder(),
                            onPressed: () => {},
                            color: FsColor.basicprimary,
                            child: Icon(FlutterIcon.mail_alt,
                                color: FsColor.white, size: FSTextStyle.h5size),
                          ),
                        ),
                      ),
                    ],
                  )),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'from',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Gilroy-SemiBold',
                        letterSpacing: 1.0,
                        fontSize: FSTextStyle.h7size,
                        color: FsColor.darkgrey),
                  ),
                  Text(
                    'Futurescape',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Gilroy-Bold',
                        letterSpacing: 1.0,
                        fontSize: FSTextStyle.h5size,
                        color: FsColor.basicprimary),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
