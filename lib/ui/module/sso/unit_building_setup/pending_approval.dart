import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/module/sso/dashboard/main_dashboard.dart';

import '../../../widgets/back_button.dart';


class PendingApprovalPage extends StatefulWidget {
  var _complex;
  String membership = "";

  PendingApprovalPage(this._complex,this.membership);

  @override
  _PendingApprovalPageState createState() =>
      new _PendingApprovalPageState(_complex,membership);
}

class _PendingApprovalPageState extends State<PendingApprovalPage> {
  var _complex;
  String membership;
  _PendingApprovalPageState(this._complex,this.membership);

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
          _complex["company_name"],
          style: FSTextStyle.appbartextlight,
        ),
        leading: FsBackButtonlight(backEvent: (context) {
          backClicked(context);
        }),
      ),
      // backgroundColor: FsColor.basicprimary.withOpacity(0.1),
      body: Container(
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.fromLTRB(20.0, 35.0, 20.0, 0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            // Container(
                            //   child: new Image.asset('images/pending-approval.png',
                            //     width: 220.0,
                            //     height: 220.0,
                            //     fit:BoxFit.contain,
                            //   ),
                            // ),
                            Container(
                              alignment: Alignment.center,
                              child: Text(
                                (membership.toLowerCase() == "primary")
                                    ? 'we have sent your details to your complex administrator.'
                                    : 'we have sent your details to your complex administrator and primary member.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'Gilroy-Regular',
                                    letterSpacing: 1.0,
                                    fontSize: FSTextStyle.h3size,
                                    height: 1.5,
                                    color: FsColor.darkgrey),
                              ),
                            ),

                            SizedBox(height: 15),
                            Container(
                              child: Text(
                                'what is next?',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'Gilroy-bold',
                                    letterSpacing: 1.0,
                                    fontSize: FSTextStyle.h5size,
                                    height: 1.5,
                                    color: FsColor.darkgrey),
                              ),
                            ),
                            Container(
                              child: Text(
                                'on approval you will be notified via sms/email',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'Gilroy-Regular',
                                    letterSpacing: 1.0,
                                    fontSize: FSTextStyle.h6size,
                                    height: 1.5,
                                    color: FsColor.darkgrey),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 20.0, top: 20.0),
                        child: GestureDetector(
                          child: RaisedButton(
                            padding:
                            EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(4.0),
                            ),
                            child: Text('Explore More',
                                style: TextStyle(
                                  fontSize: FSTextStyle.h6size,
                                  fontFamily: 'Gilroy-SemiBold',
                                )),
                            onPressed: () {
                              /*     Navigator.popUntil(
                                  context, ModalRoute.withName('/dashboard'));*/
                              /* Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainDashboard()),
                              );*/
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MainDashboard()),
                                      (Route<dynamic> route) => false);
                            },
                            color: FsColor.primaryflat,
                            textColor: FsColor.white,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  backClicked(context) {
//    Navigator.popUntil(
//        context, ModalRoute.withName('/dashboard'));
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => MainDashboard()),
            (Route<dynamic> route) => false);
  }


}
