import 'dart:collection';
import 'dart:convert';

import 'package:common_config/utils/toast/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/config/strings/strings.dart';
import 'package:sso_futurescape/presentor/module/sso/profile/profile_presenter.dart';
import 'package:sso_futurescape/presentor/module/sso/profile/profile_view.dart';
import 'package:sso_futurescape/utils/app_utils.dart';

bool _name;
bool _address;
bool _email;

//ProfileUpdateListener _listener;
class UpdateProfileDialog {
  var context;

  UpdateProfileDialog(this.context, Function listener, {name, email, address}) {
    _email = email;
    _address = address;
    _name = name;
//    _listener = listener;
    _updateDetailsDialog(listener);
  }

  void _updateDetailsDialog(Function listener) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MyDialog(listener);
      },
    );
  }
}

class MyDialog extends StatefulWidget {
  Function listener;

  @override
  _MyDialogState createState() => new _MyDialogState(listener);

  MyDialog(this.listener);
}

class _MyDialogState extends State<MyDialog> implements ProfileResponseView {
  ProfilePresenter _profilePresenter;

  TextEditingController tfAddresController = new TextEditingController();
  TextEditingController tfEmailController = new TextEditingController();
  TextEditingController tfNameController = new TextEditingController();

  bool isLoading = false;

  bool updateCalled;

  Function listener;

  _MyDialogState(this.listener) {
    _profilePresenter = ProfilePresenter(this);
  }

//  Color _c = Colors.redAccent;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text("add your details".toLowerCase(),
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: 'Gilroy-SemiBold',
              fontSize: FSTextStyle.h4size,
              color: FsColor.darkgrey)),
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(7.0),
      ),
      content: SingleChildScrollView(
        child: Container(
          height: 200.0,
          alignment: Alignment.centerLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Column(
                children: <Widget>[
                  _name == null || !_name
                      ? Container()
                      : TextField(
                    controller: tfNameController,
                    decoration: InputDecoration(
                        labelText: 'name',
                        labelStyle: TextStyle(
                            fontFamily: 'Gilroy-Regular',
                            color: FsColor.darkgrey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: FsColor.basicprimary))),
                  ),
                  _email == null || !_email
                      ? SizedBox(height: 10)
                      : _email == null || !_email
                      ? Container()
                      : TextField(
                    controller: tfEmailController,
                    decoration: InputDecoration(
                        labelText: 'email',
                        labelStyle: TextStyle(
                            fontFamily: 'Gilroy-Regular',
                            color: FsColor.darkgrey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: FsColor.basicprimary))),
                  ),
                  _address == null || !_address
                      ? SizedBox(height: 10)
                      : _address == null || !_address
                      ? Container()
                      : TextField(
                    controller: tfAddresController,
                    decoration: InputDecoration(
                        labelText: 'city',
                        labelStyle: TextStyle(
                            fontFamily: 'Gilroy-Regular',
                            color: FsColor.darkgrey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: FsColor.basicprimary))),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: new Text(
            "Cancel",
            style: TextStyle(
                fontFamily: 'Gilroy-SemiBold',
                fontSize: FSTextStyle.h6size,
                color: FsColor.darkgrey),
          ),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop('dialog');
//                Navigator.of(context).pop();
          },
        ),
        isLoading
            ? SizedBox(
            height: 20.0,
            width: 20.0,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(FsColor.darkgrey),
              strokeWidth: 3.0,
            ))
            : RaisedButton(
          child: new Text(
            "Add",
            style: TextStyle(
                fontFamily: 'Gilroy-SemiBold',
                fontSize: FSTextStyle.h6size,
                color: FsColor.white),
          ),
          color: FsColor.basicprimary,
          onPressed: () {
            setState(() {
//              Navigator.of(context, rootNavigator: true).pop('dialog');
              updateDetails();
            });
          },
        ),
      ],
    );
  }

  @override
  void hideProgress() {
    // TODO: implement hideProgress
  }

  @override
  void onError(String error) {
    if (this.mounted)
      setState(() {
        isLoading = false;
      });
    Toasly.error(context, error, gravity: Gravity.CENTER);
//    Toasly.error(
//        context, AppUtils.errorDecoder(error), gravity: Gravity.CENTER);
  }

  @override
  void onFailure(String failure) {
    if (this.mounted)
      setState(() {
        isLoading = false;
      });
    Toasly.error(
        context, AppUtils.errorDecoder(jsonDecode(failure)),
        gravity: Gravity.CENTER);

  }

  @override
  void onSuccess(String success) {
    if (updateCalled) {
      updateCalled = false;
      _profilePresenter.getProfileDetails();
    } else {
      setState(() {
        isLoading = false;
        listener();
//        _listener.onProfileUpdate();
      });
//    Toasly.success(context, success, gravity: Gravity.CENTER);
      Navigator.of(context).pop();
    }
  }

  @override
  void showProgress() {}

  void updateDetails() {
    HashMap<String, String> hashMap = new HashMap();
    print(tfNameController.text.toString());
    print(tfAddresController.text.toString());
    if (_name != null && _name) {
      String name = tfNameController.text.toString().trim();
      if (name.length <= 0) {
        Toasly.error(context, FsString.EMPTY_NAME, gravity: Gravity.CENTER);
        return;
      }
      HashMap<Name, String> hmName = AppUtils.splitFullName(name);
      hashMap["first_name"] = hmName[Name.FIRST_NAME];
      if (hmName[Name.LAST_NAME] != null && hmName[Name.LAST_NAME].length > 0)
        hashMap["last_name"] = hmName[Name.LAST_NAME];
    }
    if (_address != null && _address) {
      String address = tfAddresController.text.toString().trim();
      if (address.length <= 0) {
        Toasly.error(context, FsString.EMPTY_ADDRESS, gravity: Gravity.CENTER);
        return;
      }
      hashMap["city"] = address;
    }
    if (_email != null && _email) {

      String email = tfEmailController.text.toString().trim();
      if (email.length <= 0) {
        Toasly.error(context, FsString.EMPTY_EMAIL, gravity: Gravity.CENTER);
        return;
      }
      if (!AppUtils.validateEmail(email)) {
        Toasly.error(context, "EmailId is Invalid",
            duration: DurationToast.SHORT);
      }
      hashMap["email"] = email;
    }
    isLoading = true;
    updateCalled = true;
    _profilePresenter.updateProfileDetails(hashMap);
  }

  @override
  void onProfileProgress(String success) {}
}
