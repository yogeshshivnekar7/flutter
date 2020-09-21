import 'package:common_config/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/config/strings/strings.dart';
import 'package:sso_futurescape/ui/module/sso/dashboard/pyna_storedetail.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/facebook_utils.dart';

class PynaCard extends StatefulWidget {
  @override
  _PynaCardState createState() => new _PynaCardState();
}

class _PynaCardState extends State<PynaCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: new Container(
            child: Column(
              children: <Widget>[
                Container(
                  child: new Card(
                    elevation: 2.0,
                    key: null,
                    child: Container(
                      /*decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("images/dash-bg.jpg"),
                          fit: BoxFit.cover,
                        ),
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
                                          "Pyna Wines".toLowerCase(),
                                          style: TextStyle(
                                              fontSize: FSTextStyle.dashtitlesize,
                                              fontFamily: 'Gilroy-SemiBold',
                                              color: FsColor.primarypyna),
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Container(
                                        child: Text(
                                          "Exclusive Partner".toLowerCase(),
                                          style: TextStyle(
                                              fontSize: FSTextStyle.h7size,
                                              fontFamily: 'Gilroy-SemiBold',
                                              color: FsColor.primarypyna),
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
                                      onPressed: () => {click(context)},
                                      color: FsColor.primarypyna,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 10.0),
                                          child: Text(
                                            "Find Wines",
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
                                  child: Image.asset(
                                    "images/pyna.png",
                                    height: 90,
                                    width: 90,
                                    fit: BoxFit.fitWidth,
                                  ),
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
                                        "Exclusive offers | free home delivery | digital payments | rate card | safety of home | navi mumbai"
                                            .toLowerCase(),
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                            fontSize: FSTextStyle.dashsubtitlesize,
                                            fontFamily: FSTextStyle.dashsubtitlefont,
                                            color: FsColor.dashsubtitlecolor)))
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
        });
  }

  void click(BuildContext context) {
    AppUtils.checkInternetConnection().then((onValue) {
      //getLocation();
      if (onValue) {
        FsFacebookUtils.callCartClick(FsString.PYNA_WINE_CARD, "card");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PynaStoreDetails(),
          ),
        );
      } else {
        print("No Internet Avavilble");
        Toasly.warning(context, "No Internet Connection");
      }
    });
  }
}
