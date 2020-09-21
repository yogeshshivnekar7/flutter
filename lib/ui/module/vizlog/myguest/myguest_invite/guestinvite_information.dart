import 'dart:collection';

import 'package:common_config/utils/fs_navigator.dart';
import 'package:common_config/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/module/vizlog/myguest/myguest_invite/guestinvite_contact.dart';
import 'package:sso_futurescape/ui/module/vizlog/myguest/myguest_invite/guestinvite_visitdetails.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/utils/app_utils.dart';

class GuestInviteInformation extends StatefulWidget {
  HashMap<String, String> hmInviteDetails;

  GuestInviteInformation(this.hmInviteDetails) {
    this.hmInviteDetails = hmInviteDetails;
    print("---------------------------------------------");
    print(hmInviteDetails.toString());
  }

  @override
  _GuestInviteInformationState createState() =>
      _GuestInviteInformationState(hmInviteDetails);
}

class _GuestInviteInformationState extends State<GuestInviteInformation> {
  HashMap<String, String> hmInviteDetails;

  var firstNameController = new TextEditingController();
  var lastNameController = new TextEditingController();

  var emailController = new TextEditingController();

  _GuestInviteInformationState(this.hmInviteDetails) {
    print(hmInviteDetails.toString());
  }

  String selectedRadioTile;

  @override
  void initState() {
    super.initState();
    selectedRadioTile = "M";
    setState(() {
      if (hmInviteDetails["first_name"] != null) {
        firstNameController.text = hmInviteDetails["first_name"];
      }
      if (hmInviteDetails["last_name"] != null) {
        lastNameController.text = hmInviteDetails["last_name"];
      }
      if (hmInviteDetails["gender"] != null) {
        selectedRadioTile = hmInviteDetails["gender"];
      }
      if (hmInviteDetails["email"] != null) {
        emailController.text = hmInviteDetails["email"];
      }
    });
  }

  setSelectedRadioTile(String val) {
    setState(() {
      selectedRadioTile = val;
      print("selected----------------$selectedRadioTile");
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
//      primaryColor: FsColor.primaryvisitor,
      appBar: new AppBar(
        backgroundColor: FsColor.primaryvisitor,
        elevation: 0.0,
        title: new Text(
          'Invite Guest'.toLowerCase(),
          style: FSTextStyle.appbartextlight,
        ),
        leading: FsBackButtonlight(backEvent: (context) {
          backEvent(context);
        }),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                'fill the guest information'.toLowerCase(),
                style: TextStyle(
                  fontSize: FSTextStyle.h5size,
                  fontFamily: 'Gilroy-SemiBold',
                  color: FsColor.darkgrey,
                  height: 1.2,
                ),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
              child: TextField(
                inputFormatters: [
                  WhitelistingTextInputFormatter(RegExp("[a-zA-Z.']")),
                ],
                controller: firstNameController,
                style: TextStyle(
                    fontFamily: 'Gilroy-SemiBold',
                    fontSize: FSTextStyle.h6size,
                    color: FsColor.darkgrey),
                decoration: InputDecoration(
                    labelText: 'First Name'.toLowerCase(),
                    labelStyle: TextStyle(
                        fontFamily: 'Gilroy-Regular', color: FsColor.darkgrey),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: FsColor.basicprimary))),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
              child: TextField(
                inputFormatters: [
                  WhitelistingTextInputFormatter(RegExp("[a-zA-Z.']")),
                ],
                controller: lastNameController,
                style: new TextStyle(
                    fontFamily: 'Gilroy-SemiBold',
                    fontSize: FSTextStyle.h6size,
                    color: FsColor.darkgrey),
                decoration: InputDecoration(
                    labelText: 'Last Name'.toLowerCase(),
                    labelStyle: TextStyle(
                        fontFamily: 'Gilroy-Regular', color: FsColor.darkgrey),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: FsColor.basicprimary))),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Gender',
                    style: TextStyle(
                        fontFamily: 'Gilroy-SemiBold',
                        fontSize: FSTextStyle.h6size,
                        color: FsColor.darkgrey),
                  ),
                  Row(
                    children: <Widget>[
                      Radio(
                        value: 'M',
                        groupValue: selectedRadioTile,
                        onChanged: (val) {
//                          print("anianiniansini ---$val");
//                          selectedRadioTile = val;
                          setSelectedRadioTile(val);
                        },
                        activeColor: FsColor.basicprimary,
                      ),
                      Text(
                        "Male",
                        style: TextStyle(
                            fontSize: FSTextStyle.h6size,
                            fontFamily: 'Gilroy-Regular'),
                      ),
                      Radio(
                        value: 'F',
                        groupValue: selectedRadioTile,
                        onChanged: (val) {
//                          print("anianiniansini ---$val");
//                          selectedRadioTile = val;
                          setSelectedRadioTile(val);
                        },
                      ),
                      Text(
                        "Female",
                        style: TextStyle(
                            fontSize: FSTextStyle.h6size,
                            fontFamily: 'Gilroy-Regular'),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
              child: TextField(
                controller: emailController,
                style: new TextStyle(
                    fontFamily: 'Gilroy-SemiBold',
                    fontSize: FSTextStyle.h6size,
                    color: FsColor.darkgrey),
                decoration: InputDecoration(
                    labelText: 'Email Address'.toLowerCase(),
                    labelStyle: TextStyle(
                        fontFamily: 'Gilroy-Regular', color: FsColor.darkgrey),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: FsColor.basicprimary))),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: GestureDetector(
                child: RaisedButton(
                  color: FsColor.primaryvisitor,
                  textColor: FsColor.white,
                  padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(4.0),
                  ),
                  child: Text('Next',
                      style: TextStyle(
                        fontSize: FSTextStyle.h6size,
                        fontFamily: 'Gilroy-SemiBold',
                      )),
                  onPressed: () {
                    navigateToOtherScreen();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  setGuestDetails() {
    hmInviteDetails["first_name"] = firstNameController.text;
    if (lastNameController.text.length > 0) {
      hmInviteDetails["last_name"] = lastNameController.text;
    }

    hmInviteDetails["gender"] = selectedRadioTile;
    if (emailController.text.length > 0) {
      hmInviteDetails["email"] = emailController.text;
    }
  }

  backEvent(BuildContext context) {
    Navigator.pop(context);
//    FsNavigator.push(context, GuestInviteContact());
  }

  void navigateToOtherScreen() {
    if (firstNameController.text.length <= 0) {
      Toasly.error(context, "please enter first name");
    } else if (lastNameController.text.length > 0 &&
        lastNameController.text.length <= 2) {
      Toasly.error(context, "please enter valid last name");
    } else if (emailController.text.length > 0 &&
        !AppUtils.validateEmail(emailController.text)) {
      Toasly.error(context, "please enter valid email");
    } else {
      setGuestDetails();

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => GuestInviteDetails(hmInviteDetails)),
      );
    }
  }
//  void popupButtonSelected(String value) {}
}
