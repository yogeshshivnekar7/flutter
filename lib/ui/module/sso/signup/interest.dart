import 'dart:convert';

import 'package:common_config/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/config/strings/strings.dart';
import 'package:sso_futurescape/presentor/module/sso/profile/profile_presenter.dart';
import 'package:sso_futurescape/presentor/module/sso/profile/profile_view.dart';
import 'package:sso_futurescape/ui/module/sso/dashboard/main_dashboard.dart';
import 'package:sso_futurescape/ui/module/sso/signup/dob_dialog.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';
import 'package:sso_futurescape/ui/widgets/page_loader.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/firebase_util/firebase_databse_sso.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

class InterestPage extends StatefulWidget {
  bool resultRequired = false;
  Function notifyFunction;

  InterestPage({notifyFunction}) {
    this.notifyFunction = notifyFunction;
  }

  @override
  InterestPageState createState() =>
      new InterestPageState(notifyFunction: notifyFunction);
}

class InterestPageState extends State<InterestPage>
    implements ProfileResponseView {
  Function notifyFunction;

  InterestPageState({notifyFunction}) {
    this.notifyFunction = notifyFunction;
  }

  static var intrestArray = [
    {
      "name": "Manage Home",
      "key": "Manage Home",
      "isSelected": false,
      "image": "images/inter-home.png",
    },
    {
      "name": "Family Safety Security",
      "key": "Family Safety Security",
      "isSelected": true,
      "image": "images/inter-security.png",
    },
    {
      "name": "Order Food",
      "key": "Order Food",
      "isSelected": false,
      "image": "images/inter-food.png",
    },
    {
      "name": "Discover your Neighbourhood",
      "key": "Discover your Neighbourhood",
      "isSelected": false,
      "image": "images/inter-neighbour.png",
    },
    {
      "name": "Find Domestic Workers",
      "key": "Find Domestic Workers",
      "isSelected": false,
      "image": "images/inter-worker.png",
    },
    {
      "name": "Find Ride Share",
      "key": "Find Ride Share",
      "isSelected": false,
      "image": "images/inter-ride.png",
    },
    {
      "name": "Pyna Wines \n Exclusively on oneapp",
      "key": "Pyna Wines",
      "isSelected": false,
      "image": "images/pyna.png",
    },
  ];

  List<bool> inputs = new List<bool>();

  var _userProfie;
  ProfilePresenter presenter;

  @override
  void initState() {
    InterestPageState.intrestArray = [
      {
        "name": "Manage Home",
        "key": "Manage Home",
        "isSelected": false,
        "image": "images/inter-home.png",
      },
      {
        "name": "Family Safety Security",
        "key": "Family Safety Security",
        "isSelected": true,
        "image": "images/inter-security.png",
      },
      {
        "name": "Order Food",
        "key": "Order Food",
        "isSelected": false,
        "image": "images/inter-food.png",
      },
      {
        "name": "Discover your Neighbourhood",
        "key": "Discover your Neighbourhood",
        "isSelected": false,
        "image": "images/inter-neighbour.png",
      },
      {
        "name": "Find Domestic Workers",
        "key": "Find Domestic Workers",
        "isSelected": false,
        "image": "images/inter-worker.png",
      },
      {
        "name": "Find Ride Share",
        "key": "Find Ride Share",
        "isSelected": false,
        "image": "images/inter-ride.png",
      },
      {
        "name": "Pyna Wines \n Exclusively on oneapp",
        "key": "Pyna Wines",
        "isSelected": false,
        "image": "images/pyna.png",
      },
    ];
    setState(() {});
    presenter = new ProfilePresenter(this);
    presenter.getProfileDetails();
    FirebaseDatabaseSSO.getIntrest().then((x) {
      if (x != null) {
        List list1 = x as List;
        for (Map firebaseList in list1) {
          for (Map sName in intrestArray) {
            if (firebaseList["key"] == sName['key']) {
              sName['isSelected'] = firebaseList['isSelected'];
              if (firebaseList['key'] == 'Pyna Wines' && sName['isSelected']) {
                MainDashboardState.isWineShow = true;
              }
            }
          }
        }
        setState(() {});
      }
    }).catchError((e) {});
    setState(() {
      for (int i = 0; i < 20; i++) {
        inputs.add(false);
      }
    });
  }

  void ItemChange(bool val, int index) {
    setState(() {
      inputs[index] = val;
    });
  }

  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // primaryColor: FsColor.basicprimary,
      // resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        backgroundColor: FsColor.white,
        elevation: 1.0,
        title: new Text(
          notifyFunction == null
              ? 'select your interests'
              : "Update your interests".toLowerCase(),
          style: FSTextStyle.appbartext,
        ),
        leading: notifyFunction != null ? FsBackButton() : null,
      ),
      body: isLoading
          ? PageLoader()
          : SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(
                  top: 15.0, left: 15.0, right: 15.0, bottom: 15.0),
              child: Text(
                'To Help us serve you better\nPlease Share your interests with us'
                    .toLowerCase(),
                style: TextStyle(
                  fontSize: FSTextStyle.h5size,
                  fontFamily: 'Gilroy-SemiBold',
                  color: FsColor.darkgrey,
                  height: 1.2,
                ),
              ),
            ),
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:
                MediaQuery
                    .of(context)
                    .size
                    .width < 767 ? 2 : 3,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 5.0,
                childAspectRatio:
                MediaQuery
                    .of(context)
                    .size
                    .width < 767 ? 1.3 : 2,
                // childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 2.5),
              ),
              padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
              primary: false,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: intrestArray == null ? 0 : intrestArray.length,
              itemBuilder: (BuildContext context, int index) {
                Map place = intrestArray[index];

                return Padding(
                    padding: const EdgeInsets.only(
                        bottom: 0, top: 0, left: 0, right: 0),
                    child: InkWell(
                      onTap: () async {
                        setState(() {
                          place["isSelected"] = !place["isSelected"];
                        });
                        if (place["key"] == "Pyna Wines" &&
                            place["isSelected"]) {
                          if (_userProfie == null ||
                              _userProfie['dob'] == null) {
                            var result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CheckBoxAletDialog()));
                            print(result);
                            if (result == null) {
                              place["isSelected"] = false;
                              setState(() {});
                            } else if (result["result"] != null) {
                              isLoading = true;
                              setState(() {});
                              MainDashboardState.isWineShow = false;
                              presenter.getProfileDetails();
                              place["isSelected"] = false;
                              setState(() {});
                            } else {
                              MainDashboardState.isWineShow = true;
                              isLoading = true;
                              setState(() {});
                              presenter.getProfileDetails();
                            }
                          } else {
                            if (AppUtils.getDateDiffOfYears(
                                (_userProfie['dob'])) <
                                21) {
                              MainDashboardState.isWineShow = false;
                              place["isSelected"] = false;
                              setState(() {});
                              showUnderAgeAlertDialog(context);
                            } else {
                              MainDashboardState.isWineShow = true;
                            }
                          }
                        } else {
                          MainDashboardState.isWineShow = false;
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        // padding: const EdgeInsets.only(top: 10.0,),
                        decoration: place["isSelected"]
                            ? BoxDecoration(
                          color: FsColor.primary.withOpacity(0.1),
                          border: Border.all(
                              width: 1.0, color: FsColor.primary),
                          borderRadius: BorderRadius.all(
                              Radius.circular(4.0)),
                        )
                            : BoxDecoration(
                          color: FsColor.lightgrey.withOpacity(0.1),
                          border: Border.all(
                              width: 1.0,
                              color: FsColor.lightgrey
                                  .withOpacity(0.2)),
                          borderRadius: BorderRadius.all(
                              Radius.circular(4.0)),
                        ),
                        child: Stack(
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.only(
                                    top: 10.0,
                                  ),
                                  child: Image.asset(
                                    "${place["image"]}",
                                    height: MediaQuery
                                        .of(context)
                                        .size
                                        .width <
                                        767
                                        ? 60
                                        : 75,
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width <
                                        767
                                        ? 60
                                        : 75,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    // width: MediaQuery.of(context).size.width - 100,
                                    child: ListView(
                                      primary: false,
                                      physics:
                                      NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(
                                            left: 5,
                                            right: 5,
                                          ),
                                          alignment: Alignment.center,
                                          child: RichText(
                                              textAlign: TextAlign.center,
                                              text: TextSpan(children: [
                                                TextSpan(
                                                  text:
                                                  '${place["name"]}',
                                                  style: TextStyle(
                                                    fontFamily:
                                                    'Gilroy-SemiBold',
                                                    fontSize: MediaQuery
                                                        .of(
                                                        context)
                                                        .size
                                                        .width <
                                                        767
                                                        ? FSTextStyle
                                                        .h6size
                                                        : FSTextStyle
                                                        .h5size,
                                                    color: FsColor
                                                        .basicprimary,
                                                  ),
                                                ),
                                              ])),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              right: 0, top: 0,
                              //  bottom: 0, left: 0,
                              child: place["isSelected"]
                                  ? Container(
                                  decoration: BoxDecoration(
                                    color: FsColor.primary,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft:
                                      Radius.circular(4.0),
                                    ),
                                  ),
                                  padding: EdgeInsets.all(5),
                                  child: Icon(
                                    FlutterIcon.ok,
                                    color: FsColor.white,
                                    size: FSTextStyle.h4size,
                                  ))
                                  : Container(),
                            )
                          ],
                        ),
                      ),
                    ));

                // return Padding(
                //   padding: const EdgeInsets.only(bottom: 15.0),

                //     child: CheckboxListTile(
                //         value: inputs[index],
                //         title: Text(
                //           "${place["name"]}",
                //           style: TextStyle(fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-SemiBold')
                //         ),
                //         activeColor: FsColor.basicprimary,
                //         controlAffinity: ListTileControlAffinity.trailing,
                //         onChanged:(bool val){ItemChange(val, index);},
                //         secondary:

                //         Container(width: 36, height: 36,
                //           child: Image.asset(
                //               intrestArray[index]["image"].toString(),
                //               fit:BoxFit.contain, width: 48.0, height: 48.0,),
                //         ),
                //     )

                // );

                // return Column(
                //   children: <Widget>[
                //     CheckboxListTile(
                //         value: inputs[index],
                //         title:
                //         Text(
                //           "${place["name"]}",
                //           style: TextStyle(fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-SemiBold')
                //         ),
                //         activeColor: FsColor.basicprimary,
                //         controlAffinity: ListTileControlAffinity.trailing,
                //         onChanged:(bool val){ItemChange(val, index);},
                //         secondary: Container(width: 36, height: 36,
                //           child: Image.asset(
                //               intrestArray[index]["image"].toString(),
                //               fit:BoxFit.contain, width: 48.0, height: 48.0,),
                //           ),
                //     )
                //   ],
                // );
              },
            ),
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(
                      bottom: 10.0,
                      top: 10.0,
                    ),
                    child: GestureDetector(
                      child: RaisedButton(
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(4.0),
                        ),
                        child: Text(FsString.interestAction,
                            style: TextStyle(
                                fontSize: FSTextStyle.h6size,
                                fontFamily: 'Gilroy-SemiBold')),
                        onPressed: () {
                          _saveIntrestest(context);
                        },
                        color: FsColor.basicprimary,
                        textColor: FsColor.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void showUnderAgeAlertDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 16.0),
            backgroundColor: Colors.white,
            title: new Text(
                "sorry, you are not in permissible age!".toLowerCase(),
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontFamily: 'Gilroy-SemiBold',
                    fontSize: FSTextStyle.h4size,
                    color: FsColor.darkgrey)),
            shape: new RoundedRectangleBorder(
              side: BorderSide.none,
              borderRadius: new BorderRadius.circular(7.0),
            ),
            content: new Text(
                "as per the government ruling in India, you have to "
                    "be at the age of 21 years or above to purchase wines and liquor from stores."
                    " You may browse other stores in our app from their respective cards."
                    .toLowerCase(),
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontFamily: 'Gilroy-Regular',
                    fontSize: FSTextStyle.h6size,
                    color: Colors.grey[600])),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop('dialog');
                },
                child: Text(
                  "Okay",
                  style: TextStyle(
                      fontFamily: 'Gilroy-SemiBold',
                      fontSize: FSTextStyle.h5size,
                      color: FsColorStepper.active),
                ),
              ),
            ],
          );
        });
  }

  void _saveIntrestest(BuildContext context) {
    SsoStorage.setOneAppInterest(intrestArray);
    FirebaseDatabaseSSO.saveIntrest(intrestArray);
    Toasly.success(context, "Saved Successfully!");
    if (notifyFunction == null) {
      Navigator.pop(context);
      Navigator.pushNamed(context, '/intro');
    } else {
      notifyFunction();
      Navigator.pop(context);
    }
  }

  @override
  void hideProgress() {
    // TODO: implement hideProgress
  }

  @override
  void onFailure(String failure) {
    Toasly.error(context, AppUtils.errorDecoder(jsonDecode((failure))));
  }

  @override
  void onError(String error) {
    Toasly.error(context, AppUtils.errorDecoder(jsonDecode((error))));
  }

  @override
  void onProfileProgress(String error) {}

  @override
  void onSuccess(String success) {
    isLoading = false;
    var profileJson = json.decode(success);
    SsoStorage.setUserProfile(profileJson["data"]);
    _userProfie = profileJson["data"];
    print("_userProfie");
    print(_userProfie);
    // print(AppUtils.getDateDiffOfYears(_userProfie['dob']));
    setState(() {});
  }

  @override
  void showProgress() {
    // TODO: implement showProgress
  }
}
