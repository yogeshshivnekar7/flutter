import 'package:common_config/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

class HelpSupport extends StatefulWidget {
  @override
  _HelpSupportState createState() => _HelpSupportState();
}

class _HelpSupportState extends State<HelpSupport> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: FsColor.white,
        elevation: 0.0,
        title: new Text(
          'Help Support',
          style: FSTextStyle.appbartext,
        ),
        leading: FsBackButton(),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.fromLTRB(0, 10, 0, 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Issue Not Resolved Yet?'.toLowerCase(),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: FSTextStyle.h4size,
                      fontFamily: 'Gilroy-SemiBold',
                      color: FsColor.basicprimary,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'we are really sorry for this experience. please reach out to our support executive via call or email as per your convenience and we will try to resolve it at the earliest.'
                        .toLowerCase(),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: FSTextStyle.h6size,
                      fontFamily: 'Gilroy-SemiBold',
                      color: FsColor.darkgrey,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  GestureDetector(
                    child: RaisedButton(
                      padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(4.0),
                      ),
                      child: Text('Call us',
                          style: TextStyle(
                            fontSize: FSTextStyle.h6size,
                            fontFamily: 'Gilroy-SemiBold',
                          )),
                      onPressed: () => callIntent(context),
                      color: FsColor.basicprimary,
                      textColor: FsColor.white,
                    ),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    child: RaisedButton(
                      padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(4.0),
                      ),
                      child: Text('Email us',
                          style: TextStyle(
                            fontSize: FSTextStyle.h6size,
                            fontFamily: 'Gilroy-SemiBold',
                          )),
                      onPressed: () => email(),
                      color: FsColor.basicprimary,
                      textColor: FsColor.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> callIntent(BuildContext context) async {
    try {
      String url = "tel:+912248972111";
      if (await AppUtils.canLaunchUrl(url)) {
        await AppUtils.launchUrl(url);
      } else {
        Toasly.error(context, 'calling not supported.');
      }
    } catch (e) {}
  }

  Future<void> email() async {
    try {
      SsoStorage.getUserProfile().then((value) async {
        print(value);
        final Email email = Email(
          subject:
              "${value["mobile"]}:Requesting intervention in the specified issue",
          recipients: ['support@cubeoneapp.com'],
          isHTML: false,
        );
        await FlutterEmailSender.send(email);
      });
    } catch (e) {}
  }

  void popupButtonSelected(String value) {}
}
