import 'package:common_config/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/config/strings/strings.dart';
import 'package:sso_futurescape/ui/module/intro/intro_recipe.dart';
import 'package:sso_futurescape/ui/module/recipe/screens/tabs_screen.dart';
import 'package:sso_futurescape/ui/widgets/update_profile_dialog.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/facebook_utils.dart';
import 'package:sso_futurescape/utils/storage/restaurnunt_storage.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

class RecipeCard extends StatefulWidget {
  @override
  RecipeCardState createState() => new RecipeCardState();
}

class RecipeCardState extends State<RecipeCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => introGrocery(context),
      child: new Container(
          child: Column(
        children: <Widget>[
          Container(
            child: new Card(
              elevation: 2.0,
              key: null,
              child: Container(
                decoration: BoxDecoration(
                    // image: DecorationImage(
                    //   image: AssetImage("images/dash-bg.jpg"),
                    //   fit: BoxFit.cover,
                    // ),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    "Recipe Book".toLowerCase(),
                                    style: TextStyle(
                                        fontSize: FSTextStyle.dashtitlesize,
                                        fontFamily: 'Gilroy-SemiBold',
                                        color: FsColor.primaryrecipe),
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
                                    onPressed: () => {introGrocery(context)},
                                    color: FsColor.primaryrecipe,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 10.0),
                                    child: Text(
                                      "Explore",
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
                            child: Image.asset("images/dash12.png",
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
                              "Find delicious recipes to try at home | share your favourite recipe with neighbours"
                                  .toLowerCase(),
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  fontSize: FSTextStyle.dashsubtitlesize,
                                  fontFamily: FSTextStyle.dashsubtitlefont,
                                  color: FsColor.dashsubtitlecolor),
                            ),
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
    );
  }

 static  Future<void> introGrocery(BuildContext context) async {
    //BuildContext context=this.context;
    bool value = await RecipeStorage.getGroceryProductInfoStatus();
    if (!value) {
      var a = await Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => IntroRecipe()),
      );
      RecipeStorage.setGroceryProductInfoStatus(true);
    }
    _checkForProfile(context);
  }

 static void _checkForProfile(BuildContext context) {
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
        AppUtils.checkInternetConnection().then((onValue) async {
          //getLocation();
          if (onValue) {
            FsFacebookUtils.callCartClick(FsString.RECIPE, "card");
            /*MainDashboardState.cart_icon.changeBuniessMOde(BusinessAppMode.GROCERY);
            MainDashboardState.cart_icon.updateValue();
            */
           /* setState(() {});*/
            /*var result = await*/
            Navigator.push(context,
                new MaterialPageRoute(builder: (context) => TabsScreen()));
            /*print("RsRSRsRSRsRSRsRSRsRS");
        MainDashboardState.cart_icon
            .changeBuniessMOde(BusinessAppMode.APP_THEME);
        MainDashboardState.cart_icon.updateValue();*/
          } else {
            print("No Internet Avavilble");
            Toasly.warning(context, "No Internet Connection");
          }
        });
      }
    });
  }

  static onUpdateProfile() {
    /*print(
        "--------------------------------onUpdateProfile---------------------------");
    setState(() {
      SsoStorage.getUserProfile().then((profile) {});
    });*/
  }
}
