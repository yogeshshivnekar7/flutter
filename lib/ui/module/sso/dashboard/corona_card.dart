import 'package:common_config/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/module/corona/corona_dashboard.dart';
import 'package:sso_futurescape/ui/module/veza/veza_shop_listing.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';
import 'package:sso_futurescape/ui/widgets/update_profile_dialog.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/facebook_utils.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

class CoronaCard extends StatefulWidget {
  @override
  _CoronaCardState createState() => new _CoronaCardState();
}

class _CoronaCardState extends State<CoronaCard> {
  @override
  Widget build(BuildContext context) {
    return new Container(
        child: Column(
      children: <Widget>[
        Container(
          child: new Card(
            elevation: 2.0,
            key: null,
            child: Container(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                        child: new Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: RichText(
                                  text: TextSpan(
                                    text: 'Care for you'.toLowerCase(),
                                    style: TextStyle(
                                        fontSize: FSTextStyle.dashtitlesize,
                                        fontFamily: 'Gilroy-Bold',
                                        color: FsColor.darkgrey),
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 10.0, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              ClipRRect(
                                child: Image.asset(
                                  "images/corona.png",
                                  height: 80,
                                  width: 80,
                                ),
                              ),
                            ]),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Corona information with oneapp",
                                style: TextStyle(
                                    fontSize: FSTextStyle.h5size,
                                    fontFamily: 'Gilroy-Bold',
                                    color: FsColor.darkgrey),
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                "Aapki suraksha. Desh ki suraksha",
                                style: TextStyle(
                                    fontSize: FSTextStyle.h6size,
                                    fontFamily: 'Gilroy-Regular',
                                    color: FsColor.darkgrey),
                              ),
                              SizedBox(height: 4.0),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        child: FlatButton(
                          onPressed: () {
                            FsFacebookUtils.callCartClick(
                                "corona_cart", "card");
                            Navigator.push(
                              context,
                              new MaterialPageRoute(
                                builder: (context) => CoronaDashboard(),
                              ),
                            );
                          },
                          child: Row(
                            children: <Widget>[
                              Text(
                                "View",
                                style: TextStyle(
                                    fontSize: FSTextStyle.h6size,
                                    fontFamily: 'Gilroy-SemiBold',
                                    color: FsColor.red),
                              ),
                              SizedBox(width: 10.0),
                              Icon(FlutterIcon.right_big,
                                  color: FsColor.red, size: FSTextStyle.h6size),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.0),
                ],
              ),
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            ),
          ),
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          alignment: Alignment.center,
        ),
      ],
    ));
  }

  void _checkForProfile() {
    SsoStorage.getUserProfile().then((profile) {
      var _userProfiew = profile;
      // if (!isSocietyAdded) {
      bool isUnNotSet = false;
      if (_userProfiew["first_name"] == null ||
          _userProfiew["first_name"]
              .toString()
              .isEmpty) {
        isUnNotSet = true;
      }

      if (isUnNotSet) {
        UpdateProfileDialog(context, onUpdateProfile,
            name: isUnNotSet, email: false);
      } else {
        openTiffinList();
      }
    });
  }

  onUpdateProfile() {
    print(
        "--------------------------------onUpdateProfile---------------------------");
    setState(() {
      SsoStorage.getUserProfile().then((profile) {});
    });
  }

  openTiffinList() {
    AppUtils.checkInternetConnection().then((onValue) {
      if (onValue) {
        Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) =>
                  VezaShopList(
                    businessAppMode: BusinessAppMode.TIFFIN,
                  )),
        );
      } else {
        print("No Internet Avavilble");
        Toasly.warning(context, "No Internet Connection");
      }
    });
  }

  Future<void> coronaIntro() async {
    var a = await Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => CoronaDashboard()),
    );
    // _checkForProfile();
  }
}
