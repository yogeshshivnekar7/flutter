import 'package:common_config/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

class SocietyHelpSupport extends StatefulWidget {
  @override
  _SocietyHelpSupport createState() => _SocietyHelpSupport();
}

class _SocietyHelpSupport extends State<SocietyHelpSupport> {
  List contactlist = [
    {
      "name": "Trilochan singh",
    },
    {
      "name": "Rahul Naik",
    },
    {
      "name": "Neeraj Sharma",
    },
    {
      "name": "Amit Kumar",
    },
    {
      "name": "Dhara Patel",
    },
    {
      "name": "Sankalp Tambe",
    },
    {
      "name": "Dipesh Jain ",
    },
    {
      "name": "Rajeshwar",
    },
    {
      "name": "Ashish Sharma",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contact List'.toLowerCase(),
          style: FSTextStyle.appbartextlight,
        ),
        elevation: 0.0,
        backgroundColor: FsColor.primaryvisitor,
        leading: FsBackButtonlight(),
      ),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: ListView.builder(
                  primary: false,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: contactlist == null ? 0 : contactlist.length,
                  itemBuilder: (BuildContext context, int index) {
                    Map listmembers = contactlist[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 0),
                      child: Container(
                        padding: const EdgeInsets.only(
                          bottom: 10.0,
                          top: 10.0,
                        ),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 1,
                                    color: FsColor.darkgrey.withOpacity(0.1)))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Image.asset(
                                "images/default.png",
                                height: 42,
                                width: 42,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${listmembers["name"]}'.toLowerCase(),
                                    style: TextStyle(
                                        fontSize: FSTextStyle.h6size,
                                        fontFamily: 'Gilroy-SemiBold',
                                        color: FsColor.darkgrey),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              child: Container(
                                height: 48.0,
                                width: 48.0,
                                alignment: Alignment.center,
                                child: IconButton(
                                  onPressed: () {
                                    callIntent(context);
                                  },
                                  icon: Icon(
                                    FlutterIcon.phone_1,
                                    color: FsColor.green,
                                    size: FSTextStyle.h3size,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
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

  Future<void> callIntent(BuildContext context) async {
    try {
      String url = "tel:+919004387193";
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
