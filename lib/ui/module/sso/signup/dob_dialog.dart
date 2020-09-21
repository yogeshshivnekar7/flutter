import 'dart:collection';

import 'package:common_config/utils/toast/toast.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/presentor/module/sso/profile/profile_presenter.dart';
import 'package:sso_futurescape/presentor/module/sso/profile/profile_view.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';
import 'package:sso_futurescape/utils/app_utils.dart';

class CheckBoxAletDialog extends StatefulWidget {
  @override
  CheckBoxAletDialogState createState() {
    return new CheckBoxAletDialogState();
  }
}

class CheckBoxAletDialogState extends State<CheckBoxAletDialog>
    implements ProfileResponseView {
  bool _isChecked = true;
  bool isLoading = false;
  bool checkedValue = false;
  ProfilePresenter _presenter;
  TextEditingController dobController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _presenter = new ProfilePresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: new Scaffold(
        // primaryColor: FsColor.basicprimary,
        // resizeToAvoidBottomPadding: false,
        appBar: new AppBar(
          elevation: 0.0,
          leading: FsBackButton(
            backEvent: (context) {
              _onWillPop();
            },
          ),
          backgroundColor: FsColor.white,
          title: new Text(
            'Verify your dob'.toLowerCase(),
            style: FSTextStyle.appbartext,
          ),
          //leading: FsBackButton(),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Container(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  child: Text("Are you above 21 years of age?".toLowerCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Gilroy-SemiBold',
                          fontSize: FSTextStyle.h4size,
                          color: FsColor.primarypyna)),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      width: 18,
                      height: 18,
                      child: Icon(FlutterIcon.star_1,
                          color: FsColor.darkgrey, size: FSTextStyle.h6size),
                    ),
                    SizedBox(width: 5),
                    Flexible(
                      child: Text(
                        "As per the government rule, you have to be in legal drinking age to order from wine and liquor shops."
                            .toLowerCase(),
                        style: TextStyle(
                            fontSize: FSTextStyle.h6size,
                            color: FsColor.darkgrey,
                            fontFamily: 'Gilroy-SemiBold'),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      width: 18,
                      height: 18,
                      child: Icon(FlutterIcon.star_1,
                          color: FsColor.darkgrey, size: FSTextStyle.h6size),
                    ),
                    SizedBox(width: 5),
                    Flexible(
                      child: Text(
                        "Please provide your date of birth to verify your age"
                            .toLowerCase(),
                        style: TextStyle(
                            fontSize: FSTextStyle.h6size,
                            color: FsColor.darkgrey,
                            fontFamily: 'Gilroy-SemiBold'),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 15.0),
                  child: ListTile(
                    contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                    subtitle: DateTimeField(
                      style: TextStyle(fontFamily: 'Gilroy-Regular'),
                      format: DateFormat("dd/MM/yyyy"),
                      onShowPicker: (context, currentValue) {
                        return showDatePicker(
                            context: context,
                            firstDate: DateTime(1900),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime.now());
                      },
                      showCursor: false,
                      readOnly: true,
                      controller: dobController,
                      decoration: InputDecoration(
                        labelText: "Select your Date of Birth".toLowerCase(),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: checkedValue,
                      onChanged: (bool newValue) {
                        print(newValue);
                        checkedValue = newValue;
                        setState(() {});
                      },
                      checkColor: FsColor.darkgrey,
                      activeColor: FsColor.primary,
                    ),
                    Flexible(
                      child: Text(
                        'I acknowledge that the date of birth provided is true to my knowledge and I can provide valid documents if the need be.',
                        style: TextStyle(
                            fontFamily: 'Gilroy-SemiBold',
                            fontSize: FSTextStyle.h6size,
                            color: FsColor.darkgrey),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    isLoading
                        ? CircularProgressIndicator()
                        : RaisedButton(
                            child: new Text(
                              "Verify",
                              style: TextStyle(
                                  fontFamily: 'Gilroy-SemiBold',
                                  fontSize: FSTextStyle.h6size,
                                  color: FsColor.white),
                            ),
                            color: FsColor.basicprimary,
                            onPressed: () {
                              saveMyData(context);
                            },
                          ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      onWillPop: () => _onWillPop(),
    );
  }

  void saveMyData(BuildContext context) {
    print(checkedValue);
    print(dobController.text);
    if (checkedValue) {
      if (dobController.text.toString().isNotEmpty) {
        HashMap<String, String> finalParam = new HashMap();

        String dob = AppUtils.changeDateFormat(
            dobController.text.toString().trim(), "dd/MM/yyyy", "yyyy-MM-dd");
        print(dob);
        if (dob != null) {
          finalParam["dob"] = dob;
          isLoading = true;
          setState(() {});
          _presenter.updateProfileDetails(finalParam);
        }
      } else {
        Toasly.error(context, "please select date of birth");
      }
    } else {
      Toasly.error(context, "please accept acknowledge");
    }
  }

  void showUnderAgeAlertDialog(BuildContext context) {
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
                  Navigator.pop(context, {"result": true});
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

  _onWillPop() {
    Navigator.pop(context, null);
  }

  @override
  void hideProgress() {}

  @override
  void onError(String error) {
    isLoading = false;
    setState(() {});
    print(error);
    Toasly.error(context, error);
  }

  @override
  void onFailure(String error) {
    isLoading = false;
    setState(() {});
    print(error);
    Toasly.error(context, error);
  }

  @override
  void onProfileProgress(String error) {
    print(error);
  }

  @override
  void onSuccess(String error) {
    print("onSuccess" + "dob dialog");
    print(error);
    isLoading = false;
    setState(() {});
    if (AppUtils.getDateDiffOfYears(AppUtils.changeDateFormat(
            dobController.text.toString().trim(),
            "dd/MM/yyyy",
            "yyyy-MM-dd")) >=
        21) {
      Navigator.pop(context, {});
    } else {
      showUnderAgeAlertDialog(context);
    }
  }

  @override
  void showProgress() {}
}
