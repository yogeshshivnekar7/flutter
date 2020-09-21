import 'dart:collection';

import 'package:common_config/utils/fs_navigator.dart';
import 'package:common_config/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:libphonenumber/libphonenumber.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/presentor/module/vizlog/guest/guest.dart';
import 'package:sso_futurescape/presentor/module/vizlog/guest/guest_view.dart';
import 'package:sso_futurescape/ui/module/vizlog/myguest/myguest_invite/guestinvite_information.dart';
import 'package:sso_futurescape/ui/module/vizlog/myguest/myguest_invite/phonebook.dart';
import 'package:sso_futurescape/ui/module/vizlog/myvisitors_dashboard.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/ui/widgets/mobile_number_widget.dart';
import 'package:sso_futurescape/utils/app_constant.dart';
import 'package:sso_futurescape/utils/permission/permission_service.dart';
import 'package:sso_futurescape/utils/user_util.dart';

class GuestInviteContact extends StatefulWidget {
  @override
  _GuestInviteContactState createState() => _GuestInviteContactState();
}

class _GuestInviteContactState extends State<GuestInviteContact>
    implements TextListener, GuestView {
  ContactNumberController userNameController;

  GuestPresenter _guestPresenter;

  String _socid;

  HashMap<String, String> hmInviteDetails;

  int lenght;
  bool isLoading = false;

  String firstName;

  String lastName = "";

  String email;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserUtils.getCurrentUnits(app: AppConstant.VIZLOG).then((unit) {
      _socid = unit["soc_id"];
    });
    userNameController = new ContactNumberController(textListener: this);
    _guestPresenter = new GuestPresenter(this);
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
        leading: FsBackButtonlight(
          backEvent: (context) {
            backEvent(context);
          },
        ),
      ),
      body: /*isLoading?PageLoader(title: "Please searching guest details...",):*/
      SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                'enter guest contact number'.toLowerCase(),
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
              child: MobileNumberWidget(
                controller: userNameController,
                type: MobileNumberWidget.ONLY_MOBILE,
                showConact: true,
              ),
            ),
            Container(
              alignment: Alignment.center,
//              child: GestureDetector(

              child: isLoading
                  ? SizedBox(
                height: 20.0,
                width: 20.0,
                child: CircularProgressIndicator(
                  valueColor:
                  AlwaysStoppedAnimation<Color>(FsColor.darkgrey),
                  strokeWidth: 3.0,
                ),
              )
                  : RaisedButton(
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
                  validate();
                },
              ),
//              ),
            ),
          ],
        ),
      ),
    );
  }

  HashMap<String, String> getFirstName() {
    HashMap<String, String> hashMap = new HashMap();
    hashMap["mobile"] = userNameController.getUserName();
    if (firstName != null) {
      hashMap["first_name"] = firstName;
    }
    if (lastName != null && lastName.length > 0) {
      hashMap["last_name"] = lastName;
    }
    if (email != null && email.length > 0) {
      hashMap["email"] = email;
    }


    return hashMap;
  }

  void validate() {
    if (userNameController.text.length <= 0) {
      Toasly.error(context, "please enter mobile number");
    } else if (userNameController.text.length <= 3 || lenght == 0) {
      Toasly.error(context, "please enter valid mobile number");
    }
    /*else if(lenght==0){
      Toasly.error(context, "please enter valid mobile number");
  } */
    else {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => GuestInviteInformation(getFirstName())),
      );
    }
  }

  void hideKeyboard() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  onTextChanged(text) {
    try {
      int.parse(text);
      print("text-------------------------------$text");
      PhoneNumberUtil.isValidPhoneNumber(
          phoneNumber: text, isoCode: userNameController.country.isoCode)
          .then((isValid) {
        print("valid number ----------------------- " + isValid.toString());
        if (isValid) {
          hideKeyboard();
          _guestPresenter.getGlobalVisitor(
              userNameController.country.dialingCode + text, _socid);
          setState(() {
            isLoading = true;
            lenght = text.length;
          });
//          print("isloading------------------$isLoading");

        } else {
          setState(() {
            lenght = 0;
          });
        }
        print("isloading------------------$lenght");
      });
    } catch (e) {
      print(e);
    }

//    if (lenght == 12) {
//      _guestPresenter.getGlobalVisitor(text, _socid);
//    }
  }

  @override
  error(error) {
    setState(() {
      isLoading = false;
    });
    // TODO: implement error
//    throw UnimplementedError();
  }

  @override
  failure(failed) {
    setState(() {
      isLoading = false;
    });
    // TODO: implement failure
//    throw UnimplementedError();
  }

  @override
  success(success) {
    print("sucess----------------------------------------");
    print(success);
    var data = success["data"];
    hmInviteDetails = new HashMap();
    hmInviteDetails["coming_from"] = data["coming_from"];
    hmInviteDetails["email"] = data["email"];
    hmInviteDetails["first_name"] = data["first_name"];
    hmInviteDetails["last_name"] = data["last_name"];
    hmInviteDetails["is_existing_guest"] = "1"; //newVisitor
    hmInviteDetails["added_to"] = data["visitor_id"].toString();
    hmInviteDetails["gender"] = data["gender"];
    setState(() {
      isLoading = false;
    });
    FsNavigator.push(context, GuestInviteInformation(hmInviteDetails));
    // TODO: implement success
//    throw UnimplementedError();
  }

  void backEvent(context) {
//    Navigator.pop(context);
//    Navigator.popAndPushNamed(context, "/visitordashboard");
    FsNavigator.push(context, MyVisitorsDashboard());
  }

  @override
  onContactClicked() {
    PermissionsService1().requestContactPermission().then((value) {
      if (value) {
        FsNavigator.push(context, Phonebook(onClicked));
      }
    });
  }

  Function onClicked(var contact) {
    print("caont ---$contact");
    email = contact["email"];
    String fullName = contact["name"];
    List<String> names = fullName.split(" ");
    names.forEach((element) {
      print("nasmee-----$element");
    });
    if (names.length > 0) {
      firstName = names[0];
    }
    lastName = "";
    for (int i = 1; i < names.length; i++) {
      lastName = lastName + names[i];
    }

    final validCharacters = RegExp(r'^[a-zA-Z]+$');
    if (!validCharacters.hasMatch(firstName)) {
      firstName = "";
    }
    if (!validCharacters.hasMatch(lastName)) {
      lastName = "";
    }
    print("firstName--$firstName, -- lastName- $lastName");

    userNameController.setText(
        getCorrectContact(contact));
  }

  String getCorrectContact(contact) {
    String con = contact["number"].toString();
    if (con.length > 10) {
      con = reverseString(con);
      con = con.substring(0, 10);
      con = reverseString(con);
    }
    return con;
  }

  String reverseString(String element) {
    String revers = "";
    for (int i = element.length - 1; i >= 0; i--) {
      revers = revers + element.substring(i, i + 1);
    }
    return revers;
  }

}
