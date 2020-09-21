import 'package:common_config/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/config/strings/strings.dart';
import 'package:sso_futurescape/ui/module/grocery/grocery_list.dart';
import 'package:sso_futurescape/ui/module/veza/veza_shop_listing.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/facebook_utils.dart';

class DailyEssentialCard extends StatefulWidget {
  @override
  _DailyEssentialCardState createState() => new _DailyEssentialCardState();
}

class _DailyEssentialCardState extends State<DailyEssentialCard> {
  bool hasOrder = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: new Container(
          child: Column(
        children: <Widget>[
          !hasOrder
              ? Container(
                  child: new Card(
                    elevation: 2.0,
                    key: null,
                    child: Container(
                      /*decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("images/dash-bg.jpg"),
                          fit: BoxFit.cover,
                        ),
                        // border: Border.all(width: 1.0, color: FsColor.darkgrey.withOpacity(0.5)),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Text(
                                          "Daily Essential".toLowerCase(),
                                          style: TextStyle(
                                              fontSize:
                                                  FSTextStyle.dashtitlesize,
                                              fontFamily: 'Gilroy-SemiBold',
                                              color: FsColor
                                                  .primarydailyessential),
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
                                            click(context);
                                          },
                                          color: FsColor.primarydailyessential,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 10.0),
                                          child: Text(
                                            "Order",
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
                                  child: Image.asset("images/dash6.png",
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
                            padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                    child: Text(
                                  "Out of Eggs this morning for breakfast? Subscribe with us for your daily essentials & get your orders doorstep delivered by your preferred outlets."
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
              )
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
                      // border: Border.all(width: 1.0, color: FsColor.darkgrey.withOpacity(0.5)),
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text(
                                        "Daily Essential".toLowerCase(),
                                        style: TextStyle(
                                            fontSize:
                                            FSTextStyle.dashtitlesize,
                                            fontFamily: 'Gilroy-SemiBold',
                                            color: FsColor
                                                .primarydailyessential),
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
                                          click(context);
                                        },
                                        color: FsColor.primarydailyessential,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 10.0),
                                        child: Text(
                                          "Order",
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
                                child: Image.asset("images/dash6.png",
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                                    "Active Subscription",
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  GestureDetector(
                                    child: FlatButton(
                                      onPressed: () {
                                        click(context);
                                      },
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            "View",
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
        click(context);
      },
    );
  }

  void click(BuildContext context) {
    AppUtils.checkInternetConnection().then((onValue) {
      //getLocation();
      if (onValue) {
        FsFacebookUtils.callCartClick(FsString.Essentials, "card");
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) =>
                    GroceryList(
                      businessAppMode: BusinessAppMode.DAILY_ESSENTIALS,
                    )));
      } else {
        print("No Internet Avavilble");
        Toasly.warning(context, "No Internet Connection");
      }
    });
  }
}
