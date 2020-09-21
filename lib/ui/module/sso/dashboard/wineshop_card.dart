import 'package:common_config/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/module/grocery/grocery_list.dart';
import 'package:sso_futurescape/ui/module/veza/veza_shop_listing.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';
import 'package:sso_futurescape/ui/widgets/update_profile_dialog.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

class WineShopCard extends StatefulWidget {
  @override
  _WineShopCardState createState() => new _WineShopCardState();
}

class _WineShopCardState extends State<WineShopCard> {
  bool hasOrder = false;

  void getLocation() {
    var location = new Location();
    location.getLocation().then((currentLocation) {
      try {
        print(currentLocation.latitude);
        print(currentLocation.longitude);
      } catch (e) {
        print(e);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: new Container(
            child: Column(
          children: <Widget>[
            Container(
              child: new Card(
                key: null,
                child: Container(
                  /*decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/dash-bg.jpg"),
                      fit: BoxFit.cover,
                    ),
                    */ /*border: Border.all(
                    width: 1.0, color: FsColor.darkgrey.withOpacity(0.5)),*/ /*
                  ),*/
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
                                    child: Text(
                                      "Wine and Liquor".toLowerCase(),
                                      style: TextStyle(
                                          fontSize: FSTextStyle.dashtitlesize,
                                          fontFamily: 'Gilroy-SemiBold',
                                          color: FsColor.primarywineshop),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Container(
                                    child: RaisedButton(
                                      elevation: 1.0,
                                      shape: new RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(4.0),
                                      ),
                                      onPressed: () {
                                        introGrocery();
                                      },
                                      color: FsColor.primarywineshop,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 10.0),
                                      child: Text(
                                        "Find Liquor Shops",
                                        style: TextStyle(
                                            fontSize: FSTextStyle.h6size,
                                            fontFamily: 'Gilroy-Bold',
                                            color: FsColor.white),
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: Image.asset("images/dash_liquor_shop.png",
                                  height: 90, width: 90, fit: BoxFit.fitHeight),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                        child: Divider(
                            color: FsColor.darkgrey.withOpacity(0.2),
                            height: 2.0),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
                        child: Row(
                          children: <Widget>[
                            Flexible(
                                child: Text(
                              ('we urge you to maintain a responsible alcohol consumption habit. find the list of your nearest liquor shops here!')
                                  .toLowerCase(),
                              style: TextStyle(
                                  fontSize: FSTextStyle.dashsubtitlesize,
                                  fontFamily: 'Gilroy-SemiBold',
                                  color: FsColor.darkgrey),
                            ))
                          ],
                        ),
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
            !hasOrder
                ? Container()
                : Container(
                    child: new Card(
                      elevation: 2.0,
                      key: null,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("images/dash-bg.jpg"),
                            fit: BoxFit.cover,
                          ),
                          border: Border.all(
                              width: 1.0,
                              color: FsColor.darkgrey.withOpacity(0.5)),
                        ),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Text(
                                            "grocery",
                                            style: TextStyle(
                                                fontSize:
                                                    FSTextStyle.dashtitlesize,
                                                fontFamily: 'Gilroy-SemiBold',
                                                color: FsColor.primarywineshop),
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Container(
                                          child: RaisedButton(
                                            elevation: 1.0,
                                            shape: new RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      4.0),
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                new MaterialPageRoute(
                                                    builder: (context) =>
                                                        GroceryList(
                                                            businessAppMode:
                                                                BusinessAppMode
                                                                    .WINESHOP)),
                                              );
                                            },
                                            color: FsColor.primarywineshop,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10.0,
                                                horizontal: 10.0),
                                            child: Text(
                                              "Order Grocery",
                                              style: TextStyle(
                                                  fontSize: FSTextStyle.h6size,
                                                  fontFamily: 'Gilroy-Bold',
                                                  color: FsColor.white),
                                            ),
                                          ),
                                        ),
                                      ]),
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    child: Image.asset("images/dash5.png",
                                        height: 90,
                                        width: 90,
                                        fit: BoxFit.fitHeight),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                              child: Divider(
                                  color: FsColor.darkgrey.withOpacity(0.2),
                                  height: 2.0),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(10.0, 10.0, 0, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "3",
                                        style: TextStyle(
                                            fontSize: FSTextStyle.h4size,
                                            fontFamily: 'Gilroy-Bold',
                                            color: FsColor.darkgrey),
                                      ),
                                      Container(
                                        height: 3,
                                      ),
                                      Text(
                                        "Past Orders",
                                        style: TextStyle(
                                            fontSize: FSTextStyle.h6size,
                                            fontFamily: 'Gilroy-SemiBold',
                                            color: FsColor.darkgrey),
                                      ),
                                      SizedBox(height: 4.0),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      GestureDetector(
                                        child: FlatButton(
                                          onPressed: () {},
                                          child: Row(
                                            children: <Widget>[
                                              Text(
                                                "View & Re-Order",
                                                style: TextStyle(
                                                    fontSize:
                                                        FSTextStyle.h6size,
                                                    fontFamily:
                                                        'Gilroy-SemiBold',
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
                                    ],
                                  ),
                                ],
                              ),
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
        )),
        onTap: () {
          introGrocery();
        });
  }

  Future<void> introGrocery() async {
    //BuildContext context=this.context;
    /*bool value = await GroceryStorage.getGroceryProductInfoStatus();
    if (!value) {
      var a = await Navigator.push(
        this.context,
        new MaterialPageRoute(builder: (context) => GroceryIntroduction()),
      );
      GroceryStorage.setGroceryProductInfoStatus(true);
    }*/
    _checkForProfile();
  }

  void _checkForProfile() {
    SsoStorage.getUserProfile().then((profile) {
      var _userProfiew = profile;
      // if (!isSocietyAdded) {
      bool isUnNotSet = false;
      if (_userProfiew["first_name"] == null ||
          _userProfiew["first_name"].toString().isEmpty) {
        isUnNotSet = true;
      }

      if (isUnNotSet) {
        UpdateProfileDialog(context, onUpdateProfile,
            name: isUnNotSet, email: false);
      } else {
        openGrocery();
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

  void openGrocery() {
    AppUtils.checkInternetConnection().then((onValue) {
      //getLocation();
      if (onValue) {
        Navigator.push(
            this.context,
            new MaterialPageRoute(
                builder: (context) => GroceryList(
                      businessAppMode: BusinessAppMode.WINESHOP,
                    )));
      } else {
        print("No Internet Avavilble");
        Toasly.warning(context, "No Internet Connection");
      }
    });
  }
}
